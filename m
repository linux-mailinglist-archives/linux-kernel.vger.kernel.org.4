Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB965BAD24
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiIPMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiIPMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:12:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463CAB0B04;
        Fri, 16 Sep 2022 05:12:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C887B62B41;
        Fri, 16 Sep 2022 12:12:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D7BC43143;
        Fri, 16 Sep 2022 12:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663330347;
        bh=3gGcMHmFimfPD8rpeW8RQN1ZNlCrlPvnyk0muFEHR1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+tkvv+CSf3zCbI1dirRPAgwseoXj5cvkfdbLhwETGl9HUywBDai8fbyTJuQ72dDO
         H/no8skPjwqBisbnsJ0Tcm+X5KIBi0aI/WX1VqtvIUZ+aIP2yGnrYOICDk0xTQfoPW
         vVeYf35NCcampBpmhVg7lv+K5/4tZwjTH6xtN1/4PmVIf5XGhkn+uydHmgZaDpr4Ta
         KhgJjaCVXY19u5yx5pcbBsD07V50G5noLazKP6KcaMgXS9Z8SZwX/YSKFI35JI4NEH
         bzUYsYWqUEop+QfvISpYamO7rWRlCJBIaFp7gKeSbApLnTq0oqlXQHt4krUlv5SMJW
         e5BlCR36bSEmg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] dt-bindings: usb: qcom,dwc3: Add SC8180x binding
Date:   Fri, 16 Sep 2022 17:42:01 +0530
Message-Id: <20220916121204.3880182-4-vkoul@kernel.org>
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

Document the USB dwc3 controller for SC8180x SoC

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
index fea3e7092ace..f33735f3702d 100644
--- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,qcs404-dwc3
           - qcom,sc7180-dwc3
           - qcom,sc7280-dwc3
+          - qcom,sc8180x-dwc3
           - qcom,sc8280xp-dwc3
           - qcom,sdm660-dwc3
           - qcom,sdm845-dwc3
-- 
2.37.3

