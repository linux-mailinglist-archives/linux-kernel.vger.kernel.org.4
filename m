Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81F974B146
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 14:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjGGMrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjGGMrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 08:47:40 -0400
X-Greylist: delayed 1149 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 07 Jul 2023 05:47:25 PDT
Received: from exhmta09.bpe.bigpond.com (exhmta09.bpe.bigpond.com [203.42.40.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0A311B;
        Fri,  7 Jul 2023 05:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bigpond.com
        ; s=202303; h=Content-Type:MIME-Version:Date:Message-ID:From:To:Subject;
        bh=vzhRXbz2UpgobFDiFaVPq9YFwfbsEXh4XG75B7YpJXc=; b=qTv3AgblbGiUrJdMGQ8MOG0c6b
        EhUB3ISV1ZC4ytcVyJuawAcbHzlrbOBco+B9TwHa4XOAUS4ExfOAO3JC8lqXGkx9MgOxDxJ+G6H0i
        teztreZRKnIvIUUx0Qo+7QTIHCDyxt7LbZUCrewfILxmZzJ9343bybxayeeD1dTpOjEqgen59OTrt
        Z5BdzY3b/1apJ5KKP44EUDArYXr6FxftPCYHBzOXQCps5hajpSCY6kKPsLOgJrwqSy8gDIj3FtaPi
        SJDNJqRyPp+RogcmYj2l1IIFBNfpA1uXe1Jg6HirCQHNdiwz3yN0YevAk25DHQ6e5wkgYeoyNjybe
        5c9aJtsw==;
Received: from exhprdcmr02
         by exhprdomr09 with esmtp
         (envelope-from <bids.7405@bigpond.com>)
         id 1qHkZK-0003Kj-1l
         for ;
        Fri, 07 Jul 2023 22:28:14 +1000
Received: from [101.191.138.223] (helo=[10.0.0.38])
         by exhprdcmr02 with esmtpa
        (envelope-from <bids.7405@bigpond.com>)
        id 1qHkZL-000H1k-2K;
        Fri, 07 Jul 2023 22:28:14 +1000
Subject: Re: Fwd: 3 more broken Zaurii - SL-5600, A300, C700
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
From:   Ross Maynard <bids.7405@bigpond.com>
Message-ID: <62a9e058-c853-1fcd-5663-e2e001f881e9@bigpond.com>
Date:   Fri, 7 Jul 2023 22:28:11 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ZKbuoRBi50i8OZ9d@codemonkey.org.uk>
Content-Type: multipart/mixed;
 boundary="------------8628B942F2195D19390C676E"
Content-Language: en-US
X-tce-id: bids.7405@bigpond.com
X-tce-ares-id: e{4a9eb6c6-2d9a-4e3c-8cca-a779deb79200}1
X-tce-spam-action: no action
X-tce-spam-score: 0.0
X-Cm-Analysis: v=2.4 cv=Cvt5MF0D c=1 sm=1 tr=0 ts=64a804de a=I+ymoOSk5yzZBOYXmf4WnA==:117 a=I+ymoOSk5yzZBOYXmf4WnA==:17 a=ws7JD89P4LkA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=gj2XTu5y7l5qDgVZD0wA:9 a=QEXdDO2ut3YA:10 a=TILydWMaAdQ53EHaNYoA:9 a=B2y7HmGcmWMA:10
X-Cm-Envelope: MS4xfIoILScwK33rbupbBpEtbV4ZzqANKCuQY393vXbD0WiKc6WXcEatxhUr19gldVyCIEfV2DKcKRv2Z7ovSbONdF4nJBhsrNEgtMrgj2J1dXVInPA/Hpo7 Q57QrzVo5S4Nu+gvGM7E12lHSLJySTo4GYPCPEoucFsk3tuFV3a8iUq/bpOTsQPJUGF4cWeZV0jyNA==
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
--------------8628B942F2195D19390C676E
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am not a kernel developer, but I think the attached patch would work.

Ross

On 7/7/23 2:41 am, Dave Jones wrote:
> On Thu, Jul 06, 2023 at 01:45:57PM +0200, Thorsten Leemhuis wrote:
>   > On 06.07.23 05:08, Bagas Sanjaya wrote:
>   > >>
>   > >> I notice a regression report on Bugzilla [1]. Quoting from it:
>   > >>
>   > >>> The following patch broke support of 3 more Zaurus models: SL-5600, A300 and C700
>   > >>>
>   > >>> [16adf5d07987d93675945f3cecf0e33706566005] usbnet: Remove over-broad module alias from zaurus
>   >
>   > ...
>   > He sometimes shows up on Linux kernel lists, but I doubt he cares about
>   > that change after all these years. And I would not blame him at all.
>
> That's about the size of it.  This is pretty near the bottom of my ever-shrinking
> list of kernel drivers I care about.
>
>   > Yes, we have the "no regressions" rule, but contributing a change to the
>   > kernel OTOH should not mean that you are responsible for all regressions
>   > it causes for your whole life. :-)
>
> That said, 12 years later, 16adf5d07987d93675945f3cecf0e33706566005
> is still the right thing to do. Adding actual matches for the devices
> rather than matching by class will prevent this getting loaded where it
> doesn't need to be.
>
> If someone actually cares to get this working, cargo-culting Oliver's
> change to add the extra id is likely the way forward.
>
> 	Dave
>

--------------8628B942F2195D19390C676E
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
Binary files a/drivers/net/usb/.cdc_ether.c.swp and b/drivers/net/usb/.cdc_ether.c.swp differ
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

--------------8628B942F2195D19390C676E--
