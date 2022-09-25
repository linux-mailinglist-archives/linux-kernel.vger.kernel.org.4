Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A9E5E91F9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 12:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiIYKDF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Sep 2022 06:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiIYKDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 06:03:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A2F2D1C5;
        Sun, 25 Sep 2022 03:03:00 -0700 (PDT)
Received: from [192.168.0.127] ([91.64.235.177]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MFbeC-1oT1t211Li-00H8SC; Sun, 25 Sep 2022 12:02:54 +0200
From:   "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Subject: Re[2]: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
 V0.96 controller
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 25 Sep 2022 10:02:53 +0000
Message-Id: <emf600f901-91ef-4aea-931e-9f6fc5f42c86@689b6561.com>
In-Reply-To: <YzAMRPjywl0f4uSY@kroah.com>
References: <em0b7a6682-2da4-4480-8801-1107ea9756dd@aea403bc.com>
 <Yy7ENBX2Zo3vNgB1@kroah.com>
 <em98cdb3f1-82c0-4fd3-92af-9c3d062b3d0c@35bdcead.com>
 <YzAMRPjywl0f4uSY@kroah.com>
Reply-To: "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
User-Agent: eM_Client/9.1.2109.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 220925-0, 25.9.2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:UjyPzN9xA+BV8yt7/uKApa7MlyAApoMJrjkutUjuN5pNAf+h9cG
 hvXHtubIP5h+gTx14ivHivK3QskF0R2EY2t/Bx9SjfWz1q+UR03cUiLicOliB+l+tskmiX5
 grBvAnqB81Z41CXs5IWcJvc/tHhhpYSbg0m4UnGiCdYZW69smU3FcR64fmnn6eh1Q7+EaHH
 odAa3TxGXMckJ3rOmIVMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lqQpY1Snbtw=:krZyYQqqcP0+XOAMeHlZW+
 J7kgD9MS/DXwV9gCGLUX4xP5wiDGVYrLwIx6b6IxTM5QFYJ6uN36pgL0XO03Hw3l76gR3BPM2
 zfkHqNfLqzD5jWe0vJdQmiS+tmKBBsGBtY58wtXC45fmYHY/HHG+wTYukVG58LbHGOsV6zzv1
 Ns3dbWBSRmBmYrLhkMcccja7G7V+l0hPbi3mFC2aJlsum1dk9u3V000guePwI6NOa1ORWgMSX
 GhgRrZ7UG+ezJxrd1/CsOTFZwSt7nEVp9oVieoN9INgXyMwQkf5vSOxtxHoJ1Hn2onFXyaBV0
 sbIOCpfITOlXTRilPszFe+ez4TlJYG5lbRqgynwrCKDstfoX1uOz9kUdHqgEX6GWvXEGgMNaI
 n/dDveWCZa2XEaGj5LycQYvN0FWUOtpdXsEXIG0Xs7goRZghORyXWVv34lhd7bvYr9XM3Q7QJ
 zPeTjiEAenfAQzacH5Lzsuh/x1C6DE8yjnagt3DgU9zZLqQ/+EdL41K28JhdIk21bpnIKoTog
 Ld6iPEx1IRo558nM/knLNajAj/9yRa+eIk2Hh08ARrZjGgaT66+FvTzpHfgqVL+BjJpWn1sTI
 Vx5VnkxUJlmXO3zlIoTBAUNgW90Pl/qtE2/4MgUBFSJ34vnwCGQ4t+RPHxHLWMoXwiYKcc/TZ
 fi4qrLSVUzYPLADLdoUVpDCWDqIyn6tx7Zd2AMmpQeBY8KUQwmmaRLCWHuT7ksLyIR+d8Sx+n
 aobh1LiypgBPRRGO4RjwZVdoY+3VUtEb9jeUt4e+Y3FAepnhPiBw41tc4UC/u9S2SMs+QwvmU
 ztwzWklRbo905wChwbK3HtFOVZH5Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, found it. Them pesky editors...

thanks,

Jens Glathe

---

From 8d6e467569118b83a4622edf09768ba20aef5086 Mon Sep 17 00:00:00 2001
From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
Date: Sun, 28 Aug 2022 16:23:41 +0200
Subject: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being 
a
  V0.96 controller

only if it reports as a V0.96 XHCI controller. Appears to fix the errors
"xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
often) when using a r8152 USB3 ethernet adapter with integrated hub.

Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
---
  drivers/usb/host/xhci-pci.c | 6 +++++-
  1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
index dce6c0ec8d34..d1b8e7148dd1 100644
--- a/drivers/usb/host/xhci-pci.c
+++ b/drivers/usb/host/xhci-pci.c
@@ -306,8 +306,12 @@ static void xhci_pci_quirks(struct device *dev, 
struct xhci_hcd *xhci)
      }

      if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
-        pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
+        pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
+        /* try to tame the ASMedia 1042 controller which is 0.96 */
+        if (xhci->hci_version == 0x96)
+            xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
          xhci->quirks |= XHCI_BROKEN_STREAMS;
+    }
      if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
          pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
          xhci->quirks |= XHCI_TRUST_TX_LENGTH;
--
2.25.1

---

replaced spaces with tabs


------ Originalnachricht ------
Von "Greg KH" <gregkh@linuxfoundation.org>
An "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
Cc mathias.nyman@intel.com; linux-usb@vger.kernel.org; 
linux-kernel@vger.kernel.org
Datum 25.09.2022 10:07:32
Betreff Re: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite 
being a V0.96 controller

>On Sun, Sep 25, 2022 at 07:50:48AM +0000, Jens Glathe wrote:
>>Hi there,
>>
>>I'm a bit at a loss here. This is a three-line change, and I get loads of
>>warnings regarding "please, no spaces at beginning of lines".
>
>Yes, that's not allowed, kernel development uses tabs, not spaces.  Fix
>that up and resend and all should be good.
>
>thanks,
>
>greg k-h
