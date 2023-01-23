Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC36778F2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjAWKQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbjAWKQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:16:55 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA0622026;
        Mon, 23 Jan 2023 02:16:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id v10so13920359edi.8;
        Mon, 23 Jan 2023 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CutNyWM0IkRzqeYC5Zdvw1NAJVSyaXdgC4t26U3nWNs=;
        b=GUliwSNYyecVJiov7UaCNPigt2dgDarkQy09vEfsmYug0Y+Xh85Wm2PXcyitca3zls
         1QDjqI8P1rjVa8Chc8PGCfmsJ2bMrDkXNrhuzpMHsQyvBX1eufBUA74iTKmlfQJW/Nd7
         lXmo8tCA4omPCzAGG5W8uChAwOG+anH1mp9h9dPEkXSEHxemXoerdluhN3b/77G91vAD
         NlZmEP8xEK09ib7q/V+kiBiUc0+WViL401lo9rc+hkaR7Ncvw8+qa82iiVoMRktBv6Y3
         HyR/8QnDPnbOenN/+p1azJvEgYHskQfN5Sz5C+11IKAOKRaTi2xQRkglRyeHjia2/Owg
         xwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CutNyWM0IkRzqeYC5Zdvw1NAJVSyaXdgC4t26U3nWNs=;
        b=fMYU15wUGirPuknZCUSHtaONnvuorayA1/ebsJ3YBfIyONOjBICafPJYA1VkyaxkrK
         6gK2hdtYfb5/7yizmBoRq9OkqvT+oJ3qwNAqL1+4f3X4Vqaz9QfPXgnvorl6ah9zUHYL
         ZZ9Nw078w/boLgO9rBemlRijsz08wtwATx03BPNa0r5RHTqX2Pbq8yqnh9ofyvgkbIcy
         /4vDSMfQ2zf/t++a1jtiaQDEC29OxkCZiQDYn579vwYkaVsPTWfPWEf6pMB232sv1r40
         MH61aDt4rD5RnmzdFBAukKbyiG2XZJIRG4IjlCp1+HrkFrQZZ6AKsJuGpCcj1q3QjsOQ
         cYwQ==
X-Gm-Message-State: AFqh2koFtbZ6zZtWXJsGL/bxaC5jgedoD0nVY9cFgE/MBmaJV74K6br5
        PEasYW4WHKI25KZqpju4MME=
X-Google-Smtp-Source: AMrXdXtnqJudWy9cL9LkX3ZbUCn8NQ/5R1lx/2GJj6MFTJ3gkkpBklepo2MjsNPty38jO/p6K3QYrg==
X-Received: by 2002:a50:9ee2:0:b0:49e:e12a:a216 with SMTP id a89-20020a509ee2000000b0049ee12aa216mr10563274edf.6.1674468994397;
        Mon, 23 Jan 2023 02:16:34 -0800 (PST)
Received: from fedora.. (cpezg-94-253-128-151-cbl.xnet.hr. [94.253.128.151])
        by smtp.googlemail.com with ESMTPSA id m15-20020aa7c48f000000b0049dc0123f29sm12579125edq.61.2023.01.23.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:16:33 -0800 (PST)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_kathirav@quicinc.com
Cc:     Robert Marko <robimarko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/2] dt-bindings: nvmem: qfprom: add IPQ8074 compatible
Date:   Mon, 23 Jan 2023 11:16:30 +0100
Message-Id: <20230123101631.475712-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document IPQ8074 compatible for QFPROM, its compatible with the generic
QFPROM fallback.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes in v2:
* Add ACK tag from Krzysztof
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
2.39.1

