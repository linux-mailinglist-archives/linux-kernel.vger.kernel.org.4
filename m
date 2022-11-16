Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739D562B80A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiKPK0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:26:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238605AbiKPKZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:25:56 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D03B26EE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:23:32 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id g12so28908993wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vNIlS80kI1g8+qpgwOwxCzQSIw/iF68yTj9CQJk6jc=;
        b=Bxsr3i43QperYujsQtXipOC905fXuVERDgusSJIvEtaTQ68Vf0jd9PCrODZ+fyxjDR
         iA0Vnq5qlE2yi/za2uQeLdUNeEPhdIWqO7m78jkfZj58Pu99og/hLBHbeDl/QpKMYnsP
         XzdAid08n1klbkzVjV0qrW+zGW3E5+AvI5gYEEUa0LgrTxeoCVTXZ+MKWiRIVQ9gtHDS
         qar1/O6Yl9vXfu+eo/++l+XXM4koB4lwwUNNea13xLKIxp53iHIKpW5kzfuKZMhQ/4m5
         ozc9jdpJb1VdzG1BJNY+I3xYMbGzQEZC68SM9zjqY4wfndLuu6w/u/Gl+Y4tZX2Jwtfj
         sZsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vNIlS80kI1g8+qpgwOwxCzQSIw/iF68yTj9CQJk6jc=;
        b=EsSbZNUbz/dS87WnmJYtWENUf9efGejfENAid3eVcq0Gs+YnUHQTkkOaV3dJmaIv1O
         ZroJWVfYHxJ7L42puNTRSCX7JdTrKRkmBEHeb/yWGmx8cdLzuUVmf4F2JogRQn8fW2wU
         16PgQiqDxyEJgwgsCQw/tDK6mVFzRJ2jPHPuEnDGmBieWajY6N79mxIePzl350/izPul
         8QyX5NYXVuBw7HRAUBPxox7RTyO3xj8lEsq/tNMGJRF0LAOyVvrxt45QY+LnfRWXqWhJ
         4HvCJt8KQttXCPDrXOTJwGTFqQI5And3KzQ4Mmo4nsyjvMnMeSu6AeqMsIGdDP1FAfFy
         iwIQ==
X-Gm-Message-State: ANoB5pk2jlfG3XOyg5oAwTW1ywQm4ZNOM58eFcIQRWoCrdG54Bq9J2bE
        G2Xd1o9o1E1Lte5vEkrWqxQiQg==
X-Google-Smtp-Source: AA0mqf4aCq3gfSN0xjPybxVilQeFWq0t3p4Q22xrVpZc1FMzU+XToiawOAMTArWuFmxIBWKZiHBGKQ==
X-Received: by 2002:a05:6000:691:b0:241:7e9f:8afd with SMTP id bo17-20020a056000069100b002417e9f8afdmr10325981wrb.228.1668594191959;
        Wed, 16 Nov 2022 02:23:11 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id i9-20020adfefc9000000b00228dbf15072sm14927047wrp.62.2022.11.16.02.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 02:23:11 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 16 Nov 2022 11:23:09 +0100
Subject: [PATCH 2/4] dt-bindings: qcom-qce: document clocks and clock-names as
 optional
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-qce-v1-2-31b489d5690a@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-qce-v1-0-31b489d5690a@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-qce-v1-0-31b489d5690a@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Andersson <andersson@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On certain Snapdragon processors, the crypto engine clocks are enabled by
default by security firmware.

Drop clocks and clock-names from the required properties list.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/crypto/qcom-qce.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
index aa2f676f5382..f25089bf9a2b 100644
--- a/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
+++ b/Documentation/devicetree/bindings/crypto/qcom-qce.yaml
@@ -67,8 +67,6 @@ properties:
 required:
   - compatible
   - reg
-  - clocks
-  - clock-names
   - dmas
   - dma-names
 

-- 
b4 0.10.1
