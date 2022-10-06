Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CECE5F6358
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbiJFJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbiJFJJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:09:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D0DFF4;
        Thu,  6 Oct 2022 02:09:48 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a26so3146503ejc.4;
        Thu, 06 Oct 2022 02:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:from:to:cc:subject:date;
        bh=ODcrbPcnMCSSoamca2F6ZuB3LHikG1Oo3r1FOts8V4c=;
        b=O6ITMpBkGQ1urboVjRkxd8KYLN9uP+y0IIo/cf4zzrLKl7P1Bqn7CdvLWwKcC3M/5Y
         Id4wtwCKPPPKMG3GZQfgIJpdg5gHWhctohHKrrkb64+gtFljcykZgas12/8BhRW0ZjRV
         Ilnp/IphwEy/7gy88QQqHBQrzh7Qq1QqIgTcq8MF8iPj6qZREa7OzwXcbPvd68l+9o6E
         kKsZq0xHtVN7DZ+2QXyIWW9lbbNrSLAoe/IOViDIyRB0JBJC0ckj4un3Vwvx5ih9yAtR
         6upfwI5IEC7Yu4q/mbMbcN7mgoFGSJlEwQwDWwAP+5PHt0HPneY5eQcKl1uWKePOmwOi
         LyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:cc:to:subject:from
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=ODcrbPcnMCSSoamca2F6ZuB3LHikG1Oo3r1FOts8V4c=;
        b=j/8CbWq9+lZ3RDMZSvxcTCPOmPDgLY5WwiBE+UGaXljn5bOuHMpXlHX0GJLGCqnJAQ
         HJs73gUY0wBIauoFJA59vrkjgVC6su4KNGVnAu30XVncG1K9VbvNn3JpPGga9A5KHGdw
         SY7oW6JvuNDoK4x0WZof6MCAENc0Cft1BZuezXI9Pd5S6iXzaPbxItKCDgj4car66O4U
         Ktv5Z9LLfBSQvusuKdxbxrmlTg65x4m/esUT6GYUvJZDrNVeuF1/ErH8CDw08psBn8ow
         VLsbTp0vzzXpO8RvjXRwU6lTVTeNpZ+g/1mLqmIiQ7EMfBY5IhrUvWNR9mmY1HkVZ4df
         gekA==
X-Gm-Message-State: ACrzQf2BnWfMttkCPuGCBM1e1fxShAHqpiCdTU8JMY+2HSWKh6oRAWfu
        i3gAkuwrH2t2xlwVO42yjKs=
X-Google-Smtp-Source: AMsMyM6NskjxS+PhyY75K/LPrChZI6R4TpD3VQ9478iz/K1Ew1itC7L8OMA3fWU03XTIMFHg+V/nYA==
X-Received: by 2002:a17:906:7007:b0:6ff:8028:42e with SMTP id n7-20020a170906700700b006ff8028042emr3160836ejj.278.1665047386560;
        Thu, 06 Oct 2022 02:09:46 -0700 (PDT)
Received: from [10.34.19.122] ([95.183.227.98])
        by smtp.gmail.com with ESMTPSA id la15-20020a170907780f00b007812ba2a360sm10184397ejc.149.2022.10.06.02.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 02:09:45 -0700 (PDT)
Date:   Thu, 06 Oct 2022 12:09:35 +0300
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
Subject: Re: [PATCH v2 05/10] dt-bindings: pinctrl: mediatek,pinctrl-mt6795:
 Fix interrupt count
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <0SQBJR.LFLSOU16ZA311@gmail.com>
In-Reply-To: <17e4cfb0-e423-9cf8-8af1-588aed4481a5@collabora.com>
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
        <20221005174343.24240-6-y.oudjana@protonmail.com>
        <17e4cfb0-e423-9cf8-8af1-588aed4481a5@collabora.com>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Oct 6 2022 at 11:01:29 AM +0200, AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com> wrote:
> Il 05/10/22 19:43, Yassine Oudjana ha scritto:
>> From: Yassine Oudjana <y.oudjana@protonmail.com>
>> 
>> The document currently states a maximum of 1 interrupt, but the DT
>> has 2 specified causing a dtbs_check error. Change the limit to 2
>> to pass the check and add a minimum limit.
>> 
>> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>> ---
>>   .../devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml   | 3 
>> ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml 
>> b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>> index 73ae6e11410b..483fcdc60487 100644
>> --- 
>> a/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>> +++ 
>> b/Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>> @@ -47,7 +47,8 @@ properties:
>>       interrupts:
>>       description: The interrupt outputs to sysirq.
>> -    maxItems: 1
>> +    minItems: 2
>> +    maxItems: 2
>>     # PIN CONFIGURATION NODES
>>   patternProperties:
> 
> Nice catch.
> The right thing to do is...
> 
>   interrupts:
>     description: The interrupt outputs to sysirq.
>     minItems: 1
>       - description: EINT interrupt
>       - description: EINT event_b interrupt

I didn't know what the interrupts where exactly and if either one is 
optional so just to be safe I set the limit to 2. I'll do that nex time.

Thanks,
Yassine
> 


