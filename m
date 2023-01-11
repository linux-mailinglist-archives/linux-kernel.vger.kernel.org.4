Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F1B665A7D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjAKLlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233799AbjAKLkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:40:18 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F78263DE;
        Wed, 11 Jan 2023 03:39:38 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id f20so15718935lja.4;
        Wed, 11 Jan 2023 03:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F278+CdLu00LGOW20/JjUK3+T9UMs52TWsYg/Ly3uH4=;
        b=UwYrL8UnUhJDw57/zjh8AdHAwxztTwIZhhQLjooHcoNZkxUhBvLFf56JRwrqCC+vMQ
         bzny4hMhbIJP+264xtvnTahD8GzhsJJoVbDAghK7A82UgICDeo2orAQHEss0LM8Lkfz+
         eh46J07tqz0l6ZhVejPsr9RU6I2DLbcsw1AMwvbCCKpH77cnAoWVQpb3Yrq8mzlcA0MX
         DGDf2X5csuoRP7gLyJBPWG3ZIAsg2CJoyVXH8pOfvQ91JRPpI2AjLtv+SV7taHH8O672
         EMYsbQG6GSaF94UD973lMPCbJnkLAIV++xJh5CiRArYU6WAfjZWSEqNcUK4814cYSmy3
         FvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F278+CdLu00LGOW20/JjUK3+T9UMs52TWsYg/Ly3uH4=;
        b=eI1jyn8s/afw7TNjsE4uUgQRawNvQGAr81isHbITf6dkdnww8nAgFqO/TaTU5X3jZf
         fFbUVIQSo3vncTlEDIa3tRRQLd/wKBoZoHgIuFDlXpsyOozjpRgbNKatUWDLlzux+5Lk
         je7+hP+a1DspkTdBOf8PN/SfdWPU7s/Ma5ylrmpDwdWfSEIkiLxTack8SrvjnXGoKT8s
         CrJij9h19wyKRE5ZajjLuDkowoFfg9tIP9grllVNkk1FSm53TrtbDtYAOXtV65VgyIQk
         SHWDBi5GMYQBipoQ6gxKheDH2UIOJq6ThkuDe1boz/3dfGJATaOPsNhnme0L6tjs25z6
         0nHQ==
X-Gm-Message-State: AFqh2kpqlMU89elL3EdcKtMjtTTIxOJdqCTwauAIBwpOnI5PZ+HowJLY
        kjONNvOhi6h0yvM0Bg3tVNs=
X-Google-Smtp-Source: AMrXdXuODS09DBJLpA4KXi0N30+8JtV3HKr0e+mreGnisaz4yoJkGzE9Z1jrgPPRju5GLwZ+SYb5yg==
X-Received: by 2002:a2e:3807:0:b0:27f:ca4c:304 with SMTP id f7-20020a2e3807000000b0027fca4c0304mr13795174lja.11.1673437176442;
        Wed, 11 Jan 2023 03:39:36 -0800 (PST)
Received: from PC10319.67 ([82.97.198.254])
        by smtp.googlemail.com with ESMTPSA id h23-20020a05651c125700b0027fffd54dadsm1708863ljh.73.2023.01.11.03.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 03:39:36 -0800 (PST)
From:   Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Konstantin Aladyshev <aladyshev22@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: ethanolx: Add BIOS flash chip
Date:   Wed, 11 Jan 2023 14:39:34 +0300
Message-Id: <20230111113934.1176-1-aladyshev22@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a BIOS flash chip to the DTS to open a possibility to reflash the
main CPU BIOS from the BMC.

Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
index 8d84dcc06221..5f9093c58e8c 100644
--- a/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-amd-ethanolx.dts
@@ -63,6 +63,17 @@ flash@0 {
 	};
 };
 
+&spi1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_spi1_default>;
+	flash@0 {
+		status = "okay";
+		m25p,fast-read;
+		label = "bios";
+		spi-max-frequency = <100000000>;
+	};
+};
 
 &mac0 {
 	status = "okay";
-- 
2.25.1

