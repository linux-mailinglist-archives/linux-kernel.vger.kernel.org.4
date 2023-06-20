Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D20F57371FC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjFTQp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjFTQp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:45:26 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF141A1;
        Tue, 20 Jun 2023 09:45:25 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-77e4126badcso50286339f.0;
        Tue, 20 Jun 2023 09:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687279524; x=1689871524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9XOGuLGXhqBdh/SPGk4WJ2DXvEFR2a4aPquV+OWA5g=;
        b=OxmprRRQyd3HJzPawBTuv1y4Fkfrn3m2LyfQ2Yqvq06HHx7Lt9tb8O2k2IVrLNzz7Z
         L4Dv/G7YrMyzGa0CWNXV7dlmQeW1dFPc3VuVj7iuP0lErxMzrZZMwXlNkhj2vqxld8+L
         Jr1arEjExhJ+VPOAd1fW/4CpYsp5Nbtex9NhPF3OMHVocxQ/qR6716KK3Uv6ZITDYR2Y
         VD6N3S+zZWiyO0i+oDXXQrJF/b+dIOjJA8yHPZVOkhBxbXSuhi0y3xG/jvbsVr9Jhwt9
         PRTpfeJ/pLx2xLvfSPSXwRcUX49Z6TwjAdIeVwu2QyMkSVKCNDP4MJEFGtjfWWWFbH2U
         uqYg==
X-Gm-Message-State: AC+VfDzUSyj8P7RUS2AafBWeD3WEU7hhJYWGS7S5wyz0sBNfQkMivJ6v
        sbcWi7gKpD559RymKBFkWw==
X-Google-Smtp-Source: ACHHUZ7D8Y2CvB+TmCsAsGGa5dmCvpvC+FiLFquXEXmAYWDArnioL54LLdgIM2g4KsD0NTN9IaLdiw==
X-Received: by 2002:a05:6e02:152d:b0:340:7bba:85b4 with SMTP id i13-20020a056e02152d00b003407bba85b4mr8982202ilu.8.1687279524383;
        Tue, 20 Jun 2023 09:45:24 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v2-20020a92c6c2000000b0033bc3a3ea39sm683618ilm.70.2023.06.20.09.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 09:45:23 -0700 (PDT)
Received: (nullmailer pid 3798817 invoked by uid 1000);
        Tue, 20 Jun 2023 16:45:21 -0000
Date:   Tue, 20 Jun 2023 10:45:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 02/13] ASoC: dt-bindings: simple-card: Add
 additional-devs subnode
Message-ID: <20230620164521.GA3789188-robh@kernel.org>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
 <20230615152631.224529-3-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615152631.224529-3-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 05:26:20PM +0200, Herve Codina wrote:
> The additional-devs subnode allows to declared some virtual devices
> as sound card children.
> These virtual devices can then be used by the sound card and so be
> present in the audio path.
> 
> The first virtual device supported is the audio IIO auxiliary device
> in order to support an IIO device as an audio auxiliary device.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/simple-card.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index b05e05c81cc4..59ac2d1d1ccf 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -148,6 +148,15 @@ definitions:
>      required:
>        - sound-dai
>  
> +  additional-devs:
> +    type: object
> +    description:
> +      Additional devices used by the simple audio card.
> +    patternProperties:
> +      '^iio-aux(-.+)?$':
> +        type: object
> +        $ref: audio-iio-aux.yaml#
> +
>  properties:
>    compatible:
>      contains:
> @@ -187,6 +196,8 @@ properties:
>      $ref: "#/definitions/mclk-fs"
>    simple-audio-card,aux-devs:
>      $ref: "#/definitions/aux-devs"
> +  simple-audio-card,additional-devs:
> +    $ref: "#/definitions/additional-devs"

Why do you need this under the card node? Can't you just use the 
existing aux-devs?

>    simple-audio-card,convert-rate:
>      $ref: "#/definitions/convert-rate"
>    simple-audio-card,convert-channels:
> @@ -359,6 +370,48 @@ examples:
>          };
>      };
>  
> +# --------------------
> +# route audio to/from a codec through an amplifier
> +# designed with a potentiometer driven by IIO:
> +# --------------------
> +  - |
> +    sound {
> +        compatible = "simple-audio-card";
> +
> +        simple-audio-card,aux-devs = <&amp_in>, <&amp_out>;
> +        simple-audio-card,routing =
> +            "CODEC LEFTIN", "AMP_IN LEFT OUT",
> +            "CODEC RIGHTIN", "AMP_IN RIGHT OUT",
> +            "AMP_OUT LEFT IN", "CODEC LEFTOUT",
> +            "AMP_OUT RIGHT IN", "CODEC RIGHTOUT";
> +
> +        simple-audio-card,additional-devs {
> +            amp_out: iio-aux-out {
> +                compatible = "audio-iio-aux";
> +                io-channels = <&pot_out 0>, <&pot_out 1>;
> +                io-channel-names = "LEFT", "RIGHT";
> +                snd-control-invert-range = <1 1>;
> +                sound-name-prefix = "AMP_OUT";
> +            };
> +
> +            amp_in: iio_aux-in {
> +                compatible = "audio-iio-aux";
> +                io-channels = <&pot_in 0>, <&pot_in 1>;
> +                io-channel-names = "LEFT", "RIGHT";
> +                sound-name-prefix = "AMP_IN";
> +            };
> +        };
> +
> +        simple-audio-card,cpu {
> +            sound-dai = <&cpu>;
> +        };
> +
> +        simple-audio-card,codec {
> +            sound-dai = <&codec>;
> +            clocks = <&clocks>;
> +        };
> +    };
> +
>  # --------------------
>  # Sampling Rate Conversion
>  # --------------------
> -- 
> 2.40.1
> 
