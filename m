Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0AA6016B5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbiJQS4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiJQS42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:56:28 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7E5754B0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:56:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id r13so19856844wrj.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 11:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4wSIX+vtaaHqF9t1ZyOTlO/WaEXmbWXEH6gsVeqv78=;
        b=NRAPXUqh9seuxTIJOEeyb7dSRfcSf5qZpejer29HdPtVV84CSBFEnO6t9yaMlyRBrO
         kQ2un9wYYHrG+7Go7fzIiWmlplYqbpC0p3yhNQhLGeqShZZuU0IJMJkKyACUPtUu+ldt
         3FplUQGZ152Dw6VPaSE6nGhlqzaBJ8SnEE9XIQUcsh+xieqCmvmv6n+P/Do+Tas17ToA
         to/KckSD6RrNlvRZ06rPbXTIRwvkscbSufC6suuOHsr1+xvy4xUxzC3u2/HDhRLqM6Yp
         srpg37dVr6TTa3sMXcaW3yA1CwT4Yfjw+WfgfG91czmk3Ak+WcODigOkZWRsQ6ZCbRaf
         hv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4wSIX+vtaaHqF9t1ZyOTlO/WaEXmbWXEH6gsVeqv78=;
        b=mLvnACNmrpKvGGegydnjy6RSJ4CLTSCYZarf4GG1nVfO5gg3AhZ5hkNCqFfWNEZix2
         kT35TumrKoFGu7WmOKOzdBRQvjsEXhFYcQFR/9p2RKkC5qbXKVgkA/JFC5TrBjNLg6BV
         zzMCMHQSMOZUPJueowyBOTbCuHbu4vLPh6fDw+WY8JLbsP6p6NvlOfCsqkIZw4VhVfhF
         2p7R/Yt9fhKu+DuIGqrexXsg1iiAAnonh2gK0eJcympk+UnM+Rm9qfNShJ7a4uESUK/R
         Z8pzg1Uy2KcUBrINMiA+s/b707An/aGvKKIlIMPpDB2g7qLWhsnVHWY9voJUIwpy4FnQ
         pYwQ==
X-Gm-Message-State: ACrzQf2ZDvU3V/Rd536r6ApOABShSYy4rHA3tNmYe3RFkGWHF8J6iVm8
        66GwOJ43NMqnY28baDkIj2RD3Q==
X-Google-Smtp-Source: AMsMyM6BMkpei8gG+IwXYyMpXoJFcfNCC5HOsx6/e5OX5mu9Osi30LsyqNPXLkzNWN/uZewPVKJAuw==
X-Received: by 2002:adf:d1cc:0:b0:22e:6359:f999 with SMTP id b12-20020adfd1cc000000b0022e6359f999mr6883201wrd.667.1666032984133;
        Mon, 17 Oct 2022 11:56:24 -0700 (PDT)
Received: from localhost.localdomain (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id v16-20020a5d43d0000000b00228d67db06esm9151714wrr.21.2022.10.17.11.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:56:23 -0700 (PDT)
From:   Caleb Connolly <caleb.connolly@linaro.org>
To:     caleb.connolly@linaro.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v2] arm64: dts: qcom: pmi8998: add rradc node
Date:   Mon, 17 Oct 2022 19:56:09 +0100
Message-Id: <20221017185609.2280067-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.38.0
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

Add a DT node for the Round Robin ADC found in the PMI8998 PMIC.

The RRADC reports PMIC die and skin temperatures, as well as
battery/charger thermals. It also reports USB and DC charger voltage and
current measurements.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
This patch introduces a new dtbs_check warning which will be fixed by
https://lore.kernel.org/linux-arm-msm/20221017185105.2279129-1-caleb.connolly@linaro.org/

V1: https://lore.kernel.org/linux-arm-msm/20221016180330.1912214-1-caleb.connolly@linaro.org/
Changes since v1:
 * Change node name from adc@ to rradc@, see linked patch
 * Enable the RRADC by default, rather than per-device
---
 arch/arm64/boot/dts/qcom/pmi8998.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pmi8998.dtsi b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
index 6d3d212560c1..95c74d88eb93 100644
--- a/arch/arm64/boot/dts/qcom/pmi8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi8998.dtsi
@@ -18,6 +18,14 @@ pmi8998_gpio: gpios@c000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 		};
+
+		pmi8998_rradc: rradc@4500 {
+			compatible = "qcom,pmi8998-rradc";
+			reg = <0x4500>;
+			#io-channel-cells = <1>;
+
+			status = "okay";
+		};
 	};
 
 	pmi8998_lsid1: pmic@3 {
-- 
2.38.0

