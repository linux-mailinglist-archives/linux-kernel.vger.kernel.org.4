Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E6B74BD76
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 14:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGHMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjGHMd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 08:33:59 -0400
X-Greylist: delayed 1004 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 08 Jul 2023 05:33:57 PDT
Received: from clamta04.bpe.bigpond.com (clamta04.bpe.bigpond.com [203.42.22.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FA410FF;
        Sat,  8 Jul 2023 05:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bigpond.com
        ; s=202303; h=Content-Type:MIME-Version:Date:Message-ID:To:From:Subject;
        bh=KN8MhbogqqPfZzXWzBOKTuoSCrY8y/cA4YjxC6ozIg0=; b=JasHz1iTcPBpEv5Vhl5QEY2XGI
        3ZKrvr4au6i1HyCOy+wCmR53swbwcy0PpVe8K5YhbGT1jEGkue8Og+7k+bKmijNiI4rV6GthKucSS
        CUl0HLb6Q+rfOPTvonKpYfPRZEWA7MQBjR5cdm4OJJrmWV+e6EVmgO3hEWFerjAXGsZK1G0o1T8MQ
        Wu8psrUqtjcxd7g5rup4duN453Py82ppnHwwieNP4RhVXlleWTekhmieGHrJbWqLQN+YvyQ5PVLjD
        U4JrvX5KJLk9Z9QI7dswOaUb1kGk0G7jIiWRxX0G6SSOIqvgcTefPUQLJ6w5YqU9jgW6CYun02X70
        ITbjUYaA==;
Received: from claprdcmr09
         by claprdomr04 with esmtp
         (envelope-from <bids.7405@bigpond.com>)
         id 1qI6sB-0000XG-1S
         for ;
        Sat, 08 Jul 2023 22:17:11 +1000
Received: from [101.191.138.223] (helo=[10.0.0.38])
         by claprdcmr09 with esmtpa
        (envelope-from <bids.7405@bigpond.com>)
        id 1qI6sC-000BnE-20;
        Sat, 08 Jul 2023 22:17:11 +1000
Subject: Re: Fwd: 3 more broken Zaurii - SL-5600, A300, C700
From:   Ross Maynard <bids.7405@bigpond.com>
To:     Dave Jones <davej@codemonkey.org.uk>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux USB <linux-usb@vger.kernel.org>,
        Oliver Neukum <oneukum@suse.com>
References: <7ea9abd8-c35d-d329-f0d4-c8bd220cf691@gmail.com>
 <50f4c10d-260c-cb98-e7d2-124f5519fa68@gmail.com>
 <e1fdc435-089c-8ce7-d536-ce3780a4ba95@leemhuis.info>
 <ZKbuoRBi50i8OZ9d@codemonkey.org.uk>
 <62a9e058-c853-1fcd-5663-e2e001f881e9@bigpond.com>
Message-ID: <14fd48c8-3955-c933-ab6f-329e54da090f@bigpond.com>
Date:   Sat, 8 Jul 2023 22:17:07 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <62a9e058-c853-1fcd-5663-e2e001f881e9@bigpond.com>
Content-Type: multipart/mixed;
 boundary="------------C1A5963CB6D1F125BFE1F795"
Content-Language: en-US
X-tce-id: bids.7405@bigpond.com
X-tce-ares-id: e{89e004cc-fe21-4cc7-8a77-995180f13b8a}1
X-tce-spam-action: no action
X-tce-spam-score: 0.0
X-Cm-Analysis: v=2.4 cv=Sp1WqtC0 c=1 sm=1 tr=0 ts=64a953c7 a=I+ymoOSk5yzZBOYXmf4WnA==:117 a=I+ymoOSk5yzZBOYXmf4WnA==:17 a=ws7JD89P4LkA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=PhF-ru6i4W658Il2ksoA:9 a=QEXdDO2ut3YA:10 a=TILydWMaAdQ53EHaNYoA:9 a=B2y7HmGcmWMA:10
X-Cm-Envelope: MS4xfEP+jWftDyT9rMny2iy5Mx7ZeuwancAs7J/BAKAxx03PgemRlo0FDVenJrwyvfKGGl4UNvgCCdwHAc/S+BnsMrRDiGYqeSyXvpAhkUZhRwpe4zr6MSRy ca038Doqsd1li7cOiI0oYMa5UGA324kfxipQzohn3hTTH7IUNWuEcj8VbNXWb5lZIXqtuX8Lzs+6Jw==
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C1A5963CB6D1F125BFE1F795
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I applied my patch then recompiled the kernel, and the 3 devices can now 
connect via USB:

[  268.872485] usb 3-2: New USB device found, idVendor=04dd, 
idProduct=8005, bcdDevice= 0.00
[  268.872498] usb 3-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  268.872502] usb 3-2: Product: SL-A300
[  268.872505] usb 3-2: Manufacturer: Sharp
[  268.876526] zaurus 3-2:1.0 usb0: register 'zaurus' at 
usb-0000:00:14.0-2, pseudo-MDLM (BLAN) device, fa:0f:0f:08:2b:59

[  595.541549] usb 3-2: New USB device found, idVendor=04dd, 
idProduct=8006, bcdDevice= 0.00
[  595.541562] usb 3-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  595.541566] usb 3-2: Product: SL-5600
[  595.541569] usb 3-2: Manufacturer: Sharp
[  595.545148] zaurus 3-2:1.0 usb0: register 'zaurus' at 
usb-0000:00:14.0-2, pseudo-MDLM (BLAN) device, fa:0f:0f:08:2b:59

[  446.954583] usb 3-2: New USB device found, idVendor=04dd, 
idProduct=8007, bcdDevice= 0.00
[  446.954596] usb 3-2: New USB device strings: Mfr=1, Product=2, 
SerialNumber=0
[  446.954600] usb 3-2: Product: SL-C700
[  446.954603] usb 3-2: Manufacturer: Sharp
[  446.957871] zaurus 3-2:1.0 usb0: register 'zaurus' at 
usb-0000:00:14.0-2, pseudo-MDLM (BLAN) device, fa:0f:0f:08:2b:59

Could someone please submit the patch for me?

Thanks.

Ross

On 7/7/23 10:28 pm, Ross Maynard wrote:
> Hi,
>
> I am not a kernel developer, but I think the attached patch would work.
>
> Ross
>
> On 7/7/23 2:41 am, Dave Jones wrote:
>> On Thu, Jul 06, 2023 at 01:45:57PM +0200, Thorsten Leemhuis wrote:
>>   > On 06.07.23 05:08, Bagas Sanjaya wrote:
>>   > >>
>>   > >> I notice a regression report on Bugzilla [1]. Quoting from it:
>>   > >>
>>   > >>> The following patch broke support of 3 more Zaurus models: 
>> SL-5600, A300 and C700
>>   > >>>
>>   > >>> [16adf5d07987d93675945f3cecf0e33706566005] usbnet: Remove 
>> over-broad module alias from zaurus
>>   >
>>   > ...
>>   > He sometimes shows up on Linux kernel lists, but I doubt he cares 
>> about
>>   > that change after all these years. And I would not blame him at all.
>>
>> That's about the size of it.  This is pretty near the bottom of my 
>> ever-shrinking
>> list of kernel drivers I care about.
>>
>>   > Yes, we have the "no regressions" rule, but contributing a change 
>> to the
>>   > kernel OTOH should not mean that you are responsible for all 
>> regressions
>>   > it causes for your whole life. :-)
>>
>> That said, 12 years later, 16adf5d07987d93675945f3cecf0e33706566005
>> is still the right thing to do. Adding actual matches for the devices
>> rather than matching by class will prevent this getting loaded where it
>> doesn't need to be.
>>
>> If someone actually cares to get this working, cargo-culting Oliver's
>> change to add the extra id is likely the way forward.
>>
>>     Dave
>>

--------------C1A5963CB6D1F125BFE1F795
Content-Type: text/x-patch; charset=UTF-8;
 name="3-zaurii-patch.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="3-zaurii-patch.patch"

diff -urpN a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
--- a/drivers/net/usb/cdc_ether.c	2023-07-07 17:48:27.991833366 +1000
+++ b/drivers/net/usb/cdc_ether.c	2023-07-07 21:53:11.556198087 +1000
@@ -616,6 +616,13 @@ static const struct usb_device_id	produc
 }, {
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
+    .idVendor		= 0x04DD,
+    .idProduct		= 0x8005,   /* A-300 */
+    ZAURUS_FAKE_INTERFACE,
+    .driver_info        = 0,
+}, {
+    .match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
@@ -623,12 +630,26 @@ static const struct usb_device_id	produc
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
+    .idVendor		= 0x04DD,
+    .idProduct		= 0x8006,   /* B-500/SL-5600 */
+    ZAURUS_FAKE_INTERFACE,
+    .driver_info        = 0,
+}, {
+    .match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
 	.idProduct		= 0x8007,	/* C-700 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info		= 0,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+    .idVendor		= 0x04DD,
+    .idProduct		= 0x8007,   /* C-700 */
+    ZAURUS_FAKE_INTERFACE,
+    .driver_info        = 0,
+}, {
+    .match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor               = 0x04DD,
 	.idProduct              = 0x9031,	/* C-750 C-760 */
diff -urpN a/drivers/net/usb/zaurus.c b/drivers/net/usb/zaurus.c
--- a/drivers/net/usb/zaurus.c	2023-07-07 17:48:28.043849110 +1000
+++ b/drivers/net/usb/zaurus.c	2023-07-07 22:06:49.267699853 +1000
@@ -289,11 +289,25 @@ static const struct usb_device_id	produc
 	.match_flags	=   USB_DEVICE_ID_MATCH_INT_INFO
 			  | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
+	.idProduct		= 0x8005,	/* A-300 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long) &bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
 	.idProduct		= 0x8006,	/* B-500/SL-5600 */
 	ZAURUS_MASTER_INTERFACE,
 	.driver_info = ZAURUS_PXA_INFO,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8006,	/* B-500/SL-5600 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long) &bogus_mdlm_info,
+}, {
+	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 	          | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor		= 0x04DD,
 	.idProduct		= 0x8007,	/* C-700 */
@@ -301,6 +315,13 @@ static const struct usb_device_id	produc
 	.driver_info = ZAURUS_PXA_INFO,
 }, {
 	.match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
+			  | USB_DEVICE_ID_MATCH_DEVICE,
+	.idVendor		= 0x04DD,
+	.idProduct		= 0x8007,	/* C-700 */
+	ZAURUS_FAKE_INTERFACE,
+	.driver_info = (unsigned long) &bogus_mdlm_info,
+}, {
+        .match_flags    =   USB_DEVICE_ID_MATCH_INT_INFO
 		 | USB_DEVICE_ID_MATCH_DEVICE,
 	.idVendor               = 0x04DD,
 	.idProduct              = 0x9031,	/* C-750 C-760 */

--------------C1A5963CB6D1F125BFE1F795--
