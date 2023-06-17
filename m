Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D647342A6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 19:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbjFQRho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 13:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjFQRhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 13:37:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF8CF;
        Sat, 17 Jun 2023 10:37:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B5F5D60C36;
        Sat, 17 Jun 2023 17:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6103EC433C0;
        Sat, 17 Jun 2023 17:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687023460;
        bh=yjWqLCRuNvNrNClVvawWz5iSG0BNNGOBbd1yVAVgv2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gk6cX/rJ1Ri3cwZfCCTHAHjNyKUq1gbgys78oMyIELRnFGfeyX9pcMC1ImDIksVoD
         1K2QvyGUdwHS6OK9VUKdSsgnwJZTEiv3Wa/QFyEUf1CnA3J0curCqLE0EV13fbM+6S
         DDiO4qh6Ju9GoQ/8wbSd3yECsiSzgnrBmhukBE6AjqlYOEJRYQiLTqkxWKL7XdKPEF
         2KwZlk6NEZdbjc+o0vhvVIIVQTGX6lY4yfQJBh5XWQ/6B5jzyVtJ86vtBjo97nQXIj
         8KsLWD0oHiZxX+3f26gIMXOfzmdYTpkjIUQLy7FzWwbD42m2Mznh9fIUMMw9DgSVJG
         hSgpQYQsnHTRw==
Date:   Sat, 17 Jun 2023 18:37:31 +0100
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
Subject: Re: [PATCH v5 01/13] ASoC: dt-bindings: Add audio-iio-aux
Message-ID: <20230617183731.31e9b3c4@jic23-huawei>
In-Reply-To: <20230615152631.224529-2-herve.codina@bootlin.com>
References: <20230615152631.224529-1-herve.codina@bootlin.com>
        <20230615152631.224529-2-herve.codina@bootlin.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 17:26:19 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Industrial I/O devices can be present in the audio path.
> These devices needs to be viewed as audio components in order to be
> fully integrated in the audio path.
> 
> audio-iio-aux allows to consider these Industrial I/O devices as
> auxliary audio devices.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  .../bindings/sound/audio-iio-aux.yaml         | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml b/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
> new file mode 100644
> index 000000000000..d3cc1ea4a175
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/audio-iio-aux.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/audio-iio-aux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Audio IIO auxiliary
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description:
> +  Auxiliary device based on Industrial I/O device channels
> +
> +allOf:
> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: audio-iio-aux
> +
> +  io-channels:
> +    description:
> +      Industrial I/O device channels used
> +
> +  io-channel-names:
> +    description:
> +      Industrial I/O channel names related to io-channels.
> +      These names are used to provides sound controls, widgets and routes names.
> +
> +  snd-control-invert-range:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description: |
> +      A list of 0/1 flags defining whether or not the related channel is
> +      inverted
> +    items:
> +      enum: [0, 1]
> +      default: 0
> +      description: |
> +        Invert the sound control value compared to the IIO channel raw value.
> +          - 1: The related sound control value is inverted meaning that the
> +               minimum sound control value correspond to the maximum IIO channel
> +               raw value and the maximum sound control value correspond to the
> +               minimum IIO channel raw value.
> +          - 0: The related sound control value is not inverted meaning that the
> +               minimum (resp maximum) sound control value correspond to the
> +               minimum (resp maximum) IIO channel raw value.
> +
> +required:
> +  - compatible
> +  - io-channels
> +  - io-channel-names
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    iio-aux {
> +        compatible = "audio-iio-aux";
> +        io-channels = <&iio 0>, <&iio 1>, <&iio 2>, <&iio 3>;
> +        io-channel-names = "CH0", "CH1", "CH2", "CH3";
> +        /* Invert CH1 and CH2 */
> +        snd-control-invert-range = <0 1 1 0>;
> +    };

