Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D125F0F00
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbiI3PhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbiI3PhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:37:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9931A1082
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:37:12 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b75so4558116pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LPYKbguZc/KYKDAy5XVdCd4nJdkVt/SEkrsrImBpX8M=;
        b=Zd63G6ZoUfHEDbwl6sw1tUXxxGRU0nsMethkFkh2p6u11xvZK5YcA30HkTDpWSdI1j
         AzlRC8NZcnJzHUtN99ukkaiwGXLlbc8TJRM+cHxlAa6pqU+sPGwNWI4jO58hmUXdLrVI
         1C2vzo6IJReqnM8mMd+EBoGgesWJ9toi5HNhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LPYKbguZc/KYKDAy5XVdCd4nJdkVt/SEkrsrImBpX8M=;
        b=nb/LeGRhKDrq6ZhIiuM8n1LNzCsqFJbxeML6pGCVKYIEnZiSd8jKJ0/DUzEOL0Vdea
         BMNEBL/w8IayOS6/EbX6wb+RSvqsXPkWVofDP4mnw0QQJniUvtx3PYxX5OJMGZ6ROzsV
         +Pm9DXjmLc/8BjVywT2iJ8z6pRBndgCgpE0da3v4xodAo7x9yOtivGIEqIYCrUpt0RKx
         2qOIuxxEP43JiEEYMF4TRMrMiLw3EojFvxvh0Ml7b6FHlWxFom+A+LhaW4bDI00fEvOK
         K0boAUg0hZkOvYKd4cqEOjTzqFVW31WAO+EXNgfZJHvyMW6J8o/hpRluCK9+1UWOYrwV
         Nnkg==
X-Gm-Message-State: ACrzQf2rWmoXEqKOaNVapy005FdIOd3uZh0Vw+OnRKbFNbW/PD08DRFU
        PM5TEnwTE3QI6yjxKRmCU8W1kA==
X-Google-Smtp-Source: AMsMyM6xqal4/XOJLMBHQ9YrEG3UfneC0sz6YuMsdGK7ZXSUAgOfMfhQ9Ij8VoFNM1z75MU8PkTV+Q==
X-Received: by 2002:a63:5a63:0:b0:42f:e143:80d4 with SMTP id k35-20020a635a63000000b0042fe14380d4mr8215769pgm.456.1664552231662;
        Fri, 30 Sep 2022 08:37:11 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id s13-20020a170902ea0d00b0016d72804664sm2025155plg.205.2022.09.30.08.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:37:11 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     andersson@kernel.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v5 3/3] arm64: dts: qcom: sc7280: Include sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1 and villager-r0
Date:   Fri, 30 Sep 2022 15:36:43 +0000
Message-Id: <20220930153643.2018907-4-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20220930153643.2018907-1-judyhsiao@chromium.org>
References: <20220930153643.2018907-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1
and villager-r0 as they use rt5682 codec.

Signed-off-by: Judy Hsiao <judyhsiao@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts | 1 +
 arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts  | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index c1a671968725..c569d7a5edb7 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -9,6 +9,7 @@
 
 #include "sc7280-herobrine.dtsi"
 #include "sc7280-herobrine-lte-sku.dtsi"
+#include "sc7280-herobrine-audio-rt5682.dtsi"
 
 / {
 	model = "Google Herobrine (rev1+)";
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
index 73e24cc55a09..31a57ae5af57 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
@@ -9,6 +9,7 @@
 
 #include "sc7280-herobrine-villager.dtsi"
 #include "sc7280-herobrine-lte-sku.dtsi"
+#include "sc7280-herobrine-audio-rt5682.dtsi"
 
 / {
 	model = "Google Villager (rev0)";
-- 
2.37.3.998.g577e59143f-goog

