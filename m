Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4826CD5E4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbjC2JFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjC2JEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:04:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196310C0;
        Wed, 29 Mar 2023 02:04:37 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x3so60293517edb.10;
        Wed, 29 Mar 2023 02:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AmA1pqJOyOb2cR7V74kR64IR6Xx2k2cxNLkEbR3rMXM=;
        b=FVJ/5YauamJ6U6iOQs9roy5sKS0qDMHGt0OvI8eBFgY9RIpRlkxf3KsjRPMsSW41cz
         5RKAycWDx0/9Jh9vJTJxJyGN9O67fUrtoPCY6eb8I5HyMINfSrZvbzxcKHykOm/m8MVa
         3H4jKRrDMUf60B4uyMaIi7K8f0MFdpHTkdZw+TrwruOk1HJhHoPs65SNj+n/9refWZ7k
         QFHXxyG8m5Huh3+6oDYyV677SV7g5r1dS2LFUGplSj/IzBTaIPy85CNd8xozDwpbbb75
         BfyxuIX26oHz+4gS5Y3pBgt9U6jdTpoXXPCuYpC1PzGCh3LHCxVC6d88Jk5ZgQRRf8ab
         IJMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AmA1pqJOyOb2cR7V74kR64IR6Xx2k2cxNLkEbR3rMXM=;
        b=le8YoShSI3XzlrtG/b41+EByu3xKM1fym07D0uwa9IpEEjNyggJQc3Q0c/LkNs1Z7W
         PAxmUwxXdZKCRAooB6vYzMUEiOE/W6xxBHM73VzLolc5wFYdmA7zgP3Imq7rNCMZdNZJ
         uW/dIgu6juGjI0e8z6HbZRl+EvYpynxozcLRReHjAr6Jv4Wcxt5wwG7K0Jd5/806IPsk
         Iap+w57GBg7AUkc99+/iQ8puTOWgnwfFGsTFPHRKFiA6exQWOGifeWy8kdL9xQb03PDx
         6CJIQnIC0nngAFvHpPYBBIAKe9VayVl3tKKhpK2dkhbXmQmJouPX0/Ncf9F5k6dIkeaB
         BzKA==
X-Gm-Message-State: AAQBX9eaSH0bRhNQEh1lc1AZdIth4+xIS/btWa4ufyfG7ag6DXWtJgW6
        T1KDrXKwFv8VaU4O4AmX2GA=
X-Google-Smtp-Source: AKy350ZIBRKInUSM9Rx3wY46if9XU9amzDEMk9tHwDFrjeL46KDedicWzC2oVl5OWHZAH3h6aNL8Pg==
X-Received: by 2002:a17:906:b2d2:b0:93e:fa12:aa1a with SMTP id cf18-20020a170906b2d200b0093efa12aa1amr17924410ejb.1.1680080675859;
        Wed, 29 Mar 2023 02:04:35 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906088300b009327ed171f2sm15437127eje.129.2023.03.29.02.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:04:35 -0700 (PDT)
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
Subject: [PATCH v3 3/4] ARM: tegra: asus-tf101: fix accelerometer mount matrix
Date:   Wed, 29 Mar 2023 12:04:02 +0300
Message-Id: <20230329090403.5274-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230329090403.5274-1-clamor95@gmail.com>
References: <20230329090403.5274-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accelerometer mount matrix used in tf101 downstream is inverted.
This new matrix was generated on actual device using calibration
script, like on other transformers.

Tested-by: Robert Eckelmann <longnoserob@gmail.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/boot/dts/tegra20-asus-tf101.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/tegra20-asus-tf101.dts b/arch/arm/boot/dts/tegra20-asus-tf101.dts
index 7b2969656ec9..dcb231f6e42d 100644
--- a/arch/arm/boot/dts/tegra20-asus-tf101.dts
+++ b/arch/arm/boot/dts/tegra20-asus-tf101.dts
@@ -577,9 +577,9 @@ accelerometer@f {
 					vdd-supply = <&vdd_1v8_sys>;
 					vddio-supply = <&vdd_1v8_sys>;
 
-					mount-matrix =	 "1",  "0",  "0",
-							 "0",  "1",  "0",
-							 "0",  "0",  "1";
+					mount-matrix =	"-1",  "0",  "0",
+							 "0", "-1",  "0",
+							 "0",  "0", "-1";
 				};
 			};
 		};
-- 
2.37.2

