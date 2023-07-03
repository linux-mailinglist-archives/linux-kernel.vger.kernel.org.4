Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06822745981
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjGCKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjGCKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:00:15 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870C1FE2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:56:43 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso67410931fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688378202; x=1690970202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yFcxpzOhBBd54XFri+2kajvhzFonIIEcAtw+w2KHC+0=;
        b=ET94rEvWPCEzRWltZoBAcSq+oQ9T70y45rUYR0l/HS1wT3srLw67FMqpCQGbnb4gnE
         Mu1pWz/TTFsQV2wohpWYqUjj641KolURlSDad+HNDXKIjgznxSqc/2bfzxvwwLrApVex
         LW0nGe0BGPBkRdcVVL/symNezzzi1hm02UmXy2dTazmcZc3LLKe3iydt4rbihjh4KNUO
         S/4D9wnpRbY0lAcwyoZGqtqrqj2ElVzXqOxIzxGQQ/L/9YtHO/KZUI/5UE6C38AUK0/S
         Xt12x2v6o0Zldgr9DqfMKCNdLSlmfS202tg7Hq8vdp38/Sf2v1wBeE/P8XypVMx+Fmyv
         Z9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688378202; x=1690970202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFcxpzOhBBd54XFri+2kajvhzFonIIEcAtw+w2KHC+0=;
        b=Q6vGkRLkmPc/R91Zk5f/IYYHFSIik002QgqAAx8LvBtaAODQm6lk4Ck0LP3EIjxj2D
         6elN6MUoReOeN+dgiUOqXcki6kaf/gpatzDL9D0Qch9WddHYPQTWfNiSpQdONhZFXilm
         2Z71k9CXcwBPrwKZJyuoGkl52aNX/B2tJELuyqxyrtqU28T7hTGvjy0xg5kWUb6TxJwb
         /pognUgBZ88yowr/1c3KSjPq/5yYAO5MmjJ6pv79Yh6F4LBjH7AlgLCff6naIVqqg7HI
         4TqZRh3go2LvZS0VoOV9qaOiRGvDl//RulwhU4ABQX5dUh94jYsJQzUqnAnCLg65yY//
         QXFQ==
X-Gm-Message-State: ABy/qLZYpiVJ1WuHgOKVI1CvrE2OsS/Aii7OfeFKvbZlxLsjWUuGHmD5
        e5uMxznqSd456Qe7s0HCiflwnw==
X-Google-Smtp-Source: APBJJlFiPp5D+M8CDsBXsrjtixc558rhCoZDaYFSfKBuUGv/1G4z1yLHFUp1S2TWgfy3NbzIeXdBmA==
X-Received: by 2002:a2e:3318:0:b0:2b6:e794:5cea with SMTP id d24-20020a2e3318000000b002b6e7945ceamr1783785ljc.27.1688378202049;
        Mon, 03 Jul 2023 02:56:42 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id y3-20020a2e7d03000000b002b6eeb204a1sm87134ljc.83.2023.07.03.02.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Jul 2023 02:56:41 -0700 (PDT)
Message-ID: <0f4f5a4d-379b-c00c-6bf2-58c08fcc4551@linaro.org>
Date:   Mon, 3 Jul 2023 11:56:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] arm64: dts: qcom: minor whitespace cleanup around '='
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230702185051.43867-1-krzysztof.kozlowski@linaro.org>
 <e09af830-d114-7ee6-0cab-e6812bc10fd4@linaro.org>
 <ZKKXGE95Sv-eLQa8@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZKKXGE95Sv-eLQa8@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3.07.2023 11:38, Johan Hovold wrote:
> On Mon, Jul 03, 2023 at 11:30:24AM +0200, Konrad Dybcio wrote:
>> On 2.07.2023 20:50, Krzysztof Kozlowski wrote:
>>> The DTS code coding style expects exactly one space before and after '='
>>> sign.
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
> 
> [...]
>  
>>> diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>>> index 895cafc11480..c4209e2d4b4e 100644
>>> --- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
>>> @@ -155,7 +155,7 @@ CPU7: cpu@3 {
>>>  
>>>  		idle-states {
>>>  			CPU_SLEEP_0: cpu-sleep-0 {
>>> -				compatible ="qcom,idle-state-spc", "arm,idle-state";
>>> +				compatible = "qcom,idle-state-spc", "arm,idle-state";
>> Will conflict with:
>>
>> https://lore.kernel.org/linux-arm-msm/20230627-topic-more_bindings-v1-2-6b4b6cd081e5@linaro.org/
>>
>> there are also a couple of entries with property =\n\t{n}[a-z]
>>
>> Otherwise lgtm
>  
> Konrad, please remember to trim irrelevant context from your replies
> (e.g. so that we don't have to skim through thousands of lines to find
> a single comment).
My actual reply begins at line 77, which is considerably less than
thousands and is concluded by my signoff, which signifies the end
of the message.

Konrad
> 
> Johan
