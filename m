Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA1B6BC9F0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjCPIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCPIwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:52:18 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D16FFF6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:51:18 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id a32so861658ljq.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678956672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lGx1EMDayEFQk6t13uD2RfqUM6dmmVIVZCz4JA+bL8w=;
        b=k2cZi+Jizy40BMhfzsFTiSKLERA9RYxhndpDgUsgMlfQIwRh66hPqO35fyMbMVapCd
         K8wIf7Hi3PQqH/klEXZWCIiqLmfx/1/T/fbFgi5QsQ/7TyqIvr6xdvS4CAnrdDxz08xM
         MNFE7NYLeQux8D4Eyd1mcyjW65Im5o4IsopklTpdzkERhfGKIM13ArVFWU0gDnH8Gq0d
         zB8h3bjeXJKf7V4mLC5Eoc12alyTrk8Wz4ZJGBIoZxzuUs8YITb9G9OrRBFA2Pf2faTX
         xtUTEArirXWTU39FinWou3VtsdAbpLicVipmbHTkyLV6egSpWaNrc3+FD4GZkKKxsS49
         SRSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678956672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lGx1EMDayEFQk6t13uD2RfqUM6dmmVIVZCz4JA+bL8w=;
        b=n3uo4sQyIqs9rcLNHB92V88m1PDN57iJboDeIq/quKNGkTCnX01rkc3c8p86BkPb/Y
         enyAnkZrPamucsVh/S4NY23lhO+SrIP//juS3jg0TceHh3I3zylKMp+Nd5hOjXjuOh23
         WhchY3hGbLiFRN2x7DACc/DHjyM1czbMQ0DoGcEWBD35ZvkWR96pJUbTjaP5xVCKjjqL
         lvQNGyqJrRKN0ARDs8fJUjZIA73iYrGLBf8Gw4klREilit1ZYMI6mwaGcpYy2ZALuHKj
         wEzAA9cpPunCsZ4cSJkyr43F1BD1qnWrp5c/RZIRLKZfEMyCaqR2Asy44EolyZ6GzGSS
         Si1w==
X-Gm-Message-State: AO0yUKVTFu25rw/sZyrjVQL1ruuioJtsCWtZeIt7xISeclUyBerT79iv
        cPVAsG2VAXQUfvKhQOjvQTbLvg==
X-Google-Smtp-Source: AK7set+LOdjLIijgTnxittedEAg9C0JxSXja6pNSpgc6AZvJIVz8rS3AEv6aIeHCQyAyI4Z2IzC4eA==
X-Received: by 2002:a05:651c:550:b0:290:6e01:8d0b with SMTP id q16-20020a05651c055000b002906e018d0bmr2495303ljp.26.1678956672023;
        Thu, 16 Mar 2023 01:51:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o11-20020a2e730b000000b002991baef49bsm251566ljc.12.2023.03.16.01.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:51:11 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 09:51:07 +0100
Subject: [PATCH v5 01/10] dt-bindings: display/msm: dsi-controller-main:
 Fix deprecated QCM2290 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v5-1-9d4235b77f4f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678956668; l=1083;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Eh63V3hQJ0V0iEgOzc+LSRnQ4e7sliZ5heAo7YfywsQ=;
 b=0aBVkVeI/ZqqJNMp8miJ4K//LS3qrTKMSBxQoa70P28PuSQ+d9x7z6eVXh31sSjvZLUoOUVrG7eo
 znTwkN6hCC+O6+mSA0aiGA588ugQL8OuLP0emYeXYR9x/WhUM8b3
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

The qcom, prefix was missed previously. Fix it.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index e75a3efe4dac..2494817c1bd6 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -33,7 +33,7 @@ properties:
           - const: qcom,mdss-dsi-ctrl
       - items:
           - enum:
-              - dsi-ctrl-6g-qcm2290
+              - qcom,dsi-ctrl-6g-qcm2290
           - const: qcom,mdss-dsi-ctrl
         deprecated: true
 

-- 
2.39.2

