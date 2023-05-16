Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11DB7052EE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjEPP5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjEPP5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:57:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4BD40F5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:57:31 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-94a342f7c4cso2620339066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 08:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684252650; x=1686844650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YFdAn7Fjdx2rJ76WHO6PHBO3/n+aln2mjGgewNBmIEI=;
        b=a2D+8t+JvAvQiQfiUf/HNoXN2nApCfMqc2zY3l9l+k0y4g3vmrlApiQMQ+GRspKp+v
         aFSYnR149w3u26IWDqVaETeE8Q2wRI+7RB0oJEFCsLBWz6J3+nsMgJP6uds3MWytl3ca
         8kPwF7LQyJvAMskAT+xxeTudCn0bcy9ZnkzqcRKtWzFo4JjAdWk6eEipckv9XFmEYr3j
         CjNlwdz+mz4d2BlQ1eY2kPtYcijmzXfvwKLjddEnPlSBdLZMUpwTWklJYeRVmvBvhMla
         /hNmPVvp5J2liSfcFhLhQck1WIr+DgV4893vxsm7QwwqFo5SPkCOqGjEKjX/Fk+NPOd4
         4+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684252650; x=1686844650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFdAn7Fjdx2rJ76WHO6PHBO3/n+aln2mjGgewNBmIEI=;
        b=OI8i6viBKW2YH10aRDAy/YX/IKBUa3cy+U/h3s/eKmNDQrj+jRUoLgLbsH9AgaD225
         zg3CNHxIcWlsnmkqWkvy+N8ShEAs/ok02Cxdkp3Sp6LtXTR0dnsoOX3DOnEvHQpy+G3U
         gvHzqAb3hrq1HcNFfvuCHHqFWI0dIa8wMsoUpB+guTv3YB8FzWr4Js+oPdrkeaUiBSwb
         SUGfZ2hY5YNwKUr39ctt/eGpqN5nn7qeSTnrZATGwd1im2mkdkf4NvD22oaPQwdn05aW
         7OaHgNCCrm4rhFkz9A0kXaQDopRdSzplO6jcyZPVjybw406P44JxzsNnnMf4bBVdr4Ak
         49bw==
X-Gm-Message-State: AC+VfDyx9ZSfL9lzMInHMI/0A/fiVSooCEFT+4o/WU0oeTtTsrW3Rb/B
        iSXCBOM7t0qtjeY70PtiLfFjRA==
X-Google-Smtp-Source: ACHHUZ4LicxoTrUfWiE2B86KO8Cl3YoygDk/rLnT/Sw4BYRU6yHuzrzZFmi7+8KBxCsQ26l23fn97A==
X-Received: by 2002:a17:907:7e8f:b0:969:e7da:fcb1 with SMTP id qb15-20020a1709077e8f00b00969e7dafcb1mr29092821ejc.13.1684252649625;
        Tue, 16 May 2023 08:57:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:77d1:16a1:abe1:84fc? ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id l21-20020a170906a41500b00965c6c63ea3sm11074850ejz.35.2023.05.16.08.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 08:57:29 -0700 (PDT)
Message-ID: <023f6cf9-0f08-f27e-d203-5ff78faf110f@linaro.org>
Date:   Tue, 16 May 2023 17:57:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: display: panel: add
 panel-mipi-dsi-bringup
Content-Language: en-US
To:     =?UTF-8?B?UGF1bG8gUGF2YcSNacSH?= <pavacic.p@gmail.com>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        neil.armstrong@linaro.org, sam@ravnborg.org, airlied@gmail.com,
        robh+dt@kernel.org, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAO9szn18KsR0c+U8EEY1=xnmsKMxy6SEArMUic0z=aYJDVwWCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2023 15:09, Paulo Pavačić wrote:
> Add dt-bindings documentation for panel-mipi-dsi-bringup which currently
> supports fannal,c3004 panel. Also added fannal to vendor-prefixes.

Thank you for your patch. There is something to discuss/improve.

> 
> v2 changelog:

Please put changelog after ---

Missing user of the bindings - driver or DTS. Please sent patches
together as patchset.



>   - revised driver title, now describes purpose
>   - revised description, now describes hw
>   - revised maintainers, now has only 1 mail
>   - removed diacritics from commit/commit author
>   - properties/compatible is now enum
>   - compatible using only lowercase
>   - revised dts example
>   - modified MAINTAINERS in this commit (instead of driver commit)
>   - dt_bindings_check checked yml
>   - checkpatch warning fixed
> 
> Signed-off-by: Paulo Pavacic <pavacic.p@gmail.com>
> ---
>  .../display/panel/panel-mipi-dsi-bringup.yaml | 54 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  MAINTAINERS                                   |  6 +++
>  3 files changed, 62 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bringup.yaml

Still wrong filename. You did not respond to my previous comments, so I
don't really understand what's this.

Judging by compatible, this should be fannal,c3004.yaml

If not, explain please.

> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bringup.yaml
> b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bringup.yaml
> new file mode 100644
> index 000000000000..c9e2b545657e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bringup.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/panel-mipi-dsi-bringup.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MIPI DSI Bringup Panel Porting Bindings

Drop Bindings. I don't understand what is "Porting" in the terms of
hardware. If it these are bindings for Panel, please write here proper
hardware.

> +
> +description: |
> +  MIPI DSI Bringup Panel porting bindings to be used for a collection of panels

I have no clue what is "Bringup panel". Is it technical term for some
type of panels?

> +  from different manufacturers which don't require backlight control from the
> +  driver and have a single reset pin which is required to be passed as an
> +  argument.

Drop "driver"

> +
> +maintainers:
> +  - Paulo Pavacic <pavacic.p@gmail.com>
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +

Drop blank line.

> +  compatible:
> +    enum:
> +      # compatible must be listed in alphabetical order, ordered by compatible.
> +      # The description in the comment is mandatory for each compatible.

Drop above comment.

> +
> +        # Fannal 480x800 panel
> +      - fannal,c3004
> +
> +  reg: true
> +  reset-gpios: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    //example on IMX8MM where GPIO pin 9 is used as a reset pin

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

I asked to drop the comment.

> +    mipi_dsi@32e10000 {

dsi {

There is no way it was correct in current form.

It does not look like you tested the bindings, at least after quick
look. Please run `make dt_binding_check` (see
Documentation/devicetree/bindings/writing-schema.rst for instructions).
Maybe you need to update your dtschema and yamllint.

> +        panel@0 {
> +            compatible = "fannal,c3004";
> +            reg = <0>;
> +            pinctrl-0 = <&pinctrl_mipi_dsi_rst>;
> +            pinctrl-names = "default";
> +            reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 82d39ab0231b..f962750f630a 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -462,6 +462,8 @@ patternProperties:
>      description: Facebook
>    "^fairphone,.*":
>      description: Fairphone B.V.
> +  "^fannal,.*":
> +    description: Fannal Electronics Co., Ltd
>    "^faraday,.*":
>      description: Faraday Technology Corporation
>    "^fastrax,.*":
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e0ad886d3163..46f988ee60bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6566,6 +6566,12 @@ T:    git git://anongit.freedesktop.org/drm/drm-misc
>  F:    Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
>  F:    drivers/gpu/drm/tiny/panel-mipi-dbi.c
> 
> +DRM DRIVER FOR MIPI DSI BRINGUP
> +M:    Paulo Pavacic <pavacic.p@gmail.com>
> +S:    Maintained
> +C:    mipi-dsi-bringup:matrix.org

Missing protocol. See explanation of C: entry at the beginning.

> +F:    Documentation/devicetree/bindings/display/panel/panel-mipi-dsi-bringup.yaml
> +
>  DRM DRIVER FOR MSM ADRENO GPU
>  M:    Rob Clark <robdclark@gmail.com>
>  M:    Abhinav Kumar <quic_abhinavk@quicinc.com>

Best regards,
Krzysztof

