Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE1F36812A8
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbjA3OXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:23:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235769AbjA3OXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:23:16 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C04D3D09A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:22:16 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id bk15so32129032ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mp4r9fVpKZrzzgv4D9J+I1cyqWfeLifMaidR1ESs/XU=;
        b=nvY5nlRxsX46l48SpXxJHxTOpx5vwRolWHXeXIfrwTV+sxdjBY+bxhpt1aXTcXgErw
         e+6ApQliSQDeXS06uwz4Kqx2OEpi2RmRS9sAiphlvhx10NEqy05FFlYP19w1EJXvEmpd
         2CbTttOyOJN4mwUhtr0ht8zs0o9m1gDbxmiKKexSGcHYlz9pTlFZRyZNOQ8p5F4Gm/Xr
         r2XPUdQWTKpDfVyAnvkPUzqEWrfUeZAIjpuYbYqGgQsKcaHTrOtD/OaWPDf6RuOjqzz+
         t4m/CiCXlbt5YyFVrGRYevkpzHFwxoTnezegT3vQVgWzwWqeBOkHP3YgAcc908BZev3F
         bygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mp4r9fVpKZrzzgv4D9J+I1cyqWfeLifMaidR1ESs/XU=;
        b=b+0MHoXBnt6xEUx4CXhMTFpkPLbvb01akfQ+akCpPZqO+Jq35WWgrbV8Z+bNPoAuQ5
         9I8CIqopSq4+XRtOrmpJGVkzVYRj4KocfnvyNSujq6Ss/7o3x5iEvsGkuJsDSlpNyul+
         62dBV5vfo3+0LN/Rz92t1CsmiZzoCAx6Zy5WrFEjkpXLXOEsCvsPxrgWzUTAeOJKHQOT
         MX5mDbSnxDkJnGVtlB4AddtAxfvwHg1ZtmyW6J7QYc7jMfVPq41u7u32Ix5aqASGXlb9
         xr4pgNS7k+fYib/Ov1jZQM93QwQzGNnBxPzHh7IOy0yAoI1N+/x3giK78xg1EgUT3yr8
         uO6w==
X-Gm-Message-State: AO0yUKVbCu03sd/Ft0Oaz77J0X5MA+OT6yQYdAGmz+kuzpW3O/5/ZTjS
        CugU2URZlP81iSP6aJiR5IpvDA==
X-Google-Smtp-Source: AK7set889yj+dR/89CpchqzYstp2P/VMTYjNzpamS85mDA7EvwK5iBUQV/Uj7vVPTON3aNKos3siBg==
X-Received: by 2002:a17:906:2dd8:b0:87b:d3fa:79f2 with SMTP id h24-20020a1709062dd800b0087bd3fa79f2mr11618195eji.19.1675088478736;
        Mon, 30 Jan 2023 06:21:18 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id q5-20020a1709060f8500b00883ec4c63ddsm3634846ejj.146.2023.01.30.06.21.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 06:21:18 -0800 (PST)
Message-ID: <fd879d4e-13d7-bb82-8668-a1423fc7e428@linaro.org>
Date:   Mon, 30 Jan 2023 15:21:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] arm64: dts: qcom: msm8992-lg-bullhead: Correct memory
 overlap with SMEM region
Content-Language: en-US
To:     Petr Vorel <petr.vorel@gmail.com>,
        Jamie Douglass <jamiemdouglass@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dominik Kobinski <dominikkobinski314@gmail.com>,
        Konrad Dybico <konrad.dybico@linaro.org>
References: <20230128055214.33648-1-jamiemdouglass@gmail.com>
 <CAB1t1CwzUCEL1josABxfyqX91Z6DsrbEuopsDYsgq-eNxh6Btw@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAB1t1CwzUCEL1josABxfyqX91Z6DsrbEuopsDYsgq-eNxh6Btw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.01.2023 15:19, Petr Vorel wrote:
> Hi Jamie,
> 
> On Sat, 28 Jan 2023 at 06:53, Jamie Douglass <jamiemdouglass@gmail.com> wrote:
>>
>> A previously committed reserved memory region was overlapping with the
> 
> IMHO there should be marked commit which you're fixing:
> Fixes: 22c7e1a0fa45 ("arm64: dts: msm8992-bullhead: add memory hole region")
Yes

> 
>> SMEM memory region, causing an error message in dmesg:
>>         OF: reserved mem: OVERLAP DETECTED!
>>         reserved@5000000 (0x0000000005000000--0x0000000007200000)
>>         overlaps with smem_region@6a00000
>>         (0x0000000006a00000--0x0000000006c00000)
>> This patch splits the previous reserved memory region into two
>> reserved sections either side of the SMEM memory region.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> ...
>> +++ b/arch/arm64/boot/dts/qcom/msm8992-lg-bullhead.dtsi
>> @@ -53,8 +53,13 @@ cont_splash_mem: memory@3400000 {
>>                         no-map;
>>                 };
>>
>> -               removed_region: reserved@5000000 {
>> -                       reg = <0 0x05000000 0 0x2200000>;
>> +               reserved@5000000 {
> Can we keep "removed_region:" ?
> removed_region: reserved@5000000 {
> 
>> +                       reg = <0x0 0x05000000 0x0 0x1a00000>;
>> +                       no-map;
>> +               };
>> +
>> +               reserved@6c00000 {
> Not sure which label to add, maybe append 2?
> removed_region2: reserved@6c00000 {
> @Konrad @Krzysztof WDYT?
Generally, if you don't expect that there'll be a need to
amend/reference the node from somewhere else, the label is
rather useless..

Konrad

> 
> Kind regards,
> Petr
> 
>> +                       reg = <0x0 0x06c00000 0x0 0x400000>;
>>                         no-map;
>>                 };
>>         };
