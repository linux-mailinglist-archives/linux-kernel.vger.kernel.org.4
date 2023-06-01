Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A071989A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjFAKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjFAKKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:10:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BB210E0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:10:04 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f6dbe3c230so6810975e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614203; x=1688206203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4hM3UpU4FHsZR3ujTD4pG4KYkhz/mexEq2D+ziSUPKA=;
        b=wm0YX/FCvbKlhU8+yx/ex0SXt+VVm9oGs34CkMJgcsUos/ksIQds0jbU/2zfqJdNMt
         B1q+sI1TqnYVnzmPYirTEpd4EYzOe+2ajmG0xIlETpmHWTkrGv7/1bL4/mIupyl0zYMD
         7DZkQ9loj/ET7NJHVN7pd6l+TaDNDIDS6wfKdKO8v+MA2lM9c2XYyaEwAfKApDvTmm6r
         MOEnvqmzG9Gbpj/CSNvftIdqq1AoqGSyUYNvaJewpt+0sprqYWtSwd67YkqhsL+wkvNt
         XWgRnHXQh2c88A8ZAI39Pk03HhtDHcOOoHlwFwo8pazb+G0LCsXZDv6zpBCgxGls89Vq
         SJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614203; x=1688206203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hM3UpU4FHsZR3ujTD4pG4KYkhz/mexEq2D+ziSUPKA=;
        b=d1QeAC9fA5SrIF+QzApNr/gcNi11+0DBD0ZQjWGVakG30Lks5YrfndLvf6TUOhokXZ
         2v3Wnr3k7qNZg7njMZR5BQz/IDaiVpNHt56q9AxM4LhrRiPr2A4LiWn4wmzQoN1KycPQ
         /QnUHZD3p+ZYmVzfs+u8xLopO6kWRh1bKILstQ0SeAYEhXEdHp2MofDVfozredbtr966
         ANFUw5ONlUBIzhhfnr9O0agYwplDOUUZd4UQ/oF2A0vzSLW1a9PiOHr1ylpJcR/3wkxy
         EqfiZyncNbs3sRAP+41BX70DL8n4/rJKIByrEH6U1U2zkRm51gwaxVY0RCmB7FVZRkI7
         wzKw==
X-Gm-Message-State: AC+VfDyDVtZ9Di/X2ap4xqrTP0Qs6B5Nz9RMzYzCdaYw0gxsoqVt06ak
        C8ehsbQ7xH9ihTIzh+Il5CsExw==
X-Google-Smtp-Source: ACHHUZ69Bbf6Z3INj/J+PwXGLRxzxffkhFi1gLwovYKWHvCS3FLJST4uEj1nucW5+Z4m4vb6CSO5MA==
X-Received: by 2002:a5d:60d1:0:b0:309:5029:b075 with SMTP id x17-20020a5d60d1000000b003095029b075mr1497452wrt.13.1685614203474;
        Thu, 01 Jun 2023 03:10:03 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b0030ae53550f5sm9683845wrn.51.2023.06.01.03.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:10:03 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 01 Jun 2023 12:09:47 +0200
Subject: [PATCH v2 1/3] dt-bindings: display: msm: dp-controller: document
 SM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230601-topic-sm8550-upstream-dp-v2-1-e8778109c757@linaro.org>
References: <20230601-topic-sm8550-upstream-dp-v2-0-e8778109c757@linaro.org>
In-Reply-To: <20230601-topic-sm8550-upstream-dp-v2-0-e8778109c757@linaro.org>
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
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=876;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=DRIkrQLx11ml/or6ze6+hR4V0lPSP/PMoO7uVnzdRFc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeG54qg4wI0MlQbpeCkfXkCVcdBiCMuVoAT0SMQ1N
 59LRRxeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhueAAKCRB33NvayMhJ0afpD/
 9uWKQsA/VKfHHE76RHNW3PPQDOjVTLJ9jcBX1WePnao/vNYlw9XuVl/GTt2p8YhPZSHBIYU/T7ukFf
 lI2nbrdnYJFFikTpvDhyQvT68mZ00mTXDDakUxVB/nLwzjlAOGTUc9FbDNAifNACgVjIs+/woS4FWK
 1GLiWtPat8FaGPKQyhtnuOXTyrs1Adzidf0B5HfxDIT/ydsvX35TAVcfnl36MHTVF4ElAByV122Dnj
 7VTFiTw1ibXKN2Si6b482wou3s8hTuz64t4dKF1FmIF86b+OfJ2rr4ilpM6tCVId06IvjyYts7mZZc
 rd1DKtP+PTq2wM6hBWGrXe03vezEBp6/E+13CrqX0Rhu6CSNxyiLBm76ucWC/4oHwE6vz1zmt4LgEr
 HXeJg5KAPE1AFp7MmZGeJVdXe3CPDlSEXJkxvH0QQ8RXuHUdKfphFvi9b2oHX+tgEXIdVySCpSHo46
 8ihW6AMow+htUomkVYCNm8Gv+ZRvAOlG8Wn0/1s0oFk0fFENrBYvJNBecKqu/FLhGYdGQ7qurHcpF3
 B8DeUX2KQW6yDCvfHJ4NCcF0PG4aXOEGr+Sn8OxGA36hL63GfVQkeZ0nRpNYds81DRKMgPkW2VRdLc
 1lrLzNM2ztNi4RGed6RJ+gv/M5bd3VdkW0SY6Tph/gKTD4D9SuZ351pRlYQQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 & SM8350 SoC shares the same DP TX IP version, use the
SM8350 compatible as fallback for SM8550.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

