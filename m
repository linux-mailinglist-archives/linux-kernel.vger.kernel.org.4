Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AD866DB66
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbjAQKoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235963AbjAQKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:44:20 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA84810DB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:44:18 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t5so25704490wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rDFJAyxdwlXAceDq2HEyYot6ddhmeIhv2ZNqpa+nXCY=;
        b=mejaY73R9K8EQWWiawJO1bS1S6I4yHsgrohDuS2fhH8cueOsSYZi42eZLXw2ZhqfBj
         VIdfM3A2WiHmJi7wglW2fcZkPTPCRHfzFakebE0hzRReQV2L7HsuxA2i34ae1WWZMxEj
         EGS2JQ+ZG+kG2WmARA0PqObGq5tHf7RJAHgYOF2Vbsd95qaBGg6YCWwCGWiaLPq3+q/a
         QJyxBskSEfe06Z1XJm87x5j8m4UP5stOlFmg0xJ/j5aa1rttQdPDMY90q3XVVu0k7kKi
         gYwlkW123cPMsiJAJFT6JbsNlUip9QDE9CrBkKfQwt5TTVbCKBSgTa7kvMIijQLLb+Hw
         RlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDFJAyxdwlXAceDq2HEyYot6ddhmeIhv2ZNqpa+nXCY=;
        b=R3xLmiG60apVCGjyIGyNGG0fumOJXayoCSGqmtS8cXE0skNemowQC+4td+yEs1kJit
         L8OdshGApQ7omDJq4YOrpQhOgsNhWjuRAPRIJznWlTTVL9hxPidpgcdUAazqxCmgjeex
         ZsRWPJBJouPtbD95+BqeJW1WVahhruHhNSid4Xp+OiSt/wYb9YwPVDatGbO3YhqpYjFb
         HPWmJQ+ZlU16LGW27UZNSQjVtgIYUV91qmEgECM0PBD8J1YdgeryC9YpNu0kWjBltkiC
         SbvNAWc/RL5doqQoSksAJj5SZxzzp/d3hoyh1/vXqDqLRN0vju2ZsWKzXi83Va9qrt/r
         FX5A==
X-Gm-Message-State: AFqh2koXF8//jBMRmc/3185jETnX+7nO5cPvpe5zjbAxOu/RnmJBY4KX
        RVipctCFD2TFl3cZVr4Jkm7h5A==
X-Google-Smtp-Source: AMrXdXtZBBAJRszEFQuiAI8oVhKjjwBpWztQ8LR+hAfpx5+gygc/xT1aXjwWWGgP9vgzwbJyvxRKDQ==
X-Received: by 2002:adf:fa4e:0:b0:2bd:d415:39c with SMTP id y14-20020adffa4e000000b002bdd415039cmr12015109wrr.4.1673952257509;
        Tue, 17 Jan 2023 02:44:17 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o17-20020a5d4091000000b0028965dc7c6bsm28121074wrp.73.2023.01.17.02.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 02:44:17 -0800 (PST)
Message-ID: <3c7e9a5f-24e3-3486-11f8-556428947423@linaro.org>
Date:   Tue, 17 Jan 2023 11:44:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/10] dt-bindings: media: mediatek,vcodec: Remove
 dma-ranges property
Content-Language: en-US
To:     =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?WW91bGluIFBlaSAo6KO05Y+L5p6XKQ==?= 
        <youlin.pei@mediatek.com>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?QW5hbiBTdW4gKOWtmeWuieWuiSk=?= <Anan.Sun@mediatek.com>,
        =?UTF-8?B?TGlibyBLYW5nICjlurfliKnms6Ip?= <Libo.Kang@mediatek.com>,
        "kyrie.wu@mediatek.corp-partner.google.com" 
        <kyrie.wu@mediatek.corp-partner.google.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,
        =?UTF-8?B?Q2hlbmdjaSBYdSAo6K645om/6LWQKQ==?= 
        <Chengci.Xu@mediatek.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?UTF-8?B?WUYgV2FuZyAo546L5LqR6aOeKQ==?= <YF.Wang@mediatek.com>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?TWluZ3l1YW4gTWEgKOmprOm4o+i/nCk=?= 
        <Mingyuan.Ma@mediatek.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "will@kernel.org" <will@kernel.org>
References: <20230113060133.9394-1-yong.wu@mediatek.com>
 <20230113060133.9394-2-yong.wu@mediatek.com>
 <07ecf7cf-4a68-0f80-0452-3737b7d7922d@linaro.org>
 <796e7fb8619d114c63580e5c4289c59a57449843.camel@mediatek.com>
 <2e2a0c70-86d2-7ba1-c87c-aaaa9dd460b5@linaro.org>
 <3da13600844b8a6c3b788bdb26faa537d0287173.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3da13600844b8a6c3b788bdb26faa537d0287173.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/2023 10:16, Yong Wu (吴勇) wrote:
>>>>>
>>>>> Cc: Tiffany Lin <tiffany.lin@mediatek.com>
>>>>> Cc: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
>>>>> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
>>>>> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
>>>>> Cc: Rob Herring <robh+dt@kernel.org>
>>>>> Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
>>>>
>>>> There is little point in storing output of get_maintainers.pl
>>>> forever
>>>> in
>>>> the git log. If you need it for some reason, please keep it after
>>>> -
>>>> --.
>>>
>>> I did get the list from get_maintainers.pl. Sorry that I didn't
>>> differentiate.
>>
>> Getting the list from get_maintainers.pl is correct but storing it
>> forever in git log is really unnecessary. It's not useful. It's just
>> automated output, reproducible at any given time.
> 
> This patchset crosses several domains. This patch is about vcodec, the
> next one is about jpeg and the later ones are about iommu.
> The reviewers may be different, thus I use "Cc:" here. is this OK in
> this case? 

I guess we do not talk about the same thing. It does not matter that
reviewers are different. They are all different. Please show me the
direct benefit of storing automated output from a tool in Git log.

> or I should remove this, and put all of them in the cc list
> of the mail.

I gave you the instruction at beginning, some mails ago...

Best regards,
Krzysztof

