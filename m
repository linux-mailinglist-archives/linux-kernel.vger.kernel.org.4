Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E17F615655
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 00:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiKAX5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 19:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiKAX5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 19:57:40 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 560981F2EB;
        Tue,  1 Nov 2022 16:57:40 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id o13so2331938ilq.6;
        Tue, 01 Nov 2022 16:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IigCV0bz3Cm9IudeIDkVvgCOOFAiLJ+tyEpI4D2a40=;
        b=Hq2kiDk3LXTr2z5dD7VHHGHNPvjqPWS+U34ex+N2lkfXCTUwH8SM6A/x1fnEbTvQT2
         lstjWk2mrrEht0HgYfT0aTvp9HUn0bMDJgkRvuQ3bS0uhxb+TKXXbuCyXalpiIFkXLtw
         EB4t7wj5gQ4lv3kCsD4PwnPnVi7J7kl5vsqu771exoPCb1P9Pv3nMcEBIcRV45ZqiPh6
         eOBuuXFNuZNT+DDiRZw9Gr/YW7HbuaVYp23TCUhMC3COdYwGo83y/5J2B99gyPCyu6iv
         BYRb7YhA6kNLr7Eq95zDXwfegIqF/w7SUoalXcXSeEWUyNb8iKobo8Usl4qn+Hj8/7eI
         Vuag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IigCV0bz3Cm9IudeIDkVvgCOOFAiLJ+tyEpI4D2a40=;
        b=BJ5NAdDOnlc4SQFeq/rX+yiCEEadi9o/KRAjXexumAfHrekedVFO/vJ91GnGIvJacK
         rI/cM1aE4f+OaGHl4paaVQmblAdCS/GjPe1H9eDgDi0XjnVHL0Wp8dhP3eJxkvPepCJ8
         Nj46C3D60h/uZsyqgxWOvCJd+R9z+m1Wj0Vpynze5qMuWYugLK5WAYjJBfJKS4aPYD2j
         Q+XkQyCF1Eh2dD+T1f+7IFXXy26OEd/KhjbFTOfQFw2+buCtL0XVEB87ZOxfdx7Jqurs
         huoEQzPSDUNP6ufG1ODkc17OF12w2xw4AOS35awTCT20MLYYz5QDIcVIhVG28uU8aafS
         fL4w==
X-Gm-Message-State: ACrzQf1GOHKUdyRvndJZTolO5uCs8Tet4rbLNZGLpSX77O0gYckPoP/m
        jLBcZc+moiRMK1i/vjG+RnQ=
X-Google-Smtp-Source: AMsMyM6CyXV15ch/qAdeZ1LMf+gCyoDG0aO/8ZhoYvi0BharJXeu3HeYXKVH6hfhr/2lPonktmHiHg==
X-Received: by 2002:a05:6e02:190a:b0:2fc:5333:c879 with SMTP id w10-20020a056e02190a00b002fc5333c879mr13020087ilu.183.1667347059770;
        Tue, 01 Nov 2022 16:57:39 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00:f1f0:c4d7:e39e:e2f])
        by smtp.gmail.com with ESMTPSA id a19-20020a027353000000b003745641438bsm4238425jae.119.2022.11.01.16.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:57:39 -0700 (PDT)
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
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: arm: cpus: add qcom kryo 360 compatible
Date:   Tue,  1 Nov 2022 19:57:19 -0400
Message-Id: <20221101235722.53955-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221101235722.53955-1-mailingradian@gmail.com>
References: <20221101235722.53955-1-mailingradian@gmail.com>
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

The Snapdragon 670 uses CPUs named Kryo 360 silver and Kryo 360 gold.
Add the compatible string in the documentation.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
---
 Documentation/devicetree/bindings/arm/cpus.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/cpus.yaml b/Documentation/devicetree/bindings/arm/cpus.yaml
index 5c13b73e4d57..1247e9a975c9 100644
--- a/Documentation/devicetree/bindings/arm/cpus.yaml
+++ b/Documentation/devicetree/bindings/arm/cpus.yaml
@@ -178,6 +178,7 @@ properties:
       - qcom,kryo250
       - qcom,kryo260
       - qcom,kryo280
+      - qcom,kryo360
       - qcom,kryo385
       - qcom,kryo468
       - qcom,kryo485
-- 
2.38.1

