Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DF65F0B2F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiI3L6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiI3L6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:58:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D01A15FC7C;
        Fri, 30 Sep 2022 04:58:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08A106230C;
        Fri, 30 Sep 2022 11:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3017FC433D6;
        Fri, 30 Sep 2022 11:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664539100;
        bh=wsb962dMKRh67QppXhCfHwWVKv37pVodkZIc29Rre7o=;
        h=From:To:Cc:Subject:Date:From;
        b=L1XsEQr+hrLzLPqpP4SmZPwTNkks4X6J6VEd9w9hLVMqwk+PRgAcj271QdyUJZEkL
         9tzhPSSccqDyafu7s9Gfypcs3+MA8WD72kKKoQTGBmCqXV5V1xIpGJOS6T5SVhZL1A
         4CiJDWRt4C0MsxfA3Yox/uCNhDorpdV4S6dC8lmUhsb/6TqqCDr9pkzHt1ug1A+muu
         nrD7bZmnRl7KlCks8SIMsXR3qcaBkg/GVQIKdI4AS/EPBorq6ZwignaOaGGTdddSmJ
         snxOhQTGqxFj1+9QTUiq7dT67LmPg74gR3gHCxJRMOaBtELPISYSx5jylWdFNI8Yhj
         /t7c5D1wjbQhQ==
From:   broonie@kernel.org
To:     Lee Jones <lee@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mfd tree with the qcom tree
Date:   Fri, 30 Sep 2022 12:58:16 +0100
Message-Id: <20220930115816.128513-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml

between commit:

  4f2e28b2cc2e0 ("dt-bindings: mfd: qcom,tcsr: add several devices")

from the qcom tree and commits:

  f8c1940165bea ("dt-bindings: mfd: qcom,tcsr: Add several devices")
  a328ae8504dbc ("dt-bindings: mfd: qcom,tcsr: Drop simple-mfd from IPQ6018")

from the mfd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index d3c25daa995e4,b12809b5cc22e..0000000000000
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@@ -15,31 -15,27 +15,27 @@@ description
  
  properties:
    compatible:
 -    items:
 -      - enum:
 -          - qcom,msm8998-tcsr
 -          - qcom,qcs404-tcsr
 -          - qcom,sc7180-tcsr
 -          - qcom,sc7280-tcsr
 -          - qcom,sdm630-tcsr
 -          - qcom,sdm845-tcsr
 -          - qcom,sm8150-tcsr
 -          - qcom,tcsr-apq8064
 -          - qcom,tcsr-apq8084
 -          - qcom,tcsr-ipq6018
 -          - qcom,tcsr-ipq8064
 -          - qcom,tcsr-mdm9615
 -          - qcom,tcsr-msm8660
 -          - qcom,tcsr-msm8916
 -          - qcom,tcsr-msm8953
 -          - qcom,tcsr-msm8960
 -          - qcom,tcsr-msm8974
 -          - qcom,tcsr-msm8996
 -      - const: syscon
 +    oneOf:
 +      - items:
 +          - enum:
 +              - qcom,msm8998-tcsr
 +              - qcom,qcs404-tcsr
 +              - qcom,sc7180-tcsr
 +              - qcom,sc7280-tcsr
 +              - qcom,sdm630-tcsr
 +              - qcom,sdm845-tcsr
 +              - qcom,sm8150-tcsr
 +              - qcom,tcsr-apq8064
 +              - qcom,tcsr-apq8084
 +              - qcom,tcsr-ipq8064
 +              - qcom,tcsr-mdm9615
 +              - qcom,tcsr-msm8660
 +              - qcom,tcsr-msm8916
 +              - qcom,tcsr-msm8953
 +              - qcom,tcsr-msm8960
 +              - qcom,tcsr-msm8974
 +              - qcom,tcsr-msm8996
 +          - const: syscon
-       - items:
-           - const: qcom,tcsr-ipq6018
-           - const: syscon
-           - const: simple-mfd
  
    reg:
      maxItems: 1
