Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4136B20AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 10:53:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCIJxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 04:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjCIJw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:52:59 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A321E3889
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 01:52:52 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id ay14so4549913edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 01:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678355571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDMXuwTqQWAH56WisEztsErbpyePGnPu92kzgFHXUrY=;
        b=Mnb7BMDBDKqxQrT7/VuMapAEP1v+HiUWThI/6W7FfXaOrNfmpYVILIW+ozz8KLgwYt
         YuwFSoNsD3Sn14NCrWqyPXyoZswZzv0vHjzCf43DXQ4K/uuPXFhWOnEs3cOUjiPDZ05w
         VowVxlyxdJr6XXD9mcNo0kstHhyhyzsz6pVgxP1m26TDJCmv2L+85yRwGJXH7Lx5g33D
         1W5EynDi64QmTB8eUjkBXrepFRqEWBhZeSNSlGppa/sGGOk9fYRM8yHMmiZOMyKz8xVT
         JV78KoJ/scIFwaKKDsUCwbrukufg0Wry4IiKUiVcCNpqL84XKZfBB/v/QJJX3uJBZmxz
         IxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678355571;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDMXuwTqQWAH56WisEztsErbpyePGnPu92kzgFHXUrY=;
        b=O1tGCPbB1xOCblPqswYIC7woqD6eQgVNfaXN+rJO75Of2nVXngQ+MYdhWuwFNNLZTE
         t9AqjTY1yQq1EWoJLSGdvyTp2FRI3WV01gZJ11SDQUZ+IpA6+OpG8m9W0WeEE5NObs+c
         XTCpajIZn9p0YBkfAnOKZ9zigMWf/pl6P+pYyc4Rrn7gSe1IFpq3h8Gjq/cGFeTDnY/q
         eD28kISyPcnzz3TAY6mI/7ekZcaBL0TEdEMZRCYmwpaheKYlMu8FvRG7dT4iEz+86K/w
         0+jsc5jDAwse68yMqiCb1NzU3qKBABXVmDuMuUTzqIaJ0OwbXl0KAlM0hikoreR3WwA5
         zusA==
X-Gm-Message-State: AO0yUKU9NhX6nL5WqLXcpg+vrVPmPropOZjIvTOCNPIwcsVGbFfplkIW
        RFZqEIksnZ9JcelSxwC62jJeJg==
X-Google-Smtp-Source: AK7set9vfCOR4FrjRouAXd3nSUrf0/p8aPsE2Cbus07HJyu3nVojeYsL3SmEyCGtwCIxRgmnImbclg==
X-Received: by 2002:a17:906:8156:b0:886:221b:44e5 with SMTP id z22-20020a170906815600b00886221b44e5mr21189729ejw.62.1678355570948;
        Thu, 09 Mar 2023 01:52:50 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id t19-20020a170906065300b008be996c1630sm8638313ejb.39.2023.03.09.01.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 01:52:50 -0800 (PST)
Message-ID: <9663817e-7f6f-c3b1-8bf9-321f9b067e96@linaro.org>
Date:   Thu, 9 Mar 2023 10:52:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 09/20] dt-bindings: pinctrl: ralink: {mt7620,mt7621}:
 rename to mediatek
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
 <20230303002850.51858-10-arinc.unal@arinc9.com>
 <20230308210514.GA3767521-robh@kernel.org>
 <12be053e-b70a-faca-71c8-d8eef69a3b73@arinc9.com>
 <ccdfd262-eaf3-dbbe-7a3c-a911a5ec0fc4@arinc9.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ccdfd262-eaf3-dbbe-7a3c-a911a5ec0fc4@arinc9.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 08:53, Arınç ÜNAL wrote:
> On 9.03.2023 00:19, Arınç ÜNAL wrote:
>> On 9.03.2023 00:05, Rob Herring wrote:
>>> On Fri, Mar 03, 2023 at 03:28:38AM +0300, arinc9.unal@gmail.com wrote:
>>>> From: Arınç ÜNAL <arinc.unal@arinc9.com>
>>>>
>>>> This platform from Ralink was acquired by MediaTek in 2011. Then, 
>>>> MediaTek
>>>> introduced these SoCs which utilise this platform. Rename the schemas to
>>>> mediatek to address the incorrect naming.
>>>
>>> I said we don't do renames due to acquistions, you said that wasn't the
>>> reason, but then that's your reasoning here.
>>
>> It's not a marketing/acquistion rename as the name of these SoCs were 
>> wrong from the get go. The information on the first sentence is to give 
>> the idea of why these SoCs were wrongfully named as the base platform 
>> that these new MediaTek SoCs share code with was called Ralink.
>>
>>>
>>> To give you another example, *new* i.MX things are still called
>>> 'fsl,imx...' and it has been how many years since merging with NXP?
>>
>> Ok this is a point I see now. Though, I fail to see how this is called 
>> renaming when there's only new SoCs (from NXP in this case) to be added.
> 
> If I understand correctly, i.MX is a family from Freescale so the name 

It's the same "family" as your platform, because as you said:
"introduced these SoCs which utilise this platform"

> was kept the same on new SoC releases from NXP. I believe it's different 
> in this case here. There's no family name. The closest thing on the name 
> of the SoC model is, it's RT for Ralink, MT for MediaTek.

It's not about the name. NXP took Freescale platform and since many
years makes entirely new products, currently far, far away from original
platform.

That's the same case you have here - Mediatek took existing platform and
started making new products with it.

> 
> On top of that, mediatek strings already exist for MT SoCs already, at 
> least for MT7621.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/tree/Documentation/devicetree/bindings/mips/ralink.yaml?id=dd3cb467ebb5659d6552999d6f16a616653f9933#n83

NXP also has compatibles with nxp, thus still not that good reason.

Best regards,
Krzysztof

