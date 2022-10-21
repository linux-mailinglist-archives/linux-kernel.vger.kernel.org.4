Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC43B606E50
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJUD1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJUD1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:27:16 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7ED1EEA14
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:27:14 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id e15so917346qvo.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DXaILJA4sqV2bnElPXbGxqwviK1afldiXClOy9rIblI=;
        b=dAoHlAIA4reTZbRWZozQ9MpL036uremOzIP4o6Q0nHoppXoNYGg1S0dJ+Ua9OpsWxj
         tz0xUiaumbnos7PcCUBBQvA6bMOJGw91riQ8xYKxPONGG/+c9tAGK4M5feM5Azxbxlx8
         PK5yl7KbO0C+EbyQpGuJWtmEhl5JLS6G1+xkDqwwZ10vcnBz2MoQ4LNf4WtCdpYA7PZQ
         rytFjUWtMg9nOTQQRPq+QQi9tEcPlzfXuid88MvT7mPwG6WuWkEWCE3NvciliQITmd+7
         2ZhSVmIHcY2PEQP9L9OzsD9oqxFOd3Jps3tSH5zeWjhS5aTd2XLrO1XwBlK5rn8m4svL
         V4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DXaILJA4sqV2bnElPXbGxqwviK1afldiXClOy9rIblI=;
        b=KqopgD0NcBRhw7rh8ODaqSR/xGYIFZEdia9DLubV2uz+E/cFb5dPoVV5OPkYCiuXdK
         tFHjvT86IOGIqkuV16dFOyEDLEGd3ZgOxQNvkKpfszNFxSgLwmQVk1yJYI/NttvRxCLc
         FDYvDEY5fudugF8QSbZOj2xp3XTD9SCbuXNhGJHVHLq3lwnNLDvbRJtDZil+y8gQ3beR
         d/Ei24w9uWG50Phwpo/zXK33v/XMbeKDPMhYkgOtYrb+bfa8nZAhWEh98y8hVCQcWXOb
         O6FDMbekpVNXNpyUXLCgd0H2XLqAGytDNN8e5E0e8SMKAMM22yb3md1/dr8BS19tI9P2
         D9DQ==
X-Gm-Message-State: ACrzQf3tbPpvPpywrZIXL5u+VbwGUilJhP4xDhgTwd24vfDAO4g9r4GT
        JuPH8uxzx0vZzWGc8oXDAXtcVg==
X-Google-Smtp-Source: AMsMyM7T52UkbN7NE1B397WdN8cNM3VSPuUUf6497wUYSL/kzduK+VF63+tF662zHBsdQRB7nbUuDw==
X-Received: by 2002:a0c:f54f:0:b0:4b1:872e:102 with SMTP id p15-20020a0cf54f000000b004b1872e0102mr14926844qvm.123.1666322833490;
        Thu, 20 Oct 2022 20:27:13 -0700 (PDT)
Received: from krzk-bin.MSRM (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id y21-20020a37e315000000b006ecb3694163sm8368172qki.95.2022.10.20.20.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 20:27:12 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: defconfig: build-in Qualcomm SC7180 and SM8450 interconnects
Date:   Thu, 20 Oct 2022 23:27:02 -0400
Message-Id: <20221021032702.1340963-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Qualcomm SC7180 and SM8450 SocS, the typical debug console serial
port is part of GENI Serial Engine QUP Wrapper Controller which uses
interconnects.  This means that without interconnect drivers, the serial
might not probe.  Without serial console, the root might not be mounted
by initramfs:

  + REASON=No init found. Try passing init= bootarg. PS1=(initramfs
  ...
  (initramfs) run-init -c /dev/console -n /root /sbin/init
  run-init: opening console: No such file or directory

This means that interconnect drivers on these Qualcomm SoCs cannot be
modules and must be built-in to mount rootfs.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/configs/defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 2af94d3c1c11..c1b7fb44e381 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1301,7 +1301,7 @@ CONFIG_INTERCONNECT_QCOM_MSM8916=m
 CONFIG_INTERCONNECT_QCOM_MSM8996=m
 CONFIG_INTERCONNECT_QCOM_OSM_L3=m
 CONFIG_INTERCONNECT_QCOM_QCS404=m
-CONFIG_INTERCONNECT_QCOM_SC7180=m
+CONFIG_INTERCONNECT_QCOM_SC7180=y
 CONFIG_INTERCONNECT_QCOM_SC7280=y
 CONFIG_INTERCONNECT_QCOM_SC8180X=y
 CONFIG_INTERCONNECT_QCOM_SC8280XP=y
@@ -1309,7 +1309,7 @@ CONFIG_INTERCONNECT_QCOM_SDM845=y
 CONFIG_INTERCONNECT_QCOM_SM8150=m
 CONFIG_INTERCONNECT_QCOM_SM8250=m
 CONFIG_INTERCONNECT_QCOM_SM8350=m
-CONFIG_INTERCONNECT_QCOM_SM8450=m
+CONFIG_INTERCONNECT_QCOM_SM8450=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
2.34.1

