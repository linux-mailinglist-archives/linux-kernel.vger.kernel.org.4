Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B111A61E992
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiKGDXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiKGDXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:23:30 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB49B1136
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 19:23:28 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id j15so14326169wrq.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 19:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoCqJFFEwga8HLbIPvad2ONk7YeJiUs7YZ46dNA2Vj4=;
        b=M+NsIlRxwZJQco2DVxK1IC+XpxvBfEGXljI3xoieudB8Dp7htzA/oYgJL89345JbZ+
         7BoyTX1W1WcfOMa+KHyY+gKXeBIuks8pizpXsllvVUowdYYcGBbMv7Bln5uyqx2DGIKp
         ZCfCr4sz6dLi3G+gA0hvqJKk/MKNeV2ECIwtNIq+4QfoAGXxSa2YKrg3gTP4NvhM4s/i
         Sa1/9J1bmFdujrYV67hmPlRq6GtF6sPNSr0mwRUCCOmIN6nMoDi80n6eF9z4KzuQkcfM
         MPZiy8m2hvR7FIyRcWqGUhDdkcn9+NOywPjnUtFb1Eo/Das+NUpl69PUfbWyyXz/02aJ
         zYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BoCqJFFEwga8HLbIPvad2ONk7YeJiUs7YZ46dNA2Vj4=;
        b=qxxMCMyFbwKuDG1WRtmO3hhd62qGi2cE/KvhbOOeUOLzmOID3hcVEyD9YcnH0uY1jP
         cttW8SsipJdlQ4lTWqZc0FYjGtJPoI/MsLlnwGg7JTWY3IkvdBWzwfpXv73TdUmOOsPK
         8ElRy30XApFJ/1YPoqpPfyY6ZKtb33NDUPlj0mvf0ityBAL8CFPSFyUOTOePH9VSiYTr
         PPdWzu3Q5fsS20yFj8KOSZO76T8aZ51RHkefrQeojjLdwglk4ZIHOosQ9Z1cJUPI9xh1
         Jhq3KxR8ADssXrtG2YhEBrqTK/nDo32CCYen/lB2EQrDkY8QwNqz7N55qTmecL5M7c6C
         dAHA==
X-Gm-Message-State: ACrzQf0kKmAPm/OJzrOKIHdHQ+nHlECc8sjfi++Go7vPLiTxHxaClaKG
        XS8Qek1fj+xxpuMuULDnNhmyiB0M9CHUqQ==
X-Google-Smtp-Source: AMsMyM7Xpy/hX5YLOqDGvmPFqG6e7WURl4Q/vq45MrPiOVdJ2okbjVVyQLWJwIkvgw+axxmR69Wsig==
X-Received: by 2002:adf:fd4a:0:b0:236:87bc:a900 with SMTP id h10-20020adffd4a000000b0023687bca900mr29075747wrs.706.1667791407388;
        Sun, 06 Nov 2022 19:23:27 -0800 (PST)
Received: from [192.168.36.1] (92.40.199.16.threembb.co.uk. [92.40.199.16])
        by smtp.gmail.com with ESMTPSA id e5-20020adfef05000000b00225307f43fbsm6004290wro.44.2022.11.06.19.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 19:23:26 -0800 (PST)
Message-ID: <83faab03-30df-cc2e-c447-110f345cc1d5@linaro.org>
Date:   Mon, 7 Nov 2022 03:23:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 0/5] arm64: dts: qcom: add and enable the pmi8998 RRADC
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        luca@z3ntu.xyz, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>
References: <20221016180330.1912214-1-caleb.connolly@linaro.org>
 <166779074258.500303.6143441430945522925.b4-ty@kernel.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <166779074258.500303.6143441430945522925.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2022 03:11, Bjorn Andersson wrote:
> On Sun, 16 Oct 2022 19:03:24 +0100, Caleb Connolly wrote:
>> This contains patches 6 through 10 of the series adding a driver
>> for the RRADC
>> https://lore.kernel.org/linux-arm-msm/20220429220904.137297-1-caleb.connolly@linaro.org/
>>
>> The driver and DT bindings have been in mainline for a while.
>>
>> This introduces a new dtbs_check warning which is fixed in
>> https://lore.kernel.org/linux-arm-msm/20221016175757.1911016-1-caleb.connolly@linaro.org/
>> and depends on Luca's series:
>> https://lore.kernel.org/linux-arm-msm/20220925211744.133947-2-luca@z3ntu.xyz/
>>
>> [...]
> 
> Applied, thanks!

Hi Bjorn,

Apologies, I should have left a reply about re-spinning this; it's 
been dropped to a single patch as Krzysztof suggested in [1] and is 
currently pending a v4 (v3 can be found at [2]).

The changes aren't major, actually just enabling it by default rather 
than per-device. If it would need to be reverted I could instead send 
a followup to do this as well as add the missing dt bindings.

[1]: 
https://lore.kernel.org/linux-arm-msm/5929051d-d2be-5b51-0cf9-294affa51df2@linaro.org/
[2]: 
https://lore.kernel.org/linux-arm-msm/20221017190902.2282899-1-caleb.connolly@linaro.org/

> 
> [1/5] arm64: dts: qcom: pmi8998: add rradc node
>        commit: 1cb78978d34e1b65bbb912d8265eb95713ae7a45
> [2/5] arm64: dts: qcom: sdm845-oneplus: enable rradc
>        commit: 868985181a69df53321035d96aa668d90f6cd5cb
> [3/5] arm64: dts: qcom: sdm845-db845c: enable rradc
>        commit: e779eb99859cc26d051f6fc723d2bd2d5990a812
> [4/5] arm64: dts: qcom: sdm845-xiaomi-beryllium: enable rradc
>        commit: 53c54069d9ffd556b52893077324e628655cd591
> [5/5] arm64: dts: qcom: msm8998-oneplus-common: enable RRADC
>        commit: aac16a9d247e5496361bfe20d651f2c1333eb5dc
> 
> Best regards,

-- 
Kind Regards,
Caleb (they/them)
