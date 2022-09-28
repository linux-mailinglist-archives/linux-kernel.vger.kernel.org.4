Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BC15EDCF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbiI1MkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiI1Mj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:39:56 -0400
X-Greylist: delayed 1220 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 05:39:53 PDT
Received: from mail-40132.protonmail.ch (mail-40132.protonmail.ch [185.70.40.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913361A3B3;
        Wed, 28 Sep 2022 05:39:49 -0700 (PDT)
Date:   Wed, 28 Sep 2022 12:39:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664368787; x=1664627987;
        bh=C3iqLHXQoOQP4qiEtNxd0qDkh96OEIhJ+aK6ly1xU10=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=cZvPd9h3+gdOubV7jvlVano/5tpA3zHShXMt+SJbTYUrOPtRcXtTAjurI35Z4M0Qq
         Y2tnp0ATtH9L9X5VAgAOKRM6aeduVWyqW0s//EGoP44ro+m3lHE97XOYpfG67Ay89J
         9AOB9qx6YONFahwBqp6SFhX79+0oJ5W8YYPa1QxnchIfi9sWaiNUTHtW29HXeU2T65
         qq5lz6WVj3eLnzkOJKzsDvqoyHCLnIgZc516M74TOUj7F90qiTU85VJ3ptzMGWGyeg
         7Ei2OeWSqQwEgtQotxvbs/hUZxHdRtiyhnygThqqic3YV3Fhxma7I1/hABzm2farYO
         PtZ2LuAX3geIw==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        "Lin, Meng-Bo" <linmengbo0689@protonmail.com>,
        "Lin, Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: [PATCH v2 1/4] dt-bindings: qcom: Document bindings for new msm8916-samsung-j5 devices
Message-ID: <20220928123759.104582-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220928121717.102402-1-linmengbo0689@protonmail.com>
References: <20220928110049.96047-1-linmengbo0689@protonmail.com> <20220928121717.102402-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no
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


