Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE56745CE7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbjGCNMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjGCNMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:12:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CF01B5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 06:12:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3142a9ffa89so3333152f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 06:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688389930; x=1690981930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3C72+69VGn6Vh4PEX3kulCzL7RyUsSJTOHMj9jDZHN8=;
        b=uKaA9p0Ox2ovUpVrrVYgiLiawXF/eJHtDmw08cPCzgZCbB60Ie8INNvKUxBIAKmL3Y
         gJjymwQdcF7raXNSF8V6wRpvvBFTtLf7turtg9TU69p5lKeXMaD3Z6AKI9UYiwJRApAI
         IwHg9pDdFL6ENpVemuwnYsQ1q7YBVDw7d2I64puqIHBLNSMNvR3bY+KieueemlUZI4Wx
         VNwKAbld7p6chbwhedWQ/HFD3cmZG4DjjGBZ1UDZ5JQMWdmeF/kgXYKIpM3ZHIQHpGNk
         JalLPDuZ1BM6md6B3Gsm+P5SO/aD6zQVkMFh25wH0/768JWkKOd5sOlYeVUH5tPTISd3
         ABLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688389930; x=1690981930;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3C72+69VGn6Vh4PEX3kulCzL7RyUsSJTOHMj9jDZHN8=;
        b=HyuKeG3vnv8PNUvA58rLdYt3qMkmRd0iqLPJ+s+EfpymmsV5cWZ+7QD5g3Li7XQ/7a
         P4y2s/UZEjcXg1aboWDs4KgjHrc5zY0NhiC6OGPNYPAZ/2szg1hd/bqa0+OnABu+av6G
         BQPnNFHv3T8kfD9epjF/uYQywwBAt6WBKPVNIeXaEJg2s+xgdHR8KPmuwiyWocKSoIGZ
         7qZsrA4TCtKj4m3wHfe+mtZtJnWxg2SZFTduLxEEx6sQlh2+GCQQEfMaxnanCgkoddAw
         HwqayE81agdZ+AOYl2ZaugigFwoTM8KrP4xREoZqGD4GTuwmkxIArW378bPrGPtMyo1T
         GaZQ==
X-Gm-Message-State: ABy/qLahRywWV/n5GZKqCw0VyEOZORRO9GkM79TJbfBegvifUjo/Xt3k
        TbX7FFYAaKfDXAkxrFRY7nQvVw==
X-Google-Smtp-Source: APBJJlGzI2y08jEzmUxZusXD3XCrTA4WMsvMiPknAxeFAukczBsa/LAjJj2fSLhRTg7ATBgccqwsAQ==
X-Received: by 2002:adf:ee51:0:b0:313:fd52:af37 with SMTP id w17-20020adfee51000000b00313fd52af37mr10499400wro.4.1688389930317;
        Mon, 03 Jul 2023 06:12:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m16-20020a5d6250000000b003068f5cca8csm25443464wrv.94.2023.07.03.06.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 06:12:09 -0700 (PDT)
Message-ID: <d1cfb1fb-d347-16d8-4446-dddcf8200638@linaro.org>
Date:   Mon, 3 Jul 2023 15:12:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] dt-bindings: power: add Amlogic C3 power domains
To:     =Xianwei Zhao <xianwei.zhao@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
References: <20230703093142.2028500-1-xianwei.zhao@amlogic.com>
 <20230703093142.2028500-2-xianwei.zhao@amlogic.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230703093142.2028500-2-xianwei.zhao@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 11:31, =Xianwei Zhao wrote:
> From: Xianwei Zhao <xianwei.zhao@amlogic.com>
> 
> Add devicetree binding document and related header file for Amlogic C3 secure power domains.
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../power/amlogic,meson-sec-pwrc.yaml         |  3 ++-
>  include/dt-bindings/power/amlogic-c3-power.h  | 26 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/power/amlogic-c3-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> index eab21bb2050a..d80bbedfe3aa 100644
> --- a/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> +++ b/Documentation/devicetree/bindings/power/amlogic,meson-sec-pwrc.yaml
> @@ -12,7 +12,7 @@ maintainers:
>    - Jianxin Pan <jianxin.pan@amlogic.com>
>  
>  description: |+
> -  Secure Power Domains used in Meson A1/C1/S4 SoCs, and should be the child node
> +  Secure Power Domains used in Meson A1/C1/S4 & C3 SoCs, and should be the child node
>    of secure-monitor.
>  
>  properties:
> @@ -20,6 +20,7 @@ properties:
>      enum:
>        - amlogic,meson-a1-pwrc
>        - amlogic,meson-s4-pwrc
> +      - amlogic,c3-pwrc
>  
>    "#power-domain-cells":
>      const: 1
> diff --git a/include/dt-bindings/power/amlogic-c3-power.h b/include/dt-bindings/power/amlogic-c3-power.h
> new file mode 100644
> index 000000000000..3403e7c0b49d
> --- /dev/null
> +++ b/include/dt-bindings/power/amlogic-c3-power.h

Filename matching compatibles, please.

> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
> +/*
> + * Copyright (c) 2023 Amlogic, Inc.
> + * Author: hongyu chen1 <hongyu.chen1@amlogic.com>
> + */
> +#ifndef _DT_BINDINGS_AMLOGIC_C3_POWER_H
> +#define _DT_BINDINGS_AMLOGIC_C3_POWER_H
> +
> +#define PWRC_C3_NNA_ID				0
> +#define PWRC_C3_AUDIO_ID			1
> +#define PWRC_C3_RESV_SEC_ID			2
> +#define PWRC_C3_SDIOA_ID			3
> +#define PWRC_C3_EMMC_ID				4
> +#define PWRC_C3_USB_COMB_ID			5
> +#define PWRC_C3_SDCARD_ID			6
> +#define PWRC_C3_ETH_ID				7
> +#define PWRC_C3_RESV0_ID			8
> +#define PWRC_C3_GE2D_ID				9
> +#define PWRC_C3_CVE_ID				10
> +#define PWRC_C3_GDC_WRAP_ID			11
> +#define PWRC_C3_ISP_TOP_ID			12
> +#define PWRC_C3_MIPI_ISP_WRAP_ID		13
> +#define PWRC_C3_VCODEC_ID			14
> +
> +#endif
> +

No need for stray blank line.

Best regards,
Krzysztof

