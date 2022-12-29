Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36B5658E1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbiL2OyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiL2Oxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:53:44 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638EF94;
        Thu, 29 Dec 2022 06:53:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so17559732wrz.12;
        Thu, 29 Dec 2022 06:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZkX2cug1zygCxmeSz3WwLCkjtmVVd9uajC/eLkssWE=;
        b=JUK5cuGo8ncIXmm2Sn1MWN7TaWE2iKnkAQ2gjm2bwXDFquUIBjYpRuVbzbBVWMV/Ln
         vbNsjiAY0lZlmm030Ros394bqaeNcRRCY61R0+eBTRUWEnhaQsSvwGekMDnOH2Xmx96y
         HGSP84siKOB92McZ/YVMS6klldY0Z+qNuvEMIf6CZerfO66YOrgdSus2mtsHMXW1FSKp
         5RRmZeLMH3TsIvWOBIr860X8AHO0zwsDhG4a09gOos5jxjmJvBiA2DwZYqVFivLp2+/g
         YRYW+1SWgAv8uHcuyy8r0jMVk8ApPIJBYFLG3PSP/DB3j8TtmR94MXwQzpA8G2PiHbcW
         5LrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZkX2cug1zygCxmeSz3WwLCkjtmVVd9uajC/eLkssWE=;
        b=ZE+ZP88rY13El/8Ulmw7v147HvoNuHi5/QUlGBfmMYGyykcYL3Ec7tX6LdnqWCa19V
         RPHRz9SodSHkJMOgYjlEbvOC5B619vp3D5vE6YBtBvHy5rUnkawn9koXt0a+pwBiGUVJ
         MihCGxiItzXElLfpvZvlbPPtfXegZDmLwVbFaMsL4eiOXx2yLENFn+eEFM+B+KmQaPFz
         PB9jgp2y0fMMMPP/1XEIhJUeG0BIVbQnZBSZzXrrJnnzN8TPQ3DHXqs4jmqTcg+jAQ2w
         uF2Px0jmgac5PBL3dK0tGMi4gNBCXdE3kDccfyYJxuBMBGMqMxg69T44giLZWtSdQtiK
         py3Q==
X-Gm-Message-State: AFqh2kpuLaIPiYVTQwLNMPHfhLZMUNRZjJuGqJvUxDEtjPrr6+da+NcG
        ZsGZUolEzgAApSuu/+aMu/RUiL3OyN3bGbSR
X-Google-Smtp-Source: AMrXdXtMGKMclQkPJOv+DHGP4As9ciOc2MBZ33unXS0faDaI9fHQUoJqh2x2Ee484UtCwv2tdtVFag==
X-Received: by 2002:adf:f74e:0:b0:22e:6227:34e4 with SMTP id z14-20020adff74e000000b0022e622734e4mr17332608wrp.0.1672325621940;
        Thu, 29 Dec 2022 06:53:41 -0800 (PST)
Received: from tpt440p.steeds.sam ([69.63.64.50])
        by smtp.gmail.com with ESMTPSA id v7-20020adfe287000000b00241bd177f89sm18151089wri.14.2022.12.29.06.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:53:41 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     "Sicelo A. Mhlongo" <absicsz@gmail.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org, maemo-leste@lists.dyne.org
Subject: [PATCH v2 1/2] ARM: dts: n900: rename accelerometer node
Date:   Thu, 29 Dec 2022 16:52:49 +0200
Message-Id: <20221229145251.3535402-2-absicsz@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221227223841.2990847-1-absicsz@gmail.com>
References: <20221227223841.2990847-1-absicsz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use generic node naming for lis302dl accelerometer, and drop its
label that is not used anywhere else

Signed-off-by: Sicelo A. Mhlongo <absicsz@gmail.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index 6ba2e8f81973..20d7a7bb6b04 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -767,7 +767,7 @@ &i2c3 {
 
 	clock-frequency = <400000>;
 
-	lis302dl: lis3lv02d@1d {
+	accelerometer@1d {
 		compatible = "st,lis3lv02d";
 		reg = <0x1d>;
 
-- 
2.39.0

