Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF2732BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344593AbjFPJc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 05:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344245AbjFPJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 05:32:31 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4371A422F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:31:54 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51a2c60c529so585987a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686907900; x=1689499900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aLkZA5cA05PoZNYWbBrpjGAgG6IkmRLsJ3u06LSXUU0=;
        b=aJDnV/nARYfvrMvwaQd2qAg/79AdgRJbshd/mrYLEHOJFCF1mNziudwHlNgV46X9Cb
         bAEezRizuNBUbK3SRhEFcJZ2JdTd1xxc4uoh+uJUL08pdyMSpDIuchcxU5YY+1/43OuS
         r9CdbnyiRmY0iSw7nYDQEnHWfA8PjShbJhaZCqLLBrHNzFuGLhkeaPuZvvkWx/SIGajz
         d4cdZR0E1Ax3nrvlD4/ZkvHRvnIHVnqAoTWrgsStmMhbNA/JSCxSFDMs1hAowK/NXNkT
         7WrcFzYib32dUPWpZGKKQSrDOxZgFz9Evyj6LpHIGOHXl4+y/88jcjALOoJoaHHC4lES
         qKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686907900; x=1689499900;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLkZA5cA05PoZNYWbBrpjGAgG6IkmRLsJ3u06LSXUU0=;
        b=LQ2+CQbJlAcI6r9/QVQ9MBuDonwRAQF+zIJOM32gyJa3TG6VMdxrW/hJXqgnGAgXN6
         0K9nb/vuZre9CrLWfxyFjiHtn4HgrgWhyAhCeu6xtPBrGwgLwOz6waO0W1otvfcHQ7D2
         m64v8iOokniCRmXK2wNQ/KNaZ16W9eu1Qv3MnyE3KKGAtINspyH7Iokfs1uWHpr541OV
         U/eZwOCL/i5d1uNmQC9WhuYux+267lhCG9WaufuIPlTAbPvb1K5thvlQC7B5fq0tZkya
         Ri6wVDemQDR1a6HhSAE8NV7OO5yRYKOCLHrgG6DzqYKG2UoSMTnYMQXD5c8vwDNgUmUf
         3vCw==
X-Gm-Message-State: AC+VfDwGht4RVLqCDeKIISCo/qmTjWoL8ZgJ56q+woeyul7KVDC1cOio
        b+okqc5TPHm2tJWdtrME3aDP9Q==
X-Google-Smtp-Source: ACHHUZ73FrUEh2r99iSwRFYBQo9PGLyN5ZIWuwxO/dT06jRQk2zGgDQqcdb53zQMlw8C3vmMILtoFw==
X-Received: by 2002:a17:907:25c1:b0:974:e755:9fde with SMTP id ae1-20020a17090725c100b00974e7559fdemr1323419ejc.19.1686907900280;
        Fri, 16 Jun 2023 02:31:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h18-20020a1709063b5200b0097457363fc0sm10532382ejf.33.2023.06.16.02.31.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 02:31:39 -0700 (PDT)
Message-ID: <f65955ef-abcb-c542-00ce-1776dd89f893@linaro.org>
Date:   Fri, 16 Jun 2023 11:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 03/15] dt-bindings: display: mediatek: merge: Add
 compatible for MT8188
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230614073125.17958-1-shawn.sung@mediatek.com>
 <20230614073125.17958-4-shawn.sung@mediatek.com>
 <25816ad5-339c-e52f-adbb-686aa7977e9e@linaro.org>
 <61754861be70daa487b98475b246d8fed7e2dbd6.camel@mediatek.com>
 <643e6681-6ba7-e990-3e90-09071db904d2@linaro.org>
 <8153fbe67ccc70ff78390b78124a6983f9e329d8.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8153fbe67ccc70ff78390b78124a6983f9e329d8.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/2023 10:40, Shawn Sung (宋孝謙) wrote:
> On Fri, 2023-06-16 at 10:07 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 16/06/2023 07:29, Shawn Sung (宋孝謙) wrote:
>>> Hi Krzysztof,
>>>
>>> Thanks for the reminder, because MT8188 is not related to MT8173,
>>
>> How does it matter?
> 
> Because MT8188 Merge is fully compatible with MT8195, we didn't add its
> compatible name to the driver, but just list it in dt-bindings, and use
> MT8195's compatible name to match the ID in device table. For example,
> in mt8188.dtsi:
> 
> merge1: merge@1c10c000 {
>         compatible = "mediatek,mt8188-disp-merge", "mediatek,mt8195-
> disp-merge";
>         ...
> };
> 
> If we add MT8188 Merge as an enum with MT8173, then our device tree
> must be as below, and nothing will match in Merge driver.
> 
> merge1: merge@1c10c000 {
>         compatible = "mediatek,mt8188-disp-
> merge";
>         ...
> };

No, why? It would be incorrect with existing bindings. Again, on what
tree are you working?

> 
>>
>>>  I’ll
>>> keep it as it is for now, however, I do find that MT8195 doesn’t
>> exist
>>> in this dt-bindings which it should be, so there may be conflicts
>> when
>>> this series is going to be merged.
>>
>> Don't top post.
>>
>> No, rebase on current next and implement my comment.
> 
> Will rebase linux-next in the next version.

Rebase now - for this discussion.

Best regards,
Krzysztof

