Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36859611AF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ1Tfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJ1Tfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:35:42 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C297FFA6;
        Fri, 28 Oct 2022 12:35:41 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id r76so648077oie.13;
        Fri, 28 Oct 2022 12:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8taqJDtvUl86Drgh5fEgYjN4USVyEjdYeYqtilVVUAs=;
        b=euK7emXG2/v2gGUTzAiwXQOcrlFPmPnmY3tzG4ApAtyGNR2fJuSpwdvuhgW8zUrOAd
         SRdiWKt5T8O9P7XjwAOH91Sinn6UFW0Ow3QRASclauRYSrfRVV3VMSsXoGl4rsHjfbuw
         3SxliJyKYMqBMXEjGCeVUZvOEnF24395fJlbjnoyFd/R3y/46OeR4Qau1OFJbzQC00kY
         +eDvQduPgHvrVKFXqHFfCtnUWE1Q6KLlZ5aiWTBwYTn3Y32uKa4wyhjb4tM22Zg+bJul
         maSv8igrx3YOKTAtXdR0nGdIigkh8JhZOZFh7rdSuOkz+fJgIs88hfUKFuKdGzYeS/tF
         P81A==
X-Gm-Message-State: ACrzQf2PL08GON7GENFspWnLTMehHXOGeRX7gBG2ZW3LphRbJBXKqxRQ
        mn6sl3+yDU7+kmUrHOSo6HWd13iKAg==
X-Google-Smtp-Source: AMsMyM6Y9zExkyYtY64AW0IfA302F1WI9FzMoN/vCTIprGoOFxzrGGF1uk6seWK6mk7k3r4lw2QVxg==
X-Received: by 2002:a05:6808:d50:b0:355:4cd9:e6ca with SMTP id w16-20020a0568080d5000b003554cd9e6camr547665oik.160.1666985740445;
        Fri, 28 Oct 2022 12:35:40 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 111-20020a9d0878000000b006605883eae6sm1991047oty.63.2022.10.28.12.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:35:39 -0700 (PDT)
Received: (nullmailer pid 2188330 invoked by uid 1000);
        Fri, 28 Oct 2022 19:35:41 -0000
Date:   Fri, 28 Oct 2022 14:35:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: phy: Fix UniPhier USB3 controller node
 names in example
Message-ID: <20221028193541.GA2183248-robh@kernel.org>
References: <20221027044920.23194-1-hayashi.kunihiko@socionext.com>
 <20221027044920.23194-2-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027044920.23194-2-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:49:19PM +0900, Kunihiko Hayashi wrote:
> The word "glue" is ambiguous for the controller node name. Should put
> "usb-controller" instead of "usb-glue" on the controller node.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml  | 2 +-
>  .../devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> index 21e4414eea60..8ce57898fb96 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.yaml
> @@ -146,7 +146,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    usb-glue@65b00000 {
> +    usb-controller@65b00000 {
>          compatible = "socionext,uniphier-ld20-dwc3-glue", "simple-mfd";
>          #address-cells = <1>;
>          #size-cells = <1>;
> diff --git a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
> index 4c26d2d2303d..ba60b7add4f7 100644
> --- a/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.yaml
> @@ -131,7 +131,7 @@ additionalProperties: false
>  
>  examples:
>    - |
> -    usb-glue@65b00000 {
> +    usb-controller@65b00000 {
>          compatible = "socionext,uniphier-ld20-dwc3-glue",
>                       "simple-mfd";

This and a bunch of other Socionext compatibles in examples throw 
warnings because there is not a schema for them:

Documentation/devicetree/bindings/phy/socionext,uniphier-usb3ss-phy.example.dtb:0:0: /example-0/usb-controller@65b00000: failed to match any schema with compatible: ['socionext,uniphier-ld20-dwc3-glue', 'simple-mfd']
Documentation/devicetree/bindings/phy/socionext,uniphier-usb3hs-phy.example.dtb:0:0: /example-0/usb-controller@65b00000: failed to match any schema with compatible: ['socionext,uniphier-ld20-dwc3-glue', 'simple-mfd']


The remaining warnings are preventing turning the warning on by default, 
so fixing them would be nice.

Rob
