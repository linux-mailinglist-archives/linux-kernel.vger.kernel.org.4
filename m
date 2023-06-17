Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64B77341AF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 16:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234707AbjFQOnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 10:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjFQOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 10:43:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DD11BF3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:43:14 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-983f499fc81so249656966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 07:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687012993; x=1689604993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxuDtvFvk+FS5ZxqzBrYoH5vvu57PyuB3yI11PXnNLs=;
        b=VpOSFnnsSBvFtLWzWW3aQMyBPDA0SUBhi+66vXg5x3bq2P03ywhAUVQenj0fdDww5w
         UJTLGQFZyh6/nukfAmckKXbdBeCBg4prgEukCncGgX8oA2XV+4sXOVp8TTW5637YSByV
         hBxi1sdBBlgWxI6W43c8/v9EDsa9YVCHXNXPRGc7X0sOCnvIlvCChKK8KDP9ukJb6ACa
         7un9ojOPgEyCyD6m7ymwhOETljMYpl0qYo2HgSwD0Q0e0Cf2OrHxj5p6UjPJYFsfW+5K
         1H2to9WZjXwtiOTkkVwm666j2hSiodWHFrhy0jV/R9LU/LaITa8B91aUsX2YPuqQi5iT
         tDYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687012993; x=1689604993;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxuDtvFvk+FS5ZxqzBrYoH5vvu57PyuB3yI11PXnNLs=;
        b=WWehT6ChpWAWPVPV6jHSg7F3N2TwmbQ1SiqbM/9w2zWzEzZXMgSYCaLe6pkNNnAFJp
         +zL/cqdI5EIS2/qaQGdkMlqrcJunin0jdWSbfo1sTZL/pFOitaAidak8mUgeVMbDhpaV
         gibunH/FArIUa+5EFc1p3ZamsXANczFQ75CGakdD4R8WG4x9fLUxQhK+8LGoAuV+cSU6
         953YtKh5zUuyTrwswJb4+DCyY8/nItlrUU/VhQbqJVLl/Me9EwDmPs/GDDfwzHBpuFs8
         BB59ubb6+iysnuyNgK00Ae9vj7oBfoIhj38ebfHnu20gAh6Gg4xUIshmnL/ljQXVayj/
         0kPw==
X-Gm-Message-State: AC+VfDxHGLUszVNABq88Dbtu5ewSGy6rRcJQnkEVZgwqYl4dFwshiJsL
        RDizgop3QL2h3qp2LoH7p0Cl9g==
X-Google-Smtp-Source: ACHHUZ44aQAgx90PnJ1fhu41Pp+l7HVQRihaNMQVx42ZOKPZxYWQZVbgtSl62M7dCXYwOR5WTJmUXQ==
X-Received: by 2002:a17:906:974c:b0:974:391f:ed7d with SMTP id o12-20020a170906974c00b00974391fed7dmr4985575ejy.49.1687012993034;
        Sat, 17 Jun 2023 07:43:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m16-20020a170906849000b0098822e05539sm336114ejx.191.2023.06.17.07.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 07:43:12 -0700 (PDT)
Message-ID: <05e3ff33-ad4e-d2fb-dfd5-7b5265881b74@linaro.org>
Date:   Sat, 17 Jun 2023 16:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS
 SoCs
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Shiji Yang <yangshiji66@outlook.com>, arinc.unal@arinc9.com,
        devicetree@vger.kernel.org, john@phrozen.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        tsbogend@alpha.franken.de
References: <20230617052435.359177-3-sergio.paracuellos@gmail.com>
 <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <e0f74bdc-3a4b-596a-5ec7-83054377813e@linaro.org>
 <CAMhs-H9M_c8+AkqUTpYeS2q7_+wBA-jhhiXj-QVXNUDmuERcOA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAMhs-H9M_c8+AkqUTpYeS2q7_+wBA-jhhiXj-QVXNUDmuERcOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2023 15:31, Sergio Paracuellos wrote:
> Hi Krzysztof,
> 
> On Sat, Jun 17, 2023 at 3:07 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 17/06/2023 14:54, Shiji Yang wrote:
>>>> void __init plat_time_init(void)
>>>> {
>>>> +    struct of_phandle_args clkspec;
>>>>      struct clk *clk;
>>>> +    int cpu_clk_idx;
>>>>
>>>>      ralink_of_remap();
>>>>
>>>> -    ralink_clk_init();
>>>> -    clk = clk_get_sys("cpu", NULL);
>>>> +    cpu_clk_idx = clk_cpu_index();
>>>> +    if (cpu_clk_idx == -1)
>>>> +            panic("unable to get CPU clock index");
>>>> +
>>>> +    of_clk_init(NULL);
>>>> +    clkspec.np = of_find_node_by_name(NULL, "sysc");
>>>
>>> The node name should be "syscon" as the example node name in the
>>> dt-bindings document is "syscon".
>>
>> NAK for both.
>>
>> Node names must not be an ABI, unless you talk about child of some
>> device node. I don't think this is the case here. Look by phandle (for a
>> device context) or by compatible (looks the case here).
> 
> We need to get the cpu clock to set the initial cpu clock here. Search
> by 'sysc' is the only  shared in all the dtsi files since it is the
> clock provider node. Why is this not correct?

Because device node name can change anytime and your entire Linux driver
gets broken. Node name is not an ABI.

> I don't understand what
> you mean with look by phandle for a device context. 

Your device node should contain phandle to the other node.

> The case of
> searching for compatible is a mess since as you can see in the
> bindings there are tons of compatibles to search for, then (this code
> is common to all ralink platforms).

Compatible is one of the ways using ABI.

Best regards,
Krzysztof

