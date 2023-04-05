Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71ED16D84B5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 19:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbjDERPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 13:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjDERPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 13:15:10 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A1D5FEA;
        Wed,  5 Apr 2023 10:15:08 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id oe8so26618464qvb.6;
        Wed, 05 Apr 2023 10:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680714908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gamUfoyodxPtqgS+QEeMjD5K0L0HZ7BreqQVvBsNAbU=;
        b=Tgn3bE/RkoAuugsPHfEFEIbp9Xh97c22wBARynaD9+0nsCtchdlZ9ez5matvPzkgt6
         fe0iQfR/mnQRE6LE1qeiKIaggzBM1lr5oEyD0SmXXUEe0iXFR9E+W0N/tno//4ievGNz
         QTQN81oQfxogDQobR8mNfMhTOU4pLoyc2M8fUjDSRM/c3m8HHp69QaGPab5qzQ0TI5Eh
         oRQDgvYRiBFe4mVokxcaUZUHtCUod3Evk5sgz8V5xe9pxCQq8wbkypIQdA5Hx3Pl6ay0
         avtwCviZQ14zMPNl7wGpyojOnD8sfYBlW6sqeV7Ew8bpGpAmuSxY6dn2D3r0G/K88UV4
         W7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680714908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gamUfoyodxPtqgS+QEeMjD5K0L0HZ7BreqQVvBsNAbU=;
        b=jpNGZZVWpAfP+e4KuPXDozFJKgtHRTZ4AA7hrb3d3yHcHekjVQ0MGkeRyrVCGk756X
         0UewrCl8HwXgFN6bPd8gfiP051/4omOVP9Lono21bfjJBRkS4VIjQ05yYw5ZU+JMZAan
         boEeqVRfJHNVqW0AxakM3etOM/5vH3W2q+rIxrmb/HPy0gv3SRejCV9xhcaamTQIkvny
         KEvl3pMuR9yJL9Q1JHBYhdaAb2y4T1Az3pzjBfFbDfFqHz/e2ojqy2XjflOa6frS36oG
         otsEezw1m/nHgRNkPRo+DvvuGz2YVWzUUCAZqYL0tSdSE+TC1UMbxlbnVV5gnYufuEdX
         N07w==
X-Gm-Message-State: AAQBX9ckqR/Cyyy46IbjBX/2gIVFFlRmSv35bQF32R6HZrgV8KlNaRWI
        AgTMLUEpwvqBI0wrbtQsK+Y=
X-Google-Smtp-Source: AKy350Y+N+2gOHDAcZpIFMRGUeY30FdWItt9poT0Ac3IlRAvy5o1HvuIrCc52f20InyjGC/iF1QHxA==
X-Received: by 2002:a05:6214:1315:b0:5aa:6130:7c63 with SMTP id pn21-20020a056214131500b005aa61307c63mr12775504qvb.46.1680714907937;
        Wed, 05 Apr 2023 10:15:07 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id ct9-20020a056214178900b005dd8b934571sm4403209qvb.9.2023.04.05.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 10:15:07 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Wed, 05 Apr 2023 19:14:36 +0200
Subject: [PATCH v3 3/3] dt-bindings: mfd: dlg,da9063: document voltage
 monitoring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230403-da9063-disable-unused-v3-3-cc4dc698864c@skidata.com>
References: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
In-Reply-To: <20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com>
To:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     DLG-Adam.Thomson.Opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

Document that the da9063 only provides under- *and* over-voltage
monitoring in one, and therefore requires both to be configured with the
same severity and value. Add an example for clarification.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 Documentation/devicetree/bindings/mfd/dlg,da9063.yaml | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
index e8e74e91070c..c5a7e10d7d80 100644
--- a/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
+++ b/Documentation/devicetree/bindings/mfd/dlg,da9063.yaml
@@ -12,6 +12,11 @@ maintainers:
 description: |
   For device-tree bindings of other sub-modules refer to the binding documents
   under the respective sub-system directories.
+  Using regulator-{uv,ov}-{warn,error,protection}-microvolt requires special
+  handling: First, when GP_FB2 is used, it must be ensured that there is no
+  moment where all voltage monitors are disabled. Next, as da9063 only supports
+  UV *and* OV monitoring, both must be set to the same severity and value
+  (0: disable, 1: enable).
 
 properties:
   compatible:
@@ -121,11 +126,19 @@ examples:
             regulator-max-microamp = <2000000>;
             regulator-boot-on;
           };
+          ldo6 {
+            /* UNUSED */
+            regulator-name = "LDO_6";
+            regulator-uv-protection-microvolt = <0>;
+            regulator-ov-protection-microvolt = <0>;
+          };
           ldo11 {
             regulator-name = "LDO_11";
             regulator-min-microvolt = <900000>;
-            regulator-max-microvolt = <3600000>;
-            regulator-boot-on;
+            regulator-max-microvolt = <900000>;
+            regulator-uv-protection-microvolt = <1>;
+            regulator-ov-protection-microvolt = <1>;
+            regulator-always-on;
           };
         };
       };

-- 
2.34.1

