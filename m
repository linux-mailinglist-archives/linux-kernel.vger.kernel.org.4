Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539BC68A499
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 22:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjBCVVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 16:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232000AbjBCVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 16:21:12 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1ACA77A4;
        Fri,  3 Feb 2023 13:21:09 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id k15-20020a4adfaf000000b00517450f9bd7so628342ook.8;
        Fri, 03 Feb 2023 13:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMhMQmdUl9gckLUzvzW8A50HIsIXzsHpIFKgcHehl5k=;
        b=W9hWsT8ExbZe0zw+c+OxMjkJMaxZIy8rPBE6fbd0VOyTKWuvA9Z5/NkAtQouRnqDBg
         KKTChqoopWJoOsKtJAmuroIUjggklfHBTamcpdmf0giIZSsziX5LoV63o0mEBo/nnhiY
         V7NjVxwLY+6Oj6L9ZPCYxWd/kula1WhWV6Rs8lWSfliuhGyZt8rImgzTmaf0NOtT/NKH
         Mbz0yFd2SlU7/fFv2RoRujeAOPP7ZuDfmWMqaLYVWOY0jMyV6wTCKbSW4i21h6Oiz4Cm
         QQK1X+2ryzUAoXak/d2NN8oekviZtbPJS1lRoqS5F3+BojPXF+ZcQ6DlXKa0mELCXn8y
         dDrw==
X-Gm-Message-State: AO0yUKVkPX3p9IR1u0Cd0rquYKEIME4bg9pCgPMsvASIOHrVXgmbYcyW
        ianjdhszsrVbXB4BNSv4MA==
X-Google-Smtp-Source: AK7set+GQrrIHjUaM8J3NUGSjAawldUTArob6rqZbL/5/Z1vYaPLauP8g3Duo8z80Uxzw/lCYYg8kQ==
X-Received: by 2002:a4a:d9c2:0:b0:517:bde1:252 with SMTP id l2-20020a4ad9c2000000b00517bde10252mr5497908oou.4.1675459267911;
        Fri, 03 Feb 2023 13:21:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h13-20020a4aa28d000000b004fd878ef510sm1418818ool.21.2023.02.03.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Feb 2023 13:21:07 -0800 (PST)
Received: (nullmailer pid 908098 invoked by uid 1000);
        Fri, 03 Feb 2023 21:21:06 -0000
Date:   Fri, 3 Feb 2023 15:21:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manuel Traut <manuel.traut@mt.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: input: pwm-beeper: add volume
Message-ID: <20230203212106.GA893293-robh@kernel.org>
References: <d4c1da7b-5b49-6bbf-4470-b3f2eef7f745@linaro.org>
 <20230201171025.965276-1-manuel.traut@mt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230201171025.965276-1-manuel.traut@mt.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 01, 2023 at 06:10:25PM +0100, Manuel Traut wrote:
> Add an array of supported volume levels and a default volume level.

Don't send a single updated patch in a series. It breaks tools and 
workflows.

> 
> Signed-off-by: Manuel Traut <manuel.traut@mt.com>
> ---
>  .../devicetree/bindings/input/pwm-beeper.yaml      | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/pwm-beeper.yaml b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> index 1ebc3a46d934..7ea2954cdd6a 100644
> --- a/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> +++ b/Documentation/devicetree/bindings/input/pwm-beeper.yaml
> @@ -25,6 +25,18 @@ properties:
>    beeper-hz:
>      description: bell frequency in Hz
>  
> +  volume-levels-bp: 
> +    description: >
> +      Please note that the actual volume of most beepers is
> +      highly non-linear, which means that low volume levels
> +      are probably somewhere in the range of 10 to 300 (0.1-3%
> +      duty cycle).

This tells me nothing in terms of how to use this property. The index of 
the array is the volume level and the value is the PWM duty cycle?

> +    maximum: 5000

As this is an array, 'maximum' for the array doesn't make sense. It's a 
max for each entry:

items:
  maximum: 5000


> +
> +  default-volume-level-bp:
> +    description: >
> +      The default volume level.
> +
>  required:
>    - compatible
>    - pwms
> @@ -36,4 +48,6 @@ examples:
>      beeper {
>        compatible = "pwm-beeper";
>        pwms = <&pwm0>;
> +      volume-levels-bp = <0 80 200 400 5000>;
> +      default-volume-level-bp = <80>;
>      };
> -- 
> 2.39.1
> 
