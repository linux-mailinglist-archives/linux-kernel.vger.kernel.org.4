Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CF46BCA09
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjCPIxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjCPIw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:52:26 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3746B7187
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:51:28 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b13so846873ljf.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678956683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0GttnUpSMQrNUPBOzshROVp8f4Y5lS6s/EI+l80bqFw=;
        b=kor1lxAULsgXkpl5n64+yKp3HEn3UHihlasLo4LG+IOiKjqo1qtzr1e5I/ghTBAylY
         BCoZPVTDVpOVOWIbDNddIMYOAXk6EEyYrsFqKaa5+FnmIJhNEuurv5b0RcODOjjXuDN0
         PM2JSV7/QYTIVm85BHodt4ikndfKKD8HBosxsc1RGNfLC1O9dVl2Mn0c5CtGjgmK1kOF
         fHTtwg6SBZkgxtJtbReG5xwaoMzywUUN8BhqF5vrpxWZnTfNlaLGR9dO5PmKAG+QieFi
         QD5f71lxG8Ou3wJL/5WHhlZUbech32UsOKsG7bVeGODz300d6VYJ6SyiEWRmVBwgkMmE
         Qjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678956683;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GttnUpSMQrNUPBOzshROVp8f4Y5lS6s/EI+l80bqFw=;
        b=iYu+tgWHI9fmKmTMmSeRnYFE0nJOQ0MUawALtYKN0KpiAnJ0E8ORCdnl9V8a6917+C
         jidjy/7OkK1jOcWXSsHGIaTJWmcTIA2acOLB2Eks2u+MxfDudcGCtpIqu/u8ZH3KLnPz
         z1Rscfz7X7NrbHmgLv+YSNjGMstjuJgneLGo+9G+JtYPvm4UHeRwHcGTdhs31JCZ8/dv
         LvH4E7R1Rm++qgCERvEUuXq1Zp1bCHj/c1b48MhW70BjwCNQAfu50TQPnY3IK+JE1tug
         AofBQqcDGqppEuUkOJ2RU8YAfeclMvzMl66y3/G71ASlAOpU95oUqKp1bwSTqPvOykcr
         rKHQ==
X-Gm-Message-State: AO0yUKXDruiEBKL8pxbQE6pujqNxv8k5VrjbHxBXgputbDkI1F9AtT8y
        KjNlWmXlLBaZEBYeBcPBRcsOAQ==
X-Google-Smtp-Source: AK7set+Auq5+dK5gJxeZ4K0r+SZ3n9ajfcsMSJJWCPkouivw5kREanh325/ho0hHzItRpdsZj7o0LA==
X-Received: by 2002:a2e:b81a:0:b0:295:9d32:a653 with SMTP id u26-20020a2eb81a000000b002959d32a653mr1892728ljo.35.1678956683403;
        Thu, 16 Mar 2023 01:51:23 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id o11-20020a2e730b000000b002991baef49bsm251566ljc.12.2023.03.16.01.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 01:51:23 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 09:51:14 +0100
Subject: [PATCH v5 08/10] dt-bindings: display/msm: dsi-controller-main:
 Fix deprecated compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v5-8-9d4235b77f4f@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678956668; l=1378;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gFmAP3VKT7x6AjOlQ5QOdQrgbA01mNjW7lXWqOa56r4=;
 b=/UpSuxnKnArcV+HWoUWDAufdkfQwfpnaiqHNzcClp4+YCDcXHujpQWA5K/0h66dCKLiARD8E1ApW
 NmjtaJn1A1mPgRT5NzHJaiJqjVVNBs64JEninpB86VDW33G3VRwB
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

The point of the previous cleanup was to disallow "qcom,mdss-dsi-ctrl"
alone. This however didn't quite work out and the property became
undocumented instead of deprecated. Fix that.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml       | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 2494817c1bd6..ecc89011bec4 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -31,10 +31,9 @@ properties:
               - qcom,sm8450-dsi-ctrl
               - qcom,sm8550-dsi-ctrl
           - const: qcom,mdss-dsi-ctrl
-      - items:
-          - enum:
-              - qcom,dsi-ctrl-6g-qcm2290
-          - const: qcom,mdss-dsi-ctrl
+      - enum:
+          - qcom,dsi-ctrl-6g-qcm2290
+          - qcom,mdss-dsi-ctrl # This should always come with an SoC-specific compatible
         deprecated: true
 
   reg:

-- 
2.39.2

