Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82435EBD42
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiI0IaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbiI0IaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:30:02 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818A313F90
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:30:01 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id ay7-20020a05600c1e0700b003b49861bf48so608287wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 01:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date;
        bh=BqKb1MOod0APhgvKJiJsziZsDmx0K0c2qqX6KClwNl8=;
        b=gkskCLvsNhU6rPJILVg60kgxjOUQpR6Hq/kMdiieQiqU2RQewtzbgTYSi+OveKmK8Q
         eM84vagUMNZ/sleHwlRfAdyuTdmeMuhgkvwyh3z5m5gz9ntzcEhWYr+MQ3Je4RdTcuf/
         1vIfY61AWydZ1iGHmuNqsSgPbnyCtRXCzPfaPZTdxskoA4H97hlz2WRbWtd0BD8XB6Fs
         TI2RFhAH7Z8dcG4Osv+jgN0vElu30KR/yVBm5+pgyxUrTtR0tGQZmVrWNF+rcXzyrxyH
         q0n2hY1hhIIqYnOA5Ijitb0W/SrK/O1LxvkZKDyXNldW1H/Q7XCRdWTLFcVZvc4SI4/A
         t+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=BqKb1MOod0APhgvKJiJsziZsDmx0K0c2qqX6KClwNl8=;
        b=WkMqKdekBI9UG/5qO/nrZLStkUBi5VBUnkoLIfaPjv/QPtz2rXUOd22l028ahLIsl9
         3wLFEzJVGDAsxf1wRMid4gjRAA1YsDJ9QEWz+p2Venzz513SOi3f+QwLcOmoLs271XFu
         t1uj0H5lyNsNd1maBoTqVo7sCW6pyfHJUpP82oGTYL2AnMdJDCpcQfukC4BO5Wu6pn+E
         k5YWe4OV2ylqRHiEa+R2QeSE5sHkMhFzi/eG2nRBfjH1Ke6tgYOruMa42JVBcnCUTjRY
         aM3o3vXIfVjTbSVnNqsFwWVMsy7J2EOgO/Ytb3erAOL3lh/9SZuoZCdu0qtmJmgU/w4+
         XD/w==
X-Gm-Message-State: ACrzQf2cgIQD7YqxVBS7yNtfgpC7WYF3cWhGrbcRSauqmu1VanpbeS1L
        Npl8iVBh/p2yleWeswenc4MfSA==
X-Google-Smtp-Source: AMsMyM53efqUnk+cvJ0VgUzsAEsKx6Zwf42B1WU+5vDB7OJ8sHKF6wCrHgxbsKqn5+krOU2a/JQB1w==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr1733578wmb.146.1664267400042;
        Tue, 27 Sep 2022 01:30:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b771:c77b:f889:9833? ([2a01:e0a:982:cbb0:b771:c77b:f889:9833])
        by smtp.gmail.com with ESMTPSA id i1-20020adfa501000000b0022a2f4fa042sm1118461wrb.103.2022.09.27.01.29.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 01:29:59 -0700 (PDT)
Message-ID: <f9bf3f7e-e949-3e77-a74c-74c0eecd77c0@linaro.org>
Date:   Tue, 27 Sep 2022 10:29:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] spi: dt-bindings: amlogic, meson-gx-spicc: Add
 pinctrl names for SPI signal states
Content-Language: en-US
To:     Amjad Ouled-Ameur <aouledameur@baylibre.com>, broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        narmstrong@baylibre.com, Da Xue <da@libre.computer>
References: <20220809172017.215412-1-aouledameur@baylibre.com>
 <20220809172017.215412-2-aouledameur@baylibre.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20220809172017.215412-2-aouledameur@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/08/2022 19:20, Amjad Ouled-Ameur wrote:
> SPI pins of the SPICC Controller in Meson-GX needs to be controlled by
> pin biais when idle. Therefore define three pinctrl names:
> - default: SPI pins are controlled by spi function.
> - idle-high: SCLK pin is pulled-up, but MOSI/MISO are still controlled
> by spi function.
> - idle-low: SCLK pin is pulled-down, but MOSI/MISO are still controlled
> by spi function.
> 
> Reported-by: Da Xue <da@libre.computer>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>

Don't forget to CC devicetree@vger.kernel.org otherwise it won't be reviewed.

> ---
>   .../bindings/spi/amlogic,meson-gx-spicc.yaml      | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> index 50de0da42c13..10707a8216f5 100644
> --- a/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> +++ b/Documentation/devicetree/bindings/spi/amlogic,meson-gx-spicc.yaml
> @@ -43,6 +43,14 @@ properties:
>       minItems: 1
>       maxItems: 2
>   
> +  pinctrl-0:
> +    minItems: 1
> +
> +  pinctrl-1:
> +    maxItems: 1
> +
> +  pinctrl-names: true
> +
>   if:
>     properties:
>       compatible:
> @@ -69,6 +77,13 @@ else:
>         items:
>           - const: core
>   
> +    pinctrl-names:
> +      minItems: 1
> +      items:
> +        - const: default
> +        - const: idle-high
> +        - const: idle-low
> +
>   required:
>     - compatible
>     - reg
