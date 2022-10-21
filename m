Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9446608172
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 00:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiJUWXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 18:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJUWXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 18:23:39 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44EE1989B1;
        Fri, 21 Oct 2022 15:23:38 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id t4-20020a9d7f84000000b00661c3d864f9so2627607otp.10;
        Fri, 21 Oct 2022 15:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHszIOTWUTJP89iQhIQJQcS5anPEr/u81IUhAbne1c0=;
        b=nYG4B5ikiFB5fxaPRWt+jZ29ivrlmTVECFYjQR0EL7T8PVi4SW1U+4MEgXIDk9JOCm
         Wkr4vXI4TTpv0ztO5zMou3vwePSJnt+LYx55OIM/2LifNZ62LNmAeOE5T1xijrN+lFg7
         /Nkvx35Ra7UkrcIishLpvzMHEpHZqFsR+ENQcS79WP1+ex+6zdA2QiNEkZERaFoqDa/u
         HUAW6RL/GthdQKADHy86P3Bah56zYbfe5Er6SjE/WFtKetHZTkQheWunQvqgYv6fcsM8
         kvntM2WkvQTmX85ZKINkDnto7QPswLQ8s6ZIKYKa7/LkZBivjdm4dzkjChTIk/4r0u+z
         RPVA==
X-Gm-Message-State: ACrzQf1lxxI+hd+IEc/QOmqJQI2t0g/xAes8L+/Z1ghV2T0rheVAAvYj
        4S9ekNoH6AOcDLVr9+AQ7w==
X-Google-Smtp-Source: AMsMyM7gWaTAPjU/J6G3PGYBWNZixVoh21QdQ6tuN4esEuPLJDcHyZ9RDpCEZ9GvgreWkUsX+2JKFQ==
X-Received: by 2002:a05:6830:9ca:b0:661:2ba:9b69 with SMTP id y10-20020a05683009ca00b0066102ba9b69mr10851745ott.240.1666391018007;
        Fri, 21 Oct 2022 15:23:38 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n22-20020a9d64d6000000b006618eb616dbsm1627548otl.8.2022.10.21.15.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 15:23:37 -0700 (PDT)
Received: (nullmailer pid 567525 invoked by uid 1000);
        Fri, 21 Oct 2022 22:23:38 -0000
Date:   Fri, 21 Oct 2022 17:23:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-pwm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Frank Wunderlich <frank-w@public-files.de>
Subject: Re: [PATCH 2/2] dt-bindings: pwm: mediatek: Add compatible string
 for MT7986
Message-ID: <20221021222338.GA565200-robh@kernel.org>
References: <Y1K53n7LnjoMoIfj@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1K53n7LnjoMoIfj@makrotopia.org>
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

On Fri, Oct 21, 2022 at 04:25:18PM +0100, Daniel Golle wrote:
> Add new compatible string for MT7986 PWM.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  Documentation/devicetree/bindings/pwm/pwm-mediatek.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> index 554c96b6d0c3e0..6f4e60c9e18b81 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt
> @@ -8,6 +8,7 @@ Required properties:
>     - "mediatek,mt7623-pwm": found on mt7623 SoC.
>     - "mediatek,mt7628-pwm": found on mt7628 SoC.
>     - "mediatek,mt7629-pwm": found on mt7629 SoC.
> +   - "mediatek,mt7986-pwm": found on mt7986 SoC.

This version of the PWM h/w is not compatible with any of the existing 
chips? If it is, it should have a fallback compatible.

>     - "mediatek,mt8183-pwm": found on mt8183 SoC.
>     - "mediatek,mt8195-pwm", "mediatek,mt8183-pwm": found on mt8195 SoC.
>     - "mediatek,mt8365-pwm": found on mt8365 SoC.
> -- 
> 2.38.1
> 
> 
