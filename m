Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A0A5E9210
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 12:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiIYKVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 06:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiIYKVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 06:21:49 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0F02F672;
        Sun, 25 Sep 2022 03:21:47 -0700 (PDT)
Received: from [192.168.0.127] ([91.64.235.177]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M6ltQ-1obrKf2lEE-008Ifx; Sun, 25 Sep 2022 12:21:39 +0200
From:   "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
To:     "Greg KH" <gregkh@linuxfoundation.org>
Subject: Re[2]: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a
 V0.96 controller
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 25 Sep 2022 10:21:39 +0000
Message-Id: <em9fc0c9e0-e371-41cf-9065-1b007b937158@689b6561.com>
In-Reply-To: <YzAoUyw1opYHVFGB@kroah.com>
References: <em0b7a6682-2da4-4480-8801-1107ea9756dd@aea403bc.com>
 <Yy7ENBX2Zo3vNgB1@kroah.com>
 <em98cdb3f1-82c0-4fd3-92af-9c3d062b3d0c@35bdcead.com>
 <YzAMRPjywl0f4uSY@kroah.com>
 <emf600f901-91ef-4aea-931e-9f6fc5f42c86@689b6561.com>
 <YzAoUyw1opYHVFGB@kroah.com>
Reply-To: "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
User-Agent: eM_Client/9.1.2109.0
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------=_MB12DB44CF-DD9A-4675-A2EE-9E918E2BF1C4"
X-Antivirus: Avast (VPS 220925-0, 25.9.2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:AS8SpZUFIW+fxoM1N7kzRjiQLDoU1GjBHGHV9m81vmI2SFv26Xf
 vpgEvnVQKXAA/ksZBEYEUPYzUyKMqerNGk43NOisdXWl2zLzecE/OF8yU+qhatXt6CqzlYY
 kkqQK5NkDz0CtW4fqlHy/pRCYe0V8bxQRELxi2fwwBAOtmwBLi6du1xPcsacPS3twxePFut
 t2oXFHrGEcAh/R+VxFTUw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F2MPB5Z5RjY=:CEZLTNNz+Ho5WAK5NqJ4sI
 bCXb6t/HCJGGU/V5+4Z3DweqsxUhJM1EXwCDn9l2hS3zc25CrwKlSn0LcAPrdQVZRZArCQlCU
 bgCkeWMUDbidHlJ2WIs1YgsLYt36EHODN8vUpin9YJgudmJhF1HTx7UMfpxIX6YGDLsnofOs4
 R3yLaOpnbKRSApfLVtF5nN3Mxp9KXugc/wlg19a1gyRTFQSGvcylF/YKaaVWCQU3aTF3FYpGz
 JnWnKmaUp7oVRiq8AITXWP6PqC6yTs6o7uiNQ14+pg/p5cEDZdg46cOwYJhwFP4sZiJOTPEAS
 twcsjA5RItIlD6ezLHhf6DNS6Y1e0GbMx5nQLprBo40YM4VV0gN+e5nMk5+cuNFz0fOPjE8JB
 8ze6zT5TTnKAwUihmB1i+VJcs4zV78PlBQw6WfUbr/iYwkCWMxjMq5SEwDRIOG8lgCTFJHO+F
 nkPLs/WJBnX8qRDCPBSoJak+Esd4SXeq+iSLUL5lbuPPwsW1F5hGqQnN2vomjD4tDJKgfjrdd
 rYcStEiZ3zsyiocYWCoCNDdIDD0/XIhivn9V2nkjgJP4/R2fMupJ80A2c0pdEw9cuPfAZbEjC
 jXLgqtNlKTad9D9ySaLxxZLjOri3pXSCs8ytLIAe0ujbI8InU7gdMz0V8jlUhMBlHGt6VASeC
 31MKJfiPij6Yh+hF3vtaJZGUANfUMNgYti/1x8ZtmGo6wAshp8UyW6/e/CHZCbSKA+z94BA7V
 QMPz/5ClzipCZ9ZW6qS6LWwQFg7MjiLscN/knLnxOjVRajGfXVlmkh1yP+Z26otoGHm/EocJU
 DJjcLCVMOvsLbHilnibz2ldv0aZCA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------=_MB12DB44CF-DD9A-4675-A2EE-9E918E2BF1C4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

... and this is the moment where I append the patch file in hope that=20
this somehow works.

with best regards

Jens Glathe

------ Originalnachricht ------
Von "Greg KH" <gregkh@linuxfoundation.org>
An "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
Cc mathias.nyman@intel.com; linux-usb@vger.kernel.org;=20
linux-kernel@vger.kernel.org
Datum 25.09.2022 12:07:15
Betreff Re: [PATCH v2] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite=20
being a V0.96 controller

>On Sun, Sep 25, 2022 at 10:02:53AM +0000, Jens Glathe wrote:
>>Yep, found it. Them pesky editors...
>>
>>thanks,
>>
>>Jens Glathe
>>
>>---
>>
>> > From 8d6e467569118b83a4622edf09768ba20aef5086 Mon Sep 17 00:00:00 2001
>>From: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>Date: Sun, 28 Aug 2022 16:23:41 +0200
>>Subject: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being=
 a
>>  V0.96 controller
>>
>>only if it reports as a V0.96 XHCI controller. Appears to fix the errors
>>"xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
>>current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
>>often) when using a r8152 USB3 ethernet adapter with integrated hub.
>>
>>Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>---
>>  drivers/usb/host/xhci-pci.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>index dce6c0ec8d34..d1b8e7148dd1 100644
>>--- a/drivers/usb/host/xhci-pci.c
>>+++ b/drivers/usb/host/xhci-pci.c
>>@@ -306,8 +306,12 @@ static void xhci_pci_quirks(struct device *dev, stru=
ct
>>xhci_hcd *xhci)
>>      }
>>
>>      if (pdev->vendor =3D=3D PCI_VENDOR_ID_ASMEDIA &&
>>-        pdev->device =3D=3D PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
>>+        pdev->device =3D=3D PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
>>+        /* try to tame the ASMedia 1042 controller which is 0.96 */
>>+        if (xhci->hci_version =3D=3D 0x96)
>>+            xhci->quirks |=3D XHCI_SPURIOUS_SUCCESS;
>>          xhci->quirks |=3D XHCI_BROKEN_STREAMS;
>>+    }
>>      if (pdev->vendor =3D=3D PCI_VENDOR_ID_ASMEDIA &&
>>          pdev->device =3D=3D PCI_DEVICE_ID_ASMEDIA_1042A_XHCI) {
>>          xhci->quirks |=3D XHCI_TRUST_TX_LENGTH;
>>--
>>2.25.1
>>
>>---
>>
>>replaced spaces with tabs
>
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
>- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
>  and can not be applied.  Please read the file,
>  Documentation/email-clients.txt in order to fix this.
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
--------=_MB12DB44CF-DD9A-4675-A2EE-9E918E2BF1C4
Content-Type: text/plain;
 name=0001-fix-add-XHCI_SPURIOUS_SUCCESS-to-ASM1042-despite-bei.patch;
 charset=iso-8859-1
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename=0001-fix-add-XHCI_SPURIOUS_SUCCESS-to-ASM1042-despite-bei.patch

RnJvbSA4ZDZlNDY3NTY5MTE4YjgzYTQ2MjJlZGYwOTc2OGJhMjBhZWY1MDg2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKZW5zIEdsYXRoZSA8amVucy5nbGF0aGVAb2xkc2Nob29sc29s
dXRpb25zLmJpej4KRGF0ZTogU3VuLCAyOCBBdWcgMjAyMiAxNjoyMzo0MSArMDIwMApTdWJqZWN0
OiBbUEFUQ0hdIGZpeDogYWRkIFhIQ0lfU1BVUklPVVNfU1VDQ0VTUyB0byBBU00xMDQyIGRlc3Bp
dGUgYmVpbmcgYQogVjAuOTYgY29udHJvbGxlcgoKb25seSBpZiBpdCByZXBvcnRzIGFzIGEgVjAu
OTYgWEhDSSBjb250cm9sbGVyLiBBcHBlYXJzIHRvIGZpeCB0aGUgZXJyb3JzCiJ4aGNpX2hjZCA8
YWRkcmVzcz47IEVSUk9SIFRyYW5zZmVyIGV2ZW50IFRSQiBETUEgcHRyIG5vdCBwYXJ0IG9mCmN1
cnJlbnQgVEQgZXBfaW5kZXggMiBjb21wX2NvZGUgMTMiIHRoYXQgYXBwZWFyIHNwdXJpb3VzbHkg
KG9yIHByZXR0eQpvZnRlbikgd2hlbiB1c2luZyBhIHI4MTUyIFVTQjMgZXRoZXJuZXQgYWRhcHRl
ciB3aXRoIGludGVncmF0ZWQgaHViLgoKU2lnbmVkLW9mZi1ieTogSmVucyBHbGF0aGUgPGplbnMu
Z2xhdGhlQG9sZHNjaG9vbHNvbHV0aW9ucy5iaXo+Ci0tLQogZHJpdmVycy91c2IvaG9zdC94aGNp
LXBjaS5jIHwgNiArKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMgYi9kcml2
ZXJzL3VzYi9ob3N0L3hoY2ktcGNpLmMKaW5kZXggZGNlNmMwZWM4ZDM0Li5kMWI4ZTcxNDhkZDEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2hvc3QveGhjaS1wY2kuYworKysgYi9kcml2ZXJzL3Vz
Yi9ob3N0L3hoY2ktcGNpLmMKQEAgLTMwNiw4ICszMDYsMTIgQEAgc3RhdGljIHZvaWQgeGhjaV9w
Y2lfcXVpcmtzKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHhoY2lfaGNkICp4aGNpKQogCX0K
IAogCWlmIChwZGV2LT52ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9BU01FRElBICYmCi0JCXBkZXYt
PmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX0FTTUVESUFfMTA0Ml9YSENJKQorCQlwZGV2LT5kZXZp
Y2UgPT0gUENJX0RFVklDRV9JRF9BU01FRElBXzEwNDJfWEhDSSkgeworCQkvKiB0cnkgdG8gdGFt
ZSB0aGUgQVNNZWRpYSAxMDQyIGNvbnRyb2xsZXIgd2hpY2ggaXMgMC45NiAqLworCQlpZiAoeGhj
aS0+aGNpX3ZlcnNpb24gPT0gMHg5NikKKwkJCXhoY2ktPnF1aXJrcyB8PSBYSENJX1NQVVJJT1VT
X1NVQ0NFU1M7CiAJCXhoY2ktPnF1aXJrcyB8PSBYSENJX0JST0tFTl9TVFJFQU1TOworCX0KIAlp
ZiAocGRldi0+dmVuZG9yID09IFBDSV9WRU5ET1JfSURfQVNNRURJQSAmJgogCQlwZGV2LT5kZXZp
Y2UgPT0gUENJX0RFVklDRV9JRF9BU01FRElBXzEwNDJBX1hIQ0kpIHsKIAkJeGhjaS0+cXVpcmtz
IHw9IFhIQ0lfVFJVU1RfVFhfTEVOR1RIOwotLSAKMi4yNS4xCgo=
--------=_MB12DB44CF-DD9A-4675-A2EE-9E918E2BF1C4--

