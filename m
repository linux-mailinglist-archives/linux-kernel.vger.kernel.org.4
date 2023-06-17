Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8CAB7342AE
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbjFQRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFQRjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:39:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E113C1BDF;
        Sat, 17 Jun 2023 10:39:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78BBD6125F;
        Sat, 17 Jun 2023 17:39:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFD5C433C0;
        Sat, 17 Jun 2023 17:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687023582;
        bh=PojzvkhFGso2oFGP3uveYEqnxdHTa1uQXua16K3xhkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=l4SKCwL4R96I3XzB3D1Vjv3+FXmFQKHQPQY9k0otaA0a89GAdCn5HguiljZAwpv4r
         HTTlmUmB1VaZi1gRKZ34Fm7nLw/o4hxZr0aPm0TggWh09GnhhbGW6QoYUdzQlAwHLE
         Yn/BUTJ+WpTJFFrphpYJ7rCG13xuvrXhxFjmunmwJ3Vu1UrADW+q3DjzwH20cYiTQc
         ZuNqNrTTjCShCdDDTAfngaaDsu1g9XlFb3fzO6bLpAuXKL5hrarrPaDI1epOBaV5Rs
         6Qosz1mFLBwPIlNRoujoAXcI2Yuh5S+Z5tyzjnAq5/Ab+WgkHLE4C+RUHLgmXsAcjq
         KnhM0t8cMEB5Q==
Date:   Sat, 17 Jun 2023 18:39:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
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
Message-ID: <20230617183932.43122069@jic23-huawei>
In-Reply-To: <20230615152631.224529-3-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-3-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 17:26:20 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> The additional-devs subnode allows to declared some virtual devices
> as sound card children.
> These virtual devices can then be used by the sound card and so be
> present in the audio path.
> 
> The first virtual device supported is the audio IIO auxiliary device
> in order to support an IIO device as an audio auxiliary device.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Looks fine to me, but given it's not an area I know that much about
(other than the iio consumer bits) take that with a pinch of salt.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

