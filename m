Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915C75E918B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 09:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiIYHvD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 25 Sep 2022 03:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYHu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 03:50:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5148539121;
        Sun, 25 Sep 2022 00:50:56 -0700 (PDT)
Received: from [192.168.0.108] ([91.64.235.177]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M7sYM-1oYWvD334c-0053mu; Sun, 25 Sep 2022 09:50:49 +0200
From:   "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Subject: Re[2]: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
 V0.96 controller
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 25 Sep 2022 07:50:48 +0000
Message-Id: <em98cdb3f1-82c0-4fd3-92af-9c3d062b3d0c@35bdcead.com>
In-Reply-To: <Yy7ENBX2Zo3vNgB1@kroah.com>
References: <em0b7a6682-2da4-4480-8801-1107ea9756dd@aea403bc.com>
 <Yy7ENBX2Zo3vNgB1@kroah.com>
Reply-To: "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
User-Agent: eM_Client/9.1.2109.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:52rf65inMBMmyrIZ+seb/zigRzsdSHf/6hANlgtHpAKAtAQfis8
 IIn1uXix7qRGjSdFR8+tAnjr2d5Cxkdz+BhykgQkuJm/YYGmyHkuaLei+yPlf2lzAGldrXA
 EF+c4KvJw88it43dI0fgTCozsoOYW7gta41bszCImEJtx1UwpH7BGiScIrhYtBPDgXbgOqX
 pXa0AzE1JFDNmWYkyYXDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RZLZFZIuoGE=:8JYpD2qzRGyZRHP9buRo3A
 44o0Ed3t0lRWehmwhhppJZOU023Men4FI/fpLtrKM32/jQUFtCaSmjL5cAP3EpTL0Ng4S/2mL
 Af/2E97kww8XOaZ6lruSwDnibNLxU3Yj0SSTewVuCnMaJ50y6gczeydcX4eofG6MW0CBTBDNc
 OsKT4n4o4Aq+G2LmHa12/LrVW39UMUsb6kAZuxiH8KN4FBGpCOslgpM94FJpEmFgUS0MVo4nH
 mYdFrLRh6NhTAUbv+e7c43XLrKFEskTgzOMqMj/ql9Xv3WEJS2NLPYvBvPSgpz+vDWa3dBHvK
 3oyoSXGWQZd3SDABckw27WBEHqwF2Y+an1m2JIGMRcEmcVjOcpJeDdwIU9OHg+Pb0OcXL0xMA
 6m8xYHtAGkEGn8NrrPYD7w9lSAxwfZnRHqZHz9NrIjqSEwO14svIYC0oMg5xLXTZouSxBaATO
 KSDwsxB5HzwkqEAbT1ZylS480uwtDDxnb0mQZ9FJ40UUF3zjU6jIEvJYmkxfWfNsl0/htxjdU
 ObJKMrpP6449iZmHI8nQb+dhIzkMrxz/6x4uMOOchlokvKwvrgeYqDzqZbreTMZ29SxaZ1c6h
 uv7MQtj4VrqTO0KbpoeGX5gknu9+tdq6PTHoDk7Lg9y6igP6m3+VYvXWiTAinPS9+av7LYOw6
 aeM4KMWHmY4DRIMVgKZ4AhoTQ+5Z8iO21Xq/FpPjtEb/1SUs20omO/zC+7f+tHFxgYgEmSFBG
 ufcyZ7YvDI9twqLM7l0gWzp9ImI/jNQEp0eRN6YVuA7FqE/WYieykIS2VYQR7VZiDozqATk4k
 2XffQ0ZflMF7c9KFLxThqJtrboNcA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

I'm a bit at a loss here. This is a three-line change, and I get loads 
of warnings regarding "please, no spaces at beginning of lines". I also 
got some about proper indentation... what now? Anyway. I have 
reformatted the whole section that replaces the three lines, all tab 
indents. Script/bot doesn't really like it, but looks proper to me as a 
coder.
Anyway, the issue at hand is a bit bigger. I installed mutt and git-mail 
on the dev machine, and it actually works. But guess what, when I want 
to mail out the patch to the maintainers, it gets rejected by the mailer 
daemon (not on my machine, some MTA on the way) because 1und1 (my isp 
where the email address I use is registered) has a low reputation and 
gets blacklisted. So I go and use the eMClient on my Windows machine and 
attach the patch file... I could do an uuencode and copy/paste the text, 
maybe next time.
Also, I happen to not understand this patch and patch resend business, 
apparrently. I tried to fix all check errors of scripts/checkpatch.pl, 
and amended my commit in my branch (apparrently this). So this is still 
one commit... and the patch is one patch that should go into an upstream 
commit... and that should be it.
To conclude,

- I tried to fix the format
- I can't fix the other MTA (and I won't go out and get employed at 
intel or something to have a respectable email address)
- I don't understand this resubmit business.

Can you please help? In the meantime I will re-read "The canonical patch 
format" for further insight.

with best regards

Jens Glathe


------ Originalnachricht ------
Von "Greg KH" <gregkh@linuxfoundation.org>
An "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
Cc mathias.nyman@intel.com; linux-usb@vger.kernel.org; 
linux-kernel@vger.kernel.org
Datum 24.09.2022 10:47:48
Betreff Re: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite 
being a V0.96 controller

>On Sat, Sep 24, 2022 at 08:16:34AM +0000, Jens Glathe wrote:
>>Hi there,
>>
>>second try at a patch which was an actual pain with my Lenovo T500 notebook, augmented with an USB3 PCMCIA card that has an ASM1042 chip. Inspired by this email thread: https://markmail.org/thread/7vzqbe7t6du6qsw3
>>
>>ASM1042 identifies as a 0x96 XHCI host, brings spurious transfer event errors with a r8152 (Realtek 8153a) USB3 enthernet adapter. Additionally setting quirk XHCI_SPURIOUS_SUCCESS seems to resolve this issue in this case.
>>
>>with best regards
>>
>>Jens Glathe
>>
>>---
>>
>>v1->v2
>>
>>intensive use of scripts/checkpatch.pl, reformatted the code
>>reformatted the commit text for line wraps
>
>>From ffb3a70a48b91b79943a0131ddd470e5f09c0f41 Mon Sep 17 00:00:00 2001
>>From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>Date: Sun, 28 Aug 2022 16:23:41 +0200
>>Subject: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
>>  V0.96 controller
>>
>>only if it reports as a V0.96 XHCI controller. Appears to fix the errors
>>"xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
>>current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
>>often) when using a r8152 USB3 ethernet adapter with integrated hub.
>>
>>Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>---
>>  drivers/usb/host/xhci-pci.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>>diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>index dce6c0ec8d34..f8b3b34d257e 100644
>>--- a/drivers/usb/host/xhci-pci.c
>>+++ b/drivers/usb/host/xhci-pci.c
>>@@ -305,9 +305,13 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>  		xhci->quirks |= XHCI_EP_CTX_BROKEN_DCS;
>>  	}
>>  -	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>>-		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
>>-		xhci->quirks |= XHCI_BROKEN_STREAMS;
>>+  if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>>+      pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
>>+    /* try to tame the ASMedia 1042 controller which is 0.96 */
>>+    if (xhci->hci_version == 0x96)
>>+      xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
>>+    xhci->quirks |= XHCI_BROKEN_STREAMS;
>>+  }
>>  	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>>  		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
>>  		xhci->quirks |= XHCI_TRUST_TX_LENGTH;
>>-- 2.25.1
>>
>
>Hi,
>
>This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
>a patch that has triggered this response.  He used to manually respond
>to these common problems, but in order to save his sanity (he kept
>writing the same thing over and over, yet to different people), I was
>created.  Hopefully you will not take offence and will fix the problem
>in your patch and resubmit it so that it can be accepted into the Linux
>kernel tree.
>
>You are receiving this message because of the following common error(s)
>as indicated below:
>
>- Your patch contains warnings and/or errors noticed by the
>  scripts/checkpatch.pl tool.
>
>- Your patch was attached, please place it inline so that it can be
>  applied directly from the email message itself.
>
>- This looks like a new version of a previously submitted patch, but you
>  did not list below the --- line any changes from the previous version.
>  Please read the section entitled "The canonical patch format" in the
>  kernel file, Documentation/SubmittingPatches for what needs to be done
>  here to properly describe this.
>
>If you wish to discuss this problem further, or you have questions about
>how to resolve this issue, please feel free to respond to this email and
>Greg will reply once he has dug out from the pending patches received
>from other developers.
>
>thanks,
>
>greg k-h's patch email bot
