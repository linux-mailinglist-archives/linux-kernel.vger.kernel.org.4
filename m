Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD4D73939E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 02:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjFVAP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 20:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjFVAPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 20:15:23 -0400
Received: from mail-41104.protonmail.ch (mail-41104.protonmail.ch [185.70.41.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9548911C
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:15:21 -0700 (PDT)
Date:   Thu, 22 Jun 2023 00:03:43 +0000
Authentication-Results: mail-41104.protonmail.ch;
        dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="oPe+CtEW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687392233; x=1687651433;
        bh=1f6zJycLuFoL5WQQ7MMLphiDimdCfGXgDIFs81dzGK8=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=oPe+CtEW9hUyTJ4NiqdPk/uCGCkDffSpV2VbWqCajjwmbW8j5OnfGdzPscpc6p0t6
         GLaP5+Qc9vrah69oIzt0DH0Qb9eQV0mQrp4Hlv1RoM3afZwksb/e0AbstSlXHm1YlV
         O2gIV8Vg9dXFk3h+LW8T1Ore0R+DiA2jTfjQoDcK2Iy5RbfPhJ/uT9di0yvbrmIDsx
         HJ6uqZvuMR/rqsdjigFPFMy/bqeP7rJQNKrFknX8oWrRy6ze2pdpv2fXaziCY/7Sm6
         68UkKYgRqpt/02VQWjjk+NUsU8IcILGo1fz+QrYo1qnP4UTjh08p2pAahOLQhZk3an
         pEnvXOdRUEB2w==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 1/7] dt-bindings: qcom: Document new msm8916-samsung devices
Message-ID: <20230622000254.48260-1-linmengbo0689@protonmail.com>
In-Reply-To: <20230622000007.48219-1-linmengbo0689@protonmail.com>
References: <20230622000007.48219-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new following device tree bindings used in their
device trees:

- samsung,fortuna3g
- samsung,fortunaltezt
- samsung,gprimeltecan
- samsung,grandprimelte
- samsung,heatqlte
- samsung,rossa

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 450f616774e0..7172f657bfa4 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -235,11 +235,17 @@ properties:
               - samsung,a5u-eur
               - samsung,e5
               - samsung,e7
+              - samsung,fortuna3g
+              - samsung,fortunaltezt
+              - samsung,gprimeltecan
               - samsung,grandmax
+              - samsung,grandprimelte
               - samsung,gt510
               - samsung,gt58
+              - samsung,heatqlte
               - samsung,j5
               - samsung,j5x
+              - samsung,rossa
               - samsung,serranove
               - thwc,uf896
               - thwc,ufi001c
--=20
2.39.2


