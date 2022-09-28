Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB9A5EDB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiI1LJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233686AbiI1LIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:08:17 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F6140BCF;
        Wed, 28 Sep 2022 04:06:32 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664363188; x=1664622388;
        bh=C3iqLHXQoOQP4qiEtNxd0qDkh96OEIhJ+aK6ly1xU10=;
        h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=JgoJkm4fvgZ6P5KjNBvI2DyrZjn9Yjdr/8IEFEpxxPsCzl84hPakQ5Qbw8a/ijqPy
         FYYGZz01drOzhAtAzEIFsLbJauVWkiG9mrB1cTUFRapv5QEcVRM76Cgx6ImKuriQnm
         QgrqcgnbY60K02uNIPaaQ+BcFNMsO3q5HjEufoJFixljp+L3aMQl3s8yn9OmlBCh/r
         hO0KjRknTT5yXMO+3YfI9fomPxW8cC+mAHmFIuYkYh4JjmFzQiAznPCrYUb/CbjG9m
         dJ5f/UuMOXb6gv8YoURzzm1sjVB8pKXGmNzNuS5f0I6eljvmp75BWDGxyuj68p1KrX
         y803LxmHPCaSA==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH 1/3] dt-bindings: qcom: Document bindings for new msm8916-samsung-j5 devices
Message-ID: <20220928110502.96262-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928110049.96047-1-linmengbo0689@protonmail.com>
References: <20220928110049.96047-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new samsung,j3/j5/j5x device tree bindings used in their
device trees.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index fb1d00bcc847..b1c69d4d9a9a 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -176,7 +176,9 @@ properties:
               - longcheer,l8910
               - samsung,a3u-eur
               - samsung,a5u-eur
+              - samsung,j3
               - samsung,j5
+              - samsung,j5x
               - samsung,serranove
               - wingtech,wt88047
           - const: qcom,msm8916
--=20
2.30.2


