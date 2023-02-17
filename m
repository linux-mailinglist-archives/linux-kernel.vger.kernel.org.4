Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7DD69AC69
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBQN2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBQN2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:28:45 -0500
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A217465355
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:28:43 -0800 (PST)
Received: from fews1.riseup.net (fews1-pn.riseup.net [10.0.1.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx0.riseup.net (Postfix) with ESMTPS id 4PJCLy6tWNz9snQ;
        Fri, 17 Feb 2023 13:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1676640523; bh=8fASVHpyoFgeoRzMaCkRuqhdXLGnGo7qBsW5zDpbjik=;
        h=Date:From:To:Subject:In-Reply-To:References:From;
        b=ErZm9UZsvzTGeMI95HWyL9X+xVIOgIRbLD4MCMZjxuc/Qic0noHZmx/yRKPUvF1AW
         jExlJISFUQtZQFyD3MmcBnInEDH2JdVJX6cVsFPmStTCMwjPlm40OA8qWw5dB3vKZj
         w4EvIJFAQh1bIz8ikPRJzQjCGzb3S06EB26pmGxU=
X-Riseup-User-ID: 645A3C20C7D1BFB75EDEBE416DC82D77C0A378C10D6179E40B344884531EEE8A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews1.riseup.net (Postfix) with ESMTPSA id 4PJCLy3Y9bz5wGf;
        Fri, 17 Feb 2023 13:28:42 +0000 (UTC)
MIME-Version: 1.0
Date:   Fri, 17 Feb 2023 13:28:42 +0000
From:   Ivan Rubinov <linuxkernelpatch8234@riseup.net>
To:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add quirk for ADATA SX6000PNP
In-Reply-To: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
References: <87ff6272-2cfe-6b54-864e-71951118c43a@riseup.net>
Message-ID: <4b824085a2f4987f4682e3602a0e1a96@riseup.net>
Content-Type: multipart/mixed;
 boundary="=_bf0b7822c2a448583e03e9796c1547ea"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_bf0b7822c2a448583e03e9796c1547ea
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8

Ivan Rubinov писал(а) 2023-02-10 15:10:
> From 5a8f4f54c85ccb8e06b41b27bcaf19ec4f4d7c85 Mon Sep 17 00:00:00 2001
> From: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> Date: Fri, 10 Feb 2023 14:59:41 +0300
> Subject: [PATCH] Add quirk for ADATA SX6000PNP
> 
> Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>
> ---
>  drivers/nvme/host/pci.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index c734934c407c..c63443d531b3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3365,6 +3365,8 @@ static const struct pci_device_id nvme_id_table[] = {
>      { PCI_VDEVICE(INTEL, 0x0953),    /* Intel 750/P3500/P3600/P3700 */
>          .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                  NVME_QUIRK_DEALLOCATE_ZEROES, },
> +    { PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
> +        .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN | NVME_QUIRK_BOGUS_NID, },
>      { PCI_VDEVICE(INTEL, 0x0a53),    /* Intel P3520 */
>          .driver_data = NVME_QUIRK_STRIPE_SIZE |
>                  NVME_QUIRK_DEALLOCATE_ZEROES, },
I am sorry guys its doesnt work. I send new file which work

Signed-off-by: Ivan Rubinov <linuxkernelpatch8234@riseup.net>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d839689..3f4da40 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3480,6 +3480,9 @@ static const struct pci_device_id nvme_id_table[]
= {
 	{ PCI_DEVICE(0x10ec, 0x5762),   /* ADATA SX6000LNP */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
 				NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x10ec, 0x5763),   /* ADATA SX6000PNP */
+                .driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+                                NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },

--=_bf0b7822c2a448583e03e9796c1547ea
Content-Transfer-Encoding: base64
Content-Type: text/x-diff;
 name=297cca.patch
Content-Disposition: attachment;
 filename=297cca.patch;
 size=749

U2lnbmVkLW9mZi1ieTogSXZhbiBSdWJpbm92IDxsaW51eGtlcm5lbHBhdGNoODIzNEByaXNldXAu
bmV0PgoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbnZtZS9ob3N0L3BjaS5jIGIvZHJpdmVycy9udm1l
L2hvc3QvcGNpLmMKaW5kZXggZDgzOTY4OS4uM2Y0ZGE0MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9u
dm1lL2hvc3QvcGNpLmMKKysrIGIvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMKQEAgLTM0ODAsNiAr
MzQ4MCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBudm1lX2lkX3RhYmxl
W10gPSB7CiAJeyBQQ0lfREVWSUNFKDB4MTBlYywgMHg1NzYyKSwgICAvKiBBREFUQSBTWDYwMDBM
TlAgKi8KIAkJLmRyaXZlcl9kYXRhID0gTlZNRV9RVUlSS19JR05PUkVfREVWX1NVQk5RTiB8CiAJ
CQkJTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sCisJeyBQQ0lfREVWSUNFKDB4MTBlYywgMHg1NzYz
KSwgICAvKiBBREFUQSBTWDYwMDBQTlAgKi8KKyAgICAgICAgICAgICAgICAuZHJpdmVyX2RhdGEg
PSBOVk1FX1FVSVJLX0lHTk9SRV9ERVZfU1VCTlFOIHwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgTlZNRV9RVUlSS19CT0dVU19OSUQsIH0sCiAJeyBQQ0lfREVWSUNFKDB4MWNjMSwg
MHg4MjAxKSwgICAvKiBBREFUQSBTWDgyMDBQTlAgNTEyR0IgKi8KIAkJLmRyaXZlcl9kYXRhID0g
TlZNRV9RVUlSS19OT19ERUVQRVNUX1BTIHwKIAkJCQlOVk1FX1FVSVJLX0lHTk9SRV9ERVZfU1VC
TlFOLCB9LAo=
--=_bf0b7822c2a448583e03e9796c1547ea--
