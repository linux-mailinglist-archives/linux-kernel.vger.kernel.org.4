Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C196873DC47
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 12:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjFZKcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 06:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjFZKcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 06:32:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF1EE58
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:32:12 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so1317210e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 03:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687775530; x=1690367530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUgR1dLnPuxY4uDBYSPviY8Dvlm6F0UAHROxIQjI3RI=;
        b=S0rxiJEIck2B0qiJwwnlBYplTMkTowmDofeL+hW9pOjaFLazRvV3dYtA/lbkVWrsej
         U3qhcNmRVqC4xYDGgKJtoJe4RoGGqAn/BjXNCGvqdwu7O+X8Np/12n3euCUNJs+Q7liO
         ZQ3zkr4YBv6sTRBZUw1UrmqovWFuiib7OGR4TBpI/eWHdiy+YOqzgto9jba6GxESwdKu
         x+6iR68nFE8FyPLNNS17eg/45holEeJPgTNrldlgek17mHIycP594a5eLWhqGTDAJ8Eq
         vT9aFwAaAYIfRN0KqUTNbOzjfXWRZ/+gwLe7LglAc/LwKoGl4SX/RRTUS1poMw7AsfRa
         bUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687775530; x=1690367530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tUgR1dLnPuxY4uDBYSPviY8Dvlm6F0UAHROxIQjI3RI=;
        b=IOuPGY0Fz60vwPSnTo4SmzqvGIeSB9Kzot6I+woAk4ZSfnXEsRE9XX6y742jBqUqmc
         BCA86PshE7jQNxtWJwzAtxkNXokg8OPaa30oVYyv1m/pgaotzGjHpU7eS36XTOpVjGlO
         WtaXTvY9JhZs+9GM11d2Ewakac54SOdsgmMbw6hMZhvmgnmR1GjKy8gS90hVD2/exgug
         +YjlwZIwX+d0DiAcrmo6cFptupapoXidw5EjB6/etf/4nWIvckzfz/jgDUa3SQm/9KN1
         H3hQjM5JUGdXt0iu5jM30bYRjbUVdZvc9Un7jScQ5ZGVx6HSh81XeLbqJMqMgO/kcz3P
         R/2w==
X-Gm-Message-State: AC+VfDzg080vvYp3cJz4WcMKjLRbczt6KOGt5WgZ7VTHTFocy0qkGtFZ
        KFsjY6kjhkllYBXr6y7fdT5ewg==
X-Google-Smtp-Source: ACHHUZ4bzudIo1D9r0Rg7s/vfxrKuM7pbkkFh8NBSgttAPwb65aHdHQomcKk0wJSZRIsF8HsCRI4/g==
X-Received: by 2002:a05:6512:3a95:b0:4f9:6adf:3981 with SMTP id q21-20020a0565123a9500b004f96adf3981mr3350599lfu.33.1687775530289;
        Mon, 26 Jun 2023 03:32:10 -0700 (PDT)
Received: from [192.168.1.101] (abyk179.neoplus.adsl.tpnet.pl. [83.9.30.179])
        by smtp.gmail.com with ESMTPSA id c26-20020ac2531a000000b004f13ca69dc8sm1041655lfh.72.2023.06.26.03.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 03:32:10 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 26 Jun 2023 12:32:06 +0200
Subject: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Mitsumi Electric
 Co., Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230621-topic-mm8013-v2-1-4be6223587ad@linaro.org>
References: <20230621-topic-mm8013-v2-0-4be6223587ad@linaro.org>
In-Reply-To: <20230621-topic-mm8013-v2-0-4be6223587ad@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687775527; l=1125;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=TuRO5xCEXwws0sr0Ai5UAAA9eIk2XyYn2SGhIajpq0E=;
 b=YUjTXuuD7JlDrbZ3dgnAc3HoM7SActksn/k/2eFBg71QNM2I7rOd9bWH+tXW5vF0MvYd0QO7j
 7xN9o6r9MBXDKjPJiSucfXZfoxt1UJlqZTIlMNI8EVqw1PyPwQP9710
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mitsumi was [1] a Japanese company making various electronics devices
and components. They've merged into a new entity, MinebeaMitsumi in 2017.

Their current main page is available at [2]

[1] https://en.wikipedia.org/wiki/Mitsumi_Electric
[2] https://product.minebeamitsumi.com/en/

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index af60bf1a6664..6142c40cf06e 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -865,6 +865,8 @@ patternProperties:
     description: MiraMEMS Sensing Technology Co., Ltd.
   "^mitsubishi,.*":
     description: Mitsubishi Electric Corporation
+  "^mitsumi,.*":
+    description: Mitsumi Electric Co., Ltd.
   "^mixel,.*":
     description: Mixel, Inc.
   "^miyoo,.*":

-- 
2.41.0

