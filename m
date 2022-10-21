Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9877A60797F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbiJUOYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiJUOYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:24:35 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35E3CE32;
        Fri, 21 Oct 2022 07:24:26 -0700 (PDT)
Date:   Fri, 21 Oct 2022 14:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1666362263; x=1666621463;
        bh=xobhonkjJEPM2+RCCEDKaeuxmgDEQm6jEtUjcfbshas=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=V3eGVUIaCRtt03QbRMOO+Qln0tyIONehWogvk49V4OevPI67YpzXnWA6UA1MT+wm6
         /1JUGd/aEidLBfg0oopfU6WBh1QuWa5g7nKOdDfor+Gou7ihjpYWubevEFPWkUVqRb
         gLjwSiUUjjQRJJY9MER0IRLdZOoZOkM1gKc0t0OH28I8oVPjfpUyn3xw3uJLrR9Pvg
         yDKfIqHxGplAZ7kf5FTW2XcPApZm+bjrg3owETJiJLxOJva2f9iWCf7RgfAzUECJWN
         aj+yH4JoYQquWVrQVvHZA43+UzlhUu+HucktOmPwuzoqUQ13nDxp0ToXRoSijZRg73
         UnJM2PhPJia7w==
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
From:   Harry Austen <hpausten@protonmail.com>
Cc:     Harry Austen <hpausten@protonmail.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH 3/4] dt-bindings: arm: qcom: add oneplus3(t) devices
Message-ID: <20221021142242.129276-4-hpausten@protonmail.com>
In-Reply-To: <20221021142242.129276-1-hpausten@protonmail.com>
References: <20221021142242.129276-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible strings for the OnePlus 3 and 3T phones which utilise the
Qualcomm MSM8996 SoC.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 1b5ac6b02bc5..e49a3fc02948 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -221,6 +221,8 @@ properties:

       - items:
           - enum:
+              - oneplus,oneplus3
+              - oneplus,oneplus3t
               - qcom,msm8996-mtp
               - sony,dora-row
               - sony,kagura-row
--
2.38.1


