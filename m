Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BD66BEC2A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjCQPEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjCQPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:04:32 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA468145B49
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:04:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id m2so4720506wrh.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679065467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehh+IB7mATn8qRRIIxxLIJvaBEzJ12on/Ve9T/GbUQs=;
        b=zL6tjSZZwavSiV7nxL7ZYOD2UA1MeMtf6V0z+SSQkFO+5sVFOJqjmkp5pNzsfNxq9z
         8DsS12/o/oTlUSo9JgGcaStM6ZMF24ZqeyNRKGgjzSjuyjfZpbV+kw5dJU3VWwAfm491
         Q+mk8Dft8YNodNASDf/pYB/dsN5pw7kVbvj/uf4VZIxUXBXuX4wPNmTcwYJ0LhC302i8
         4osxPabCp7v5HEwDxM/46ic/BcwVfaNjMPhKmqDsxyHJUag1G8A6pAdY5OtDJkJ7L+Dz
         V3EHFnsUzyvncvkyhwcidLerAWh2XK7P+ELgP7RD1M9eGmcB/hBJxZPulHPF/bd2Tv8C
         tKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679065467;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehh+IB7mATn8qRRIIxxLIJvaBEzJ12on/Ve9T/GbUQs=;
        b=xQzy1CLwjfll4YWzHph4mo49THOMFXIpUdX2S+Pw24IXwXBmkMv2wseiKeZlNClbo5
         G9/0kutIbT4xEMsqVAq58BcJ8cYR0lnAwZ/Qxh8mKJ6Lj9Q8IwPIszijYGmoFK9NO3ta
         ZYJofOh9kA4buuSm8yHoag53FWQ7qONgI/syEq8Npd769fdkrmgDbZ6BTx1FlSD234Tm
         EGp0wAmddvFRqWgOQluOnWdK8SdY+iAGuURdVy3BMWQXZt1HqeN9diixj/NNS6Ci/wqg
         IjJ7Ho8RMHFQmb9vg5oso5bUeNN+w5G+f23IvDNLj9CR0+yqOJrfLdk2mzW0/WGOxVod
         pxSQ==
X-Gm-Message-State: AO0yUKXEPnzp30eDn6uoHU4Zjg1b3+rQEx+BfXXAGQQ7QRT3gzCU0VSn
        /thLFcnJM9WK9AJ0RRWiofa5oQ==
X-Google-Smtp-Source: AK7set/NqW4Kbk9eVF0j0q7FtpPi/wkWEO5WCtNVYF74PINBGAkZzS7igmPg/Hiy70mF7QHxJVt1wQ==
X-Received: by 2002:adf:e3c2:0:b0:2d1:46eb:3f97 with SMTP id k2-20020adfe3c2000000b002d146eb3f97mr6063265wrm.68.1679065467674;
        Fri, 17 Mar 2023 08:04:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600000ce00b002be505ab59asm2133773wrx.97.2023.03.17.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:04:27 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 17 Mar 2023 16:04:19 +0100
Subject: [PATCH v4 03/12] dt-bindings: soc: qcom: qcom,pmic-glink: document
 SM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v4-3-38bf0f5d07bd@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org>
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
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

