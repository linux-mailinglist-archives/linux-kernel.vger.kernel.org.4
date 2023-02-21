Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7210A69E3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 16:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjBUPmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 10:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbjBUPlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 10:41:46 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DC793EC;
        Tue, 21 Feb 2023 07:41:27 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id r34-20020a4a9665000000b0051abd9835d4so472034ooi.1;
        Tue, 21 Feb 2023 07:41:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yAmFGspOZMSPZfnaoWYmVR2MjZajqXp66cfwHSIQL14=;
        b=cKR6OCPXE1mHANDV7mSCN1O2DpE54R56M3ldb70/ej4Z6tmRe7bhfV2CsmBG1FzRtO
         2XqOypGCfT5mCs6obivqusneMqxxdqvYHT57MOypYXZHaf+xGiOz10aP9TjKWZIldTp0
         0pz8j4RSw2HAEQrzOH1PVFWFZ424yI90sMifKoISRK8sEe10PrHOSbQK8/Jx8U5JfE1D
         jOQv1+3If/vzUQjoTK5pQjMUOgNjZQa5l9Avzsw+dGs0G+EQo3i0C2TznoEy7p+TEuzQ
         W2CHmVAWRYJw8JO9D03t1fYmHoKPmKogshrNR2dtQtvAYhT37NXA99qYXg3fxmalxU3R
         1tJg==
X-Gm-Message-State: AO0yUKWKoNsdRymbG4K42OMu+aQMeJ2SpcwBEiUKqEOEb4JMwkpYjQa9
        41Xi2ZSHkXQcumkYxAQk1A==
X-Google-Smtp-Source: AK7set85VAFntiNHIDjGtfCC2oOT1/ixiwDzGmV6KZlRV3vcVPs11dYw0ZIvaGYFHStwN8BXxG0AZg==
X-Received: by 2002:a4a:b6c3:0:b0:51f:e966:e3b7 with SMTP id w3-20020a4ab6c3000000b0051fe966e3b7mr1792287ooo.3.1676994086229;
        Tue, 21 Feb 2023 07:41:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bf7-20020a056820174700b0051ff746e2b2sm293867oob.8.2023.02.21.07.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:41:25 -0800 (PST)
Received: (nullmailer pid 2586813 invoked by uid 1000);
        Tue, 21 Feb 2023 15:41:24 -0000
Date:   Tue, 21 Feb 2023 09:41:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pin-yen Lin <treapking@chromium.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: display: bridge: Add ddc-i2c-bus for
 anx7688
Message-ID: <20230221154124.GA2584323-robh@kernel.org>
References: <20230218111712.2380225-1-treapking@chromium.org>
 <20230218111712.2380225-2-treapking@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218111712.2380225-2-treapking@chromium.org>
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

On Sat, Feb 18, 2023 at 07:17:08PM +0800, Pin-yen Lin wrote:
> Introduce a optional "ddc-i2c-bus" property for anx7688 bridge. This
> allows the bridge to register a .get_edid callback.

What's .get_edid? This is a binding and is independent of Linux.

> 
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> ---
> 
> Changes in v3:
> - New in v3
> 
>  .../bindings/display/bridge/google,cros-ec-anx7688.yaml      | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
> index a44d025d33bd..9d5ce8172e88 100644
> --- a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
> @@ -25,6 +25,10 @@ properties:
>      maxItems: 1
>      description: I2C address of the device.
>  
> +  ddc-i2c-bus:
> +    description: phandle link to the I2C controller used for DDC EDID probing
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +

No, this belongs in the connector node. The DDC signals are routed to 
the connector, not the bridge chip.

Rob
