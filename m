Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A076F6637DD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 04:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjAJDfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 22:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjAJDfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 22:35:30 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7547035926
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 19:35:27 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so16272253lfa.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 19:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=profian-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UosNqGA9C/XIdHT1k8S2LsPXYWx8A3sEk/zWC7bC67s=;
        b=xwwEbEXD12KZoQtAd4yCi07zYXy9XoxjKp5yUWCQlIjjdY5yqyduY7kzQVOSxNQ5B3
         Z6WaC1d+4GyseI5Eu3f9HSqSXLAc4CDM8eV4sATmPaChxQ9/7R2bCxyUFSoxu9nNzOcn
         bRHdD8sQs6M5SeNmJfSH9N9ou4QggFa1IN5anjzTsWots1ygtD9CU+VmN2PTtAYPcajB
         fFSxIawiHTNgaV30nLANYlJAIJVHg2pFfRLs2rW2aZ++zI87Ld4xH/q74sOw0eufikq8
         AiPlKm57Ecbtcc08gMqOeeWQVsuWaPwea53fvRi7EisQ5egBdEtvcKOdhCTLcNRUecc3
         XJaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UosNqGA9C/XIdHT1k8S2LsPXYWx8A3sEk/zWC7bC67s=;
        b=4O3ykvGkHfJ3F+Y4ydLFPJjDZlJ/ClSyyhHqgwARCwelPCTlGcjdZXNUv73o2xDLX3
         lM/TtKgzrGU4FS1g0zHqN4/Tda1iDjke/JxnblSwARi5p2cIcnyjtHZ4BGfORm3BA1P4
         JcweILYTU1SDljNmT0PTfiem/GmpxgdEIxE8XeXRC6Vj4KGe28vCx5vVFXWuW9KAos5p
         2e7Phc8yq686pYyTE8IyY3bgzJcvZAviJRHQ26rx1DF78QkBu/Z87K53sVk8bMGEPcie
         GvvRi2pIj4HNEfZoOyPBz0F5f8CZmDQ4B6anvpmUAdLcNjlvbIIN2q+5ct3zpNV+DdyI
         CSeQ==
X-Gm-Message-State: AFqh2krsRCQlG+0jse6H2xdDUiRR/xjWqdz5OiexRBnSabejDkCrfb1U
        bhR+KX4Srk6DuSH4/Qt7ZdxVbg==
X-Google-Smtp-Source: AMrXdXsd0exkiXSWIxI6iXBfC1lzwBbDYhmrGgcgZfUVpJdIRiQnA8sbXQ63dUcWRs9pClckNjlGng==
X-Received: by 2002:a05:6512:b22:b0:4cb:154d:2175 with SMTP id w34-20020a0565120b2200b004cb154d2175mr14399098lfu.30.1673321725738;
        Mon, 09 Jan 2023 19:35:25 -0800 (PST)
Received: from localhost (83-245-197-49.elisa-laajakaista.fi. [83.245.197.49])
        by smtp.gmail.com with ESMTPSA id c14-20020a056512074e00b004cb3a55feacsm1941490lfs.100.2023.01.09.19.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 19:35:25 -0800 (PST)
From:   Jarkko Sakkinen <jarkko@profian.com>
To:     Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        John Allen <john.allen@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Jarkko Sakkinen <jarkko@profian.com>,
        linux-crypto@vger.kernel.org (open list:AMD CRYPTOGRAPHIC COPROCESSOR
        (CCP) DRIVER - SE...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] crypto: ccp: Sanitize sev_platform_init() error messages
Date:   Tue, 10 Jan 2023 03:35:20 +0000
Message-Id: <20230110033520.66560-1-jarkko@profian.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following functions end up calling sev_platform_init() or
__sev_platform_init_locked():

* sev_guest_init()
* sev_ioctl_do_pek_csr
* sev_ioctl_do_pdh_export()
* sev_ioctl_do_pek_import()
* sev_ioctl_do_pek_pdh_gen()
* sev_pci_init()

However, only sev_pci_init() prints out the failed command error code, and
even there, the error message does not specify which SEV command failed.

Address this by printing out the SEV command errors inside
__sev_platform_init_locked(), and differentiate between DF_FLUSH, INIT and
INIT_EX commands.  As a side-effect, @error can be removed from the
parameter list.

This extra information is particularly useful if firmware loading and/or
initialization is going to be made more robust, e.g. by allowing firmware
loading to be postponed.
---
v4:
* Sorry, v3 was malformed. Here's a proper patch.

v3:
* Address Tom Lendacky's feedback:
  https://lore.kernel.org/kvm/8bf6f179-eee7-fd86-7892-cdcd76e0762a@amd.com/

v2:
* Address David Rientjes's feedback:
  https://lore.kernel.org/all/6a16bbe4-4281-fb28-78c4-4ec44c8aa679@google.com/
* Remove @error.
* Remove "SEV_" prefix: it is obvious from context so no need to make klog
  line longer.

Signed-off-by: Jarkko Sakkinen <jarkko@profian.com>
---
 drivers/crypto/ccp/sev-dev.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 06fc7156c04f..bdc43e75c78b 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -476,19 +476,23 @@ static int __sev_platform_init_locked(int *error)
 		dev_err(sev->dev, "SEV: retrying INIT command because of SECURE_DATA_INVALID error. Retrying once to reset PSP SEV state.");
 		rc = init_function(&psp_ret);
 	}
-	if (error)
+	if (rc) {
+		dev_err(sev->dev, "SEV: %s failed error %#x",
+			sev_init_ex_buffer ? "CMD_INIT_EX" : "CMD_INIT", psp_ret);
 		*error = psp_ret;
-
-	if (rc)
 		return rc;
+	}
 
 	sev->state = SEV_STATE_INIT;
 
 	/* Prepare for first SEV guest launch after INIT */
 	wbinvd_on_all_cpus();
-	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, error);
-	if (rc)
+	rc = __sev_do_cmd_locked(SEV_CMD_DF_FLUSH, NULL, &psp_ret);
+	if (rc) {
+		dev_err(sev->dev, "SEV: CMD_DF_FLUSH failed error %#x", psp_ret);
+		*error = psp_ret;
 		return rc;
+	}
 
 	dev_dbg(sev->dev, "SEV firmware initialized\n");
 
@@ -1337,8 +1341,7 @@ void sev_pci_init(void)
 	/* Initialize the platform */
 	rc = sev_platform_init(&error);
 	if (rc)
-		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
-			error, rc);
+		dev_err(sev->dev, "SEV: failed to INIT rc %d\n", rc);
 
 	return;
 
-- 
2.38.1

