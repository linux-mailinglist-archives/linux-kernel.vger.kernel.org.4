Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF27658C50
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 12:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbiL2Ljh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 06:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiL2LjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 06:39:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C71B13E9B;
        Thu, 29 Dec 2022 03:39:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z11so10493633ede.1;
        Thu, 29 Dec 2022 03:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL7W0UbK/uwHhrL/ebbYLl16dFNUQnqpqk5DlrkcofQ=;
        b=XZebkHQJ416b2bVgOIpHp7OjUe+l5KMCIwXfMscGFBwoNs4j4l32Jrbn64AgdoaKq3
         eFwp5ruKCymbMl4iHGbjt7ZXCZlJkRwMKoETrNz77eX670EGUDPV1qg8mOzLTl4W8KzN
         gRHxEacLvb0dGJZGd8nlhzlLvohACE2GeQj/CKmRFWDug9fkVV1GI6G4Dd6ZPJUTgwBX
         8kIyQS4FNd6Qail9uIbTpfhf0rBoaK1poKfC2To12ARZAvYLBDPdjfetv50kXBInudH4
         ZxQrQKLJioMFOTe4eWEyAj+mvbMunSRGNUyrZhApDj1E1omytLGjg+70ejvgUP1GoG1B
         b0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZL7W0UbK/uwHhrL/ebbYLl16dFNUQnqpqk5DlrkcofQ=;
        b=bWkGqh51u/dLLBNANViz3Ol9fKhSeAazzp534ZwLtVPVcjN1xcvx9QHhDTOjlekfbF
         RIAKnw/jQi4MuswpZnqvoa5zpS/gbKuv1wlCWMke1UC9rNwi6s4/gsW2DFc+e1hV5VDF
         LuBiuIg4B84rDy/BIQlCN0cHPS7oGFi6NqegfyjJbRbwVKxQzvHFS2awzsLVje5I6ERF
         zxkZatxBJAklIPNeR676liE9Va2Dr1viiy0Hp9qjTLdwuIshKcsUTuPnc/ihNeToLNg6
         PmGem/PU//6Aqe86W/YXUzkxKsYcxkKpcWDhIIqZRPTnIgQ7obcdyht46ius3+wolTu+
         bo4A==
X-Gm-Message-State: AFqh2kq1heE0cJkmsBaeOUF77ujbsPOpxTbHkzXuPq83UendZQsSwxeX
        NWDLZ0BrRJtQG8QTrKD1ueJ8J0XrWSw=
X-Google-Smtp-Source: AMrXdXvpRLDZqD2mcnt2ORSXZKriqyX1MovkfFzEg33cDv6OGKF42t7q6lJRk0KCvZs3N4kx+yTweQ==
X-Received: by 2002:aa7:c516:0:b0:485:48ed:b1f3 with SMTP id o22-20020aa7c516000000b0048548edb1f3mr10954209edq.26.1672313959810;
        Thu, 29 Dec 2022 03:39:19 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r28-20020a056402035c00b0045b4b67156fsm8161374edw.45.2022.12.29.03.39.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 03:39:19 -0800 (PST)
Message-ID: <99794484-d67e-ee1f-4e76-200de20a879c@gmail.com>
Date:   Thu, 29 Dec 2022 12:39:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1] dt-bindings: phy: rename phy-rockchip-inno-usb2.yaml
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-phy@lists.infradead.org,
        vkoul@kernel.org, kishon@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename phy-rockchip-inno-usb2.yaml to a more common format of
rockchip,inno-usb2phy.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Apply after:
  dt-bindings: soc: rockchip: grf: add rockchip,rk3288-dp-phy.yaml
---
 .../{phy-rockchip-inno-usb2.yaml => rockchip,inno-usb2phy.yaml} | 2 +-
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/phy/{phy-rockchip-inno-usb2.yaml => rockchip,inno-usb2phy.yaml} (98%)

diff --git a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
rename to Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
index f71920082..0d6b8c28b 100644
--- a/Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.yaml
+++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/phy/phy-rockchip-inno-usb2.yaml#
+$id: http://devicetree.org/schemas/phy/rockchip,inno-usb2phy.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#

 title: Rockchip USB2.0 phy with inno IP block
diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 8dc141410..39d8c3b5d 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -192,7 +192,7 @@ allOf:
       patternProperties:
         "usb2phy@[0-9a-f]+$":
           type: object
-          $ref: /schemas/phy/phy-rockchip-inno-usb2.yaml#
+          $ref: /schemas/phy/rockchip,inno-usb2phy.yaml#
           unevaluatedProperties: false

   - if:
--
2.20.1

