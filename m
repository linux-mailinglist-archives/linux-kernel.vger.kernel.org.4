Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CA36510C4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbiLSQ4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiLSQ4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:56:39 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63425FD7;
        Mon, 19 Dec 2022 08:56:38 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id tz12so22986492ejc.9;
        Mon, 19 Dec 2022 08:56:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MW9IUi38LGJbWOititTnXuZuxcZ+qs+mMT17ZPnQkKo=;
        b=OeS+09a5otGiv+Kpp8lLf+vmlBCzLGRQR7qaXnlrCYGE2jyYt7zZ96biw1Dqc+/HT0
         A/HvI2rQK1PhpdXfAu8BkfTe8SpXixvvkcogsKLFjRipBr3Z/72DkU+uGlsb2940rucX
         sJo4GcqGJ8KVxFlsN4DisdJDmDEFTWGBogewBBWvwny/hCGMSXzuO1jLOAFn7f81cByM
         2Akq7VTkHMbjuCNNk7/JNHnR0SHjuLGoWFp+5JjOmjPV9MED3JTPNEVgrfs/UmaxukWZ
         NqtQXG8SUkdFIAnSufSaC16d3VGbJLX5xiQTfvDLeJ0Pre0Zko9oKo/6wUsaRHJ52u5f
         n6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MW9IUi38LGJbWOititTnXuZuxcZ+qs+mMT17ZPnQkKo=;
        b=VvNYLSE6x30Wn40lWiODiMWcL2MzMoHSEQogFALeIEMlm+w1G0VnEqTUwQGyeZXOnb
         mvB9MftS/H0JlwTmzoT2GSqfEa6xAYRi3OWfyngGzFtksYm+QS3Pm+ZWcqoIokpfV4xf
         8XMNb7OOvT1AqbDqsg92amKVQgkOiuBO99Fs5T8JBEJ1Y4PVbPXQMMlsfyVOwfANM/s4
         JV9E4smpLpDcahP6bLC+eojExqTe+JyBwlGosw8ejoA7GZOw7sMsg2KlxcxtvlVIhWao
         nMKxeu1ZCBoaQFJwKb+KqIlDaQlCqQeAxsvAVArzAjr0ptEj2h72QePoJqyoKREyxJq4
         susg==
X-Gm-Message-State: ANoB5pn96+DQ05p58wm6mR1rw/XtLClZx/cEbC5xCLOgTsTCSqDQO79J
        ke+5RfNBg49OKiZJFTiezLo=
X-Google-Smtp-Source: AA0mqf41B2/H4EPNsKQaq9hNNH4wwwkWyo/RIZIY1kQU+RhK6rFFtS4wChCTmLuHjDyyznqvRl+W0Q==
X-Received: by 2002:a17:907:11c8:b0:7c0:beee:2f06 with SMTP id va8-20020a17090711c800b007c0beee2f06mr34217874ejb.52.1671468997317;
        Mon, 19 Dec 2022 08:56:37 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id rs13-20020a170907036d00b0077a1dd3e7b7sm4623533ejb.102.2022.12.19.08.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 08:56:36 -0800 (PST)
Message-ID: <0b9bb507-1819-4bfa-593f-8b7e92c2ce3d@gmail.com>
Date:   Mon, 19 Dec 2022 17:56:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 2/5] dt-bindings: soc: rockchip: grf: add
 rockchip,lvds.yaml
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, vkoul@kernel.org, kishon@kernel.org,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
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

Add new converted rockchip,lvds.yaml to grf.yaml file.
Prepare for more SoCs with lvds output.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 .../devicetree/bindings/soc/rockchip/grf.yaml          | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 2ed8cca79..d74295e98 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -75,13 +75,17 @@ allOf:
       properties:
         compatible:
           contains:
-            const: rockchip,px30-grf
+            enum:
+              - rockchip,px30-grf

     then:
       properties:
         lvds:
-          description:
-            Documentation/devicetree/bindings/display/rockchip/rockchip-lvds.txt
+          type: object
+
+          $ref: "/schemas/display/rockchip/rockchip,lvds.yaml#"
+
+          unevaluatedProperties: false

   - if:
       properties:
--
2.20.1

