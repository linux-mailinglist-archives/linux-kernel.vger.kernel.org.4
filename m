Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BC36B209D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCIJtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjCIJs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:48:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE604C78ED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:48:52 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u9so4646763edd.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678355331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KqM9tPbk85fkSamrIGtF+aGGKkrU9G+V8TUF+yeEv8A=;
        b=SOGx0RpyMsiXOR6INiKJFbpBvSFe9w7i05zm2lXlR/T2TKa8QylkB7e9C+MQuPWhO/
         Ku/H+APnyg5V/why7CWDcRyCYN1EUTaAy7gUz8MgMug30Oroj1hx2lt4hjJXzJ4L+smS
         Gl9GOre6r+id+4BvTzvCBZiFzsiuWufrylwoWWv1JKjLeRh2ebzdoMrEgZEa/ISGRQCK
         suwRxZsk4QME0pgnBm3ErfIfs5rWuFyHeKyNi+8KHgjZ3KVHYTidsMbkOrKNcU13+CyF
         8dpMQhVRryLJFV3L/NNAJH3yHfPOzd5bizHY4ltfMiJelw/cK3gSw7K/UOYRp0bg2qnj
         +iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678355331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqM9tPbk85fkSamrIGtF+aGGKkrU9G+V8TUF+yeEv8A=;
        b=YmcesUoyDKKj9jyZw5Yoy8tRoVzb1vXaca6qYJ4fpjKJ0FIFzW7Pz9ewvxSpVmFnKG
         /SKHu46wqPmsP1IE+f8RJlFpWOvAXAuODjV/fMqLxhCEYyYGpDswSqy8dwVWN08XN9EN
         +fMsVha/gtXPptunD+LMPRjm3sdh1IWnic519h4PZHZmpy7wIAN0/MMN9GUkyvzYpD/D
         FM8nLkDqAay1NFHPDHzQIQTJ2weCG8+D7Fbijcf5NzCz2USaMynNXH2anZYmQZNWeZuN
         tUbd7Lw+1B5k12DBw+LRTDguMEoZ+Ro00QeCGDkLeIPxNvU1BsS3Xgby/fOVRkWZVjLQ
         KjFw==
X-Gm-Message-State: AO0yUKVf5kDqCJaUBQ+sLGXlEvcE0ugnH1Bk4Ok889CYJ1UYhv8/a908
        20w94yIYz9ipPXOUSMa9bWHqqg==
X-Google-Smtp-Source: AK7set+LdAcJf2k76HO3Ko/pAiaiYsVO6swO8CiLqUtf9WOiHED+3AcF+H/mT/wOUS2xwh46rEkt0Q==
X-Received: by 2002:a17:906:da82:b0:88f:9f5e:f40 with SMTP id xh2-20020a170906da8200b0088f9f5e0f40mr30594330ejb.68.1678355330988;
        Thu, 09 Mar 2023 01:48:50 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906005700b008e3e2b6a9adsm8646897ejg.94.2023.03.09.01.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:48:50 -0800 (PST)
Message-ID: <38eaed94-647d-a25b-f1ed-8e2d1b6e8852@linaro.org>
Date:   Thu, 9 Mar 2023 10:48:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/20] dt-bindings: pinctrl: ralink: add new compatible
 strings
Content-Language: en-US
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-9-arinc.unal@arinc9.com>
 <20230308210017.GA3744272-robh@kernel.org>
 <1c704ea4-2241-ef21-dc6c-d2d243d3bbad@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1c704ea4-2241-ef21-dc6c-d2d243d3bbad@arinc9.com>
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

On 08/03/2023 22:19, Arınç ÜNAL wrote:
> 
>>
>> If you want to break the ABI (do you??, because the commit message
>> still doesn't say), then you don't need "ralink,mt7620-pinctrl".
> 
> I don't want to break the ABI. But I deprecate ralink,mt7620-pinctrl on 
> later patches.

Deprecation should happen here. Otherwise you have now two valid
compatibles which contradicts previous Rob's comments.


> The driver still has it though, so old DTs will keep 
> working. That keeps the ABI intact regardless of deprecating strings on 
> the dt-binding schema, right?

Yes, but deprecation is missing.


Best regards,
Krzysztof

