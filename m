Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD5C5EA826
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiIZOQX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Sep 2022 10:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiIZOP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:15:59 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C066106F7F;
        Mon, 26 Sep 2022 05:26:07 -0700 (PDT)
Received: from [192.168.0.127] ([84.175.93.28]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9Mh8-1pHRW61qoG-015KSY; Mon, 26 Sep 2022 14:25:50 +0200
From:   "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
To:     "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        mathias.nyman@intel.com
Subject: Re[2]: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite being a V0.96
 controller
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Sep 2022 12:25:49 +0000
Message-Id: <emdf9049cf-39a6-4c77-9c88-c1f08f179fc1@bea64cbc.com>
In-Reply-To: <c1857a88-2303-43d7-5539-37afd2401a12@linux.intel.com>
References: <20220925172236.2288-1-jens.glathe@oldschoolsolutions.biz>
 <c1857a88-2303-43d7-5539-37afd2401a12@linux.intel.com>
Reply-To: "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>
User-Agent: eM_Client/9.1.2109.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
X-Antivirus: Avast (VPS 220926-0, 26.9.2022), Outbound message
X-Antivirus-Status: Clean
X-Provags-ID: V03:K1:T7BPx3bGmQluFqiWGnwKYhN64BQMtgqB+BT0LOkY/295dyL1TKU
 6wafZx5Ea2HrANHWLKPvCiJ+vxk2O+4h2MCb10S0iVaCayMwm9v2yejCmqe1IqcC97Xn6QI
 adWLI3xycqJuXMSVmOkN4CgVA7yGzm8XYbCP2fwDYtzKcETRbAVgok4TBD2TpbTV6zFbooP
 y5ng/LaKh7MhiW3tFhrFw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WRM+wmWS6ic=:QiDzmalfG2zg/ywdq47NF0
 6zeFQNtZPuU6OfTdtveodGkSZOVFq1pZ+6srjYWJtdHuk1Xa4hf94WOOvDWvGcsmGxFVY/cu3
 74IJ8qJN6M4DQvNXPt+gRGg3NR/0aeLEPw5BYoLvBRBTM67ah0tBj6u/uBcYEWI8Udi8uWwSS
 v/lIvHFdVNE0+qm6mXG4+JJ6qMQeIRNHun+/p6LsfXnENuFA1JVW0FKwxVmdph8zfcXL7ebIq
 8zMJqO+AF8qylOexwT3C4rOK0HqfoMEmT4WsU1A21/EliQ9aNRdtoXnlFK5rtND1MboiPJH3+
 hVQPCWwDMOaZnQtMIwKhuvd1vnDTAlLdSr6glFl/VTzYyEn3paePkCcmgM0ymSXPBxTG7TcDH
 8nSaMvHE8MGiGW41W0RY9n9Z8JDienVNHde3WCKp/EBdL1wNhoL3XcDRLQleFVgOFie+nmXMR
 Mgz4lAwA6IAv2+Lsyy9tt6BR6za1rnt/C3kAmQ3HEAquKc0WUtpThGviUwYuick3nnb1srq9R
 LnIuMaTSCP3cGD+q+e/9s+Y8jxBKa4V+k8JWtLbdp2wdcJjRW1FhL1uM1bSACebpF++lN+pxk
 eFnHIqtCI0FvbuxV+XpuPoHZcoA/smOMwZS0UY9WCjC8xL6ZZ9McKLtCZo1h2xUViiT8t7XDJ
 8AcR/dvS6XC6bQLC4R1MiYFwbCMs58M+GWx0K86zF3P2CckqpuNzXNxfno5vxCSzYcwWVOUSi
 q2N3vxOcYdgK+lsAwyHanUl4UpSJWAeP78FwHWpaDIl0XM8NY4fTmUlPdidpXP7oPNa2A7xoO
 t/1QlxuEPy1G49F5mqSQgODyiDqQw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

thank you for the hint, I'll amend the commit text. For practical 
purposes you won't need to check for ASM1042/0x96, however according to 
documentation it *should* be a V1.0 XHCI controller. So, the defensive 
approach would be to check for it (so its a quirk only in this case), 
the outcome without checking would be the same. I can take it out, 
adding the quirk for ASM1042 would be sufficient.

with best regards

Jens

------ Originalnachricht ------
Von "Mathias Nyman" <mathias.nyman@linux.intel.com>
An "Jens Glathe" <jens.glathe@oldschoolsolutions.biz>; 
mathias.nyman@intel.com
Cc gregkh@linuxfoundation.org; linux-usb@vger.kernel.org; 
linux-kernel@vger.kernel.org
Datum 26.09.2022 13:31:42
Betreff Re: [PATCH] fix: add XHCI_SPURIOUS_SUCCESS to ASM1042 despite 
being a V0.96 controller

>Hi
>
>Thanks for the patch, some small changes still needed:
>
>Include subsystem in subject line, something like
>usb: xhci: Add XHCI_SPURIOUS...
>
>On 25.9.2022 20.22, Jens Glathe wrote:
>>only if it reports as a V0.96 XHCI controller. Appears to fix the errors
>>"xhci_hcd <address>; ERROR Transfer event TRB DMA ptr not part of
>>current TD ep_index 2 comp_code 13" that appear spuriously (or pretty
>>often) when using a r8152 USB3 ethernet adapter with integrated hub.
>>
>>Signed-off-by: Jens Glathe <jens.glathe@oldschoolsolutions.biz>
>>---
>>   drivers/usb/host/xhci-pci.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>>diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
>>index dce6c0ec8d34..d1b8e7148dd1 100644
>>--- a/drivers/usb/host/xhci-pci.c
>>+++ b/drivers/usb/host/xhci-pci.c
>>@@ -306,8 +306,12 @@ static void xhci_pci_quirks(struct device *dev, struct xhci_hcd *xhci)
>>   	}
>>     	if (pdev->vendor == PCI_VENDOR_ID_ASMEDIA &&
>>-		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI)
>>+		pdev->device == PCI_DEVICE_ID_ASMEDIA_1042_XHCI) {
>>+		/* try to tame the ASMedia 1042 controller which is 0.96 */
>>+		if (xhci->hci_version == 0x96)
>
>Do we need this 0x96 check? It's anyway set for 1.0 and newer controllers
>
>>+			xhci->quirks |= XHCI_SPURIOUS_SUCCESS;
>
>This reminds me that I should get rid of this quirk.
>
>If we get a short transfers event for a TRB mid TD, then xhci hosts version 1.0 and later
>should send a second event for the last TRB in the TD
>
>so this is default behavior for modern xHCI, not a spurious event.
>
>But your patch is anyways needed for stable kernels.
>
>Thanks
>-Mathias
