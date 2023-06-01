Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173827197C7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjFAJwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjFAJwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:52:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAA81AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 02:52:30 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30af86a966eso586639f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 02:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613149; x=1688205149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8attWh5blvnbK1LTsKzAzIPWfugB8bqZKE5rCB1mH2E=;
        b=WMBGwlX/O8yvrJIcjOaJA5LTwFL5xJM1kY0E7juWli5+RbvtRVvKGa3nxk4PzKmtq1
         qEWjRNIqJIeu+J0b9WulCuXfuaAju5RQ/V+Q9ot39V0HuSW1dgk6vyqhkS8KTV0Uc13f
         PS/qpka1R6ODmKblm1HQNxHrATX4+ns2ooNCyMvAVIggMdhfCrPjHjAvTJXicabH2/8J
         U6UtmkJYshzk0pWg8dpQd84ok0ITwyI01uYFiL3xmnff6FQd/1jYH1ipEhvvWmFWquKq
         jPJXcAZZIn4reSOWzBQK6k2j56widPKIBxuzkhnfrR5LQmxHOuJLCgFmGyI3C1IOtFbO
         OpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613149; x=1688205149;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8attWh5blvnbK1LTsKzAzIPWfugB8bqZKE5rCB1mH2E=;
        b=a/DdYCkyg0HNRbLzAa5oV+/CNwM1moew1lPZnvO1LjrGUpMLXlVvoi53gg2Yg9lJLa
         zT8I78X9s7tijUP/IBYAtfK9RmaEtGywydcNnBhC61pRnwcp6KFTT8ePwJyzVUjiZyDb
         69hevuF85z2O1IuWpQHFOWZDM6AnwL6K7Cq09pBXMKoBzk+e+pfpKs1U0cfGFw+fxM9u
         tikR7R8dwKz5lsyy2u+SS0Rj+iMFTEad4oWbeOF1+0RGFHa0DS5WbJa0S6FtlfyC1jh8
         z0zD3wpVZaA8rRIIsTLozNGACEQc+3uXPPeRDDMc9h/UJ1ovxczhb+WmY+iPOoI13RJM
         1E4w==
X-Gm-Message-State: AC+VfDzi3IKEooSZmIRVeMK/PVGUpKMVAkM19r/oyn8pkIaGnxDYeqfb
        DIBgLsQSuFi/g2NbNgTfdOT+5w==
X-Google-Smtp-Source: ACHHUZ5Uwli8lIE4aUP29QdpJvFFOhoFA838PaUoUut8+Zvx5HXYE0KDra2r/45aiutnlBy2iQn2og==
X-Received: by 2002:adf:ee8e:0:b0:2f5:930:39b1 with SMTP id b14-20020adfee8e000000b002f5093039b1mr1388308wro.38.1685613148927;
        Thu, 01 Jun 2023 02:52:28 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id z9-20020a5d4409000000b0030af05fce4dsm9746150wrq.77.2023.06.01.02.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 02:52:28 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 11:52:24 +0200
Subject: [PATCH 1/2] dt-bindings: display: msm: dp-controller: document
 SM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-dp-v1-1-29efe2689553@linaro.org>
References: <20230601-topic-sm8550-upstream-dp-v1-0-29efe2689553@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v1-0-29efe2689553@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=812;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xZLag6FJYjzac0Af/641OR1LVZQQZ3vGR7dxiu2wW2k=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeGpZO1zfPVuPaj5xJCI/YaYWnipNbGY/zOZsKGD/
 6dwpMOWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhqWQAKCRB33NvayMhJ0elbEA
 C9slU97TnvSWLFECu3STmbQT68/hUCOfKfs1km6yvrBOEs6xxoE/WVz3Syv5lj/O01R+C2+BiNkumd
 WXvpwT3N3PX7DuTboZskNyXFt3hP78gsIKl+KNxe3TpWcggLJb91nYcBvf8eLkUrD903FSsP+bU8sb
 paOyFG8U0raryciPLMEaNeYiroQuMiYywfGIP6ZBV2CKE2JDPQd5BGD2ocRjZUjsNMLP2siQ4yXaHI
 +Ge3j9TLUDz88oIl21p5+AoZ2zQmMNAE3CvzuQ5OWj/FHd74jhc6Q8wnT+MPrKfzpQRTjKzlFfjM/h
 XTEi/a3G6H1S/nYGyqkgwZCV1MTqY6QRkHI9XYGxQohm1JdpviWkXQoFGCG0epxnrZhAUYG5f74/fy
 JH7GIehs5OhwOBggl1uFjGDDqVGvlbr+bAMVXFIH4B9BmSh7hY2wrwhh9Qwhexj2ZeVmsQB8JgBN8Z
 xJt3vi6/k5XvH8tUsM7EMePECXOLLAuuXbwn0nFwIETBIQDqncVVWO3+u1gu23e64AWmm3bOeETC41
 3Q3LBV1lBG4YoCmY8eKJSZ6GvERyAjFD35LKm2Hcljsh0JkDI44pMlV4w01293i3VEmRQr7LmvmMzS
 MeVzMwr5OSkeWjbKtD3Hxcs7wYy53kyDs9kcWRT/5Y2JHFNMuHeb6mOb+wsw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 & SM8350 SoC shares the same DP TX IP version, use the
SM8350 compatible as fallback for SM8550.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dp-controller.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index f0c2237d5f82..7a7cf3fb3e6d 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -29,6 +29,7 @@ properties:
       - items:
           - enum:
               - qcom,sm8450-dp
+              - qcom,sm8550-dp
           - const: qcom,sm8350-dp
 
   reg:

-- 
2.34.1

