Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859B568BE8A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjBFNod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBFNoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:44:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6824423DB5
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:12 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id z13so1232778wmp.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcQCOTgzaeE74ZCuxo4/3CNeOTAuJvVOxPA2T7IDx74=;
        b=Pfgt8ch43jiNNCklv4ad/yczZ5V7HMAIs19a0WwmzBW9S2RPMkHLbMK0vGhUyEj4iH
         MfkYZ479mOjU6cn8U51zyhr0h4rLVr4vNKIAmjFOOo2fBeQCrF0hWxhjURJhQSjGvOU1
         AaZobTc9or0EhwGrffaOy4QUKnHKFW5AL3e4qavBkEIRhD+/hLcWOXIQdBEXGOBaRl2Z
         titS6s7kqhydT50R3KntOop8azQjrYogj/V9+KSitD/rLVt4p/X23YELkTjXuTcGWCB9
         q5vrv9N53J6qaS8jB/Tx3XDdfWQpnrHmjcbkUXbwWmlOvAZZzzxnChDF5YBBf4yX3zjT
         Cnew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcQCOTgzaeE74ZCuxo4/3CNeOTAuJvVOxPA2T7IDx74=;
        b=gL0o04HjDsJIY9CuZNYxrRjx0W0ya3M1qUWS2KdGV2nR8buUNV1//tC1i8bfsAMMg4
         F34ml46JJ0k2Xbej2atE07r2UZBQOT6OIymgxsHMmNlno9JRXwimJgUyTF3Zc0TH5nyl
         ubslS0uh4T0G9JSMlvWoGsspUPPGruv4dYqJXzLVREUSOD5nNHEAs9umAW1yOTsAKuhN
         5y+QIg57rG9XK/9JmWfyU15M3eX4y3enLTEeAuYIs+mG1MinCZJpVlepDW0rEUYKDb5L
         l8fJXuz1bhGXJ1SXRO+Q+qKjTzF/riVaZqGQi6Gpavi8ikk88JoKRD8JutGlrvdM0ZHG
         Zr9Q==
X-Gm-Message-State: AO0yUKWyd0bCtRfHLSTY0wSu+H4HTttad246jUjmz1pb/pKDfrIFTslf
        XFul9f8gcBO9qXJlwE7wvdiV+g==
X-Google-Smtp-Source: AK7set8RZMqp4z50un/8cdVYpt/C4OGBbCWxw7yAwgAmYfJ6JGAyT8YJVq72OnnGJyjrMPF5kWDNSg==
X-Received: by 2002:a05:600c:3c88:b0:3dc:1f90:35b with SMTP id bg8-20020a05600c3c8800b003dc1f90035bmr1245689wmb.34.1675691050947;
        Mon, 06 Feb 2023 05:44:10 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:10 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 06/22] dt-bindings: nvmem: Add compatible for SM8250
Date:   Mon,  6 Feb 2023 13:43:40 +0000
Message-Id: <20230206134356.839737-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
References: <20230206134356.839737-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konrad Dybcio <konrad.dybcio@linaro.org>

Docuemnt the QFPROM on SM8250.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index a248033026b1..9ddf3cef9e84 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -32,6 +32,7 @@ properties:
           - qcom,sdm845-qfprom
           - qcom,sm6115-qfprom
           - qcom,sm8150-qfprom
+          - qcom,sm8250-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1

