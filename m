Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B8862A34D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 21:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbiKOUrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 15:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiKOUrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 15:47:12 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A5C1EECB;
        Tue, 15 Nov 2022 12:47:10 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id j6so10566563qvn.12;
        Tue, 15 Nov 2022 12:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PaujosqZgD+9nGp4WpeQDZHeIobxvaj6k2xEkA643lA=;
        b=cNpiTovvYxnIu62xcsLWO7MOCS1BN+2DpsIfVyGOQ0urMTf+WGIGaG2E+/bCqn+q96
         6nK9Kjwf9u3cUob4sfwRLOLkIMPq6Kx5m4HvD+m91K+u1CxdOj5iaHSc3XFi8k7xZfs3
         piOUqngs3fMIW0hgDTdW7v4JnDQ6zsQzw8+/KMYmXBYAWFnP+ZRVlYydam91BXxVaNFY
         eo5sXqalIUroEjYQ+JDagfWszOQHdSC/CEixtYMAGRY83YYjnGnvDhmSF971YsCLlI+C
         XOJs6kW/OnzVozX8/DJZ2fJUo/5hgP6G80IVL/exrUwTcFgtswNEWIqx81yG1S7OBC7V
         OG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PaujosqZgD+9nGp4WpeQDZHeIobxvaj6k2xEkA643lA=;
        b=gW//87tSb/+X4bKzheHaY8umTs50Jsk/aX+wQRVm5bteti14touEzJ1ai0PX6p2Dh6
         vXRSVOr7MckR43M26v+VuUaOJ8wepe9qW53uDaeb78KNzgF931S10h2+uub7Bf8ncAzZ
         wwb+5RPv199u6GIu63Rz8aF6QpXqvytyPNbgv4kMFfiLyQPdTlK3XYy7XKddEb79rpFx
         MOpjJf6V41JUmR43nU8h+3/X6jcYrOyOhXwMljiKcvIKhF86H/MF/X7kLRas22TNrEZO
         k+bGfjGzmU/ErJOoMSbZEohH6nPpqwqhpkuhML5uoOlFiD2QcUKuU2s80PZHUeD8awly
         ZA7Q==
X-Gm-Message-State: ANoB5pmikSZnL/K1h4Uhe9XQblC81cV+HQpd4cVMDj09Au/MEU6oxMhn
        0Yqu+uAQ2itlQ2cO7mongwc=
X-Google-Smtp-Source: AA0mqf6GCIGJQX7d4EzAVBSYABUYg2W+QWtz3SM3EuliPORZQPJcLgTXuQLNKgbaA5//vMSAyOHF3A==
X-Received: by 2002:a0c:b35c:0:b0:4c6:5908:84f0 with SMTP id a28-20020a0cb35c000000b004c6590884f0mr4109481qvf.9.1668545229840;
        Tue, 15 Nov 2022 12:47:09 -0800 (PST)
Received: from [10.4.10.38] ([96.237.180.62])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a254800b006fa16fe93bbsm8810927qko.15.2022.11.15.12.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 12:47:09 -0800 (PST)
Message-ID: <92868186-4251-d37f-8cbc-69971dd0afb0@gmail.com>
Date:   Tue, 15 Nov 2022 15:47:08 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 4/4] ARM: dts: imx: prepend a 0 in the memory address
 to make it clear it's 32MB
Content-Language: en-US
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Bough Chen <haibo.chen@nxp.com>
References: <20221115193244.10484-1-giulio.benetti@benettiengineering.com>
 <20221115193244.10484-4-giulio.benetti@benettiengineering.com>
From:   Jesse Taube <mr.bossman075@gmail.com>
In-Reply-To: <20221115193244.10484-4-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/15/22 14:32, Giulio Benetti wrote:
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Again I'm not sure if this is necessary but I think there should be a 
commit description. Otherwise
Acked-by: Jesse Taube <mr.bossman075@gmail.com>
> ---
> V1->V2:
> * nothing done
> ---
>   arch/arm/boot/dts/imxrt1050-evk.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imxrt1050-evk.dts b/arch/arm/boot/dts/imxrt1050-evk.dts
> index 1d339f48899f..3de392d014fe 100644
> --- a/arch/arm/boot/dts/imxrt1050-evk.dts
> +++ b/arch/arm/boot/dts/imxrt1050-evk.dts
> @@ -28,7 +28,7 @@ aliases {
>   
>   	memory@80000000 {
>   		device_type = "memory";
> -		reg = <0x80000000 0x2000000>;
> +		reg = <0x80000000 0x02000000>;
>   	};
>   
>   	panel {
