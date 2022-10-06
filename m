Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194705F66FB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiJFMz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 08:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiJFMzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 08:55:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26D8CE05;
        Thu,  6 Oct 2022 05:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8D963CE1691;
        Thu,  6 Oct 2022 12:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D174BC43145;
        Thu,  6 Oct 2022 12:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665060857;
        bh=MsIFn/B1+08rEbLiGduxeXGRhxZBa1pWHKmWKGsKPmw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HjKhW+QmffhhWWlm6qsN4Uz81lr19nxM/HJdG4wEwq9L9XPaX0J1su1KEdDq5zX+H
         jacDe1k2Jy9HTQTm01rhLr7k9z2kwwBcBGt44UQDYGfLTA97W4C44qlc3jpNPCoWZh
         UGbkop6EcgE13ItegzofWa3I06I+hIw0LBCMlH33lVJh+I/5m1tXviTau8LDsl1JmN
         vOIcsXa0JJXK8w1E5YhF3m0/eX53oT7l2+ouFSGmlonsKXcxx1rlRXR4LnVJIqY9Pd
         Ic1lBDcP2KQtNep343ytuBnfWaKHAbvHaNS7uiXmrkjTi1sMvz9km42+Vdt+kc8fIz
         Z2kzXwqZInzsg==
Received: by mail-vk1-f172.google.com with SMTP id k14so775445vkk.0;
        Thu, 06 Oct 2022 05:54:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf0Q6XSr3jvdH+SOTVFAr4FxQ0XLhfWqiZp5W1ibh+q4laxW/RZe
        /BSrCm+ekC/lsu6eHPT2bgIsLEvs1JFFqnUHXQ==
X-Google-Smtp-Source: AMsMyM5YQNA460THnTExkzg+jr8ivd5DgaPTjt3P6pRYVuUbdtP71PS4b31kGlnH8wJCcBae3wbGM0+goQ7pfoEgZas=
X-Received: by 2002:a1f:3285:0:b0:3a9:ebd7:db97 with SMTP id
 y127-20020a1f3285000000b003a9ebd7db97mr2401790vky.14.1665060856647; Thu, 06
 Oct 2022 05:54:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221006020444.15823-1-allen.chen@ite.com.tw> <20221006020444.15823-2-allen.chen@ite.com.tw>
In-Reply-To: <20221006020444.15823-2-allen.chen@ite.com.tw>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 6 Oct 2022 07:54:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJvwi5wL9_POvPcQASXDzrcw0CQ2T7Xig0hCHjiSaQ7Tw@mail.gmail.com>
Message-ID: <CAL_JsqJvwi5wL9_POvPcQASXDzrcw0CQ2T7Xig0hCHjiSaQ7Tw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 5, 2022 at 9:05 PM allen <allen.chen@ite.com.tw> wrote:
>
> From: allen chen <allen.chen@ite.com.tw>
>
> Add properties to restrict dp output data-lanes and clock.
>
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>
> ---
>  .../bindings/display/bridge/ite,it6505.yaml          | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> index 833d11b2303a..f5482a614d05 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ite,it6505.yaml
> @@ -52,6 +52,16 @@ properties:
>      maxItems: 1
>      description: extcon specifier for the Power Delivery
>
> +  ite,dp-output-data-lane-count:
> +    description: restrict the dp output data-lanes with value of 1-4
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [ 1, 2, 4 ]

We have a standard property for lanes: data-lanes

It goes in the endpoint.

> +
> +  ite,dp-output-max-pixel-clock-mhz:
> +    description: restrict max pixel clock
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 150

Also have a common property for this: 'link-frequencies'
