Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485366765D7
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 12:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjAULI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 06:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAULIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 06:08:25 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E5B1A4A8;
        Sat, 21 Jan 2023 03:08:23 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id tz11so19958160ejc.0;
        Sat, 21 Jan 2023 03:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bV0QlH+wN08mDafAyJd6ZKnO9vWwwQ+auoKN9/OejlI=;
        b=abuZ60NluSmgsGz2jcp2YIhZdWoLJBvP1gSIN2DCdv0eu7xt1+3/qldtsQvJ1qvQcu
         V6mvEhlCLtEk54odvZbsuvpI2qP1kBGzFfxd89oEK24E+VKwqbGSYV2L2VLXWbmp9pPW
         KxbjY1SukwcrFCBk+7A9wmcTaoPHp9t+3xFmStJegKyX8HHc1aV2PWTxxqZGYhtcZdB1
         ZGv9/xD6XbfvaRbI+miT6LQDTBYsyNqTJFUITslYim7D8pLWlnGGte7KRMxPYSaCjOIn
         YdUYR8Eu5w1mKJXymInUFUNfSQLC4JMG7EZFWqN98DPcrEieQyJbpIzjFpyE8V/VF2BZ
         rSmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bV0QlH+wN08mDafAyJd6ZKnO9vWwwQ+auoKN9/OejlI=;
        b=PAlz7yCWbqMRmPaF4mvP24rp9xuvcP9W3YCTwQIXN7t95Mjvs0VDV+cOfvOMP/JlwP
         KXPMVuLMh2SoxpgXm7KQJHhF39z58HeRhj6McHwSSrP8zX8NNEb2O4qH36YJ/SvZ4a5s
         ghxBeR8Sph1OmWirmKBF6gowRN70eWatoGf1fL87dG3lBVTHD8rpbDoE3uE9dSwKMtUo
         0iMll8IOMBsV8cFgI/uAKDHZXq31WygtgvcX32xA5RBM2VlhgdjRxiSWkZhOPVITRjbB
         uDa5YwU5VvqZ1gaPhhlL2882n5JGakT6PFVM36307NyFj1+FjFVRabV3A5P8UrLoI7ra
         j7XA==
X-Gm-Message-State: AFqh2kpWA0fVKLEEJGDkwOiWcRMMlhQX7RAPE0g5dgmbILOC88frkjFr
        5aaa2jMjffoOyM4Tv1xt1QE=
X-Google-Smtp-Source: AMrXdXvharavu5Ec3k9/t3pIEVUoQifYmrL6N6/KDWOXmGzBGu2cKkGVU+ItgcsFfkDLRZNqjwCq6g==
X-Received: by 2002:a17:906:2582:b0:877:573d:e91c with SMTP id m2-20020a170906258200b00877573de91cmr14335913ejb.63.1674299302493;
        Sat, 21 Jan 2023 03:08:22 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090609c100b0084ce5d3afe7sm19207706eje.184.2023.01.21.03.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Jan 2023 03:08:22 -0800 (PST)
Message-ID: <137b56f0-8e86-f705-4ba7-d5dfe3c0b477@gmail.com>
Date:   Sat, 21 Jan 2023 12:08:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v2 2/8] dt-bindings: pinctrl: rockchip,pinctrl: mark gpio sub
 nodes of pinctrl as deprecated
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kever.yang@rock-chips.com, sjg@chromium.org,
        philipp.tomsich@vrull.eu, john@metanate.com,
        quentin.schulz@theobroma-systems.com
References: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
Content-Language: en-US
In-Reply-To: <03627216-54b5-5d9b-f91d-adcd637819e3@gmail.com>
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

Mark gpio sub nodes of pinctrl as deprecated.
Gpio nodes are now placed in the root of the device tree.
The relation to pinctrl is now described with the
"gpio-ranges" property.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/pinctrl/rockchip,pinctrl.yaml         | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
index d6539723f..45b767986 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
@@ -76,15 +76,13 @@ allOf:
 required:
   - compatible
   - rockchip,grf
-  - "#address-cells"
-  - "#size-cells"
-  - ranges

 patternProperties:
   "gpio@[0-9a-f]+$":
     type: object

     $ref: "/schemas/gpio/rockchip,gpio-bank.yaml#"
+    deprecated: true

     unevaluatedProperties: false

--
2.20.1

