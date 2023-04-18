Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559CA6E6E77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjDRVlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjDRVlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:41:18 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8EBCE;
        Tue, 18 Apr 2023 14:41:17 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-541b69cbe87so643688eaf.2;
        Tue, 18 Apr 2023 14:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681854077; x=1684446077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ElC7aqM0OYKhp7zqQxQuTXx1H9IDxJGXKnxZVOIROXA=;
        b=NmpIvhZRJp6raBg/mVkrpZFNcKaiWGplwGrgsH/mP6IxpaSZ+OKr+iOuW2TN1hLa8k
         IWQ9M0bvSEMzewk2lphtchRUQ7ScXF7RlL8ryiX2KtKA8k1nAh2HKp2hmwa+M8yV30wz
         I545LHecrHcUHmb9glbPVdVWbnIvvmyrm5INMDvxUfeDlhiXjHiYKw5PdOJiYUOU4HQ0
         unSCWacZ490peovOqPtD8tBa++0LJsJJmOpJffy1EO+OGYy3eSXs4F9co+jioc4f5y+F
         WJeq/OpvHjwFF2QbcIaeezzXPvaftE1k1hmyi+op5VJjAcLiKQjGxbRfB3KtsLaiupLN
         FMsw==
X-Gm-Message-State: AAQBX9fkEhS+qBjfBqosuiCeGNr9GeFPaI/ueMQai8A080ZZ4o3J+RdX
        wvGDiKWdbqtx6n0pBzUhrQ==
X-Google-Smtp-Source: AKy350Y/zUwTPUY+bloMxG86x5GIO5/WgZZJ0w2lgVcgHZEOKfFzsX6+0hRjmFOdov3MNztPcibQZw==
X-Received: by 2002:a05:6870:1702:b0:187:8f01:7107 with SMTP id h2-20020a056870170200b001878f017107mr2215193oae.44.1681854076847;
        Tue, 18 Apr 2023 14:41:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o19-20020a9d5c13000000b006a3f8f7b686sm6075534otk.28.2023.04.18.14.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:41:16 -0700 (PDT)
Received: (nullmailer pid 2378744 invoked by uid 1000);
        Tue, 18 Apr 2023 21:41:15 -0000
Date:   Tue, 18 Apr 2023 16:41:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        samuel@sholland.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-media@vger.kernel.org,
        hverkuil-cisco@xs4all.nl
Subject: Re: [PATCH 1/3] dt-bindings: display: synopsys,dw-hdmi: Add property
 for disabling CEC
Message-ID: <20230418214115.GA2376963-robh@kernel.org>
References: <20230415104613.61224-1-jernej.skrabec@gmail.com>
 <20230415104613.61224-2-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415104613.61224-2-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 12:46:11PM +0200, Jernej Skrabec wrote:
> Even though some DW-HDMI controllers have perfectly usable HDMI-CEC
> implementation, some boards might prefer not to use it or even use
> software implementation instead.
> 
> Add property for disabling CEC so driver doesn't expose unused CEC
> interface, if CEC pin isn't connected anywhere.

Isn't this all true for any bridge supporting CEC? Make this common.

> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> index 4b7e54a8f037..624d32c024f6 100644
> --- a/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/synopsys,dw-hdmi.yaml
> @@ -48,6 +48,11 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  snps,disable-cec:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Disable HDMI-CEC.
> +
>  additionalProperties: true
>  
>  ...
> -- 
> 2.40.0
> 
