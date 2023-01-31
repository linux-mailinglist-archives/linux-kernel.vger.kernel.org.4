Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8657682E00
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjAaNdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjAaNdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:33:23 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3968F50850
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:33:22 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id m2so41158160ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/whnsNry6VB8uKQBheTAOpeLql048SnvWb40T9c6cY=;
        b=XwS8Q2bjQLTFp2zv1NyNhG4A7uOdja0EAXaWVeczhLkmTbTq5ODUAx0zh8sCvH4YuV
         OauClZawsGjti1GsQFbaXTsqBfMVgSRVhSVrOe7zeXpGQMb1QKbuKPkOJ5BqqzTHcZ3/
         LakOlNG/83W3mpBYHQK0E61+B1bWq5MSTRLIyvOQHzVQ9MyUqMKfEVWK/7RopRTpWSKv
         o7pCU4v5oNiIh+XxHaMVt7+gi+SEJc6FIiqju2eKA9zHl0sbJKO6ZMemGrNV5kX/Kn+U
         DnmxDSunbUHGf2w671ED2JiPGB7dHOjB9VVyXKb7JTbsFQ9UPPu/Hb5sf7/0RfhO4oFg
         6NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/whnsNry6VB8uKQBheTAOpeLql048SnvWb40T9c6cY=;
        b=V0x+kmHC+DkGCsgogDxSL7Kk8H0TIz4JRMDOO7G6E2KrUqulO27b7sAEcJWgD/P5Hu
         pSVDxJlRyF8IeYy2RxvCWO+jb26pQlvZ64M2AsH+KJ+T8KgKhAtsr2vsxPNpW3OO3ZhE
         COOripa1qYrK1vXBA/SoW72ciLmF5XGNittqrsKFfKdMEfyR5jZcwZloXFyjInpgMzLA
         ubJc1uA/yOXDVZY8t7W9I34nCpPqDK2eqqe8R0s7GViXXnxEYDr6EMeomJI7BtUy5Svq
         ylUVel6AGj9otsaU2aEwBGoBTRjQHqCAMuBesA0v75fWm43SgMQtUBD5aINTCN/x50gc
         5r8Q==
X-Gm-Message-State: AO0yUKW21odd30WIt9R8UKlZXOojLa8DDAV/248jbejlBY+xtPUa2nBM
        7oqQtx1424KgWO4xsN8/TTKCiQ==
X-Google-Smtp-Source: AK7set+koSZf6sHbHDiaLVwPkMiC+vP2w4cQYHPGzAXOwJi38AqFiKtmADM9MZ/Kl0ofOmPk8Zldhg==
X-Received: by 2002:a17:906:7394:b0:87b:d402:95ac with SMTP id f20-20020a170906739400b0087bd40295acmr3846126ejl.27.1675172000747;
        Tue, 31 Jan 2023 05:33:20 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id c20-20020aa7df14000000b00499b3d09bd2sm3900289edy.91.2023.01.31.05.33.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:33:20 -0800 (PST)
Message-ID: <8508e3d5-7468-0b2f-5a43-7c439ecf2d8b@linaro.org>
Date:   Tue, 31 Jan 2023 15:33:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] arm64: dts: qcom: sdm845-db845c: Mark cont splash memory
 region as reserved
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20230124182857.1524912-1-amit.pundir@linaro.org>
 <39751511-3f06-7c39-9c21-208d4c272113@linaro.org>
 <CAA8EJppLBuA08hkqTrZx_wwbtCxK9sAjv48c9_DxgPENgo7a8Q@mail.gmail.com>
 <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1a840d88-e5b1-711c-b980-f57620c54472@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 14:45, Konrad Dybcio wrote:
> 
> 
> On 31.01.2023 12:06, Dmitry Baryshkov wrote:
>> On Tue, 31 Jan 2023 at 12:54, Bryan O'Donoghue
>> <bryan.odonoghue@linaro.org> wrote:
>>>
>>> On 24/01/2023 18:28, Amit Pundir wrote:
>>>> Put cont splash memory region under the reserved-memory
>>>> as confirmed by the downstream code as well.
>>>>
>>>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 8 ++++++++
>>>>    1 file changed, 8 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>>> index f41c6d600ea8..2ae59432cbda 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>>> +++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
>>>> @@ -100,6 +100,14 @@ hdmi_con: endpoint {
>>>>                };
>>>>        };
>>>>
>>>> +     reserved-memory {
>>>> +             /* Cont splash region set up by the bootloader */
>>>> +             cont_splash_mem: framebuffer@9d400000 {
>>>> +                     reg = <0x0 0x9d400000 0x0 0x2400000>;
>>>> +                     no-map;
>>>> +             };
>>>> +     };
>>>> +
>>>>        lt9611_1v8: lt9611-vdd18-regulator {
>>>>                compatible = "regulator-fixed";
>>>>                regulator-name = "LT9611_1V8";
>>>
>>> Doesn't this mean we loose 0x2400000 of DRAM for all rb3 platforms
>>> though ? About what 37 megabytes.. ?
>>
>> I think this memory is further used for display memory allocation. So
>> we are not loosing it, but dedicating it to the framebuffer memory.
> Not exactly, to do so, you'd have to use the memory-region property
> with mdss, which nobody does. Otherwise it's just a hole for Linux.

Then maybe it's time to start using that property?

> 
> Konrad
>>
>>

-- 
With best wishes
Dmitry

