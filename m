Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E166EE6B6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234700AbjDYRaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbjDYRad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:30:33 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9C75BBA;
        Tue, 25 Apr 2023 10:30:32 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-549d9c295dfso1132541eaf.2;
        Tue, 25 Apr 2023 10:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682443831; x=1685035831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kx2MBexI4IdwwU3HpEq9VlXt44gc2MaIIVYzDB9fIV4=;
        b=AiliSyTg6nIo/kjAS7JyEfIFAxQx5OP69OvrF/lHoicVsFxHrJ3MTfNr6pNE6YaPib
         6Qt3GL776p8K20uVJAPDosy4HYR/ZBKKNRG9mEYsdyraWurdZo4p2P3rktJl8RC09/0w
         qu/AAV2fFMje8Z3pDev8I5hSd7MSb3fC5fm6lt5cPS7VtJTVUFj+6Iq5MbR8VjyFe4PZ
         Jj3nkM6MghSZV/WWEW/hqFn5WJb1hn+A2aNX+xpM4w9CNZ2WOYLmPHeMzQ+g7scn1mXM
         IkBLo1rhxcWd2KrlGhkcEUdp5AgK8hAdSHgRE9uwIzXy+VRqdLSDman0/adrwUALisdu
         1EPQ==
X-Gm-Message-State: AAQBX9dZv60rKG+eziQgVTxZGYMNLxiy7nvCYrUiUW5LI0Y+v8de5BmM
        lcQM2zdgADFZ7wJHMAPEPtltYizOeQ==
X-Google-Smtp-Source: AKy350YWtCrrLr3UM/3y9aq2ToOzHzoeNJ5TSClKRGZBXj25jO0yAiVnnnhvDs1DjJXnxt3FzDRMHw==
X-Received: by 2002:a4a:e058:0:b0:545:62bf:fd6c with SMTP id v24-20020a4ae058000000b0054562bffd6cmr6727843oos.0.1682443831133;
        Tue, 25 Apr 2023 10:30:31 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m41-20020a4a952c000000b005251e3f92ecsm6259455ooi.47.2023.04.25.10.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 10:30:30 -0700 (PDT)
Received: (nullmailer pid 1984548 invoked by uid 1000);
        Tue, 25 Apr 2023 17:30:29 -0000
Date:   Tue, 25 Apr 2023 12:30:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 1/4] dt-bindings: sound: Add simple-iio-aux
Message-ID: <20230425173029.GA1967523-robh@kernel.org>
References: <20230421124122.324820-1-herve.codina@bootlin.com>
 <20230421124122.324820-2-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421124122.324820-2-herve.codina@bootlin.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 02:41:19PM +0200, Herve Codina wrote:
> Industrial I/O devices can be present in the audio path.
> These devices needs to be viewed as audio components in order to be
> fully integrated in the audio path.
> 
> simple-iio-aux allows to consider these Industrial I/O devices as
> auxliary audio devices.

What makes it simple? Any binding called simple or generic is a trigger 
for me. Best to avoid those terms. :)

Examples of devices would be useful here.

> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../bindings/sound/simple-iio-aux.yaml        | 65 +++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml b/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
> new file mode 100644
> index 000000000000..fab128fce4fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-iio-aux.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/simple-iio-aux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple IIO auxiliary
> +
> +maintainers:
> +  - Herve Codina <herve.codina@bootlin.com>
> +
> +description: |

Don't need '|'

> +  Auxiliary device based on Industrial I/O device channels
> +
> +allOf:
> +  - $ref: /schemas/iio/iio-consumer.yaml

You don't need to reference consumer schemas.

> +  - $ref: dai-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: simple-iio-aux
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
> +  invert:

Property names should globally only have 1 type definition. This is 
generic enough I'd be concerned that's not the case.

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
> +    aux {
> +        compatible = "simple-iio-aux";
> +        io-channels = <&iio 0>, <&iio 1>, <&iio 2>, <&iio 3>;
> +        io-channel-names = "CH0", "CH1", "CH2", "CH3";

Not really useful names. Do you have a real example?

> +        /* Invert CH1 and CH2 */
> +        invert = <0 1 1>;

IMO, invert should be same length as io-channels.

> +    };

How do support multiple instances? Say you have 2 sound cards (or 1 
sound card with multiple audio paths) each with different sets of IIO 
channels associated with it. You'd need a link to each 'aux' node. Why 
not just add io-channels to the sound card nodes directly? That's 
already just a virtual, top-level container node grouping all the 
components. I don't see why we need another virtual node grouping a 
subset of them.

Rob
