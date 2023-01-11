Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0FCF666507
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 21:51:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjAKUvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 15:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjAKUvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 15:51:33 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5363B3D5F8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:51:32 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id bq39so25422853lfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Wr8laYn6BNAzfzpqrvLlNLWQHAe4YySPp4O0GFkETM=;
        b=q9MTHdUNZsoZCccIV45EDRaB5XTLW77ktAK3ck9tgnt6LvUlWqQ62MCG3X51lT05Vl
         Jkf+eQpS57GP2oe5RhIf2wSpwuHWXh1VeEbEYKttiOhWqN2GvePp0Iq0Lo8DgckRv1Ti
         cPOKlC1Zw1VDWlM7QNqV1pOcd+QJMzXxqY93CW9bqinBzXKsvHzRCplbKMPGc7hwGccO
         Ud1+tSghADiLFgVf4r4BjD8sKtZYXYiBzVVL5kuKUNAMB4T29Uy7x8/IdBH+Ql9z4TY/
         uR/xCf4t1SMokPBMksLPD13yurM8QOD5aZe4WtYEkEmHUXycLDF5/8zuBBZgNUkGWk01
         u2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Wr8laYn6BNAzfzpqrvLlNLWQHAe4YySPp4O0GFkETM=;
        b=FpzsMcol5DNkqn+BDvG6FA5DnMpiAKHhgwp1OOnSIfDZZgcFw4IiPxvsQTSLYMJYK4
         KAaSSquXoe7vEiHZmisdxn0Q539xMKWJ7UznfrDckT6u4E64SxFSKHC928c4Trbt7RIG
         nCeWQ3GMxzKC2vMKtHBgxG8nOmKlnqN4eTRVX1M1Ua5LBjWlXtRxARvRF75yIfL/Ssct
         laNJrnoYiPl0OYW7vTldNO7F6b7aG/c0PQ257wQ67kxshnFax8axQtWGKloqjsh5hlpQ
         +PO2OeXWal6/4PvsrZE96egM4O5kX6tRogNrhfZLO3dGVjBxsnkVZa+EvcNG+mZlJ8ZE
         wcqQ==
X-Gm-Message-State: AFqh2koKEnBmDF4ky2sJQHm+pvvDv4gK5f0hfY5cEHt+yY1Ddeovjo7l
        Z3FD5UGhuF+8xaI4Mo6VPrvfhg==
X-Google-Smtp-Source: AMrXdXt/VUCoc2P2Ua3uU7A8tXp1xXb8mAOxGuI44LSvg5ywkrCP7Xou+h7hqVjHirE/hMXxKhOxJw==
X-Received: by 2002:a05:6512:74:b0:4ca:fe23:7677 with SMTP id i20-20020a056512007400b004cafe237677mr16604710lfo.43.1673470290716;
        Wed, 11 Jan 2023 12:51:30 -0800 (PST)
Received: from localhost.localdomain (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id q11-20020a056512210b00b004cc9042c9cfsm928888lfr.158.2023.01.11.12.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 12:51:29 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: cpufreq: Make reg-names a required property
Date:   Wed, 11 Jan 2023 21:51:24 +0100
Message-Id: <20230111205125.1860858-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for determining the number of frequency domains based
on reg-names entries, rather than performing calculations based on
reg entries and parent #{address,size}-cells, make reg-names a
required property.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
index 99e159bc5fb1..460a7ab7b87c 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
@@ -74,6 +74,7 @@ properties:
 required:
   - compatible
   - reg
+  - reg-names
   - clocks
   - clock-names
   - '#freq-domain-cells'
-- 
2.39.0

