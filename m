Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1DB7272A5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 01:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjFGXDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 19:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjFGXDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 19:03:21 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCEE11A;
        Wed,  7 Jun 2023 16:03:20 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-777ac791935so168662439f.2;
        Wed, 07 Jun 2023 16:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686179000; x=1688771000;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJmr8d4vIXjlqQuoPxUVCbEDrAJO2WI0A5hbY1xFW/M=;
        b=kXMrhL34QMF89+khf1u9l+LXp92L7z3HhRhRltTxsutnEcZNt5Fu9/XP3knE5xbrA5
         bZ5zcLfXWCplPjb2z+OY0XFTlUg7utAC0m6em9a6ZiGaiBwpnWFhG+tTV3MsOldmIZBe
         wqdXPLiLhlAU/nkL6kDNe580UipqH9SnIzz+4NBpGBqk5JD22UJpdrYWX8vup7Ha8fI3
         NCvC0+m/KC4Ol8dr/CChrbSuREhMUOFKOz6bH3Lq0xK19TY/UO/7z+hXn/F48cKQ+sSE
         hBQcXeNI/Pml2LWh4g2CRQMm5divklX/o6ArnXr6wyIXDkW6FAKsQHexF/dBbsR9qI2p
         R52w==
X-Gm-Message-State: AC+VfDxoy7ojdZ3gP5HTuQx/Olvj9g+PBUukBkt6ZL/IkfUtk4NCQiWL
        dcoyIjUnChvrcy7xS13c3g==
X-Google-Smtp-Source: ACHHUZ44anLflGzxROAwGHEtAG2uexfjuAvsT+mvkm2zNj8Yil495qpTVuBzwUiFga9s18d4NWvDVA==
X-Received: by 2002:a6b:e614:0:b0:760:f795:ccdf with SMTP id g20-20020a6be614000000b00760f795ccdfmr5743972ioh.8.1686179000100;
        Wed, 07 Jun 2023 16:03:20 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z25-20020a6b0a19000000b00760f256037dsm2289652ioi.44.2023.06.07.16.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 16:03:19 -0700 (PDT)
Received: (nullmailer pid 150871 invoked by uid 1000);
        Wed, 07 Jun 2023 23:03:15 -0000
Date:   Wed, 7 Jun 2023 17:03:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>
Cc:     Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, kernel@pengutronix.de,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/8] dt-bindings: can: m_can: add
 termination-{gpios,ohms} properties
Message-ID: <20230607230315.GA141591-robh@kernel.org>
References: <20230607115508.2964574-1-l.goehrs@pengutronix.de>
 <20230607115508.2964574-4-l.goehrs@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607115508.2964574-4-l.goehrs@pengutronix.de>
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

On Wed, Jun 07, 2023 at 01:55:03PM +0200, Leonard Göhrs wrote:
> The termination-gpios property allows specifying a GPIO pin that
> enables/disables a termination resistor on said CAN interface.
> The termination-ohms property specifies the resistance of said resistor.
> 
> Signed-off-by: Leonard Göhrs <l.goehrs@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 67879aab623b5..106c79fa560c3 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -118,6 +118,9 @@ properties:
>    phys:
>      maxItems: 1
>  
> +  termination-gpios: true
> +  termination-ohms: true

All you should need here is change additionalProperties to 
unevaluatedProperties as these are defined by can-controller.yaml.

> +
>  required:
>    - compatible
>    - reg
> -- 
> 2.39.2
> 
