Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850A86B255C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCIN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCIN2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:28:08 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62DD25E20
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:28:05 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso3597225wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678368484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehh+IB7mATn8qRRIIxxLIJvaBEzJ12on/Ve9T/GbUQs=;
        b=uWE32Jzi7B/VYhLBA77vhUCna5zpACF5NtdS4D77IOtvhnWVfzrMF2r6JL1RfHdq45
         W2dE1JnuyPTnL8U1+w+OrhknqqHIF8xPLZwW0RyxQK53xMCZGS11xxNpxY3fGJxtYs8K
         4s+x4Nf0SWl5rHbyyilkfRdR5pLy82rWq/nXEG9XE99nHvqt+3fA2qf7GW75AnCRr+fa
         FQw2JifZwJL+r8mshlpMDkbGNo+XzvvIEjUN4iQeRvt8bEeQEL79ey8LxraQne5OTHGz
         bgoukJ+APy+9+rWoLaE+pZtJefIiphistRHIH4rHdPjnhqGBMHb6jpNWcdh/EOIoUtWH
         SUwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678368484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehh+IB7mATn8qRRIIxxLIJvaBEzJ12on/Ve9T/GbUQs=;
        b=NKq4X7+Z4/Y9hbDEEzccfBzDcEx5H4fFxkVtKE29DrKVQ/pVYXcu8VEAxWBBCoIOus
         19eV2g58RgrYUBFiGtvBOrSn8+jp5nVAe6pt5Hz0OVZrAqqkxrImqMToaJYXm3CGxiU8
         GhlJVjdQm74QSBSvIQTUuxw4G3R2kO6mDvQ94XX5JBkudJFnxCr5Pxd52szpR1uj1WXG
         7T/+MyqlArF8w6Qft/qIxygg3C+DwfoP7VNFjC3PGJ3CkiX2sqpfNJXO5H0ojAoLOs8a
         6kNCt+Q+LaF8li+D2dwOr6H7U/Zgq2HkSpWB3g9qiMHpafdnkP/+5to0iwa2OJM+6fCD
         GfJQ==
X-Gm-Message-State: AO0yUKXy6afaoIcQ8Kt9AdogkjjGoehWNDKQZt7btr6jb4Yi8R86n3Sa
        6f3VTxTVmHHbNT1rEw9M1V/noQ==
X-Google-Smtp-Source: AK7set+RRnLwGGAsX74B0ntwn/d+CjngaH9g7XwPMQjpwM2tmR3OSeqQimDeJ+a1XnFHewZPcEUB0A==
X-Received: by 2002:a05:600c:501f:b0:3eb:3947:41ea with SMTP id n31-20020a05600c501f00b003eb394741eamr19133342wmr.37.1678368484282;
        Thu, 09 Mar 2023 05:28:04 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c458700b003eb966d39desm2926714wmo.2.2023.03.09.05.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 05:28:03 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Thu, 09 Mar 2023 14:27:54 +0100
Subject: [PATCH v3 03/12] dt-bindings: soc: qcom: qcom,pmic-glink: document
 SM8550 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v3-3-4c860d265d28@linaro.org>
References: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
In-Reply-To: <20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org>
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

