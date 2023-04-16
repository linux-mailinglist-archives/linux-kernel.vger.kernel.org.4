Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF68F6E379A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjDPLCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjDPLCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:02:10 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D4AE59
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:02:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id dx24so12909646ejb.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681642926; x=1684234926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4WEBjyty9DFdqOQH0zK6dTdg5jesKwkOh/RLzzQc8K4=;
        b=aULvflOyaSYPx8ovMpRCo9pz0QX6rYvnfEFnSAcXlceTgnefx7dnaBcK1xFz6eJ9rA
         dYatYZgVtjclp3vxTgX/E//i//5qykFtkLGuVhEXsP4fgID4DNfbCo58ujyOc0wQ+v+w
         QTj7y4w+mZRGLT3VVnICZzANcECoa8BXO38YcjscZwooNhfaD4iu8tYz6ZP7B7qWapVh
         LF3wvQHG5q2q0Y3iWTET7Rbnzmz+O2K0ESry66jYtaGFPFpJh/9JNZ7jy690f7QJKuJU
         Fe7WHUi3JoQKTfVLY5YmSFZ5xPfxTB4H3lCgIGOFploepeAVuooDGBN99vEDjmoQ5h+A
         vYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681642926; x=1684234926;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4WEBjyty9DFdqOQH0zK6dTdg5jesKwkOh/RLzzQc8K4=;
        b=ShsFEOT0LFjuomFzfOMsnPYaI2nMSwdJ/nEd8TNwbqymvZvZM9+ncOj1pwG4N7Woeo
         zvf8yJboJX17+B8qQtqIYgKqSF0SJjp5WZDuUZz8h4bIudHju/RjBnKr35Eye+oMLrff
         DOOYjVcjg74bRKVHqif21nAOsE39MjJlgK2FSWoTPupaLa1QMqRM5/8okNrzagSNmiYP
         yoGyeHZ5kPcCwx2qJL3EfvT5hEEyy3j1PqVL2PVeta3jBzIBrJl6LSLYuLPE5hW+rw1I
         gems1NxTuWdZ8L1N3uJB7QMRRH9ifeHzNyZUsr4TcRlcddyOHjSGNjXeJoSJLFbFkOZo
         93NA==
X-Gm-Message-State: AAQBX9dK7Sa8G5uCu9EGrKtj5rNmWfnbtrDE4ZyH8wwZCGR9k9ayPX0G
        ULYgRQx5UscGL2RMelcvkRY9MA==
X-Google-Smtp-Source: AKy350b1E+fZ7aEii7E43vI6XNJJZQzoyIgmsDvGp/Bmzgmo4kBSdXvFFXklgYoiD4Nx/4MnoxRj8Q==
X-Received: by 2002:a17:906:2b0c:b0:94f:3980:bf91 with SMTP id a12-20020a1709062b0c00b0094f3980bf91mr2538331ejg.19.1681642925782;
        Sun, 16 Apr 2023 04:02:05 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:29dd:ded4:3ccc:83db? ([2a02:810d:15c0:828:29dd:ded4:3ccc:83db])
        by smtp.gmail.com with ESMTPSA id ca11-20020a170906a3cb00b0094f14286f86sm2122418ejb.48.2023.04.16.04.02.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 04:02:05 -0700 (PDT)
Message-ID: <3d5dbf9d-614b-7c36-3467-2e80d5a9c33f@linaro.org>
Date:   Sun, 16 Apr 2023 13:02:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] dt-bindings: panel: Add Samsung S6D7AA0 LCD
 controller bindings
Content-Language: en-US
To:     Artur Weber <aweber.kernel@gmail.com>, thierry.reding@gmail.com
Cc:     sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230416100139.13741-1-aweber.kernel@gmail.com>
 <20230416100139.13741-2-aweber.kernel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230416100139.13741-2-aweber.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2023 12:01, Artur Weber wrote:
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>

Missing commit msg.

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.


> ---
>  .../display/panel/samsung,s6d7aa0.yaml        | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> new file mode 100644
> index 000000000000..969cef7738b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/samsung,s6d7aa0.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung S6D7AA0 MIPI-DSI LCD panel controller
> +
> +maintainers:
> +  - Artur Weber <aweber.kernel@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: samsung,s6d7aa0-lsl080al02
> +
> +  reg: true
> +  reset-gpios: true
> +  backlight: true
> +
> +  enable-supply:
> +    description: Enable supply
> +
> +required:
> +  - compatible

reg?

> +  - reset-gpios> +  - enable-supply
> +  - backlight

keep the same order as they appear in properties.

> +
> +additionalProperties: false
> +

Best regards,
Krzysztof

