Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2F06B0551
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCHLDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjCHLDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:03:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704D95C103
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:02:52 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d36so17650088lfv.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 03:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678273371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lMzCAsM0PhpCHmoe0EGDyegccw9zsrjHGG0hK/hbQG0=;
        b=spKaCHdwBbNQMkrq9/qgK/20+UT4ELpaBrExg9eaxAwqGlWQ+sPhOS2F7HjOTilwOx
         0arnR2z2YF/LwqjkGer1Qqv9Ixjc62V9O8CHd7pX8y32GvI7v+Xo9vEtx8ZLETMHgqxZ
         Lk7tKp+xa6PVlZ1YEsEKk5GhcaZD0BAUgqlwoCwPinZeJmjl8lZgA+6KreoVjoB9RR4G
         FYCcqyPwpk5ZdDd9a1QhybkM9aKRbRieAZMVanGQnI8/DDa4Fsb3l3Kj5VDklgEVPBEj
         i1W4TIRD3XG0vmpAfGe3glyTQyU4lWqCWndxuLxj4q7/xG9iQphtdnkFYvyjTxiQ37pp
         63lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678273371;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMzCAsM0PhpCHmoe0EGDyegccw9zsrjHGG0hK/hbQG0=;
        b=1/wLxApUvl6c4QPdR0IlghdgGDzzmriLgWQrOjC5UmAnPNwovQAs6fhPQBLPZ5Cfie
         oLsAQJR4MOBY/KonDaobKxpj2XA9ck1eVF0hea0MkTA/k6nhfphtJP+yqQCtgswTwsdw
         u8C5riHAy9iTbJuR5iK2bj0BrQjWyhjNoKJwnQOzF9ZemCzKsLiWFf3OTBflAq81utLZ
         O0plk1Y+7/CRJOKfCU3HyOFUrXKHv2Wg3RmP3zuxMq/3Q0LvkTlEV0g7lh/28hjNH5VL
         VkO1bmWqqzlldn5YyXc91GL4Ka47PH2P3Csm9KxbAn3vHSTNjlsHej9rxLr9TFW1Z7a4
         Dk9Q==
X-Gm-Message-State: AO0yUKV87RVfvoiv9fzhJNm2W09X/xHGQUwFArtSVs5eEP4L2ddDY+O2
        aDQ8AVgdIWlf78Zm6ha6hfQ6Vg==
X-Google-Smtp-Source: AK7set+4lf+PExgrl5oucKm4T53qnUKKcSB06qXrcWKFni/6BNULX5raCpueUNIJBrk0aQF95+wLMw==
X-Received: by 2002:ac2:5e8e:0:b0:4b5:b87a:3262 with SMTP id b14-20020ac25e8e000000b004b5b87a3262mr4911109lfq.28.1678273370725;
        Wed, 08 Mar 2023 03:02:50 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id v10-20020a19740a000000b004db3e330dcesm2314791lfe.178.2023.03.08.03.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:02:50 -0800 (PST)
Message-ID: <aa963fa9-e2d6-a7e1-8396-745de5f996d4@linaro.org>
Date:   Wed, 8 Mar 2023 12:02:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 1/2] dt-bindings: display/panel: Add Lenovo NT36523W
 BOE panel
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jianhua Lu <lujianhua000@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, phone-devel@vger.kernel.org
References: <20230217-topic-lenovo-panel-v2-0-2e2c64729330@linaro.org>
 <20230217-topic-lenovo-panel-v2-1-2e2c64729330@linaro.org>
 <CACRpkda7=Y4ZRBDOhxE974qV-yXuFyZZs7m_aBwtF9qivV5WQg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CACRpkda7=Y4ZRBDOhxE974qV-yXuFyZZs7m_aBwtF9qivV5WQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.03.2023 23:08, Linus Walleij wrote:
> On Tue, Mar 7, 2023 at 2:26 PM Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> 
>> Add bindings for the 2000x1200px IPS panel found on Lenovo Tab P11/
>> XiaoXin Pad devices.
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> (...)
>> +$id: http://devicetree.org/schemas/display/panel/lenovo,nt36523w-boe-j606.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: NT36523W BOE panel found on Lenovo J606 devices
> 
> It's a Novatek NT36523 display controller-based device isn't it?
> 
> I would reflect that in the title or at least the description.
> 
>> +
>> +maintainers:
>> +  - Konrad Dybcio <konrad.dybcio@linaro.org>
>> +
>> +allOf:
>> +  - $ref: panel-common.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: lenovo,nt36523w-boe-j606
>> +
>> +  reg:
>> +    maxItems: 1
>> +    description: DSI virtual channel
>> +
>> +  vddio-supply: true
>> +  reset-gpios: true
>> +  rotation: true
>> +  port: true
> 
> This is clearly (as can be seen from the magic in the driver) a
> Novatek NT36523 display controller, just configured differently.
> https://lore.kernel.org/lkml/20230220121258.10727-1-lujianhua000@gmail.com/T/
> 
> Why can't you just modify the existing nt36523 binding from
> Jianhua Lu by e.g. making these two non-required:
> 
>  - vddpos-supply
>  - vddneg-supply
> 
> It would not be helpful for driver writers to have two different bindings
> for similar hardware hand having to write code to handle different
> properties depending on which binding is used, so please unify into
> one binding by cooperating with Jianhua.
I'll look into Jianhua's patchset and try to work atop that!

> 
> Would it help if we merged Jianhua's binding so you can build on topYes please, the less out-of-tree dependencies the better..

> 
> Yours,
> Linus Walleij
