Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C6669216D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 16:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjBJPCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 10:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbjBJPCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 10:02:24 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9463589
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:02:13 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id r18so4014061wmq.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehh+IB7mATn8qRRIIxxLIJvaBEzJ12on/Ve9T/GbUQs=;
        b=rBIuglPIw2kXh4ah/kB+lytip67iZo0+IR9WeLL00qHZcft3gQ4rVUhmCgWX26SCax
         F/e6BcoZoZ0BTimxQRQ5b0Imgz3AB2cjwaEYVKkNDP6WH66b5YQfZSCyQ+pT9qqSsEdH
         E93q4Y+U+pK7f4GMEa0xdYvJrixfVCUd/ai5prH3p194H0Cgd3TMkT6wG45foSc24h1m
         CHuWzKPFbxIESCpZcuBZ6O1VyshKQaftQJzE5ynKlYDdwJEAVWDe4d8IEMpx/yf2yUtr
         lV5/EMIG4xaAE73m5NPOIdcYG9Ry8rfLUs9As6YKcQRIoI0O2gk/QGmPPlzjOFUQQtzu
         ftzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehh+IB7mATn8qRRIIxxLIJvaBEzJ12on/Ve9T/GbUQs=;
        b=QCKpIT68Ttq2yiDnjO+Xfy30wuZ/YSIs8Gh4BxRxBQBnaCgaIuPhDSU+ATmXr0JTXm
         fYRSlMh01D9nuKBENt0lBsc2r+lytorH1EBsAOBgQni8nGJ88uv005jRxgTU33XKM/Po
         FDTEIVZm0bhRvP5ZPKw+6h24Rscbys01XJipsjxcCAjZCbx9x+uL742+1HipghamZake
         ysj1WUwzTq/e+l40LUU2mgfX0j3A0dFaecFsqBtOPaTZ3Jw1OFk7p8EiNxwvg5wTUHHc
         0HgVwRW3nCcfMtB2bDOz7+s8gGFln8QwOXe8piy3g3NrXKLgqKnN+BerNd98BHeNfNPB
         1m+Q==
X-Gm-Message-State: AO0yUKUIq8gqYu3FbrjEa4Mw3gzjMaRGYDKwUU1QPputINnYjE4oBeZM
        3beXLK7H9ZpO/V7AwWmNqa27Fg==
X-Google-Smtp-Source: AK7set9GHpabIFk7MyERfGeFwdwWB2ITFrNd7U/Weuc23DeJH6Z8USiCrBK3uNLdNvPKM6waQYhkNQ==
X-Received: by 2002:a05:600c:13c8:b0:3da:28a9:a900 with SMTP id e8-20020a05600c13c800b003da28a9a900mr12826912wmg.41.1676041332286;
        Fri, 10 Feb 2023 07:02:12 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w23-20020a1cf617000000b003db1d9553e7sm8282482wmc.32.2023.02.10.07.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 07:02:11 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 10 Feb 2023 16:02:06 +0100
Subject: [PATCH v2 03/11] dt-bindings: soc: qcom: qcom,pmic-glink: document
 SM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v2-3-71fea256474f@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the SM8550 compatible used to describe the pmic glink
on this platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index a85bc14de065..6440dc801387 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,sc8280xp-pmic-glink
           - qcom,sm8350-pmic-glink
           - qcom,sm8450-pmic-glink
+          - qcom,sm8550-pmic-glink
       - const: qcom,pmic-glink
 
   '#address-cells':

-- 
2.34.1

