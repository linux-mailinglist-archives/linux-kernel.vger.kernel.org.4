Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6BE6CC030
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjC1NIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjC1NIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:08:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8D5A27C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:07:25 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so7413157wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680008844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+g3PbkFkvtGB7Ib7crNaYlWYLpKjLrVlGCKu7Q19AQ=;
        b=HIDkkVqHA/weBRrh6Qi+epawFgmNjYODxBgBz0fD3hPiDoNTdQHN8wRWatd9nOKTgK
         K/tPnvN5G3VC9a5SLy2UJMhwMNpZ7iKfqOuC4WD+pt0MYOD4hT7Ah3TXWmg/gxIP/FCG
         2DLylGyZto4PuVazOYb3rK6Q149ryse3CoaqgAAKOI5Q2F7cDF8ePrU3HGXFwrLnwwnB
         EGsSccOlSAEhNhSQNn9bwZsDRh896M1I8NEa/YWLCF2sf2eF+KVzpEBsNF0pJzwGIKZ+
         il+trUhvJ14PmQqM0xXDOR76vwqBAl2ZZwc4CXCOOCZdnsK9vJHG747SaryIs1ceVyVj
         u2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680008844;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+g3PbkFkvtGB7Ib7crNaYlWYLpKjLrVlGCKu7Q19AQ=;
        b=sNS/sL9igcLhje6Q4VQXVN+ENU3QC6TtmH0WLkOUlJR5ydEAdWiU2/bmyla8s4HwEA
         vqokrbsQTPY6+EzVvZOgQ9sbISNQXCTA4qPiM746Z6grkCLuEfKJc5g+UlUsJ7MdWl0d
         p4a764QisiWb851KIctZ7WHLudesWjWNzvN4shu18yckoMb5x2NVw6KgAiKD4zWBQ9lH
         trjS3a1O2iq+xcg8m/JI3raEEsRCV+JyE2uMGyOuOXrAxJCF2Pf3T06CNNAXc6XHbWWA
         wDZ6dK5NqdZr+hOC/t0IXwDgpnIMP/qF/8HLSiHWiSIHDQDEszvE5KTSCx6Y1dpAl6ue
         d3UA==
X-Gm-Message-State: AO0yUKWpppCBGLpyLbWNbbN6Lj8SRctAeahoZcKChiyITW08IckqLIpN
        D72sOxSaPRx8oTRT+x97VpNV1g==
X-Google-Smtp-Source: AK7set+NYLNhPbe4XUq6GsaMPEKBtv3HLCG2+YsiBNv+epKhJ6eSYCiELA9LbaPxvZwQB0W2AmsjOA==
X-Received: by 2002:a1c:4b07:0:b0:3ee:ed5:6115 with SMTP id y7-20020a1c4b07000000b003ee0ed56115mr12304335wma.19.1680008844372;
        Tue, 28 Mar 2023 06:07:24 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id z6-20020a05600c0a0600b003ee6aa4e6a9sm12733650wmp.5.2023.03.28.06.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:07:23 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 28 Mar 2023 15:06:33 +0200
Subject: [PATCH 2/2] dt-bindings: pinctrl: mediatek: deprecate custom bias
 pull properties for mt8365
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230327-cleanup-pinctrl-binding-v1-2-b695e32e4f2e@baylibre.com>
References: <20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3516; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=E7NNrE/lyS6SM3/lDUDf2mg8xJW/mo7YWCrWRiTlOHE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkIuaJqnTzKNbbFjvellRqZs6ZK7Bw/T9+Wr9UfXMx
 KcMt3vCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZCLmiQAKCRArRkmdfjHURfLVD/
 0Y1g+p3Qqiud0eO5eRTXh1KrSids521TfhEt1utTseFC/mF2E0Lre6+uMIvpRNF9zZuQkDHNaZYbE0
 yi1rSQFRZ0U/0aIzhE5NPcNGEc2oNJLcro07fF2RKl4ovmPXjuULS2Cp7uTC8lMNNhfOJgUrFXqKYc
 avLzANdWJUHV+yohEctzPVCnddiLW7oMQlcso4UlbxMQ7pj/vFVyYGBTx8f3XoB96MJuAiTNaNknez
 e4yAMMDTjtLDm2NhvYvrxzAkONP7cUEXZlaPtsnKIT/+AdY9hEg8yXkFNB2H+0pIfl+RM3o669VcA+
 EwAaDjr60+gscMRflghjoR2J0GHxzcmA8OikvQdy/PNgYeFK94nKfIlcjkhU5KQUJFIUxo2bH/popK
 iDXt6y0sFo2ZsvbReAmpnIwLunKqmQvlTWJ2jeHPku8zAqgTPLvFp6z0w3Xfrc+9e5E6HobEEBCdXF
 VJRG2qhu7BJLMCw//90x2bXN7IExDlQMJ3EeM9Dqcv/Ryb7GR9oM9UTOll3+iRFHa7NbULaB+nsw9a
 ONg9vZfwfCsqZ5gMKrnmp2L7WOSOKBp3c79neEE10RFV3dm7sANkW3jXHDRH644mQ+e0OD9vrQ7S/c
 VshzQ5xq5BRpwTFyYwmkulklakerPQzivkr2wVfrXgrYP54nUaiENBS0LRow==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be more generic, "mediatek,pull-up-adv" and
"mediatek,pull-down-adv" should be deprecated. Use "bias-pull-up" and
"bias-pull-down" instead.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 .../bindings/pinctrl/mediatek,mt8365-pinctrl.yaml  | 32 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
index 347f533776ba..4ebc7f1caf55 100644
--- a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml
@@ -72,12 +72,32 @@ patternProperties:
           bias-disable: true
 
           bias-pull-up:
+            oneOf:
+              - type: boolean
+              - enum: [0, 1, 2, 3]
+                description: Pull up R1/R0 type define value.
             description: |
-              Besides generic pinconfig options, it can be used as the pull up
-              settings for 2 pull resistors, R0 and R1. User can configure those
-              special pins.
+              For pull up type is normal, it don't need add R1/R0 define.
+              For pull up type is R1/R0 type, it can add value to set different
+              resistance. Valid arguments are described as below:
+              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
 
-          bias-pull-down: true
+          bias-pull-down:
+            oneOf:
+              - type: boolean
+              - enum: [0, 1, 2, 3]
+                description: Pull down R1/R0 type define value.
+            description: |
+              For pull down type is normal, it don't need add R1/R0 define.
+              For pull down type is R1/R0 type, it can add value to set
+              different resistance. Valid arguments are described as below:
+              0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
+              1: (R1, R0) = (0, 1) which means R1 disabled and R0 enabled.
+              2: (R1, R0) = (1, 0) which means R1 enabled and R0 disabled.
+              3: (R1, R0) = (1, 1) which means R1 enabled and R0 enabled.
 
           input-enable: true
 
@@ -123,7 +143,9 @@ patternProperties:
             enum: [0, 1, 2, 3, 4, 5, 6, 7]
 
           mediatek,pull-up-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use bias-pull-up instead.
               Pull up setings for 2 pull resistors, R0 and R1. User can
               configure those special pins. Valid arguments are described as below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.
@@ -134,7 +156,9 @@ patternProperties:
             enum: [0, 1, 2, 3]
 
           mediatek,pull-down-adv:
+            deprecated: true
             description: |
+              DEPRECATED: Please use bias-pull-down instead.
               Pull down settings for 2 pull resistors, R0 and R1. User can
               configure those special pins. Valid arguments are described as below:
               0: (R1, R0) = (0, 0) which means R1 disabled and R0 disabled.

-- 
2.25.1

