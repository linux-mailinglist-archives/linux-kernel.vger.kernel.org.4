Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63F36678A66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 23:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjAWWKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 17:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjAWWKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 17:10:53 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C90532E70;
        Mon, 23 Jan 2023 14:10:33 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id n8so11744038oih.0;
        Mon, 23 Jan 2023 14:10:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+oBU6QhiMJWJA5PyjPdZyGxoFfBGQTI7dLnT9GRQYQ=;
        b=5/9Cvg9bhKvGgMml0P9Stg2oC+wXlSfjht7blAXdkmwyX4w0a7rCPB/3g1QMwp4ONI
         OS8+r8k/7wmoql+e5M9oyLdzEpTH9sJHYVOOPCtM0ZGdOVa8YeKlP6AubALJ492Kjd8W
         p23cy2O9KXTe8PGN3JrZ0/gPYYDPqAd34Uq72P0BGZRv3JXabHVBLf0Tg6D0DV2hy/0z
         TreeqGEIp/y+YuTo1S+P+7a60sTYeQtF79yu4r/raybDVv/ZTHMeQwbF+PFq+6ODCbhf
         vjVKArmfadWmmsb8I5/No4FNIuVYO/ClLW6Xy09Pk4okkrgjh0C3tR/keL8B8v6MKPFD
         tosw==
X-Gm-Message-State: AFqh2koT33WnF4ePrDW7rahp6/iJpa9WFbKSThlQcLLdVghraE84YibI
        3J9BnPwHJN+tN5bjmvrRJA==
X-Google-Smtp-Source: AMrXdXuvsZxGtJD0l6UXaq6gtyP+fr1yafFDygzbhBdWeEIl1O6lOPBYCXkauU3R3RjEhpDssOuYPw==
X-Received: by 2002:a54:4810:0:b0:35e:2d5c:6114 with SMTP id j16-20020a544810000000b0035e2d5c6114mr12298293oij.25.1674511769870;
        Mon, 23 Jan 2023 14:09:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t10-20020a9d728a000000b006706cd202b0sm209190otj.11.2023.01.23.14.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 14:09:29 -0800 (PST)
Received: (nullmailer pid 2726293 invoked by uid 1000);
        Mon, 23 Jan 2023 22:09:28 -0000
Date:   Mon, 23 Jan 2023 16:09:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dylan Reid <dgreid@chromium.org>, kernel@axis.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ASoC: dt-bindings: ti,ts3a227e.yaml: add jack-type
Message-ID: <20230123220928.GA2720169-robh@kernel.org>
References: <20230120102555.1523394-1-astrid.rost@axis.com>
 <20230120102555.1523394-5-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120102555.1523394-5-astrid.rost@axis.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 11:25:54AM +0100, Astrid Rost wrote:
> Add jack-type: Bitmap value of snd_jack_type to allow combining
> card drivers to create a jack for it.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> index 785930658029..1d949b805f98 100644
> --- a/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> +++ b/Documentation/devicetree/bindings/sound/ti,ts3a227e.yaml
> @@ -27,6 +27,14 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  jack-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Bitmap value of snd_jack_type to allow combining

snd_jack_type? Is that a Linux thing? Bindings are independent of Linux.

> +      card drivers to create a jack for it. Supported is
> +        1 SND_JACK_HEADPHONE
> +        2 SND_JACK_MICROPHONE
> +    default: 3

I'm pretty sure jack properties are more complicated than just headphone 
and/or microphone. There's buttons which are detected in differing ways.

Rob
