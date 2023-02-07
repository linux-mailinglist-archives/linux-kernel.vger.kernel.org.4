Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2686168D9A0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:47:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjBGNq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbjBGNqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:46:54 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5603BB9F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:46:50 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h16so13574758wrz.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aG9xyJEWq8xfzQLUkXepXFg+WW0EUsU0Fq705yW4t3s=;
        b=iE7TjlqZz6va0JTZBey0ugvYw+Hk9P/7K2DX5kDSL+OIcRwMuWbfPZidDTq3DHc3Tz
         A0rW8LMOAaF5X1mkf334DG4Mqk3H4XOdOUwuEYdUCVwEZ1xfrZYi6XyOPWwcZ7QaHT+t
         Ft8Gi8YOags67/SOK0mn24qLRZhDDMq2laXisnZOm8xQBmaCxuugnyzI3uHOkRer95tM
         ZBgQHBEfvV8R6bTQ7gUTRhAV51iIIpOQppGDf+66xzCYlXQcKC0Sb1MTXFHN9Ry4RZ4a
         zRVmX1mqCk6kxc23+JCFQs7uYrh0PThVZWxaLesj78tROG8josCnevfnSstSWm4gZgXB
         +L+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aG9xyJEWq8xfzQLUkXepXFg+WW0EUsU0Fq705yW4t3s=;
        b=SlxpMmAnHLlT6l87kiDuypJwLLd3Mzf2lMgWFd9wdObhzUtl37X1T9lY1PohlAN27L
         0AMSg7ula11fFttgZI6yPfGq3fC2HpcO2AVg/LjojcsO+KQZ+RKdMwS60pNNZsdQ6Ilf
         uh461VkpS+tMjNLsIIq316/2m6+cMvapDv5iAWpLbvC2TvgiZhh3lUeax/ctLrRsyhw8
         3siMHA885R3C2b9ydWUNfbokRJByEX9v9QOfiYbhuAQ9LpREf4GUdUu394Q24e6xxdWI
         twiGc0JV/NH0MNK1qSHfmDI8VrdlS58qZs34Qk9xqEKQhjOVSLvok78RIxOzyX7c7R4N
         K2mg==
X-Gm-Message-State: AO0yUKXDz/yNIm3S5Y08JidynctIX3TUIziKg9sLojrZLz87y/g/KHSu
        vantvCP7q2Ibv353skH+N/NgYQ==
X-Google-Smtp-Source: AK7set/foZL7LzUjzZNlYiTs9qS+b+uBwpRfHsoNPwLIc+5xmfCweBpO4Ts9Ae6+UXoQuVnEkAKxYQ==
X-Received: by 2002:a5d:4685:0:b0:2c3:e5d5:5d77 with SMTP id u5-20020a5d4685000000b002c3e5d55d77mr2563126wrq.68.1675777608918;
        Tue, 07 Feb 2023 05:46:48 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s2-20020a5d69c2000000b002c3de83be0csm8610927wrw.87.2023.02.07.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:46:48 -0800 (PST)
From:   neil.armstrong@linaro.org
Date:   Tue, 07 Feb 2023 14:46:46 +0100
Subject: [PATCH v2] dt-bindings: firmware: document Qualcomm SM8550 SCM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-topic-sm8550-upstream-scm-bindings-v2-1-ca12bd33fa1c@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEZW4mMC/x2NywqDMBAAf0X23IWQNhr6K6WHPFZdMKtktRTEf
 2/oceYwc4JSZVJ4didU+rDyKg3srYM0B5kIOTcGa+zdWDPgvm6cUIt3zuCx6V4pFNRUMLJklkm
 RzODjo8/96B20UAxKGGuQNLeUHMvS5FZp5O///Hpf1w/HkWbYiQAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@linaro.org>

Document the compatible for Qualcomm SM8550 SCM.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Added missing allOf:if:then entries.
- Link to v1: https://lore.kernel.org/all/20221116124038.2769028-1-abel.vesa@linaro.org/
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 4193492ba73e..4eee95f65f8e 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -54,6 +54,7 @@ properties:
           - qcom,scm-sm8250
           - qcom,scm-sm8350
           - qcom,scm-sm8450
+          - qcom,scm-sm8550
           - qcom,scm-qcs404
       - const: qcom,scm
 
@@ -165,6 +166,7 @@ allOf:
             contains:
               enum:
                 - qcom,scm-sm8450
+                - qcom,scm-sm8550
     then:
       properties:
         interconnects: false
@@ -177,6 +179,7 @@ allOf:
             contains:
               enum:
                 - qcom,scm-sm8450
+                - qcom,scm-sm8550
     then:
       properties:
         interrupts: false

---
base-commit: 49a8133221c71b935f36a7c340c0271c2a9ee2db
change-id: 20230207-topic-sm8550-upstream-scm-bindings-e078b46d6f85

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

