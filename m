Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A50F5BAD1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiIPMM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiIPMMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:12:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517C85F102;
        Fri, 16 Sep 2022 05:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFDE7B82686;
        Fri, 16 Sep 2022 12:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7444FC4347C;
        Fri, 16 Sep 2022 12:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663330339;
        bh=OpH/LkFcan6rEPF6JDBQlCDJrC4M5P0hs4ZvJDBbnrk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aTMlMmP/ozrY2LtTOsUOZCxF+j9qjHhjUx2PYRRDg4xAo3mCytowQ4f42HfLpmFaO
         LYM+xbcfoqguoxNLAt6cVkBY7mv/AA0NZyBy7VOBmdPj1Byj1ZDM0yCl4ByLsiieb+
         XRBqFZ4xmyzUJvrSZJfknpueKOctI2bidHyhepxR1b/EEsAyzxjJ1HXIB6TuouyKQS
         sEfcxbsifgEw8DpnCgUfqCZZ7qFQhA6eOsVLl/PBLKFj8SONUBuCQl95NvI6EQ8UMd
         cMayKMo4chPpnYN8ycBtnRHGFQwEI6MRv+aqSuYFFip5HkRvPgDY2gQmJCiwQBWzjg
         ls0+aLecSV91A==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] dt-bindings: firmware: document Qualcomm SC8180x SCM
Date:   Fri, 16 Sep 2022 17:41:59 +0530
Message-Id: <20220916121204.3880182-2-vkoul@kernel.org>
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

Document the compatible for Qualcomm SC8180x SCM

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
index c5b76c9f7ad0..a8a14da54e53 100644
--- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
+++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
@@ -40,6 +40,7 @@ properties:
           - qcom,scm-msm8998
           - qcom,scm-sc7180
           - qcom,scm-sc7280
+          - qcom,scm-sc8180x
           - qcom,scm-sc8280xp
           - qcom,scm-sdm845
           - qcom,scm-sdx55
-- 
2.37.3

