Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770FC618C7C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 00:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiKCXF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 19:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiKCXFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 19:05:36 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA45220C6;
        Thu,  3 Nov 2022 16:05:23 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id i5so1398441ilc.12;
        Thu, 03 Nov 2022 16:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7kc281aVcUMddvIOOcqINBZLyKd0NANguvehTEG+Zg=;
        b=WU/yg53Ke5hC1h8ViWZ+1zGMobzkCCVk3ZDKeGFKI12JfgATFCRrcjh70DBOoYtYSH
         zLxyL2XOMEmpEbipvDrPXs0JCJhy2ADYu5dRGlfKHWop67afL8O89f57X7qInpNFpXJ6
         +xzFtFI8KuUajQTMyQ8F7HcYq6acXFwA0+s4p637lvEp927bEiMibi/BZn9luAm/NWd9
         y9Chh5hdAvr+HqTsBE1Msa7JwbFKyMNRNylS4icySFlsL2L48DY1odkpGMzVquuB1xIX
         peAEoPVrugjsnXVA4oGvUU1m89mI7bYbvQ4PWcBBPr3+xL0ZHJadSmUn0Qw9yB+/Fz6K
         50IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7kc281aVcUMddvIOOcqINBZLyKd0NANguvehTEG+Zg=;
        b=Y02uDpckH7G0fREUoPAuyClzD64v1eA6/QHPlzRky9aeMH/svhnIRmiy27q11rmj/Z
         G4K+0mWWAUXQqspv82K4AWKvQwn0YlV6rs6dlGNjYbRVnCm57B3xAbJTmG2dMGBo9VT2
         AHpvgap8pR8ZMlfZ1ATjHFFNyTEfoJybkY/u+I+PMXoKOpg/aGRZN/gpYPxuPoWHSeW0
         lmz2SgmpTvlRbYjCexp536zh9e2lGxec7zIT1prkGri7EfMEyVclOeGbvWv8sWWU4bEV
         PoMYkV8vHjtoHGf2FHIzV+ES9oz9MGu0gzXrSojAXLd301wE7U1pXk1RKaTv5jXnjwY5
         OilA==
X-Gm-Message-State: ACrzQf0hEbjIvUO1kgsNAIQ7LzT3xx2WsixFfrjGPKF1843MVrfG4rco
        ayx/OoDuDNsjbSEx/8qxrHc=
X-Google-Smtp-Source: AMsMyM4SfppYzGTorpvZY2bZVxgWxJkgwYThU+w1xBgkwTweI+xEcjEROFYrE9FDh/dFvFggUoPPFA==
X-Received: by 2002:a92:d804:0:b0:300:8716:966b with SMTP id y4-20020a92d804000000b003008716966bmr19631316ilm.307.1667516722819;
        Thu, 03 Nov 2022 16:05:22 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id k29-20020a02335d000000b00363582c03dfsm635917jak.85.2022.11.03.16.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 16:05:22 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>
Subject: [PATCH v2 3/4] dt-bindings: firmware: scm: add sdm670 compatible
Date:   Thu,  3 Nov 2022 19:03:50 -0400
Message-Id: <20221103230349.212861-4-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103230349.212861-1-mailingradian@gmail.com>
References: <20221103230349.212861-1-mailingradian@gmail.com>
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

The Snapdragon 670 uses SCM as for PSCI power management. Document the
appropriate compatible string for it.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index be1b5746eddb..25688571ee7c 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -41,6 +41,7 @@ properties:
           - qcom,scm-sc7180
           - qcom,scm-sc7280
           - qcom,scm-sc8280xp
+          - qcom,scm-sdm670
           - qcom,scm-sdm845
           - qcom,scm-sdx55
           - qcom,scm-sdx65
-- 
2.38.1

