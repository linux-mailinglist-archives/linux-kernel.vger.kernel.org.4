Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DEB6B5F48
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjCKRmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjCKRmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:42:17 -0500
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E75B1EFD8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:41:47 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id r15so5855559edq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678556143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v+m9ntVT6zRyn4E2lUXnQpNIrwyEGSazrrlPjQH0kBc=;
        b=evEJOqDUyhyJ4BAxvgh/2/8+QmDu+PYl70SiOXoV4jJoIVGtGsy/l7uB5lUAMVQ6Wt
         Fj3Vw2Zk47tLRDt8W5FfVgiW0nRF1C/T/09UItZ9xoIX/sqhwrHOWDszPY5o9YWb54BY
         /9pkJBSRp/ykglCVzUMs9vup46r8NL9emZ/DRtDRMST2IG5Ke4RPzMSGAYF3QNn8+IPo
         KarlnAsUZJvZqsY2CIgvu6YS0+d2+T2FDjob3J1qBR8mJoWdDhZHVIaop59w56aegGCc
         XDX02LvNHRHKAbjpboRqZamGwyrBSlM5Ag+Qwi5J7pR4HczeVA0FW2IpczCMaptZMoU3
         llsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556143;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v+m9ntVT6zRyn4E2lUXnQpNIrwyEGSazrrlPjQH0kBc=;
        b=Mo+mOzZDOqHpSLxxnSdup/w8oQ7/StuXRyfEV3TOGIQ2i1r3Heo17FJfK74qslgirz
         6dR6FJneLAAftaDYnHAPbOnymMPCJqNHrNWv4Uka+nHQnvLrDmtvFANw2RxNkchMp2c/
         KD3TWcuIBpvLUuktl5ZHpHTWVJ/KdxniCwGynCHicALEjIIBc9FaihAl/heueT539CsB
         ch88z532QM2LeiLaYqpghvJnCgmTPky/+oaZ5CHBmKh1Fcn7MZjF1VdHkC1QPMONS3GW
         dNBH2t77IwCjfjBTTwGXOw2J0M1f6cEM4l4fTgJern9KQWFPZzhQjvCCYPC65m0s7+2V
         I/sw==
X-Gm-Message-State: AO0yUKWuZex0HAplAf9D3SME+Kd7VthCO6oSFtvniYNr5xS+T5pVspVW
        Twv4sl2A4UrZ8TzKMlUdjfis3g==
X-Google-Smtp-Source: AK7set80VWxHVxYHu+wGmqGEYQ65EZyVH8EpLxy1MCkaCXxmE5sRxnJehdZdW9zWvh4uIdLJpizVlg==
X-Received: by 2002:a17:907:110b:b0:921:d539:1a3a with SMTP id qu11-20020a170907110b00b00921d5391a3amr1816638ejb.58.1678556143149;
        Sat, 11 Mar 2023 09:35:43 -0800 (PST)
Received: from krzk-bin.. ([2a02:810d:15c0:828:6927:e94d:fc63:9d6e])
        by smtp.gmail.com with ESMTPSA id v12-20020a170906b00c00b008c76facbbf7sm1311364ejy.171.2023.03.11.09.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:35:42 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] tpm: st33zp24: Mark ACPI and OF related data as maybe unused
Date:   Sat, 11 Mar 2023 18:35:40 +0100
Message-Id: <20230311173541.262949-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver can be compile tested with !CONFIG_OF or !CONFIG_ACPI making

  drivers/char/tpm/st33zp24/i2c.c:141:34: error: ‘of_st33zp24_i2c_match’ defined but not used [-Werror=unused-const-variable=]
  drivers/char/tpm/st33zp24/spi.c:258:34: error: ‘of_st33zp24_spi_match’ defined but not used [-Werror=unused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/char/tpm/st33zp24/i2c.c | 4 ++--
 drivers/char/tpm/st33zp24/spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index c4d0b744e3cc..2d28f55ef490 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -138,13 +138,13 @@ static const struct i2c_device_id st33zp24_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, st33zp24_i2c_id);
 
-static const struct of_device_id of_st33zp24_i2c_match[] = {
+static const struct of_device_id of_st33zp24_i2c_match[] __maybe_unused = {
 	{ .compatible = "st,st33zp24-i2c", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_st33zp24_i2c_match);
 
-static const struct acpi_device_id st33zp24_i2c_acpi_match[] = {
+static const struct acpi_device_id st33zp24_i2c_acpi_match[] __maybe_unused = {
 	{"SMO3324"},
 	{}
 };
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 2154059f0235..f5811b301d3b 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -255,13 +255,13 @@ static const struct spi_device_id st33zp24_spi_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, st33zp24_spi_id);
 
-static const struct of_device_id of_st33zp24_spi_match[] = {
+static const struct of_device_id of_st33zp24_spi_match[] __maybe_unused = {
 	{ .compatible = "st,st33zp24-spi", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, of_st33zp24_spi_match);
 
-static const struct acpi_device_id st33zp24_spi_acpi_match[] = {
+static const struct acpi_device_id st33zp24_spi_acpi_match[] __maybe_unused = {
 	{"SMO3324"},
 	{}
 };
-- 
2.34.1

