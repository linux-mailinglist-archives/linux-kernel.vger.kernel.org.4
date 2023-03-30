Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF446D0C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjC3RUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjC3RUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:20:43 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF1ED52B;
        Thu, 30 Mar 2023 10:20:41 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n19so11400610wms.0;
        Thu, 30 Mar 2023 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680196840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pLS5bdQOQb5HnWHfDHbDpW+ENKv/YseqZteHlVYBypQ=;
        b=AZBi+ryfecgYJD+FtgtywoyUuQVbsUoV3IEc1c55WE7gvbK1Xz3M1p+nm8Jwlc2f53
         IkKQDLt7oPDlHQw04DhKMvSzBYq0Z1qY7kvh0TVeIGLblF7D47AU33ttiPcb606pvB+A
         L7YnI0ajjTlfR1hg8vj7oB+aaBrfWmqPfnzoJWCcvGU1gzPG85aLOPptNk5fWj4wNdtT
         zUaMf01FHLR7lE7rvJc2NEX0U02eEpEvYn8M/cIBvI9g3RzTQR7WbE8oU7dkXGDv3EIq
         N0g5T3chPIyPeoczkoK7hVlCPTNoBMmLAYTWGD+pvFs+8EHn0YFKlati60AOu06wjXra
         w9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pLS5bdQOQb5HnWHfDHbDpW+ENKv/YseqZteHlVYBypQ=;
        b=ydCLpWjz6IwKKK8601oNrZPuRbTh38a/j70keNUfRG69of3cLzD6n5tsPGQuEDVwuX
         JlRwBiuchZADtGhzG/2Pr5/7u1ooj5/l36DWlojW2NkguRcXmhCCU6DbWIcQWQJRGqNo
         x/9DoFhteL3mm34zN4B7GKdEU6NX2/i5eD/jMWejDPWWpVoJ6AY4bNnB1O5ctQDwbLn+
         Tit/zs8BhQsH5rrcJjnyzAJfqkC2bOOtk2TKd9LRpaNtS7JCfzFZILzM0a8deiT++Fp8
         yGBSO0b72sk1dyfAsnCywpCNHop32gSAckm2VUFkFwpyUiPztz1m57URNKwaZ90gUVCI
         BlCg==
X-Gm-Message-State: AO0yUKXhgx92R2cuEmmAxQOV6WNqYMmWGF8zFSTG4fz0GoJmdYi7s3aZ
        IHXCV40/sYUTuk51vt9WzJg=
X-Google-Smtp-Source: AK7set+YwD5gWoY1BrGbOORNpDOIrzSXxF3uUn/NGsz2zN8/nEXjjGcxWc+D6uKyOcosJZ/zcAsPaw==
X-Received: by 2002:a1c:ed0e:0:b0:3dc:55d9:ec8 with SMTP id l14-20020a1ced0e000000b003dc55d90ec8mr17291285wmh.41.1680196840183;
        Thu, 30 Mar 2023 10:20:40 -0700 (PDT)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b003ed246c1d28sm6363722wmr.44.2023.03.30.10.20.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 10:20:39 -0700 (PDT)
Message-ID: <dcacbef3-43e2-090f-1493-be40b1e9cd22@gmail.com>
Date:   Thu, 30 Mar 2023 19:20:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 03/17] arm64: dts: mediatek: Increase the size BL31
 reserved memory
Content-Language: en-US
To:     amergnat@baylibre.com, Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>
References: <20230203-evk-board-support-v3-0-0003e80e0095@baylibre.com>
 <20230203-evk-board-support-v3-3-0003e80e0095@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230203-evk-board-support-v3-3-0003e80e0095@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/2023 10:54, amergnat@baylibre.com wrote:
> From: Alexandre Bailon <abailon@baylibre.com>
> 
> The reserved size for BL31 is too small.
> This has been highlighted by the MPU that now restrict access to BL31
> memory to secure world only.
> This increase the size of the reserved memory.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Applied, thanks!

> ---
>   arch/arm64/boot/dts/mediatek/mt8365-evk.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> index b68aee8f229f..fc7f6d8ae173 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8365-evk.dts
> @@ -65,10 +65,10 @@ reserved-memory {
>   		#size-cells = <2>;
>   		ranges;
>   
> -		/* 128 KiB reserved for ARM Trusted Firmware (BL31) */
> +		/* 192 KiB reserved for ARM Trusted Firmware (BL31) */
>   		bl31_secmon_reserved: secmon@43000000 {
>   			no-map;
> -			reg = <0 0x43000000 0 0x20000>;
> +			reg = <0 0x43000000 0 0x30000>;
>   		};
>   
>   		/* 12 MiB reserved for OP-TEE (BL32)
> 
