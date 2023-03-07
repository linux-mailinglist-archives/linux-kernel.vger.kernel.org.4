Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35AE6ADF80
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 14:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjCGNB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 08:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjCGNBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 08:01:46 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B23FE0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 05:01:45 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id m6so16956350lfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 05:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678194103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBjV0MIGjzxWCA4dde9ccbuSp/4SeZ0AfFye0IJguH0=;
        b=S8K842lXW/grOayUPiw1/stytcPwZSZw0ib3Rwy0G8TyU3BoqzW3i8GNnezA75iJe0
         F7HbbM9q2lxbK5+c3ta6HNsfVLqMBtL+CzPhG4mIP/5W7xIU+socPmju4EYLTcIUOU79
         +zj5AxGzs7WfjpWK/llomuMJ7Vp3dns4XOpOPPDLIZvJPcHMrWMDIkpBBQ0DVaik4aeC
         Myyy6/XxwQ8T9XVXJbWlX0/rC6juLAo+ZwwGNEAbopbofiS91kTYa9nKLJpyw/MP7lHw
         P0jWblIUN56/EU3Een7Ib8YU0ugO5btmCZdq2y6MOVR/gimEISu0JfHR37i7PelEw5ig
         eetg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678194103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBjV0MIGjzxWCA4dde9ccbuSp/4SeZ0AfFye0IJguH0=;
        b=tOdsln8xU9V4QNhnqKo2oLkYj9mokFmraK53j+m3ZKZontw3Rm9G25btdCW3KtE15R
         v+7mdXNzqng8G93FUQEGUdwOcQEG/BLGs+THUjR8ZBRvGxTYElCI8aZDl0gf5hvUjPem
         IQ3avtQAfRiO61ZzZzZZ2DZyOUAmv1cCdbw/uqeTkePLyHrmmkO1JtFJwZwzeQzK90AA
         0dbcZZ5sJv0nV375YnGYt4jTgYw8SK+tPDr4tczJl4vLhurcNlu9BM+Pe53efV5GzIZT
         uaraUvAox+eEvkYeeDC09ZHIyNHujHRpnIJ82POtxDWpgWfvAXo6OTCwDOLyUYDunR2i
         1WwQ==
X-Gm-Message-State: AO0yUKUpBSBZ8tl+joaQB/eVOKDRuxa0dF6B+5DRMhCwgkGir/UFdjZy
        TaEczy12nybtzQEbWVq4aQdRow==
X-Google-Smtp-Source: AK7set/BUtMgR4MG5rcNS3SZZlwGfqldYfAdp5uYc++c6d8LEm3HWAca8HOGIbFj8Oi5XqD7hswj6A==
X-Received: by 2002:ac2:43aa:0:b0:4b5:6042:d136 with SMTP id t10-20020ac243aa000000b004b56042d136mr4125457lfl.22.1678194103253;
        Tue, 07 Mar 2023 05:01:43 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u2-20020ac248a2000000b004cc5e97d356sm2048265lfg.148.2023.03.07.05.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 05:01:42 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 07 Mar 2023 14:01:39 +0100
Subject: [PATCH v3 01/10] dt-bindings: display/msm: dsi-controller-main:
 Fix deprecated QCM2290 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230307-topic-dsi_qcm-v3-1-8bd7e1add38a@linaro.org>
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
In-Reply-To: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
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
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678194100; l=1022;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yadLtYUd+NaBlrHtthnWah/BoxxYiya5SpI6g5dSH5k=;
 b=VXFbvloo8L6tf6wwoMkScWR9GbZ6ztU3t6q9TPy+AM8ughrYGsc0FKWNJHCSqgBFQH3zp2bjnBiP
 1u/l49IqAkFsvhNRiqUfofrrCrYY3xmsfHQCG0TIA5f8YQPX277W
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

The qcom, prefix was missed previously. Fix it.

Fixes: 0c0f65c6dd44 ("dt-bindings: msm: dsi-controller-main: Add compatible strings for every current SoC")
Acked-by: Rob Herring <robh@kernel.org>
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

