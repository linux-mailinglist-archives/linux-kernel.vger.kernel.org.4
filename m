Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D8C647809
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 22:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLHVdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 16:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiLHVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:33:36 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A6391EA
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:33:36 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id y2so1776153ily.5
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 13:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlPWTbCJss1Wa3UIwQqQGPK89+eiS/X8Uksm10Uyh6Y=;
        b=sPv+Jec7RqY4m+nNl4+gh3qbUH9OdNcZRCr1IS0DhqXcxfj69/UPwmmU3wuMeJgB4c
         fnx3H7UPp5Jf2nJ318LZ5oHAoCRamZm7g8242lewL8uusEgKxwRRIHN4v8Pv9uHHHxew
         32E+OITHQSnMQbriXhFZBv2lx/LZbvb6j1zHYCZNLyGRcVf0vIyfRwAma+Ccelhi0JIf
         VpleTRL4leLlsxCTknqmXf/Lx7/m+qymLRuWYetV3WpkXs1RaQGBHjZNKOdzwqwKDMGH
         7UHikrfM0MMQlBQ04Jzuyxrlj1HaSWgihkb2cEMR4xkITfgAZoVfkhRccBGqnnRN+VP/
         ZXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlPWTbCJss1Wa3UIwQqQGPK89+eiS/X8Uksm10Uyh6Y=;
        b=dgGI6/ikKmWuFSx4McxF+n+Sly5xBaNzrJLU75gvQEdXikYJTjahFf35qznVGqqt4b
         K9Q4NUigVsRbPQ9ISTg6G3OIXrAIR6b0VcM0/CfeOK5kHIN/9MbP1SiFJOO+bSEfn46l
         IGnqfsokUs7KzvE9G/OFs2ifem1CwrH9MIUYJfodSeKodVQ3UR4x7XWtWs3v3sxkxpXU
         urVpcmP1/4t8pMajpt0hejB+QaIYmswCtGGCAlDSsqBhTAKSswTZNzm8ScKhGg4PX74Q
         xfIz+jlCy45eKETdqMijKy0gR5wRFkRPInIjwtaK4mfgN+EQCkF9j2Nuw6UntOWJQrff
         ufPA==
X-Gm-Message-State: ANoB5plTuciE0KDmTPFUoUfykwZzQM1JddgttD+W2QW08BYtyY6fhGHQ
        Wr/WDLdafO3fDMma2Db/ha9vsQ==
X-Google-Smtp-Source: AA0mqf4bfdd1wX5q7idr1fxwa8VtO0DvVuMASgioAfG+KJjYbOZm2vIuUWP43tyFz5uBrVMBbHcBzA==
X-Received: by 2002:a05:6e02:e42:b0:303:92b3:27ec with SMTP id l2-20020a056e020e4200b0030392b327ecmr559095ilk.31.1670535215476;
        Thu, 08 Dec 2022 13:33:35 -0800 (PST)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id a8-20020a021608000000b003755aa71fffsm9237846jaa.105.2022.12.08.13.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 13:33:35 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     Luca Weiss <luca.weiss@fairphone.com>, elder@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sm7225-fairphone-fp4: enable IPA
Date:   Thu,  8 Dec 2022 15:33:30 -0600
Message-Id: <20221208213330.937714-3-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221208213330.937714-1-elder@linaro.org>
References: <20221208213330.937714-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca.weiss@fairphone.com>

IPA is used for mobile data. Enable it.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index c456e9594ea5b..1e199a7898a04 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -362,6 +362,13 @@ haptics@5a {
 	};
 };
 
+&ipa {
+	status = "okay";
+
+	memory-region = <&pil_ipa_fw_mem>;
+	firmware-name = "qcom/sm7225/fairphone4/ipa_fws.mdt";
+};
+
 &mpss {
 	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/modem.mdt";
-- 
2.34.1

