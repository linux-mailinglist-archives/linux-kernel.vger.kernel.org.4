Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB3B6B5770
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCKBWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:22:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCKBWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:22:07 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930A13C37D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:55 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s20so8924253lfb.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWdc7RJEdurOYCOkUt7zfGgdNNMCIQtAcmMEUyc6Xf8=;
        b=kZ1CmRYr8k/ER8mwDbjVQ6WECftsAqGKKVkEFnvuy+pYX1Oh35u/p7pY0He23m2xFh
         CLcAFK24zF9A2LRWOynhZtGPjS27AEdFetsP+YwDPSFJ/adN+amvPRH/pWe9srt2elBw
         aMDtsh7hfylwLaL8+dolOMLV8uaJwsQmbxvGKk9LG2TYbQgP7nHUqCP8vp2ZZD4yqTBQ
         GaQGxCA37FhRVLWx3cl0Scg5+h/ipkf7oekw4wTgj2pFs1zX2Y6gznYs3fy4sCqU+te+
         hKIbx8fAK3nB2gVzhzq6HKbiu1VuY5CCiQAx9ypady6hHwQm+aNArhnvgwzKa6FqS1Td
         O6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWdc7RJEdurOYCOkUt7zfGgdNNMCIQtAcmMEUyc6Xf8=;
        b=nEh3mwR/oEv5Ny9yZ4V78eHYhXCHeVmt9S4ZbSbcGvr2EgPGbTToeQf0IMt3EsK2QS
         obwUtCyI3W3jSWhqZaOI2367qJskDbZIcPz1YfVEqxpwGBtT9mNuAf0UZ8TEYv8P42eR
         XMEPcxocODY7P1tug0LG8UBMDmtlzIV4VgTu1MB4KV27lIMWOB6RPDy0uDk1B52uCvKd
         L16mKcFO88LTtlSIEgkgx+Qw+NiyucqGM5IJpEKjn9/12aLrYy24jD+FuwmkDSlOb1Xy
         K+ftrZRChHfd0x3p0X5NG70rsFogqIz3b8dsO9X7rnBvnHHViHbYzPVI+fQMw7119PKz
         HR5Q==
X-Gm-Message-State: AO0yUKXBONre2YaBUI884XSIP2GoMCZt/Yk3NNXT7lHHOjzH5+anijzg
        P/vxOuvRGt8ADy/289RC4oLX5Q==
X-Google-Smtp-Source: AK7set+JK/ZcDoi8P8YguljBJas5ccdPs1MNqSX/iFx5SesX3Hhn/d3M8Yad4AHN6ja/bQSG+v3rTg==
X-Received: by 2002:ac2:55b0:0:b0:4e0:a426:6ddc with SMTP id y16-20020ac255b0000000b004e0a4266ddcmr7077494lfg.0.1678497714652;
        Fri, 10 Mar 2023 17:21:54 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:54 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:39 +0100
Subject: [PATCH RFC 09/15] arm64: dts: qcom: sdm630: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-9-e9c2094daf09@linaro.org>
References: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
In-Reply-To: <20230311-topic-msg_ram-v1-0-e9c2094daf09@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=693;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gvy2AUP7UIpys8tLkzTkVfgT8p6fXK5G+QzuGMy3mVI=;
 b=u2+pcTyDEJLEh80jP1h+qsnKcfopB6hU2Yzyv6E9svImcjkXOT4Ntu2PRj7bAT3+aCsdVH8TxYF1
 GIwn7N9XDrf5BbvVDChotsq5FpFPp3pA4ObV5rOBw0pEezxqpqVq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing compatible to make the node compliant with the bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm630.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
index 5827cda270a0..e85ec7979d4e 100644
--- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
@@ -548,7 +548,7 @@ gcc: clock-controller@100000 {
 		};
 
 		rpm_msg_ram: sram@778000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0x00778000 0x7000>;
 		};
 

-- 
2.39.2

