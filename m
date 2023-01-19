Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271AE673E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 17:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjASQSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 11:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjASQSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 11:18:02 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D9B87660;
        Thu, 19 Jan 2023 08:17:59 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id r132so2070051oif.10;
        Thu, 19 Jan 2023 08:17:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/53TQZW6r1zwjASQ4lZJdhbvckS1KV0aS6PofzSPkk=;
        b=WQRQnN6dkGnQf0lTCOwP1LKfmpaUil2fJPl5uu6rvHoOPGaXKEodSvcb8lTYxJqit+
         +MOfwo2e/rXinDey3Si7MdEBi9I8g+D0/e/Lz2cLX6oZ30quI5GKaBWhw6VXvPdV73XD
         hiAnaLduLQB/A+N/JXTAR9bc+akK0OsO0JScKRGrJVWl2YgML/qAWRpKCa183PwR4CQ0
         EVv/7+rRMG9zYLWc1MSMgXxbYWoMISGlkm8Eyw2Fws4ZCkoBA6eHS8eQ6Iv+OyAFohi2
         dGLUr9YKJK2JGdOXaC6bs7DXW5xB6IdbINTQiHEIPm+PhvV5JGaX9DaPiE4yksCwtv3M
         ideA==
X-Gm-Message-State: AFqh2kqAHwmHFU+azHBa2Gf5T4V8njCPWKPhX8HgGykP5joxSFeJd3Um
        KCOWDJslFFQVnFUPCqJwof0v/ocQYg==
X-Google-Smtp-Source: AMrXdXt1/e8p21lDMD81LUtAdmC9sW2dgNdOlCMjCvqrbAlT/E0IC+wziF1ov3qWxFpRUOB6UMdX6g==
X-Received: by 2002:aca:f2d7:0:b0:364:de8b:dddc with SMTP id q206-20020acaf2d7000000b00364de8bdddcmr3754167oih.29.1674145079100;
        Thu, 19 Jan 2023 08:17:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a9d3e0e000000b00670523bf1cfsm4203541otd.47.2023.01.19.08.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 08:17:58 -0800 (PST)
Received: (nullmailer pid 1976357 invoked by uid 1000);
        Thu, 19 Jan 2023 16:17:57 -0000
Date:   Thu, 19 Jan 2023 10:17:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        kernel@axis.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 4/4] ASoC: dt-bindings: simple-card: create jack for
 aux_devs
Message-ID: <20230119161757.GA1969308-robh@kernel.org>
References: <20230118125226.333214-1-astrid.rost@axis.com>
 <20230118125226.333214-5-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118125226.333214-5-astrid.rost@axis.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 01:52:26PM +0100, Astrid Rost wrote:
> Add simple-card,aux-jack-types:
> Array of snd_jack_type to create jack-input-event for jack devices in
> aux-devs. If the setting is 0, the supported type of the device is used.
> A device which has the functions set_jack and get_jack_supported_type
> counts as jack device.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  .../bindings/sound/simple-card.yaml           | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index ed19899bc94b..2635b1c04fc9 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -199,6 +199,13 @@ properties:
>      maxItems: 1
>    simple-audio-card,mic-det-gpio:
>      maxItems: 1
> +  simple-audio-card,aux-jack-types:

Drop 'simple-audio-card,'. That way we can reuse this for the 
not-simple cases.

I'm pretty sure we have some vendor specific properties for this 
already. Use those for inspiration and to create something which could 
replace them.

> +    $ref: "/schemas/types.yaml#/definitions/uint32-array"
> +    description: |
> +      Array of snd_jack_type to create jack-input-event for jack
> +      devices in aux-devs. If the setting is 0, the supported
> +      type of the device is used. A device which has the functions
> +      set_jack and get_jack_supported_type counts as jack device.

Sounds like Linux details. How does BSD use this property?

Rob
