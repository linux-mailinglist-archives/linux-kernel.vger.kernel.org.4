Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74B7660390
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235308AbjAFPkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjAFPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:39:56 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E227BDE6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 07:39:53 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id m18so4252543eji.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 07:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IrFALWtjvyHrEODn7/AmsHwOIckZb4wGAaCGF9DBAVM=;
        b=Jmun4CjNGliRP410OzyR1BUUiSsCJ5Bm43gNMHYkxiwSL9xVDWlb5av85NU3qMEPti
         w5p3ya5HuRHHodDPbKvNMLeJOvWHcuAKDkQ5r4BnjNISCMSEX7OFnr+CZb3Kd0/iGwdI
         5+EEGGMjZ//u2TybrowJ8g5RlcHu5IxTg+Qe0VYOUl4ZJIcTQKpAuTordn4c0ioA3GaZ
         zy0HJkBPMO07WRa++itg1FVeDszYzXQ+6dQPOAqDjsYcUp72DcyDkmK8fiI1yvxy3DVH
         tz4FbtcaVS5lM8n0afLrNDLR/qgfNIfGCVUUK61tb9tIE8ZfINNPc3M16jF9Mgg1KLLE
         oTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IrFALWtjvyHrEODn7/AmsHwOIckZb4wGAaCGF9DBAVM=;
        b=Q6hk4qLwGJuGl76rffQpfPvyyY8SXD3+nI27Iw7hZWhWiVafhfHv+BRsriE+8pkzwj
         at4oKp1lqaQFKvxvT7bheWkoALuxpSwZtY/sGmMklTwXzHlmegLECbe9yP31bkhiBwvR
         yNvvMOYRke/qzWKVvE9khkW+BXlOW1XsP/sBbQFetbh8B+YKD6/8qSMfiwCDHQb9RwjA
         DraSjEG99Q2WwJSE8s4iGbS+aUI6idD/n/7BsGntXedetoJU9atUDyxFoodUe5THwCen
         4cz1Xjd+8NZxbOrCwuhnH9cB30L6WEg6yM4bGg8SXbSGVRR28ByyjeGu8TDg50WmP7ob
         +07A==
X-Gm-Message-State: AFqh2kpi0YNTTOAwngVBGnx6I8suEhlw4H5W6RZwztDPvMfKYmC6/9Fj
        NdnCGbl0xmJM8yoSuClMeJ+9dA==
X-Google-Smtp-Source: AMrXdXu7mftrNvtn7RupRJFbxPZJo8dYVuvhmeBH27k1Q4dQpg1FR8BIZbUZvzI2v9kBDXiCohL1Bg==
X-Received: by 2002:a17:907:c081:b0:84d:207d:c00e with SMTP id st1-20020a170907c08100b0084d207dc00emr2369537ejc.46.1673019592525;
        Fri, 06 Jan 2023 07:39:52 -0800 (PST)
Received: from [10.0.0.3] (217-149-174-217.nat.highway.telekom.at. [217.149.174.217])
        by smtp.gmail.com with ESMTPSA id gx8-20020a170906f1c800b007aed2057eacsm496235ejb.221.2023.01.06.07.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 07:39:52 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 06 Jan 2023 16:39:42 +0100
Subject: [PATCH 2/2] arm64: dts: qcom: pm7250b: Add BAT_ID vadc channel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230106-pm7250b-bat_id-v1-2-82ca8f2db741@fairphone.com>
References: <20230106-pm7250b-bat_id-v1-0-82ca8f2db741@fairphone.com>
In-Reply-To: <20230106-pm7250b-bat_id-v1-0-82ca8f2db741@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.11.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a node describing the ADC5_BAT_ID_100K_PU channel with the
properties taken from downstream kernel.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 61f7a6345150..d709d955a2f5 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -110,6 +110,14 @@ adc-chan@1e {
 				label = "chg_mid";
 			};
 
+			adc-chan@4b {
+				reg = <ADC5_BAT_ID_100K_PU>;
+				qcom,hw-settle-time = <200>;
+				qcom,pre-scaling = <1 1>;
+				qcom,ratiometric;
+				label = "bat_id";
+			};
+
 			adc-chan@83 {
 				reg = <ADC5_VPH_PWR>;
 				qcom,pre-scaling = <1 3>;

-- 
2.39.0
