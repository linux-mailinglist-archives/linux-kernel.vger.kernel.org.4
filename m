Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E5B6E6DF9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjDRVVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDRVVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:21:01 -0400
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9ED40C7;
        Tue, 18 Apr 2023 14:21:00 -0700 (PDT)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-38e12d973bfso551898b6e.0;
        Tue, 18 Apr 2023 14:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681852860; x=1684444860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WgwKd7P9qrzMTpu2fy50tBPL0/0q3LqzdG1B04wyE0o=;
        b=L3OuSpzsJ1681ne9oa8SWMU8iqzFPKDbjqtL7Ye4Irj6jkPm/kLQKK8rAPwOaT0+oI
         zJp9CwVVsnYhytnf89YA8Cnoi0rqreHW/gW9V71wphBQmNt3PNeCb7+1sw0tHbWni3PE
         SRXLrLRJgb/To9f23x3aw/svOTPgMWSMrA74kEPw2Qxr1UBTufzOOR3rQzFJSMiJFv8j
         2mnjv+CzTc/K8q5K7gJwrY98OHHQ5qjZg+7jx1DqEKnJw+ImPtYq8V8KLk46+22EBWIT
         cjAPvCkkAEq9D2XHxQrRHd5Lel9CIPobsgpxfQ8ZLS8Tyy6FoUfF98Id8TTBXZREl0E7
         /cwQ==
X-Gm-Message-State: AAQBX9dl83SGFmD5yE56fY9+qNbaEmvA1nfAnNjDJ+xVhaNRpMj7Phft
        K8Wz1mCWVE9W/B1SRuX7OA==
X-Google-Smtp-Source: AKy350a7SEgsQ2r6iAUhm0CDPasiv1xJKKONwc7jtSSrwcfYr146T+Oa94O7gZPoSAEMLOgZsuQczQ==
X-Received: by 2002:a05:6808:302c:b0:38c:570f:8c83 with SMTP id ay44-20020a056808302c00b0038c570f8c83mr1710779oib.15.1681852859983;
        Tue, 18 Apr 2023 14:20:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k206-20020acabad7000000b0038934c5b400sm6279161oif.25.2023.04.18.14.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 14:20:59 -0700 (PDT)
Received: (nullmailer pid 2356240 invoked by uid 1000);
        Tue, 18 Apr 2023 21:20:58 -0000
Date:   Tue, 18 Apr 2023 16:20:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johannes Zink <j.zink@pengutronix.de>
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@gmail.com,
        daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1/2] dt-bindings: display: simple: support non-default
 data-mapping
Message-ID: <20230418212058.GA2351633-robh@kernel.org>
References: <20230414161116.3673911-1-j.zink@pengutronix.de>
 <20230414161116.3673911-2-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414161116.3673911-2-j.zink@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 06:11:15PM +0200, Johannes Zink wrote:
> Some Displays support more than just a single default lvds data mapping,
> which can be used to run displays on only 3 LVDS lanes in the jeida-18
> data-mapping mode.
> 
> Add an optional data-mapping property, analogously to panel-lvds, to
> allow overriding the default data mapping.
> 
> Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
> ---
>  .../bindings/display/panel/panel-simple.yaml  | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> index 18241f4051d2..6e219f67dd67 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> @@ -349,6 +349,57 @@ properties:
>    power-supply: true
>    no-hpd: true
>    hpd-gpios: true
> +  data-mapping:
> +    enum:
> +      - jeida-18
> +      - jeida-24
> +      - vesa-24
> +    description: |
> +      The color signals mapping order.
> +
> +      LVDS data mappings are defined as follows.
> +
> +      - "jeida-18" - 18-bit data mapping compatible with the [JEIDA], [LDI] and
> +        [VESA] specifications. Data are transferred as follows on 3 LVDS lanes.
> +
> +      Slot          0       1       2       3       4       5       6
> +                ________________                         _________________
> +      Clock                     \_______________________/
> +                  ______  ______  ______  ______  ______  ______  ______
> +      DATA0     ><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
> +      DATA1     ><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
> +      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
> +
> +      - "jeida-24" - 24-bit data mapping compatible with the [DSIM] and [LDI]
> +        specifications. Data are transferred as follows on 4 LVDS lanes.
> +
> +      Slot          0       1       2       3       4       5       6
> +                ________________                         _________________
> +      Clock                     \_______________________/
> +                  ______  ______  ______  ______  ______  ______  ______
> +      DATA0     ><__G2__><__R7__><__R6__><__R5__><__R4__><__R3__><__R2__><
> +      DATA1     ><__B3__><__B2__><__G7__><__G6__><__G5__><__G4__><__G3__><
> +      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B7__><__B6__><__B5__><__B4__><
> +      DATA3     ><_CTL3_><__B1__><__B0__><__G1__><__G0__><__R1__><__R0__><
> +
> +      - "vesa-24" - 24-bit data mapping compatible with the [VESA] specification.
> +        Data are transferred as follows on 4 LVDS lanes.
> +
> +      Slot          0       1       2       3       4       5       6
> +                ________________                         _________________
> +      Clock                     \_______________________/
> +                  ______  ______  ______  ______  ______  ______  ______
> +      DATA0     ><__G0__><__R5__><__R4__><__R3__><__R2__><__R1__><__R0__><
> +      DATA1     ><__B1__><__B0__><__G5__><__G4__><__G3__><__G2__><__G1__><
> +      DATA2     ><_CTL2_><_CTL1_><_CTL0_><__B5__><__B4__><__B3__><__B2__><
> +      DATA3     ><_CTL3_><__B7__><__B6__><__G7__><__G6__><__R7__><__R6__><
> +
> +      Control signals are mapped as follows.
> +
> +      CTL0: HSync
> +      CTL1: VSync
> +      CTL2: Data Enable
> +      CTL3: 0

Why do you duplicate what's in display/lvds.yaml?

This also just made 'data-mapping' valid on non-LVDS panels.

Rob
