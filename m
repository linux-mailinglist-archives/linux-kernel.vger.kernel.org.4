Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26C4F63D38E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiK3KjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiK3KjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:39:10 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155D41F9DC
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:39:06 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id w129so16434458pfb.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5TAnhV54JmMi0M+JcoIlZnJVtXsKMSgKIgfzZmwhBE=;
        b=xCAXHrnKBUKuWBWElgpAn9CFuUXTJvPlXK35VTlGw4YyabwU12J4hL/JtohdbkbNnW
         CUc3KpwJRm1f6PSHTlTPHlQ4iJDxNK1hdVlw3moqA1N8n4A1IKF1IKDw9RCW6VNu0UDg
         q9FVa0+hAlDgPhhGYDaMhjJq3G8oRTl0p1Xtlx5GcjoDLkbrxD4T9a053walESLtBv1/
         X0b89ZlE/pvnEacH345A5bd26CQkt1s7w5jjC8vlumTzSuFeGjJVUWve9m9wZSa2Eo4G
         i0spvPna594JLyOg/ILGFdTf7j7PXBPbuttVtxA31vS2ES+bG0rzJmZ26ln0iegCQzDu
         S7Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5TAnhV54JmMi0M+JcoIlZnJVtXsKMSgKIgfzZmwhBE=;
        b=fUdNLGBuNmnlqceIwfu/7dMe+Mx2IeJRKw/h8kzJmxAfhhodS9O/M2szWUwNkknizQ
         z83ifN7fkpC1m297Rr1lHfpnFWDMHMQZWUn6F+EWzUe9KM/2UsvTYaBrW2V7NJAzyKrD
         0UXdSHvULUNiyC60Luag4DB6buIO28EsRgcsBjTtqmOlPD3u5djOekILjNLeCjwZvlbO
         fWdLpyjU+5RbruTJ7wscW4HcuHHUhQStS0aNhswrndVg4nD4IPStPMLIOfZ8jBXkNrtX
         UFhAqYU2x/FOCIFaZAeheV/kbVcnYIkVM3RXu2jH/d5WvPsl3v3UtKZCym4owhjVdZh+
         a/OQ==
X-Gm-Message-State: ANoB5pkPos5CVmT+4ybUs1m4bekcQWycbKldwTjg/zjzpm9XTo/Pxokr
        VPCImkQ6QGkcGQiXV6/4oEE9tQ==
X-Google-Smtp-Source: AA0mqf67nbIwdSgA6lvIGSkye8gIPdOARrZHgHvR6JFbybvTwqYz1PgO9cPh+NAFypFoK8ehLWYNIQ==
X-Received: by 2002:a63:1a48:0:b0:477:786:f557 with SMTP id a8-20020a631a48000000b004770786f557mr36941225pgm.476.1669804745139;
        Wed, 30 Nov 2022 02:39:05 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5f:27a2:d13a:7614:addb:b29d])
        by smtp.gmail.com with ESMTPSA id b207-20020a621bd8000000b00562677968aesm1098012pfb.72.2022.11.30.02.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 02:39:04 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, bhupesh.sharma@linaro.org,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        djakov@kernel.org, konrad.dybcio@linaro.org, a39.skl@gmail.com,
        andersson@kernel.org
Subject: [PATCH 0/2] Add SM6115 interconnect support
Date:   Wed, 30 Nov 2022 16:08:39 +0530
Message-Id: <20221130103841.2266464-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
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

This patchset adds the support for interconnect provider found
on Qualcomm SM6115 and SM4250 SoCs.

The topology consists of several NoCs that are controlled by
a remote processor that collects the aggregated bandwidth for each
master-slave pairs.
 
Bhupesh Sharma (2):
  interconnect: qcom: Add SM6115 interconnect provider driver
  dt-bindings: interconnect: Add SM6115 DT bindings

 .../bindings/interconnect/qcom,sm6115.yaml    |  137 ++
 drivers/interconnect/qcom/Kconfig             |    9 +
 drivers/interconnect/qcom/Makefile            |    2 +
 drivers/interconnect/qcom/sm6115.c            | 1371 +++++++++++++++++
 .../dt-bindings/interconnect/qcom,sm6115.h    |  115 ++
 5 files changed, 1634 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
 create mode 100644 drivers/interconnect/qcom/sm6115.c
 create mode 100644 include/dt-bindings/interconnect/qcom,sm6115.h

-- 
2.38.1

