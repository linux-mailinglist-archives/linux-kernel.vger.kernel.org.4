Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C9F62BE6A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiKPMlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiKPMlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:41:12 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C690AB3C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:41:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o4so29579291wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kj6hNhybTnNcaQ6fHwD5wQp+bSb1uN49o9Qhpb0mU/M=;
        b=JXj4UKYDsUshc3XLgQ7MmVkB/P2oryJsLHPKCUIjCMT0YsKuK9+02NWyGvDlo52zW4
         1Xy3pinI0Gnu4lyWrQ95s3ka6veCMJ26Nfmbj5mciBNEWEfObs1uU7bEqIsdFdeJ5NKA
         VWP0tgHtYMOEvGq3dq7yqWS79BB7P4toRljT496asOfYMxhG4Jtn1d0vcdvPajWbag6b
         preKi5InoXeEyd5O2+RM8EYkg14zVlgqHBbPVloIJHMwzbguZ4cWC+n+j8kgeSQpCUMa
         0xJxwVLfa5efEx0qnxC+VW5ZUTwhIjPjV+2+hlgdpWncRGoCtJFo/6ZjD9H+blEa7LBi
         3TSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kj6hNhybTnNcaQ6fHwD5wQp+bSb1uN49o9Qhpb0mU/M=;
        b=g/5XbTxEb2UQkOP9uPiN8yoe8dAE8IKSimfXuu9K5h0yy9Vxhylgkw/V1R99ngJuyc
         u8Bur5LCKWEOB4oy9ebc1tajgnXS+Rt0c70QAxl49rgrYAnPHrbpj0nZV6H4pcftoIlf
         0tZR2T2XNTA3MBBaAwG5CEvkfchfWXIHHtQ6qF076J95vh/XEFKWgQuDPHNL2l0KI3Fg
         OjeCMXjSmZ7PnNWW1rjWh8S3YAhYDflQIvAZioC6W30Hua/Rg8hoe00Ukkb1SSm6FOZr
         BYBW/QWFEPIU1LinrOT6HaQ2KuEFLAHfKl1Vo7Mrd4CndJMS6jmphN3u5yFkvWA8r0RR
         0X/w==
X-Gm-Message-State: ANoB5plT4mCQhVwjZSytv5sfXzfupH/dFrcpkutI4bkdmWkxbb7MJDoz
        ADGm/58px0vh82bUPTSzAILOHQ==
X-Google-Smtp-Source: AA0mqf6wAPtBCIWUO7xTE+Ndf6MWifSBF9p4upBE+m3tekmqE8ZTbTipAhhpV91Uze9eu28Qj3VbQQ==
X-Received: by 2002:adf:edc2:0:b0:236:774e:5b78 with SMTP id v2-20020adfedc2000000b00236774e5b78mr13970233wro.351.1668602469398;
        Wed, 16 Nov 2022 04:41:09 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003a3170a7af9sm2231764wms.4.2022.11.16.04.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:41:09 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH] dt-bindings: firmware: document Qualcomm SM8550 SCM
Date:   Wed, 16 Nov 2022 14:40:38 +0200
Message-Id: <20221116124038.2769028-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for Qualcomm SM8550 SCM.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index 25688571ee7c..7b753acb85d5 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -53,6 +53,7 @@ properties:
           - qcom,scm-sm8250
           - qcom,scm-sm8350
           - qcom,scm-sm8450
+          - qcom,scm-sm8550
           - qcom,scm-qcs404
       - const: qcom,scm
 
-- 
2.34.1

