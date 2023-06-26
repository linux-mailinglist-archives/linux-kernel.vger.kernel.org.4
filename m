Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E171773E4C9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjFZQSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFZQRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:17:12 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83166198C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:15:18 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-307d20548adso3146558f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687796117; x=1690388117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QXdcqnvtNLyYu0+DzoP64iL7BfxCUJXqKjjg/aEjYQI=;
        b=BQyAxkXZ/Pm8o888uBT0Y2kNK2mhYizFhK3HVzRIdqmzuAn6Gs2D3LsYIOBLcl+svX
         i9Wz2xn/4cYfe4gR0ISAEeUPFbRmu0pfQcC3OsUiNW5b+irGTbPSXOOYQ0NN0d+VAP4g
         I9NtpShUSCTrVjXqUTS/qhaxNVIsW91WNpkYLkRKPw7HIIrkhx1zivzDNqClkkLCyjF9
         mguDvcohXv41IN1B/trN9Nzi6S/Fa9cWQA0Qx29ANAysYN2Mqc8aHcbxCmXwdCdhsshu
         1+mFtTnuFPIBZpps1BIJP/pMEEGSQLlF2xivddDPAd7v/kR8RYD1MbOF8Vw0vBp7YxlG
         cuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796117; x=1690388117;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXdcqnvtNLyYu0+DzoP64iL7BfxCUJXqKjjg/aEjYQI=;
        b=S5+FvSVlPud9dqo8bEksLwZlf6LnA6bJme5WVeSDe68ugnPPM9g6DJHCvTnln0Zlfx
         YOfrMnXEsncWoEn860S2UroRu7lEua11FZPwkgccnWSvI9k37qDLT33ML7TPdUEgMcKU
         3sC1TagEyMYr4ZHq6lS3fJFpX2swf0DBXeIzmrqOqcHYUjV++C8f4D/uYgJXOzHuuutW
         a1PB3fSWb8dkyf28X7S3QpSX38O2TkRf7UCSBazef+hrCg519gl03vM0ZsZ1ILVB27ii
         4QQjPeSbVSDCYIWeZia1u/EWNRgApKuA+cwFWOcnvPzC8zs4VQIVNTwo88aa1kwKGml0
         woJA==
X-Gm-Message-State: AC+VfDyEWqi8GemkeYushgs/KrrpLbYSSan4dFQxY2Is3SvZ6EkR2RwB
        vCW7HbwKQyBJSMH1KVddOthYmA==
X-Google-Smtp-Source: ACHHUZ6L7+dXpjqr2EV3aL4IlTsw7dGgISi6PqeOrudMedtpUkBoHht2nG3bZmc6aUVxu1ixi0dDDw==
X-Received: by 2002:adf:e684:0:b0:30e:5284:cbc4 with SMTP id r4-20020adfe684000000b0030e5284cbc4mr20071341wrm.68.1687796116886;
        Mon, 26 Jun 2023 09:15:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m16-20020a5d6250000000b003068f5cca8csm7755235wrv.94.2023.06.26.09.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:15:16 -0700 (PDT)
Message-ID: <c3c79634-b4d3-84a4-4c41-8d74d8648313@linaro.org>
Date:   Mon, 26 Jun 2023 18:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/15] dt-bindings: clock: qcom,dispcc-sm6125: Require GCC
 PLL0 DIV clock
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>
References: <20230624-sm6125-dpu-v1-0-1d5a638cebf2@somainline.org>
 <20230624-sm6125-dpu-v1-3-1d5a638cebf2@somainline.org>
 <c9681bce-efa8-9b79-4bf6-837dd6a2dc12@linaro.org>
 <edrftxqhywiaxvbonyh25cmubrg77y4dryqoy7id4ndan2lfa7@rhvcoavtg5vl>
 <f62d750e-da73-fece-c3de-0dac1fbb9827@linaro.org>
 <dp2ucgmql2jff52nbxti2hwjchtgjkbrwcgpx3p7ruodz7adnj@635pcqr6fv4x>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dp2ucgmql2jff52nbxti2hwjchtgjkbrwcgpx3p7ruodz7adnj@635pcqr6fv4x>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 16:26, Marijn Suijten wrote:
> On 2023-06-26 11:43:39, Konrad Dybcio wrote:
>> On 25.06.2023 21:48, Marijn Suijten wrote:
>>> On 2023-06-24 03:45:02, Konrad Dybcio wrote:
>>>> On 24.06.2023 02:41, Marijn Suijten wrote:
>>>>> The "gcc_disp_gpll0_div_clk_src" clock is consumed by the driver, will
>>>>> be passed from DT, and should be required by the bindings.
>>>>>
>>>>> Fixes: 8397c9c0c26b ("dt-bindings: clock: add QCOM SM6125 display clock bindings")
>>>>> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
>>>>> ---
>>>> Ideally, you'd stick it at the bottom of the list, as the items: order
>>>> is part of the ABI
>>>
>>> This isn't an ABI break, as this driver nor its bindings require/declare
>>> a fixed order: they declare a relation between clocks and clock-names.
>> Bindings describe the ABI, drivers implement compliant code flow.
> 
> That is how bindings are supposed to be...  However typically the driver
> is written/ported first and then the bindings are simply created to

Your development process does not matter for the bindings. Whatever you
decide to do "typically" is your choice, although of course I understand
why you do it like that. You can argument the same that "I never create
bindings in my process, so the driver defines the ABI".

> reflect this, and sometimes (as is the case with this patch)
> incorrectly.
> 
> That, together with a lack of DTS and known-working device with it
> (which is why I'm submitting driver+bindings+dts in one series now!)
> makes us shoot ourselves in the foot by locking everyone into an ABI
> that makes no sense.

No one is locked into the ABI. SoC maintainer decides on this. However
unjustified ABI breaking or not caring about it at all is not the way to
go. It is not the correct process.

> 
>>> This orders the GCC clock just like other dispccs.  And the previous
>>> patch dropped the unused cfg_ahb_clk from the bindings, so all bets are
>>> off anyway.
>> Thinking about it again, the binding has not been consumed by any upstream
>> DT to date, so it should (tm) be fine to let it slide..
> 
> Exactly, I hope/doubt anyone was already using these incomplete
> bindings.  And again: the ABI here is the name->phandle mapping, the
> order Does Not Matter™.

No, it's not. Your one driver does not define the ABI. There are many
different drivers, many different operating systems and other software
components.

Best regards,
Krzysztof

