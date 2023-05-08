Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECB06FA429
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbjEHJz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEHJzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:55:49 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3BB2ABE4;
        Mon,  8 May 2023 02:55:46 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pvxaq-0006bV-6U; Mon, 08 May 2023 11:55:44 +0200
Message-ID: <9b987585-0834-bb8c-3414-283c29f3f2ab@leemhuis.info>
Date:   Mon, 8 May 2023 11:55:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
To:     =?UTF-8?Q?Filipe_La=c3=adns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        guy.b@bluewin.ch
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] Since kernel 6.3.1 logitech unify receiver not working
 properly
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683539747;28b8ae58;
X-HE-SMSGID: 1pvxaq-0006bV-6U
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a regression report in bugzilla.kernel.org. As many (most?)
kernel developers don't keep an eye on it, I decided to forward it by mail.

Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217412 :

>  guy.b 2023-05-07 07:37:34 UTC
> 
> Hello,
> 
> Since kernel 6.3.1 the boot process hangs (~ 5 seconds) by uevent triggering with the following errors :
> 
> logitech-hidpp-device 0003:046D:405E.0004: hidpp_devicenametype_get_count: received protocol error 0x07
> 
> 
> The logs about logitech input:
> 
> usb 1-8: new full-speed USB device number 2 using xhci_hcd
> mai 06 11:54:24 Cockpit kernel: usb 1-8: New USB device found, idVendor=046d, idProduct=c52b, bcdDevice=24.10
> mai 06 11:54:24 Cockpit kernel: usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> mai 06 11:54:24 Cockpit kernel: usb 1-8: Product: USB Receiver
> mai 06 11:54:24 Cockpit kernel: usb 1-8: Manufacturer: Logitech
> mai 06 11:54:24 Cockpit kernel: input: Logitech USB Receiver as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.0/0003:046D:C52B.0001/input/input4
> mai 06 11:54:24 Cockpit kernel: hid-generic 0003:046D:C52B.0001: input,hidraw0: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:00:14.0-8/input0
> mai 06 11:54:24 Cockpit kernel: input: Logitech USB Receiver Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:046D:C52B.0002/input/input5
> mai 06 11:54:24 Cockpit kernel: input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:046D:C52B.0002/input/input6
> mai 06 11:54:24 Cockpit kernel: input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.1/0003:046D:C52B.0002/input/input7
> mai 06 11:54:24 Cockpit kernel: hid-generic 0003:046D:C52B.0002: input,hiddev96,hidraw1: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:00:14.0-8/input1
> mai 06 11:54:24 Cockpit kernel: hid-generic 0003:046D:C52B.0003: hiddev97,hidraw2: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-8/input2
> mai 06 11:54:24 Cockpit kernel: usbcore: registered new interface driver usbhid
> mai 06 11:54:24 Cockpit kernel: usbhid: USB HID core driver
> mai 06 11:54:24 Cockpit kernel: logitech-djreceiver 0003:046D:C52B.0003: hiddev96,hidraw0: USB HID v1.11 Device [Logitech USB Receiver] on usb-0000:00:14.0-8/input2
> mai 06 11:54:24 Cockpit kernel: input: Logitech Wireless Device PID:405e Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.2/0003:046D:C52B.0003/0003:046D:405E.0004/input/input9
> mai 06 11:54:24 Cockpit kernel: input: Logitech Wireless Device PID:405e Mouse as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.2/0003:046D:C52B.0003/0003:046D:405E.0004/input/input10
> mai 06 11:54:24 Cockpit kernel: hid-generic 0003:046D:405E.0004: input,hidraw1: USB HID v1.11 Keyboard [Logitech Wireless Device PID:405e] on usb-0000:00:14.0-8/input2:1
> mai 06 11:54:24 Cockpit kernel: input: Logitech Wireless Device PID:2010 Keyboard as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.2/0003:046D:C52B.0003/0003:046D:2010.0005/input/input14
> mai 06 11:54:24 Cockpit kernel: hid-generic 0003:046D:2010.0005: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Device PID:2010] on usb-0000:00:14.0-8/input2:2
> mai 06 11:54:24 Cockpit kernel: logitech-hidpp-device 0003:046D:405E.0004: HID++ 4.5 device connected.
> mai 06 11:54:24 Cockpit kernel: logitech-hidpp-device 0003:046D:405E.0004: hidpp_devicenametype_get_count: received protocol error 0x07
> mai 06 11:54:24 Cockpit kernel: input: Logitech Wireless Device PID:405e as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.2/0003:046D:C52B.0003/0003:046D:405E.0004/input/input18
> mai 06 11:54:24 Cockpit kernel: logitech-hidpp-device 0003:046D:405E.0004: input,hidraw1: USB HID v1.11 Keyboard [Logitech Wireless Device PID:405e] on usb-0000:00:14.0-8/input2:1
> mai 06 11:54:24 Cockpit kernel: input: Logitech Wireless Device PID:2010 as /devices/pci0000:00/0000:00:14.0/usb1/1-8/1-8:1.2/0003:046D:C52B.0003/0003:046D:2010.0005/input/input19
> mai 06 11:54:24 Cockpit kernel: logitech-hidpp-device 0003:046D:2010.0005: input,hidraw2: USB HID v1.11 Keyboard [Logitech Wireless Device PID:2010] on usb-0000:00:14.0-8/input2:2
> 
> Next, once booted and remove the unify receiver and plug it again there is a massive lag (~ 15 seconds) before that the receiver get ready for the mouse and keyboard to be functional with following errors :
> 
> kernel: logitech-hidpp-device 0003:046D:405E.0022: hidpp_devicenametype_get_count: received protocol error 0x07
> kernel: logitech-hidpp-device 0003:046D:405E.0023: Couldn't get wheel multiplier (error -110)
> 
> Unify receiver with K800 keyboard and M720 Triathlon mouse paired.
> 
> This happens on my desktop computer but not on my laptop with a unify receiver and a marathon M705 mouse.
> 
> Both computer are on Archlinux and up to date.
> 
> On the desktop the boot is fine without the unify receiver.
> 
> Let me know if you need more info.
> 
> Thank you.


See the ticket for more details.

Note, there are two users affected by this (see Comment 5 for the
second), but you have to use bugzilla to reach the second reporter, as I
sadly[1] can not simply CCed them in mails like this (the initial
reporter gave permission).


[TLDR for the rest of this mail: I'm adding this report to the list of
tracked Linux kernel regressions; the text you find below is based on a
few templates paragraphs you might have encountered already in similar
form.]

BTW, let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.2..v6.3
https://bugzilla.kernel.org/show_bug.cgi?id=217412
#regzbot title: input: hid: logitech unify receiver not working properly
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (e.g. the buzgzilla ticket and maybe this mail as well, if
this thread sees some discussion). See page linked in footer for details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

[1] because bugzilla.kernel.org tells users upon registration their
"email address will never be displayed to logged out users"
