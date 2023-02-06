Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDAC68BE97
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjBFNpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjBFNpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:45:02 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611CC24132
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:44:38 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id o18so10416306wrj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 05:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEBwyInNQj4T9UrPWpH8IzyU0lvHzwvDqekdsT+4wvM=;
        b=eTUHGNo1UuEuc0hxSLBRF68hd7oI3LV6W715ikMdMKdtCLwU+jZsmWm9sjVgTxhU5q
         T1S2B5SXUFDaKRkgJ0doTGkD/FTUPD0DpkROCMSeRUaAVuI3kWKUO7BcAInj4A2GZNNN
         NsnxTIU0upVjiSpS4xYIt2hTNFFpvGa4SS53R1f4VDhrCbroRSOwL1KeMhE3GzEgNYuz
         3J5oiRC+7e6shqoMhx6EUM9eD9NWKvuAuhdfZPYPx1gy7NkIRilJSy2wbx5EFT7DEToC
         /Bamz2kVDOX0AGX69/9yIInNDBJdkGuKu4+Bljm+yblIYXJzcGM/E7GQTkritbB47LIY
         5yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IEBwyInNQj4T9UrPWpH8IzyU0lvHzwvDqekdsT+4wvM=;
        b=PsqbrVVJAVn5hSnmFLuv5LmjKaPAzGo1U7LJLwKhCalF17phFVDBnmv/yNGozg/P+V
         yeGZYs8WSjL3YU+PazRATUcM4acc2HSzYC776uFG8orTZJuHx58iml05v60OaUlSDV1d
         6Yk6OTRo4AkbtRPfzTLqIs6YC340JvvYMhWSJeCLvCDBlHR+89pE3UvIHIV0S6nq4YHc
         uX54pjfwEfXwX1AAqaA9/plyj8sKnN5JO0JFOzaozVZ8sDQTQ/qQi/EXoJzHRjsABiH5
         eKmL6R9E4ENfKtcLBZfpMbYFtdIGTa9eau1J0Tz1Bf7FJVPRinlxflqs6nV4hVdubAzP
         o9Pg==
X-Gm-Message-State: AO0yUKUS9B5MnpGRL5updwBk1camopm0a26qO5iDJOam7eqGKFPCGINk
        8Inq/+Nz7FA7nIZ1vn1a6A4HkA==
X-Google-Smtp-Source: AK7set/xhyK/TQetImdnuZohMTBiQ2LNlVUmrkeifNVtMyy398EMPHNFH0KrzY7HlK+YRgdG2LfexA==
X-Received: by 2002:adf:e18e:0:b0:2c3:f070:911f with SMTP id az14-20020adfe18e000000b002c3f070911fmr299177wrb.21.1675691074094;
        Mon, 06 Feb 2023 05:44:34 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id o15-20020adfa10f000000b002bddaea7a0bsm9008037wro.57.2023.02.06.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 05:44:33 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 21/22] dt-bindings: nvmem: qfprom: add IPQ8074 compatible
Date:   Mon,  6 Feb 2023 13:43:55 +0000
Message-Id: <20230206134356.839737-22-srinivas.kandagatla@linaro.org>
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

From: Robert Marko <robimarko@gmail.com>

Document IPQ8074 compatible for QFPROM, its compatible with the generic
QFPROM fallback.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 9ddf3cef9e84..2173fe82317d 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -19,6 +19,7 @@ properties:
           - qcom,apq8064-qfprom
           - qcom,apq8084-qfprom
           - qcom,ipq8064-qfprom
+          - qcom,ipq8074-qfprom
           - qcom,msm8916-qfprom
           - qcom,msm8974-qfprom
           - qcom,msm8976-qfprom
-- 
2.25.1

