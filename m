Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08446616C7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjAHQkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbjAHQkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:40:47 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0C8E031;
        Sun,  8 Jan 2023 08:40:45 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id y4so3490449iof.0;
        Sun, 08 Jan 2023 08:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMq5mdx2/8Hut7F0lg9JoCdClaBGqd57bfF0gzLs3yI=;
        b=HoBNh/hdK1IMye2htyitHPpeXgZ94cEgBtr9VMwq7uDPFo0RYAPKgJ6V+HM25U93qZ
         Q5L1WTf64QfNPAzqvks8FfVxtsWWlBxgdtxWW/YlXh8nJxGBs7KdBntjRR8RePdfHA7B
         YnTwX4GZYtzbXqdf6SqLbel9yx41mIe1LsXbXHzj7Obx8FBnFD11GrhZPQGBtavYMcLj
         7EJJW79y8kuDppYJQzJcrpbK/emJ9FbPdUPsloPwH5MJByNIzM15f1BPofs4TlSdrU/S
         1Cd2SNcdwPSN+qRsE7vFTpZ79BoY7fchz9egYaAmHCP7RvKvUhqqrU8czw36i5xALd7J
         ZHeA==
X-Gm-Message-State: AFqh2kpRVFlhPFFaOGNjVOuSo+PgG6y/uSi+i0kQhYRk6gFBd6WqPlo0
        e+r4CvR3ZsR2XKSdpGRBLw==
X-Google-Smtp-Source: AMrXdXuo7awWg54JHoOGJwYFs1h+7TeEUm5MOri76QszWjSsTaOmcA1T6oeiQ6FYnodqWwD2Z2i/Dg==
X-Received: by 2002:a6b:d210:0:b0:6de:3e2c:d791 with SMTP id q16-20020a6bd210000000b006de3e2cd791mr38939062iob.1.1673196045155;
        Sun, 08 Jan 2023 08:40:45 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
        by smtp.gmail.com with ESMTPSA id w20-20020a05663800d400b00375783003fcsm2025633jao.136.2023.01.08.08.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 08:40:44 -0800 (PST)
Received: (nullmailer pid 36866 invoked by uid 1000);
        Sun, 08 Jan 2023 16:37:41 -0000
Date:   Sun, 8 Jan 2023 10:37:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Faiz Abbas <faiz.abbas@arm.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        kuninori.morimoto.gx@renesas.com, Anurag.Koul@arm.com,
        Deepak.Pandey@arm.com
Subject: Re: [PATCH] ASoC: dt-bindings: simple-card: Document
 simple-audio-card,plat
Message-ID: <20230108163741.GA30997-robh@kernel.org>
References: <20230105160346.29018-1-faiz.abbas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105160346.29018-1-faiz.abbas@arm.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 09:33:46PM +0530, Faiz Abbas wrote:
> The simple card driver has support for adding cpu, codec and platform
> nodes with the simple-audio-card prefix. Add documentation for the plat
> binding.

Another node, is it still 'simple card'?

> 
> Signed-off-by: Faiz Abbas <faiz.abbas@arm.com>
> ---
>  .../bindings/sound/simple-card.yaml           | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index ed19899bc94b..fa67c76d4dbb 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -205,6 +205,8 @@ patternProperties:
>      $ref: "#/definitions/dai"
>    "^simple-audio-card,codec(@[0-9a-f]+)?$":
>      $ref: "#/definitions/dai"
> +  "^simple-audio-card,plat(@[0-9a-f]+)?$":

What does 'plat' mean?

Don't continue the 'simple-audio-card,' prefix.

> +    $ref: "#/definitions/dai"
>  
>    "^simple-audio-card,dai-link(@[0-9a-f]+)?$":
>      description: |
> @@ -285,6 +287,27 @@ examples:
>          };
>      };
>  
> +#-------------------------------
> +# single DAI link with platform
> +#-------------------------------

Really need another example for 1 simple node?

> + - |
> +   sound {
> +        compatible = "simple-audio-card";
> +        simple-audio-card,format = "i2s";
> +        simple-audio-card,mclk-fs = <384>;
> +        simple-audio-card,cpu {
> +                sound-dai = <&iofpga_i2s>;
> +        };
> +
> +        simple-audio-card,codec {
> +                sound-dai = <&hdmi_tx>;
> +        };
> +
> +        simple-audio-card,plat {
> +                sound-dai = <&audio_formatter>;
> +        };
> +};
> +
>  #--------------------
>  # Multi DAI links
>  #--------------------
> -- 
> 2.25.1
> 
> 
