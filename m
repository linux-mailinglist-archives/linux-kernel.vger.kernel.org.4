Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081A85E939E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 16:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIYOaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbiIYOaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 10:30:00 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1C51263B;
        Sun, 25 Sep 2022 07:29:58 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c24so4142599plo.3;
        Sun, 25 Sep 2022 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=S+RG48s6FUDV6ht8+uEPounXKq0zz4a5qSA3BCzY9/s=;
        b=Z8oM4e5yvwolyodjE+2ZaOJU4oCx5kRhyeK5mpQ1IRZJBOnl3Q9nvI/hIMHQutd9fK
         JelLd1nqilb/oodLNB/BysY9917uylXLTjnpG8Qz+NcxwMUkLnH37P0GW3RgKNES2gsK
         hCaeFjL6Z75c4QybcZDg0FWqddBhztKA8xY3eQ6Fb58etHejHyuSVkVaXvUYVR+JJ2X/
         e+aJOCnTYBd0y5aSmzcIgADK6DW0bSBCLTFAIsQFc54FnYxQ9Yz9wc4Y03FSlTqGjuQ2
         7UxiEZ/T1uzwqIFV04PUWYGPZZrZIPaEaPi/qeqfTmi8fcOJVY+lyt34CCYSUknPtIyu
         yAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=S+RG48s6FUDV6ht8+uEPounXKq0zz4a5qSA3BCzY9/s=;
        b=sOnjC8gXgfN78aeRLHh9/jnUj2cjpOIZwcMdN1tOMq48b1Jb+W0Pl0nYOGY2gATG30
         QqQDcY5ZM9sMPH/uyooSrx5+avJrrFz40GJ4KuP6Z1qDm9NCmKmpaNc7ah4itlv9tJFQ
         qTqTF1CwL81rww3qs263EVO8v4iaj2VO9MimZQDLNPU+fl5vuTEs/qTUleU/Rn+liiL0
         J/uUbHX7rwk+6hQHxjHpbS6Kz6SUP7nvyYsmm7HrcE/GsAw4iGfUf39tlE8wPDE5vin8
         qpWzzSzg9mS15XOyvPNmFl8DszxJtA8cLt8Rfy0bmWVirMWXFbqUmOlb1WvW/VZYJoN9
         noRw==
X-Gm-Message-State: ACrzQf1bkozum+kvPnnNq+ViRWTHDaAN81hps/nBUkHracp6b/e9UyMn
        hJNgfnY2C0aGon7k8jbE3LA=
X-Google-Smtp-Source: AMsMyM4jnAWWNhRBQGingmImuc9rZoK/O2f6RUTBMEtjTKbkR7ytzXKfiOzEpFgwZLz0Z2TGrxXOPg==
X-Received: by 2002:a17:902:d484:b0:178:1b69:1488 with SMTP id c4-20020a170902d48400b001781b691488mr17594111plg.156.1664116197924;
        Sun, 25 Sep 2022 07:29:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z10-20020a1709027e8a00b00176dee43e0dsm9300538pla.285.2022.09.25.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 07:29:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 07:29:54 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: watchdog: toshiba,visconti-wdt: Update
 the common clock properties
Message-ID: <20220925142954.GA1752068@roeck-us.net>
References: <20220525004605.2128727-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525004605.2128727-1-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 09:46:05AM +0900, Nobuhiro Iwamatsu wrote:
> The clock for this driver switched to the common clock controller driver.
> Therefore, update common clock properties for watchdog in the binding document.
> And this matched this example with the actual dts.
> 
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
>  v3: doesn't remove timeout-sec.
>  v2: send to linux-watchdog.
> 
>  .../bindings/watchdog/toshiba,visconti-wdt.yaml      | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
> index 690e19ce4b87..eba083822d1f 100644
> --- a/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/toshiba,visconti-wdt.yaml
> @@ -35,20 +35,16 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/clock/toshiba,tmpv770x.h>
> +
>      soc {
>          #address-cells = <2>;
>          #size-cells = <2>;
>  
> -        wdt_clk: wdt-clk {
> -            compatible = "fixed-clock";
> -            clock-frequency = <150000000>;
> -            #clock-cells = <0>;
> -        };
> -
> -        watchdog@28330000 {
> +        wdt: watchdog@28330000 {
>              compatible = "toshiba,visconti-wdt";
>              reg = <0 0x28330000 0 0x1000>;
> -            clocks = <&wdt_clk>;
>              timeout-sec = <20>;
> +            clocks = <&pismu TMPV770X_CLK_WDTCLK>;
>          };
>      };
