Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD22C73F6DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjF0IVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjF0IVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:21:19 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB0173C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:21:17 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fba94f26b1so403935e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687854076; x=1690446076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=62PvuKpVR4vvVJ+czbvONPwN6io0eLrvuJxR3ESd9KA=;
        b=GWJ9ONMSJlMwyYXp0QaRKdaJtu5jZBcNxzdkPKUwRpJhwrwX8c1oqud662S6O4ihKq
         F12QXcEAEIpIvy36KrpOXKMDntQowJdz9/xuPNmmzcv92GGCXuAMA4OGjXTlWB2cr0zj
         htXt7F/EKv+oWankZqOEy+DVMFKw0Edbljrb8IPfWM3xTyKxrrD+IqCiiJ6AY9o4RZXa
         MeWxAjQ09kxu5VA6De4g7ejM4B5ySaVEnB02kj/YjkbXYjr4VqSqSQ3fn5FWb9NuvRYn
         QB7lpctHLQPZLpQZn5XtQow9S4KY7bdecScKLdGxXOvNbzLL0apf6pIWdZY+Kla/eNep
         uB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687854076; x=1690446076;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=62PvuKpVR4vvVJ+czbvONPwN6io0eLrvuJxR3ESd9KA=;
        b=ZO8rI9VhMWsyVbehTvHAOM+cuj6xyM3IA2TFjISYzx/2CRCEwF0HA2Jm6dUUx/Vlqb
         aT1VJEIr51UpdtkKDOCKggQ6fAPgsTOudy6DC4p7B59E+tBK2UYvK1J3rzd6+0zesCv5
         MctucL0laynObeDKB4gbJYduhXdM5KFeA+f5DqN5Ept5FJL3u0wF/OIfHdA7SEt1e+eQ
         tq59Px/WVwukFXhzWp2PLzrl7js+ACUJQ/7FGSt6q3E9l1a3QYI5fAfC4JSwRinL/ZAZ
         yemSME72hWM5YJUBNNJqw82LTZ35nFze1EGQDhiuRBBCVo/TetGfeL6W35faRvbmwLOc
         4A/A==
X-Gm-Message-State: AC+VfDygHj5NNlVOte9AULSjFIq9dwnKyyKNV6Anlt0WZJN8xrs7kwGY
        9QzVSfbZtqeIblMLuDM6z/0+KQ==
X-Google-Smtp-Source: ACHHUZ4PvmNA0F8Q+dsc+125+loCwPVtHMhlTOLwsM5Ei8GYIzO5r9zAz/2rQpnzolZP8rtVPJDjVA==
X-Received: by 2002:a05:600c:3657:b0:3f6:8ba:6ea2 with SMTP id y23-20020a05600c365700b003f608ba6ea2mr29015214wmq.15.1687854075903;
        Tue, 27 Jun 2023 01:21:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l1-20020a1ced01000000b003f9b0830107sm12942303wmh.41.2023.06.27.01.21.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 01:21:15 -0700 (PDT)
Message-ID: <145ab255-b3f8-1c6c-824d-5f1b40568d30@linaro.org>
Date:   Tue, 27 Jun 2023 10:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 03/15] dt-bindings: clock: qcom,dispcc-sm6125: Require GCC
 PLL0 DIV clock
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
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
References: <55b0ca89-8f2e-5383-59d4-6809e813abf8@linaro.org>
 <vnp263d43flny2ibt3n7fbloyi26enqrejnobogplfu5fcj6l3@s7zkxrsi2rde>
 <52c57cab-10cf-2e7e-2c1d-fa6506786d45@linaro.org>
 <jmtjuya4c423rmdlo4ubvvqndbxvgapal5otjqnejdpdd25izp@kewbjmqdu2xs>
 <6311f26f-79ee-c471-649f-5e0b4629cfcc@linaro.org>
 <uuy5prkjhhs66te7h6z3pu4lzj2cfbiqk6ftjijwoeqpw573av@ogs6cboanvzc>
 <ziykmixskqkgheigefvyo4q3katbc4uix6jtcg7mncs25z4tj5@5gykrfgns4bm>
 <16731023-7dc7-d43d-1b16-fda44c0948ed@linaro.org>
 <yofju7jp7vmv33x7dzvzoelpumfsz3fjqy2ozakfphsuysunon@pglt2wzlsjex>
 <683a6f7e-bf1a-aff2-070b-472fb14e0353@linaro.org>
 <3nnk4xvmpnum2q6g6c6crjlqq3ra7j2z5zis53xcqbvevymuhz@mkffvs45n6ut>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3nnk4xvmpnum2q6g6c6crjlqq3ra7j2z5zis53xcqbvevymuhz@mkffvs45n6ut>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 09:49, Marijn Suijten wrote:
> On 2023-06-27 09:29:53, Krzysztof Kozlowski wrote:
>> On 27/06/2023 08:54, Marijn Suijten wrote:
>>> On 2023-06-27 08:24:41, Krzysztof Kozlowski wrote:
>>>> On 26/06/2023 20:53, Marijn Suijten wrote:
>>>>> On 2023-06-26 20:51:38, Marijn Suijten wrote:
>>>>> <snip>
>>>>>>> Not really, binding also defines the list of clocks - their order and
>>>>>>> specific entries. This changes.
>>>>>>
>>>>>> And so it does in "dt-bindings: clock: qcom,dispcc-sm6125: Remove unused
>>>>>> GCC_DISP_AHB_CLK"?
>>>>>
>>>>> Never mind: it is the last item so the order of the other items doesn't
>>>>> change.  The total number of items decreases though, which sounds like
>>>>> an ABI-break too?
>>>>
>>>> How does it break? Old DTS works exactly the same, doesn't it?
>>>
>>> So deleting a new item at the end does not matter.  But what if I respin
>>> this patch to add the new clock _at the end_, which will then be at the
>>> same index as the previous GCC_DISP_AHB_CLK?
>>
>> I think you know the answer, right? What do you want to prove? That two
>> independent changes can have together negative effect? We know this.
> 
> The question is whether this is allowed?

That would be an ABI break and I already explained if it is or is not
allowed.

Best regards,
Krzysztof

