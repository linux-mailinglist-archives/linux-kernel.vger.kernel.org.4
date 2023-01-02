Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D52DF65B5C9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjABRUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbjABRUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:20:31 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40694B1C1
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 09:20:29 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id s25so29567674lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 09:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HhiywSazON54Mhvv4AES789lmzGPYER5DTGViA52XI8=;
        b=FEpL3u3qwAlN7fWGm5sJBqEAKdxHd2FQkJYWzzpBh6ZKNdCwTPtqyxVEuav46RVfIv
         t1NnwkYn0D7n1RNHKp9K40+R6jnJBTtlMTrm1KkJfIEBK+N7nlsgkdT8dmb3IcinLZUC
         wLL6meYssFfoSgIbzV732v2ymNy6mQBmxgp4znPeQPBBPdTC/mWhXM5H1iOSZSWyT6HH
         u6TpgtSoPC1v/xbHgMjCNtGfz/TvJEU4X9ZF4DQCC4Tlmcg5cMJf7DLVQi4AUBEOM6vZ
         VPxcOddov9gmd7o4hzjWiyYpI0dGZMwj1qPotMLz5tUN6d84zC7mUSmfdNRNZxqL/io4
         BxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhiywSazON54Mhvv4AES789lmzGPYER5DTGViA52XI8=;
        b=VWXK+lEvdJd9E07nPJyaj4oV6srqNAPm1rUZ+oXsDSeEVvDF8VQ8fFfupuwLuow//v
         3ODbqqhjzj82FyRYmRaBA7OWgXqqwjveiTfPlAC1jneh4pKmzT4uEHZyf0OLYqc0pBOh
         fWo1p66RlG7dQcuvF79EeGf3ZPJmN0KzdXa1todm2JF3neZ50P4UggEX6LYdRaxEY09c
         rEW56yMzpB6Vuw/InknTAOQnu32tXvNOAOyICNkeClK7/KFsllX59ivoXkPs8byUn6Fz
         bLX1HAW2KhFLqOwoHj1fXIRgNysP87BaKNAKA4GzZmXSL8a84mQG583GWFIl4hVn0dA0
         L21g==
X-Gm-Message-State: AFqh2kqZ7Nnrk3GWdSY+sB37Ei+vIxkrYkou5whhd+QUDKCEZmrsAEOK
        aw1Chp7ywKeEGh2J7jTQZrM90hhUcgrk5biu
X-Google-Smtp-Source: AMrXdXvfUnc+NWPdVOY3n0YcrYO0gHwfUQiG6a3yeb18y/WILz9N2ccXaFoTrsmBow/StcZQYXjHaw==
X-Received: by 2002:a2e:be04:0:b0:279:e2cd:9ad7 with SMTP id z4-20020a2ebe04000000b00279e2cd9ad7mr13925532ljq.0.1672680027140;
        Mon, 02 Jan 2023 09:20:27 -0800 (PST)
Received: from [192.168.1.101] (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id 17-20020a2eb951000000b002777a07f48esm3306723ljs.12.2023.01.02.09.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 09:20:26 -0800 (PST)
Message-ID: <2fc23a4c-baf0-0b31-b55c-8795cf089f57@linaro.org>
Date:   Mon, 2 Jan 2023 18:20:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sc8280xp: disable sound nodes
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-3-johan+linaro@kernel.org>
 <82ac16e1-6c8a-b050-d627-535b4562a422@linaro.org>
 <Y7L1HkPRwzuliUjR@hovoldconsulting.com>
 <Y7MRqbYWY3Qlyc8+@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y7MRqbYWY3Qlyc8+@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2.01.2023 18:17, Johan Hovold wrote:
> On Mon, Jan 02, 2023 at 04:15:42PM +0100, Johan Hovold wrote:
>> On Mon, Jan 02, 2023 at 01:29:38PM +0100, Krzysztof Kozlowski wrote:
>>> On 02/01/2023 11:50, Johan Hovold wrote:
>>>> The sound nodes in the SoC dtsi should be disabled by default.
>>>>
>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 16 ++++++++++++++++
>>>>  1 file changed, 16 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>> index ed1e2bee86ee..c1ce2d7b3675 100644
>>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>>> @@ -1733,6 +1733,8 @@ rxmacro: rxmacro@3200000 {
>>>>  
>>>>  			pinctrl-names = "default";
>>>>  			pinctrl-0 = <&rx_swr_default>;
>>>> +
>>>> +			status = "disabled";
>>>
>>> There is no reason this should be disabled by default. No external (per
>>> board) configuration is needed and by default SoC components should be
>>> enabled if they do not need anything from the board.
>>
>> This node is one of the nodes for which driver support is not yet in
>> place so that's one reason for at least disabling it temporarily.
>>
>> Since all other pinconfig lives in the board dts, if we decide to move
>> also the sound pinconfig then then that may be a second.
> 
> Also note that these depend on q6prmcc which is in turn depends on
> remoteproc_adsp being enabled by the x13s dts.
> 
> So keeping them disabled by default seems justified.
This I agree with, having sound-related nodes enabled by default
results in a big chunk of "deferred probe pending" spam when you
boot with adsp disabled (for example when you don't have fw for
your board in your rootfs)..

Konrad
> 
> Johan
