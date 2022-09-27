Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66D5ECE2E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 22:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiI0UPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 16:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiI0UOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 16:14:55 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C001EC9A4;
        Tue, 27 Sep 2022 13:14:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id l14so23009818eja.7;
        Tue, 27 Sep 2022 13:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=kWViXtTBqS7aTL7UygyNBSdcy/UNMyveeA0UaNDvMVo=;
        b=Vd2r9vF0K3kgL6X9sO2ggWppq72fXoOIH47xkjq/I274AJqWDn25hI/wtHc+PhziSB
         qbhM+cj6IcbFWrR7JoZe7Oix/0oh26nm1DwPVALFKOgkT8NrA5nxYqEASrchd9TEe65O
         4hT5cIGaAZRV6dfbcraiFgCE+8AXEcg4cvxUVci9kujVHSee00ueY5VQvSM8nDYtoss8
         699n62lu8WW2zNCXNDDzq9ihL+a5iO9AYO0GPbOXPq6CmjeOQV/1RgfggdYktRZe3Eh5
         +5MrHbjo+o0I2SzQXHR3Uez+0T66Y7EbSMm9SYo0WfOp7v1IcYZSIZnBa7rVPIz6V4gm
         H8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kWViXtTBqS7aTL7UygyNBSdcy/UNMyveeA0UaNDvMVo=;
        b=ntQaZQlxl5Kvsiigr4LojhciAFnsXkg3JgW6wlOdoSUbylbYBChd210kfZcTQC85fx
         KK+UnAJD6t8/eLFjaKkGh9ghR8rHrIGfX/wBuUc6D4Q7+hCLcMjf2eM17XD3j/ZirZMf
         FXS/FNKI7EaSrwJOz2Tq3x9G/MabVUgY63pjL7Tlt7sKp2sSNWUws/WiBqL+N84vo76I
         9shUrlpYD2S3euaop3OoTpqF74Wg1bsrbg2nhhN90ya/sa4C6u6e7BTxVMRU/895lx9L
         kwoXxaetmCbZMuRKkrDKWg6gnXJrupHoUgBOUO/WMjmLQD9BTYNR9ngNZS4EU6miSwlI
         SwVA==
X-Gm-Message-State: ACrzQf3+5npgK/ZkfODT7Bjh7gbAXrbD/1xUSmkURJZF0+JRSOoFjS0y
        inzc2/HXIniN+gBI43/G9Wo=
X-Google-Smtp-Source: AMsMyM5Mw+AyXnViQ2dUtOeoKPzn9O0jIrnqDAxM3T0nG3B1++Bsd2lGA/EwiNI8igK+lrRvMVZ7sA==
X-Received: by 2002:a17:906:4fd2:b0:783:bba7:60bf with SMTP id i18-20020a1709064fd200b00783bba760bfmr8152798ejw.68.1664309658737;
        Tue, 27 Sep 2022 13:14:18 -0700 (PDT)
Received: from fedora.. (dh207-96-59.xnet.hr. [88.207.96.59])
        by smtp.googlemail.com with ESMTPSA id i27-20020a170906115b00b0076f0a723f6bsm1250610eja.58.2022.09.27.13.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:14:18 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 2/2] arm64: dts: qcom: cp01-c1: use "okay" instead of "ok"
Date:   Tue, 27 Sep 2022 22:14:15 +0200
Message-Id: <20220927201415.1265191-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927201415.1265191-1-robimarko@gmail.com>
References: <20220927201415.1265191-1-robimarko@gmail.com>
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

Use "okay" instead of "ok" in USB nodes as "ok" is deprecated.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
index eaaaaa72234f..c424b8390c78 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq6018-cp01-c1.dts
@@ -106,9 +106,9 @@ &sdhci {
 };
 
 &qusb_phy_1 {
-	status = "ok";
+	status = "okay";
 };
 
 &usb2 {
-	status = "ok";
+	status = "okay";
 };
-- 
2.37.3

