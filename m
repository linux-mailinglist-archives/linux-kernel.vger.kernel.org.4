Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5136B5761
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 02:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCKBWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 20:22:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjCKBV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 20:21:56 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD03A12EE7B
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:52 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g17so8956359lfv.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 17:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678497710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GwE7AohqGbIcmWslXi8oNJB/iLnz66+C6xZsC78Hh4M=;
        b=tp5KEncJYE1bs7xThQ+kOcCyWUtDh2yp0/bxxk1WSNKeDhlaQmMMEbbsw0lLwgPg/0
         F1CCkAZhRqxz+xuujUkZCyFsMCwxTFlUD529RwO5xeLFnXdcKDfanFuTCjZltiv5Q6q+
         VjV1zMt28iZrTESwKX0Kap7vhgGM6mFWPhN5zy3cY39JvuZT2GTroqZ6/lM2AyPt9Dsl
         dHItMxyFyPUqvg9sMC+uPQYc/Fs4JNIL8qvmeyt+TcpgE3wcCfZQ+kgB957fO7RmebKh
         UqB5g9nDpJcnQREcP8jlRSzv632bo1OPVdYlgfdyy2/bFPYbdUmpph6Xfew2l0L5hIev
         8GGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678497710;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwE7AohqGbIcmWslXi8oNJB/iLnz66+C6xZsC78Hh4M=;
        b=FWvm6w/qSNTnnGovEIK8Dydr0CKjSdpClyOQGIe+Pgx+5/nuwEG2ucZ096xNaHWdOP
         xuQU81UZuhI9B5iPGrWue26afIHAuUZEn49WGPBXTOygZs9fwT6zn1+rzVc+vDkPxuGz
         nluVkc521eYc7G6pDfJMj3hew1hTUhxF+M51w+JRrilkOMkoJtwRUJvVan9DldNYzQ9g
         DtS1IZs/hu/+MbrAzMVxazBuiBI5mHhLGgE9nrso+pe4317iArWxJ6bDGkdvnhpYHcuW
         H+lqCu5q+9TlnTgMIglUaJ4/hM5FISUVbOFdCrf3yV/ZIUNrAyIXyyeMA5AWBcXzH8ql
         vqBQ==
X-Gm-Message-State: AO0yUKX6/mr0tdpLUha2IoZHoPyd8bAKY7UWdny2Lv+98ykcWj++pNDX
        vc+3WGrbW5CaLHJBvueMQ8mRvw==
X-Google-Smtp-Source: AK7set+L2dAf+1VpQKyWQQ7A8I7PpISsbHdtf+VwWIaMcYPy1P/2bZ5x4tavogcp2f75Y1DIGA1PPg==
X-Received: by 2002:ac2:4831:0:b0:4dd:a565:8b8 with SMTP id 17-20020ac24831000000b004dda56508b8mr8174315lft.57.1678497710630;
        Fri, 10 Mar 2023 17:21:50 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id y26-20020ac2447a000000b004db25f2c103sm142318lfl.86.2023.03.10.17.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 17:21:50 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 11 Mar 2023 02:21:36 +0100
Subject: [PATCH RFC 06/15] arm64: dts: qcom: msm8996: Add simple-mfd to
 rpm_msg_ram
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230311-topic-msg_ram-v1-6-e9c2094daf09@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678497700; l=688;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=J8sNWFgvXFFj+ysUZApL4w6CccWyaDk9MIMtC1PdHS8=;
 b=G90Y++nOEXoYmethmum+lQ0hudf0zvsAFikikT/qQH3WxTDyIWHn+jZ7yTOOi03zXiVJ9Oe1nRl6
 kp8g1GEiD3PA3UuqlAyaWFMKl4BvAUQM5R9d/IrqRizqL1naPjuk
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
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 905678e7175d..9a0c1ebf1e52 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -679,7 +679,7 @@ pciephy_2: phy@3000 {
 		};
 
 		rpm_msg_ram: sram@68000 {
-			compatible = "qcom,rpm-msg-ram";
+			compatible = "qcom,rpm-msg-ram", "simple-mfd";
 			reg = <0x00068000 0x6000>;
 		};
 

-- 
2.39.2

