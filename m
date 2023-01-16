Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B50366B971
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 09:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjAPIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 03:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjAPIy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 03:54:56 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31F812F12
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:54:55 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id f34so41719443lfv.10
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 00:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e3NwldBnwc51CwPQjc0BZUztCg2yevkoWHylAFGNbrA=;
        b=Zkjjj6hPl/yhqIJ6W4XI9nodnspnZ2W7I0NOodVJHcguGrSCriStH72UgcgRP7EQAK
         +wCOvGAvExhuFNKAL+TA1HyO6GdOLyZ3TR4wOjU9ugDNq+gGcF6/bh7KE/8v0MLB4Adq
         ZgBh9THtUWT7zoAdCkg4NwSeA1NJcJszEeTKrKLovqkQtQ103vvnoHVdsTMS4CUlCmNh
         KFhF+LQL74hwDc9kuAv6X/OJuXLtrpuMUGpwI7rtHckgmqQWvz88Yb10spP0ckQc53xv
         lqN2fPOf98fgEhu3pm+yzKfom0yjcQmBnGluTI1Z4diuuefO3FXl5vCaYb8Vwc3osbro
         IqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3NwldBnwc51CwPQjc0BZUztCg2yevkoWHylAFGNbrA=;
        b=ac1FJLftEMB2KIoQVzu4swTDPd8AKNhnbbTW4pIRYNDGEGeOEq5RZACiS05svNzCzn
         8ZGem8zia1NbVjOE0Dfh1rmXk8sYJvXN1TGbA5YYPezHzg6uN1wxf9y2cZI5G9BghjNn
         SdfEf2A5imdCneglZNMtLUEZKjaJ1lGBtpAdXC4/dRGnRJjqHDL9IfSbr0TzAJjLUkx2
         ReFKQwcuvTrXWM06Fm1JNFSjFYrSStvoK4pd2ujvyCQubYN80jHqleEIWDnYMbbST6BM
         0SB16DfM3AdwzkgVk/ykaNHMvBgS1KP9mHun0x4OjviRhABocSwS2cPzvYBBB83TcjEB
         nF7A==
X-Gm-Message-State: AFqh2kqKRwlBqaCr0fZA34Hh9Y/uEq4WAvWvw7YlrGigb0J8s6ziyQO/
        6UsMfniqu4WhVWKf19GasVOGJkS76a4yu83N
X-Google-Smtp-Source: AMrXdXulonNTsRYzQRFTvucqEbwPMkwgdmuB6RuuBZFOkklQ+lGJhKMJIlKqToM+JcJInf4shS0Gqw==
X-Received: by 2002:ac2:5dce:0:b0:4b5:b988:b409 with SMTP id x14-20020ac25dce000000b004b5b988b409mr24227939lfq.21.1673859294168;
        Mon, 16 Jan 2023 00:54:54 -0800 (PST)
Received: from [192.168.1.101] (abym53.neoplus.adsl.tpnet.pl. [83.9.32.53])
        by smtp.gmail.com with ESMTPSA id i14-20020a056512224e00b004cc8b29ed7bsm3135350lfu.205.2023.01.16.00.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 00:54:53 -0800 (PST)
Message-ID: <9116109f-0351-a2bb-2278-29ed9d32f635@linaro.org>
Date:   Mon, 16 Jan 2023 09:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sdm845: move WCD9340 codec to
 separate file
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230113162245.117324-1-krzysztof.kozlowski@linaro.org>
 <20230113162245.117324-2-krzysztof.kozlowski@linaro.org>
 <e3c367ba-b752-d116-0b84-fd2437e565b8@linaro.org>
 <5e784285-c391-91f4-c9d1-a53443fc4264@linaro.org>
 <CAA8EJpr+0fnhy+aHwmdKQA_xk2Qkse0L5u8JdCJNDZqqdYwhrg@mail.gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpr+0fnhy+aHwmdKQA_xk2Qkse0L5u8JdCJNDZqqdYwhrg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16.01.2023 06:55, Dmitry Baryshkov wrote:
> On Sun, 15 Jan 2023 at 13:21, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 14/01/2023 21:33, Konrad Dybcio wrote:
>>>
>>>
>>> On 13.01.2023 17:22, Krzysztof Kozlowski wrote:
>>>> WCD9340 codec node is not a property of the SoC, but board.  Move it to
>>>> separate file and include it in the specific boards.  On all others,
>>>> keep the Slimbus node disabled as it is empty.
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> ---
>>> Generally this should be SoC-independent, for example some newer
>>> MSM8998 devices shipped with the 9340 codec that most 845 devices
>>> used, but earlier ones used the WCD9335 found on MSM8996
>>
>> OK, but I don't get if you expect me to change anything?
> 
> Maybe it might make sense to name new include file just 'wcd9340.dtsi'
> rather than 'sdm845-somthing.dtsi'? Same applies to the wcd9335 codec
> found in msm8996.dtsi, if you are going to extract it too.
> 
> Note to Konrad: I don't see slimbus support in the msm8998.dtsi. Are
> there any pending patches?
There was *something* at one point.. Gotta play archeology again!

Konrad
> 
