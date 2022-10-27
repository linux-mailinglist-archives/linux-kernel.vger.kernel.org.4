Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1663F60F7E9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbiJ0Mss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiJ0Msq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:48:46 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0825A16DC14
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:48:45 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id x15so1147813qvp.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivr3WQ9zDX9Y22oat/ojEdcP2jI5Jp64wFrkCI45QPU=;
        b=X9+Dqqb+6eCq2gOlGFQdxBEM9fMVjIiMtkhbinWXMgvolMLdOEAZ0uhDT8nZLOuSJw
         y2/iEMvLvOsW7qfalSwQGdCtUXAoXilBM8hGiKGl2ykX/DvUEm7lURDB9/iZKV5RYFgU
         09mQ0X0ygNe4d2S9QaKbAoFjOBZDYDCLv8rWGOYzZhigpaJeXc0kYA7ab6CMBo88GYW1
         crqToUC6YK3UyhyEmQgvQhc5LLCWWuZXptSUxGtgc+Wij+HVrSvoHghx27RJ0a6owXb1
         5kIV6oGOSHeeRpnm74+qO3qMln5n2TpSgXYQFYaAPKQdRgoi4To/Y+dQosDl/L/dsmPf
         m2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivr3WQ9zDX9Y22oat/ojEdcP2jI5Jp64wFrkCI45QPU=;
        b=QCBKpHBWT+a+PRv6w8C7BRFsff2DisEMD8KVivvZ9RwuEwlxmFT67VY5M4RpA1TXDx
         b6YjRVb7T43jsk/zbewRFzJMBD9XZ6JJEcHO7BEjmSGQYukYWADdAa3oqqWqaoKb3ZK9
         VAv0omacrfDI1yooj60HZmc89MYHbs9Pezw2fi8TTmNGgbaTxJwuhlByJGdNs7ZRXlri
         6ih/9VQyRY4AoQL5l0GXjFU9vKd0nlZSKuXTboRTdTyOIJJ7M8PUqr5a+isKQWUVzMjL
         xmcZ/+j6jINcYtxxqetLMk3GfM0wI6RC2mCCo6NPqZEGcg/7OUVROiRfEAKXxmegGjLX
         JVYQ==
X-Gm-Message-State: ACrzQf0t7SxfB2ybQSQ+YoWXej89k6UU4/5zNMrGESJHAzgPHfWZ9gK3
        QlxyMzjw6FoQC2gS8diPM4+img==
X-Google-Smtp-Source: AMsMyM6NYajlewJo1rx9NQm0NgImM/f60WhI72FLmeO1JCXGB5Br56/FA9bm1X0JwH+22uADv73HRw==
X-Received: by 2002:a0c:979a:0:b0:4b7:4a8c:a80d with SMTP id l26-20020a0c979a000000b004b74a8ca80dmr34679342qvd.42.1666874924180;
        Thu, 27 Oct 2022 05:48:44 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u14-20020a05622a17ce00b0039bde72b14asm777902qtk.92.2022.10.27.05.48.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 05:48:43 -0700 (PDT)
Message-ID: <b353f6a2-57ab-0b70-e23e-77753fe6d767@linaro.org>
Date:   Thu, 27 Oct 2022 08:48:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [RFC net-next 2/2] net: dsa: Add driver for Maxlinear GSW1XX
 switch
Content-Language: en-US
To:     Camel Guo <camelg@axis.com>, Camel Guo <Camel.Guo@axis.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, kernel <kernel@axis.com>
References: <20221025135243.4038706-1-camel.guo@axis.com>
 <20221025135243.4038706-3-camel.guo@axis.com>
 <d942c724-4520-4a7b-8c36-704032c68a36@linaro.org>
 <55da4718-4422-745a-8880-95adc8e0abd9@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <55da4718-4422-745a-8880-95adc8e0abd9@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/10/2022 02:35, Camel Guo wrote:
utdown(priv->ds);
>  >> +
>  >> +     dev_set_drvdata(priv->dev, NULL);
>  >> +}
>  >> +EXPORT_SYMBOL(gsw1xx_shutdown);
>  >
>  > 1. EXPORT_SYMBOL_GPL
> 
> Will update in v2
> 
>  > 2. Why do you do it in the first place? It's one driver, no need for
>  > building two modules. Same applies to other places.
> 
> All stuff in drivers/net/dsa/gsw1xx_core.c is supposed to be generic and
> totally independent of the actual management interface (mdio, spi, uart,
> maybe memory-mapped IO). This way, I think the gsw1xx_core.ko can be 
> reused in
> gsw1xx_spi.ko, gsw1xx_uart.ko and so on.
> 
> I don't how similar the chips that lantiq_gswip.c supports are due to
> no datasheet. If not too much, maybe someone the gsw1xx_core.ko can also
> be reused in lantiq_gswip as well.

Keep the files separate but there is no need to make two modules and
exprt this. Your patch should stand on its own, not prepare for some
imaginary future work which might or might not bring more modules.

Once these future modules appear, it will be easy to change existing
file to a module.

Best regards,
Krzysztof

