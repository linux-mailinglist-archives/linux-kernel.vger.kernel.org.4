Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97D55BAD22
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbiIPMMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231366AbiIPMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:12:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F369B089B;
        Fri, 16 Sep 2022 05:12:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C259B825ED;
        Fri, 16 Sep 2022 12:12:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42111C433D6;
        Fri, 16 Sep 2022 12:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663330343;
        bh=1yC4yByue2GYH632QAml0xc+/AbTMt75z9T2KM9E5/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KzBWuMVdTPhMTe7OZeES5V8+g4vhkw12tj9mM/M25RaibgJwfS7C3Jsb7o4GhrMgJ
         RbsmLfuReB/1BCYW9OP5T/V663gzk1deObXpWwfAm/cLR/HV2MPB7MpTPjWmDE27tX
         dpM73KAvVZVNQatnfqQtU9Ud0T/rpYZqt4ZlWHrX8kzljTh6frj3apEUTjPRG1esBu
         BhY8Od0s0ZdU8/MLsXWFAc9JlzJL6TgsTHSzLKNIIV2Lnbh5OuNgai3t7G57b5hIk5
         cJGFo9nwiE/t/OJKdR7RiPHPjqoNczIdKS9jB2OHFzdGTMiJkDvTPl7bzSVg095lhi
         2/83eGzL+6yCQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-scsi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] scsi: ufs: dt-bindings: Add SC8180x binding
Date:   Fri, 16 Sep 2022 17:42:00 +0530
Message-Id: <20220916121204.3880182-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916121204.3880182-1-vkoul@kernel.org>
References: <20220916121204.3880182-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the UFS HC for SC8180x SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index f2d6298d926c..dd0256357247 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -26,6 +26,7 @@ properties:
           - qcom,msm8994-ufshc
           - qcom,msm8996-ufshc
           - qcom,msm8998-ufshc
+          - qcom,sc8180x-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6350-ufshc
-- 
2.37.3

