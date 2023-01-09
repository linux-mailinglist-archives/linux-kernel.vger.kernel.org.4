Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517D366217B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjAIJ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:26:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjAIJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:26:44 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2482AE
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:26:43 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so6786781wml.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KqmLVgay/XqUNaT/xdLAcUPvxXRqKr/LkmMi0cg+BiA=;
        b=vFJGUQxQwVVfSUIbv6MJWzDEWqUs/JRKefkXc35uK/FCCbHEPD7ABHHP6l0i9Qtt3Z
         WdhjJorxYa6inL5U+nn+RuR+83hRqB+SN7Ux9vxjT1yhrMWhvgzWKfPoWxaTOvcmJlWG
         IMPACdhipUcalbBDuvNJLaLW1zwG84Pa2INJOcPoDvujWBQu0gprrTBVOWzSaxnBPV/0
         WYjhLSuDWl6hOY2Xkch74u3vT7jOxFKUJH6EVO26isuitnALNDcvlx+atOreULrRdWa4
         xBq066zR9tRavmyqO0QcINKaEscDcyycosuaDAymUfuZJjQyO7v2xJuFHVs/axNOETwV
         3/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqmLVgay/XqUNaT/xdLAcUPvxXRqKr/LkmMi0cg+BiA=;
        b=SaXSUYV4dRtY+5lR+iv1dHziS14XwkAFr7uSg3EaRQjvRrIJJKrfne3Wlke4BFkEv6
         W0sQOG3rmtWQO1kae8JSGwZSXLKbL8MFvt9CRxoKlF3MDBAfmlgOwdbB+Ic4tX751yu8
         6cekypHh7IEw0mjeiSWr7b+4/pmoiSWr0jNFMK8XMuIH6QZ1UGFxFIH9XRu3k3W2TvI3
         peFtArIU7doJOcGxCh0Tzqj/OQ/7j3egt6IOVowf98nOiiUlcslwEuecs4SjQcThaDiE
         qwlbgRAGmCW9od4D0v3wSnEdA1QW0+yKV+mYN/QSJBCYMwV4b9V3nSUBbjXLkaiQ2GbT
         iGEg==
X-Gm-Message-State: AFqh2kpzaEGdCx9HoMYj9gWlFKMYZY+0Ke9vNwTJqKF3JxOl4OBbzEwK
        scc6DLEbCob5rl5JH0yJxU2aug==
X-Google-Smtp-Source: AMrXdXs3M9hLBBet8rNXj4CgsKntDY7FRJIZhtrjOokvCd8hf+wIdnNNqKxE//VENUIdFVYjJ9kIQA==
X-Received: by 2002:a05:600c:12c6:b0:3cf:6926:2abb with SMTP id v6-20020a05600c12c600b003cf69262abbmr48660636wmd.7.1673256401693;
        Mon, 09 Jan 2023 01:26:41 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003d1e3b1624dsm15195758wmc.2.2023.01.09.01.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:26:41 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 10:26:33 +0100
Subject: [PATCH v2 1/7] dt-bindings: display/msm: document the SM8550 DSI PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-topic-sm8550-upstream-mdss-dsi-v2-1-87f1c16d7635@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8550 DSI PHY which is very close from the 7nm
and 5nm DSI PHYs found in earlier platforms.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
index 299751a9caea..78ab8c410ccd 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-7nm.yaml
@@ -20,6 +20,7 @@ properties:
       - qcom,sc7280-dsi-phy-7nm
       - qcom,sm8350-dsi-phy-5nm
       - qcom,sm8450-dsi-phy-5nm
+      - qcom,sm8550-dsi-phy-4nm
 
   reg:
     items:

-- 
2.34.1
