Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB17269E671
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234821AbjBURyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjBURyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:54:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3469E2ED6B;
        Tue, 21 Feb 2023 09:54:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id ec43so20056654edb.8;
        Tue, 21 Feb 2023 09:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2cvh0M4miY/BiqN/UdWftX82fG+Lj6GlwYOBUkwznvo=;
        b=cBa6WRllV+su64zJBcA5Ebb57h84BMkCI47BRx7vs9wpaKO0YylJsSHxaF4lJHPpNs
         hfLV2+KYNq6WRS0HLCAsgAIgLmmtpbRN0JlFk3cFJ/BK6U8msQZ0V+R4sC5+HweYsO+z
         mxEzounI70ZVLJKLNLYSk4zT99qZzhoo1o5ktifW/yUIIcoDKh/QgKBA1aTi/1XDI6lb
         ZC9EGsBEKze1MC9CX9PvzEK4DJWnPprqdvrZ0J3/c21B+ov4PRJY1GOKz8dzkFuoG8Gf
         JNoLeHNU1fxkJqOfxd73gIKfrmOD6++9rpdgryjR4kqUAvKRKaQ2u7CgK7tZNCggluKr
         y8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2cvh0M4miY/BiqN/UdWftX82fG+Lj6GlwYOBUkwznvo=;
        b=o7yKy4WE/mFjvVM6VNIW5CtFi+tw/XDQUKrOr9FOenV0yhDluGVt3SgRoIKUr9pPjB
         CVXJ/WJ5JwMU/58N4seiMqwmi/TsU9Zz3kFPzzcYPyw85j5DKQchM+rxFxTHeEFtCrHk
         eX60nw0n2xxurCMNca7qDZQACU8ZlHuDNVnViUuepo8ISqjbMQ4aYEel7JniiB7s8xBl
         9MyRt8wQwru2G/l/dh5yrEj38hYToWRSM2ytPchQuKooLKom8SFAUWr5qqFPrPy2d0i3
         6Tej/7hpdOxf8rVbCk0GlzInVXyMwuQeRv9mo41pvB36WvHnvDtC1mIbpv8TD4SIMo3v
         2sUg==
X-Gm-Message-State: AO0yUKX7IP6Snw82Ixs0QsYc5N/kEdUIojUWq7K02eVtF+amv2wCX92E
        ShplkH6eDBfId9RXFlACpuY=
X-Google-Smtp-Source: AK7set9Du+VNgjJ7eqcqf0pXGnMgk+UPo48Ibap6n4a45WyZGXaPoEqCLYH/H+uwO4tx7dINcWoukQ==
X-Received: by 2002:a17:906:805a:b0:8b2:7534:265e with SMTP id x26-20020a170906805a00b008b27534265emr15054249ejw.58.1677002055648;
        Tue, 21 Feb 2023 09:54:15 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906660300b008e493b7bb61sm236357ejp.153.2023.02.21.09.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:54:15 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/5] ARM: tegra: transformer: use labels for mmc in aliases
Date:   Tue, 21 Feb 2023 19:53:46 +0200
Message-Id: <20230221175348.15681-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230221175348.15681-1-clamor95@gmail.com>
References: <20230221175348.15681-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since mmc devices in common dtsi are labeled let's use labels
for simpler comprehension of tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
index 08ea9cb32d0e..70f7f279fd35 100644
--- a/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
+++ b/arch/arm/boot/dts/tegra30-asus-transformer-common.dtsi
@@ -12,9 +12,9 @@ / {
 	chassis-type = "convertible";
 
 	aliases {
-		mmc0 = "/mmc@78000600"; /* eMMC */
-		mmc1 = "/mmc@78000000"; /* uSD slot */
-		mmc2 = "/mmc@78000400"; /* WiFi */
+		mmc0 = &sdmmc4; /* eMMC */
+		mmc1 = &sdmmc1; /* uSD slot */
+		mmc2 = &sdmmc3; /* WiFi */
 
 		rtc0 = &pmic;
 		rtc1 = "/rtc@7000e000";
-- 
2.37.2

