Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8E4A6BDB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 22:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjCPV5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 17:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjCPV5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 17:57:39 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB260A95;
        Thu, 16 Mar 2023 14:57:38 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id g6so1451087iov.13;
        Thu, 16 Mar 2023 14:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679003857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCX8Q0KiFWBenYq33JmGKJRfWkS+jFykJMHbbG7dBoQ=;
        b=cIJ48kvpSVdmLMZodfgcDjQW7a8TB9rAZBEw8EqL9yunVoSsF3qKdv4AyM0gYpeEid
         +k7hr574e2ZEDhr6Sp3eNKetU8XXnyXxI6D2E6xCaMBpQErdkykwYNvMxHEueiNoUqR9
         sGDt9iWIdH864NaYcErn5jhIbfLcX4Jel4tD8rxUj6FvjkdbTFJSmtr/zJxSIXXO2bGr
         tByXrT1Dio/jMVudjhunB4GQSbwZ5slq6JebI+u2GUu5n7X7JG+aeNYyyx5yhCK9lwjP
         zYxy5YIftk0juwuM3lx2GKCBmwVyBI2l0c2EpPHV5j3r09C+jND/5ttz+52rm1Rqj1c0
         gMWw==
X-Gm-Message-State: AO0yUKX43X7EkP+nEy21aHdlNcRPj2GhHOLFi3zL2UxLUX7yp9B5pc9U
        yQ8mBZPSlhSa973JaD6KjQ==
X-Google-Smtp-Source: AK7set/1ioEGwLLlKvF20+unEkGcnCNWjn2iYIU36TopHqxFzHe7QejHEg/KOrCEWBF56csPo4ShDQ==
X-Received: by 2002:a6b:5b12:0:b0:745:4726:b228 with SMTP id v18-20020a6b5b12000000b007454726b228mr335948ioh.17.1679003857572;
        Thu, 16 Mar 2023 14:57:37 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id x3-20020a056638248300b003ee9720740esm121887jat.153.2023.03.16.14.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 14:57:37 -0700 (PDT)
Received: (nullmailer pid 3948932 invoked by uid 1000);
        Thu, 16 Mar 2023 21:57:35 -0000
Date:   Thu, 16 Mar 2023 16:57:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH 7/7] dt-bindings: display: add panel-timing property to
 sitronix,st7789v
Message-ID: <20230316215735.GA3940832-robh@kernel.org>
References: <20230314115644.3775169-1-gerald.loacker@wolfvision.net>
 <20230314115644.3775169-8-gerald.loacker@wolfvision.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314115644.3775169-8-gerald.loacker@wolfvision.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 12:56:44PM +0100, Gerald Loacker wrote:
> The sitronix-st7789v driver now considers the panel-timing property.

I read the patch for that and still don't know 'why'. Commit messages 
should answer why.

> Add the property to the documentation.

We generally don't put timings in DT for panels. Why is this one 
special?

> 
> Signed-off-by: Gerald Loacker <gerald.loacker@wolfvision.net>
> ---
>  .../display/panel/sitronix,st7789v.yaml         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> index ed942cd3620f..8810f123dedf 100644
> --- a/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/sitronix,st7789v.yaml
> @@ -21,6 +21,7 @@ properties:
>    reset-gpios: true
>    power-supply: true
>    backlight: true
> +  panel-timing: true
>    port: true
>    rotation: true
>  
> @@ -54,6 +55,22 @@ examples:
>              spi-cpol;
>              spi-cpha;
>  
> +            panel-timing {
> +                clock-frequency = <7000000>;
> +                hactive = <240>;
> +                vactive = <320>;
> +                hfront-porch = <38>;
> +                hback-porch = <10>;
> +                hsync-len = <10>;
> +                vfront-porch = <8>;
> +                vback-porch = <4>;
> +                vsync-len = <4>;
> +                hsync-active = <1>;
> +                vsync-active = <1>;
> +                de-active = <1>;
> +                pixelclk-active = <1>;
> +            };
> +
>              port {
>                  panel_input: endpoint {
>                      remote-endpoint = <&tcon0_out_panel>;
> -- 
> 2.37.2
> 
