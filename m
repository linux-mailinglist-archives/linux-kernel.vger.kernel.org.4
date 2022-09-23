Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D6D5E7C91
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 16:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiIWOKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 10:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiIWOJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 10:09:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56655E557
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:09:54 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 78so319476pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=LPYKbguZc/KYKDAy5XVdCd4nJdkVt/SEkrsrImBpX8M=;
        b=EAjhOdvgjArw8sNIzQ0hUGUR5C0UY0fiqJfiosuEyKMIz+iThn3vm7sx98wNmV/jxa
         GdQAjsSLhEsVaxKT6+c1FsvRYbY76gLPkreqY9O41/mllSkEtyxhn8HuNPmNGPZe9lTy
         AdJFFWbMZpy93pAnlgHBGTx9rsCKFAnjBUug8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=LPYKbguZc/KYKDAy5XVdCd4nJdkVt/SEkrsrImBpX8M=;
        b=oEuBXil1GcKU4kJIrB6EmghhTllAVPPdU077H7ER2NDeghPDCffblRhWA5z/Rb+fGC
         9htO6hl4OMr0R9a5nA83t8W7DZKkbSj7hZokibKYPeNrBCW2GMGRiAVxGo19wnqJ8+Dn
         T+eOio7Q6Ad6WAK2wOyfQe7fchS7wLSXeS1Ea6xfOmciJVk10yPg2X501DqxL2Znh3hK
         oMpAiv7hbwDyX2MOF2Adj27HEIifJLWgRMebHlluaUQpHeY5yJk+siV+TcoyEJUCkU3c
         FX0XZp+AvQ7HlEVOLNa6kDK8Ouahx2ZgX4nq8txQwQBkX3f92u1BtqSCNIL8k1MvKB0m
         dAwg==
X-Gm-Message-State: ACrzQf170L0Z5PC7984L7Oa612pzGrNHY1Rh1oBj/khARA1HYzEIF9Cy
        BgFd2QPHGCo1vwfzyVFgw3whEw==
X-Google-Smtp-Source: AMsMyM6PLPe54eIdKclOEZNjNZ5iwV7lzwMpeVGCZ0MgnUzMuC6AN9cMLx1aHKnMYqF/oMDRjlEgAQ==
X-Received: by 2002:a63:90:0:b0:439:befb:fdab with SMTP id 138-20020a630090000000b00439befbfdabmr7481048pga.341.1663942194478;
        Fri, 23 Sep 2022 07:09:54 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id l14-20020a17090a408e00b001fd8316db51sm1645318pjg.7.2022.09.23.07.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 07:09:53 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v5 3/3] arm64: dts: qcom: sc7280: Include sc7280-herobrine-audio-rt5682.dtsi in herobrine-r1 and villager-r0
Date:   Fri, 23 Sep 2022 14:09:18 +0000
Message-Id: <20220923140918.2825043-4-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220923140918.2825043-1-judyhsiao@chromium.org>
References: <20220923140918.2825043-1-judyhsiao@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

