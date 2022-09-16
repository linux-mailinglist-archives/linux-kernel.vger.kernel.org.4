Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3525BA9CB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 11:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbiIPJ5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 05:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiIPJ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 05:57:18 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D685A7A99
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:57:17 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id az24-20020a05600c601800b003a842e4983cso15553550wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 02:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=HlYqY84Q7JKlVo+hQMmDPSm91ffRg42QAGjY1100Eu0=;
        b=yEtG1W2GzV50LFm8GSSF5Hf42wJULL32v8P9v+hOTdrNNJLtN5pXVv7Z0/V6+o3/vG
         4ZXT62MseyDlB1eVHB/TcfiMNB6WNt5kiRpXMkXrcc8srKdm+5+D+V3NjVhePOY3zDxe
         k/Ts6sBEbtOuIAlkwoZx2Q2FZIEcun7wAoIL1NWD7xN/8yR+V8RoWNj08323hYUQ89qo
         iEHURAF34ycZKqAebrQbVewr7KK1xyopUxY1NFe97qRddDDuAipgZxfNOLz1Za2yz5UV
         sNLloJGt02V0pyrUptgUC7wT0BoYLyDgdTM6rQ5f1lijj3T2RsDnxYKvKJPXLjK86ajs
         Gc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=HlYqY84Q7JKlVo+hQMmDPSm91ffRg42QAGjY1100Eu0=;
        b=8BrwWT/QVQUsjeIrzwhzJSp1kvvpzFvKdjLfZc+/lQoR5rMt9KAzta7la9V+ACfIsY
         Yi4BssYqp/MuCdX7/AFIzUUBPf8+/5NM9tbpxK30uQt18033nG0wAYDPWQrUXuaNAMUq
         y593q72RJfjpn0TEXa5gy2eBqsyMbUA8xV8+YJcE6LPaiXrdcuruQorDk92keAyMTSFn
         WF1cEv90topuGwfgyzPUEpBTXYAr/2IhErIHC82fDbATv54BHS7LEnaNIANZZZpzqsQd
         SObQLds3iiXEDxFT7+DEESunfgQvIkRlQFI/KZ+WHJdAEH32uGDCoBCjyQusYFuw5Cvy
         zaPg==
X-Gm-Message-State: ACrzQf1cu7yZMHmwHr4WN5Cho6kDuuYTXKQUw0AKbKu+fJcMU3o4o2Da
        lBVGDnYh190FBKrpDeT1Vm6v5S0o6taJTQ==
X-Google-Smtp-Source: AMsMyM5G2n0ZJDFq3bH1CwUMEY6MkqX7AaCe/i+t7RXZ9xD236sOE2U0CcQbh42JHI337yNPeIxEaA==
X-Received: by 2002:a05:600c:35c8:b0:3b4:bf50:f844 with SMTP id r8-20020a05600c35c800b003b4bf50f844mr728986wmq.192.1663322235599;
        Fri, 16 Sep 2022 02:57:15 -0700 (PDT)
Received: from [192.168.86.238] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id h22-20020a05600c2cb600b003b4868eb71bsm1819055wmc.25.2022.09.16.02.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 02:57:14 -0700 (PDT)
Message-ID: <fd7cf2d0-b115-a13b-7056-0b96fc14b618@linaro.org>
Date:   Fri, 16 Sep 2022 10:57:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmem: u-boot-env: find Device Tree nodes for NVMEM cells
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Tom Rini <trini@konsulko.com>, Michael Walle <michael@walle.cc>,
        linux-arm-kernel@lists.infradead.org, u-boot@lists.denx.de,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20220915200629.10270-1-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220915200629.10270-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/09/2022 21:06, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> DT binding allows specifying NVMEM cells as NVMEM device (provider)
> subnodes. Looks for such subnodes when building NVMEM cells.
> 
> This allows NVMEM consumers to use U-Boot environment variables.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Applied thanks,

--srini
> ---
>   drivers/nvmem/u-boot-env.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
> index 9b9abfb8f187..d17a164ae705 100644
> --- a/drivers/nvmem/u-boot-env.c
> +++ b/drivers/nvmem/u-boot-env.c
> @@ -92,6 +92,7 @@ static int u_boot_env_add_cells(struct u_boot_env *priv, uint8_t *buf,
>   			return -ENOMEM;
>   		priv->cells[idx].offset = data_offset + value - data;
>   		priv->cells[idx].bytes = strlen(value);
> +		priv->cells[idx].np = of_get_child_by_name(dev->of_node, priv->cells[idx].name);
>   	}
>   
>   	if (WARN_ON(idx != priv->ncells))
