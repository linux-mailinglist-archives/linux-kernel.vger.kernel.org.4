Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8D6BCA0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCPIxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjCPIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:52:28 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F9B78B4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:51:30 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z5so840490ljc.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678956686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeylFVo7UbFotxXKN5Jk9AW63WMsXe+ARjqLamdFW7w=;
        b=Z3AAdZzei69KEGBWwngVymIGtG0e2xa+U+6TbMOtWfK1l1cEV5wJ3Oi6sWJ2+TKL/q
         EhbRSkMaKzivAqA3RZWQnkPaHiOfK2UGbG7XX2LIL2jZ0m1zoDIBejQRIix5sOlIEWO3
         Lk5ajq/5dDxD6snISzP1DGsPSF+aKSyMSzV/0qaIp8v2bUJctOrfujVAgmf8YGpHVFAh
         TPw6v4TvssRhGP1vj2JBl0iLXDDdTxn7CAV1hmWLjlMD73AbTLWbzW7IGO1HAsNjGkfx
         jpKtSQrYiR5YMhj03+49lnFb+XsB9v5hB+i5F+FQIzD6kM+SvhdsIWn6pjl7bmyjs/i2
         gYgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678956686;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yeylFVo7UbFotxXKN5Jk9AW63WMsXe+ARjqLamdFW7w=;
        b=3A6OjOI1lk79GoZWbvywo8I5GmjDt5+wP5izd4qeHg30X9wt8KINN1N39t/3OPribl
         Zwj4FMx9VNC5JoIj3W7rhVouRI1J1fXeodjc5QyAiHYoBE07qce7MJoIWT5ngWc6u5GW
         78iBD9gz81H8+S6EKOptDCZOVjJd2MvA8V0QUQzfDEYaZ8Ciax4YQgPVSmLEeBjNXeOi
         TO22iwlSEZicbiuXzGgufTl0rDKTLD4477fZ4vs98n3OAV13WfAWZwRd/XRPstNLis21
         IjduAnLFrmfYtOdCCNGT2vxWbd6QdjHQFmbHpQ454pEdq8pYh4nQdTxHLzRiwv6CRxfG
         /2nQ==
X-Gm-Message-State: AO0yUKVWK9wDy8jZ9YVPwSkQq4fGGFPIjWJld0qzcv5sVtH1MEFmPvRe
        ARN/UJxV2wdFkfE4ujQNmvYSmQ==
X-Google-Smtp-Source: AK7set/0NJerC8vUaJNQ2tyW8LwLWSp5G6DBTMCvwIABzlv+WcmetLF/tmCq3vX0+utRYHtmPqbJeA==
X-Received: by 2002:a2e:9c8c:0:b0:295:a96c:f77c with SMTP id x12-20020a2e9c8c000000b00295a96cf77cmr1644721lji.3.1678956686536;
        Thu, 16 Mar 2023 01:51:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o11-20020a2e730b000000b002991baef49bsm251566ljc.12.2023.03.16.01.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:51:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 09:51:16 +0100
Subject: [PATCH v5 10/10] arm64: dts: qcom: sm6115: Use the correct DSI
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v5-10-9d4235b77f4f@linaro.org>
References: <20230307-topic-dsi_qcm-v5-0-9d4235b77f4f@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v5-0-9d4235b77f4f@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678956668; l=835;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=fTDJ/Pk/K83TEsz8nt+gatYoQ7InKrC5bjtKXy4Z9Sw=;
 b=6dVPWc6fouGLAtAlDaU7jHpfHzCJJY89FA5mqEAD5VXJxPTs5FZju6xUdRCpTHYgRqkK04rKeJ9v
 GWYlKOQLDjLJlUaQssq0kx9ZMu1bZssR7Q1yyKs82T4JnyTfzVY5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the non-deprecated, SoC-specific DSI compatible.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index fbd67d2c8d78..18c7eedff300 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -1219,7 +1219,7 @@ opp-384000000 {
 			};
 
 			mdss_dsi0: dsi@5e94000 {
-				compatible = "qcom,dsi-ctrl-6g-qcm2290";
+				compatible = "qcom,sm6115-dsi-ctrl", "qcom,mdss-dsi-ctrl";
 				reg = <0x0 0x05e94000 0x0 0x400>;
 				reg-names = "dsi_ctrl";
 

-- 
2.39.2

