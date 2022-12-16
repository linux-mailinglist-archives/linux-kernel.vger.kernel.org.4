Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484D64EA2A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbiLPLUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiLPLT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:19:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C5913CF9;
        Fri, 16 Dec 2022 03:19:56 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id a17so995354wrt.11;
        Fri, 16 Dec 2022 03:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=heyMuzHz04KriYj72sAHJedD18+iTfhlMb4XPvSBspg=;
        b=PrqKoAa/RVDC8IMImj4wqKQxVWkq8wfzQa29ZFtEpLDU9FmIUYj3VwkcGJd4xAyt6L
         p1OMPIMyFJ8IPhtzPx+gLKIIwH1tdfcGlc8uO/bu1XyWXQdaZ4XRa7k7UYkxb8mnMCbu
         PpTXRVyi2xoTiUOPNsE5OAgI4gTozuMhfptawGg+a/6g3ojEmT2iQXrl2ELKje8Ea8PD
         jPugDooGQdPs4w7mp9qKcSXwZnik241zUG9WUm3mo2rKmc/seZxQd6IzHCD1pHfIP1h+
         ALgw5PldIQBOh4YFG3GRGC+WGqxbUrMe8rLDZL8tjgDUdxjYVM76w8OJDfR6ejpfyeOv
         lyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=heyMuzHz04KriYj72sAHJedD18+iTfhlMb4XPvSBspg=;
        b=FuUZQurbTrgtxWYiJWZmiN4+pOjV9YFlQFyNxxpR2lVT9MXzL0pAc4D1g6qN9tz2v3
         z/yuGQrVIYgnhdr5PE0aK6yZEB73Xw836LD6+4vbFWxxtXsTaNPTwerRbfp7i0MwkXhH
         FUD7Yp/eQFICGpKmKms1uPbiZqEspG4oHecRBgpriTYV7PeoAGqPw3q/1pQvocxNRJSr
         7+hkeAAiT6Ke1dX5xydMH3Q7spOd4Bz13Kv5b+16nv3p7McuPq7qrsppIlwgv/9b/j+1
         QVWCL966B83+k6BffHFSlgcoa75lZIQ0uIZo8oFIhRHVs76CgAQWPVSiWmCvXQEPQRJO
         ECAw==
X-Gm-Message-State: ANoB5pnjMOFNhHVaglzIKHaBsynaaMTDSwO5jfoNpRFM14fAx8YFcqRD
        hs0xDA+xaU2lxULkzLrDfVc=
X-Google-Smtp-Source: AA0mqf6qzujekHT6IZcXXelCTj2i4HPROM7svglyHpI3TSb5uzFdzhe0cPZAq932XfbYKkwkU9S+ZQ==
X-Received: by 2002:adf:ed05:0:b0:242:1ea7:2bba with SMTP id a5-20020adfed05000000b002421ea72bbamr20885675wro.49.1671189595136;
        Fri, 16 Dec 2022 03:19:55 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i13-20020adfefcd000000b0024216d2e386sm2102009wrp.16.2022.12.16.03.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 03:19:54 -0800 (PST)
Message-ID: <b0e5d510-9947-b54c-a8a9-c20555818bb1@gmail.com>
Date:   Fri, 16 Dec 2022 12:19:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v5 3/7] dt-bindings: mfd: syscon: Add mt8365-syscfg
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com
References: <20221213234346.2868828-1-bero@baylibre.com>
 <20221213234346.2868828-4-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221213234346.2868828-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2022 00:43, Bernhard Rosenkränzer wrote:
> Document Mediatek mt8365-syscfg
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 1b01bd0104316..7beeb0abc4db0 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -50,6 +50,7 @@ properties:
>                 - marvell,armada-3700-usb2-host-misc
>                 - mediatek,mt8135-pctl-a-syscfg
>                 - mediatek,mt8135-pctl-b-syscfg
> +              - mediatek,mt8365-syscfg
>                 - microchip,lan966x-cpu-syscon
>                 - microchip,sparx5-cpu-syscon
>                 - mstar,msc313-pmsleep
