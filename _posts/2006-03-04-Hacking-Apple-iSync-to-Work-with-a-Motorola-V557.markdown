---
layout: post
title:  "Hacking Apple iSync to Work with a Motorola V557"
date:   2006-03-04 11:40:11
categories: tech gadgets
excerpt: "It shouldn't be this difficult"
---
I recently got a new <a href="http://www.motorola.com/motoinfo/product/details/0,,100,00.html">Motorola V557</a> to replace my ageing Nokia 3650 which had developed an intermittant fault that would cause it to crash. The 557 is a pretty good phone: small, light, good battery life, bluetooth etc with a <a href="https://www.cingular.com/media/media_net_ticker">nifty news ticker thing from Cingular</a>. The only problem is that its not one of the phones supported by Apple's <a href="http://www.apple.com/macosx/features/isync/">iSync</a> software. I'd gotten used to having all the contacts and calendar items on my laptop synced with my phone and to suddenly lose this capability was a pain. I did a bit of googling and managed to synthesise the following solution from a <a href="http://forums.macosxhints.com/showthread.php?t=51769">couple</a> of <a href="http://www.macgeekery.com/gspot/2006-02/moto_v557_no-go">forum</a> posts.

Make a copy of the iSync application just in case and then edit the following file:

<pre>/Applications/iSync.app/Contents/PlugIns/ApplePhoneConduit.syncdevice/Contents/ \
PlugIns/PhoneModelsSync.phoneplugin/Contents/Resources/MetaClasses.plist</pre>

That's one long path broken over two lines. The easiest way to do this is from the command line but you can also burrow into the iSync application contents by ctrl-clicking it and selecting "show package contents" from the menu. Search for the existing entry for the Motorola V551 and copy the <code>&lt;key&gt;..&lt;/key&gt;</code> line and following <code>&lt;dict&gt;..&lt;/dict&gt;</code> lines. Move the editor insertion point below the <code>&lt;/dict&gt;</code> line and paste a copy. Now edit the new lines so they look as follows (the changes from the copied V551 entry are shown in <b>bold</b>).

<pre>
&lt;key&gt;com.motorola.<b>V557</b>&lt;/key&gt;
&lt;dict&gt;
    &lt;key&gt;Identification&lt;/key&gt;
    &lt;dict&gt;
        &lt;key&gt;com.apple.cgmi+cgmm&lt;/key&gt;
        &lt;string&gt;"Motorola CE, Copyright 2000"+<b>V557</b>&lt;/string&gt;
        &lt;key&gt;com.apple.gmi+gmm&lt;/key&gt;
        &lt;string&gt;"Motorola CE, Copyright 2000"+<b>V557</b>&lt;/string&gt;
    &lt;/dict&gt;
    &lt;key&gt;InheritsFrom&lt;/key&gt;
    &lt;array&gt;
        &lt;string&gt;com.motorola.usb-bt.0x22B8/0x4902&lt;/string&gt;
    &lt;/array&gt;
    &lt;key&gt;Services&lt;/key&gt;
    &lt;array&gt;
        &lt;dict&gt;
            &lt;key&gt;ServiceName&lt;/key&gt;
            &lt;string&gt;com.apple.model&lt;/string&gt;
            &lt;key&gt;ServiceProperties&lt;/key&gt;
            &lt;dict&gt;
                &lt;key&gt;ModelName&lt;/key&gt;
                &lt;string&gt;<b>V557</b>&lt;/string&gt;
                &lt;key&gt;PhoneIcon&lt;/key&gt;
                &lt;string&gt;MOTV551.tiff&lt;/string&gt;
            &lt;/dict&gt;
        &lt;/dict&gt;
        <b>&lt;dict&gt;
            &lt;key&gt;ServiceName&lt;/key&gt;
            &lt;string&gt;com.apple.synchro&lt;/string&gt;
            &lt;key&gt;ServiceProperties&lt;/key&gt;
            &lt;dict&gt;
                &lt;key&gt;stringEncoding&lt;/key&gt;
                &lt;string&gt;UCS2&lt;/string&gt;
            &lt;/dict&gt;
        &lt;/dict&gt;</b>
    &lt;/array&gt;
&lt;/dict&gt;
</pre>

<p>Save the edited file, close it and then fire up iSync. Add the phone as a new device and run a synchronisation. Voila !</p>
