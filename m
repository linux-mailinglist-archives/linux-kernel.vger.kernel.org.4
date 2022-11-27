Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F656639CAA
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 20:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiK0T4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 14:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiK0T4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 14:56:40 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AF5DF60
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:56:38 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d3so3323634plr.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 11:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fFn/YKE8jPSBUZvBBUeVp9MQ2tiONJsxtj+ufAwhww=;
        b=ochlP3mYMyIUiJmaI0D7X7oaduxw2wgrT7rxHtg0Ojn6dw1dpfgSx1kDYyp3lby7PQ
         JsWNT/OASkrthRpWr/u3wiv7P4W4LZ6FR+svfw9Uvz1FlvWlZBYmrLPTj4GI5EDJrb3Q
         KPoHBU9SvoXj4V/YLsWYvwC+BZ0//JM6/HELh3+tGmGedAAb++2Nrqg9mnfcwvXNMCuZ
         qmkI7QVITLFzaPdFhKvJoxOIDm0XNLJRIsGf8ZV0ka/qdwEGIj6uZuYZOAhXuzkdka5O
         Rwoi2Ujis+OeUYvew8K0Dv3Cmpc/Dgqkq+T820eI+z8L77Cy5qSqWCtio4LMjaI7FpZ4
         FLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fFn/YKE8jPSBUZvBBUeVp9MQ2tiONJsxtj+ufAwhww=;
        b=BX66dv9J5KzqVDGBp65/Imlm9mEgt6n/tl6fchBmjtabLutCnmeTLdjq0Wnsg6wOOt
         bRUDpWmN7uNAhQslsmcjZ6R/VcMlofLkPvG38MmgU1GaGQVK8OhfITIiRAmVBAd+SdPX
         JRoIgQ0bvofBE8Go0r7xRGtmFJDqWAujSMdmqxfKaL0NiTuYd1RKQ9i/RS+q/Dm4lk0y
         OwdcKGWwuLhrNRDN4c2PWqK73G8v9Zb6gsgc9egSz8vxF5LtZu6tQRXUpoA8Q91L/zcr
         j71FcDHi6zYqvsJGjjA2psVUEkcNLOZnk3HJzKDPx/criyCN8c1uAXqMhKRDXNwH/Ysv
         F9cQ==
X-Gm-Message-State: ANoB5pncRAxT4zVl6L0LPTWaoD/qOHEKOK/Kqn7qnei+pilWCANLIBB5
        SIrwYD+qWYqtxAryq08BHgn7bw==
X-Google-Smtp-Source: AA0mqf4otZZgHImjhiYMefW0riYu3ZM2VvHXjOJFvthJzin/lETGrkWlF4Kxn6KbVm4QutRluWdgxA==
X-Received: by 2002:a17:902:cf03:b0:186:5d7e:7ca8 with SMTP id i3-20020a170902cf0300b001865d7e7ca8mr28080223plg.74.1669578998284;
        Sun, 27 Nov 2022 11:56:38 -0800 (PST)
Received: from localhost.localdomain ([223.179.131.184])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902968100b00186616b8fbasm564636plp.10.2022.11.27.11.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 11:56:37 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     jassisinghbrar@gmail.com, devicetree@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, agross@kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: [PATCH 1/2] dt-bindings: mailbox: qcom: Add SM4250 APCS compatible
Date:   Mon, 28 Nov 2022 01:24:17 +0530
Message-Id: <20221127195418.1506876-2-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221127195418.1506876-1-bhupesh.sharma@linaro.org>
References: <20221127195418.1506876-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for the Qualcomm SM4250 APCS block.

Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 .../devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
index f24fd84b4b05..05fbef6486fe 100644
--- a/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom,apcs-kpss-global.yaml
@@ -28,6 +28,7 @@ properties:
               - qcom,sc8180x-apss-shared
               - qcom,sdm660-apcs-hmss-global
               - qcom,sdm845-apss-shared
+              - qcom,sm4250-apcs-hmss-global
               - qcom,sm6125-apcs-hmss-global
               - qcom,sm6115-apcs-hmss-global
               - qcom,sm8150-apss-shared
-- 
2.38.1

