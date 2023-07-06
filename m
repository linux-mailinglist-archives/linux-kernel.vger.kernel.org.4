Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF23974A431
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 21:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbjGFTIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 15:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGFTIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 15:08:14 -0400
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A9D1BDB;
        Thu,  6 Jul 2023 12:08:13 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-78625caa702so38391239f.1;
        Thu, 06 Jul 2023 12:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688670493; x=1691262493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDtpj3AemTprLuOeN9ET5glEPVq64dNxotKByZ/22z0=;
        b=PY6YMo3GcW1OrqNb53C/AAohmERf+EGJZXLBoSkhsljsPRGSuvq4EOEnZA/ji6vL7m
         FQTfaF26X2K2A2Ej3CQiMa0wJR6FREAjdMTBYo1I+kIbqE1dMJMsIX81uFvECyn2SuxX
         zDEn4FIhLub8i9t8B2UQjYwf/kOMCIUSTpYjvcEb2wRnraV8GwVb5Q86S4EfajGe5rim
         J36msV3MHqIO+58fv/NtCj7chgaE64NWPU6C4Z/kU0/+kbAjvZgwHf6j32UMfcp1WFTA
         tQmIovXLL2hDSxPkv+HtzoYXCztWVPaO2pi0iUvomYzsZNkyFst/NTw3GwGGP7pX6IwB
         wOOA==
X-Gm-Message-State: ABy/qLbDBDkyPxl0d+fZlV6AZTWYgEtb4Ut09+piqYBX9wqmGYqjxW1t
        4J1IfX/yj+bpdnLUbrCukQ==
X-Google-Smtp-Source: APBJJlGcC2tN7uRy5/zmvOcJRSvJfJhaWa5WsJUy45o9yDL4txQsVMEV32bENG8vzc4/KNKPEfz9xw==
X-Received: by 2002:a6b:760f:0:b0:786:26f0:3092 with SMTP id g15-20020a6b760f000000b0078626f03092mr2893375iom.3.1688670493131;
        Thu, 06 Jul 2023 12:08:13 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f8-20020a056602038800b00785ce1b3293sm690554iov.49.2023.07.06.12.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 12:08:12 -0700 (PDT)
Received: (nullmailer pid 163081 invoked by uid 1000);
        Thu, 06 Jul 2023 19:08:10 -0000
Date:   Thu, 6 Jul 2023 13:08:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: amlogic,meson-pinctrl-common:
 allow gpio-line-names
Message-ID: <20230706190810.GA161389-robh@kernel.org>
References: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-0-fa442d5aae91@linaro.org>
 <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-1-fa442d5aae91@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706-topic-amlogic-upstream-pinctrl-fix-bindings-v1-1-fa442d5aae91@linaro.org>
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

On Thu, Jul 06, 2023 at 09:42:26AM +0200, Neil Armstrong wrote:
> Allow gpio-line-names property for the gpio subnode.
> 
> Fixes: 94df03a45276 ("dt-bindings: pinctrl: Convert Amlogic Meson pinctrl binding")
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml        | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
> index a7b29ef0bab6..28659f0389a5 100644
> --- a/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/amlogic,meson-pinctrl-common.yaml
> @@ -34,6 +34,7 @@ $defs:
>  
>      properties:
>        gpio-controller: true
> +      gpio-line-names: true

There should be a range of number of entries.

>  
>        "#gpio-cells":
>          const: 2
> 
> -- 
> 2.34.1
> 
