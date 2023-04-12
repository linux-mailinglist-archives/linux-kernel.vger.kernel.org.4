Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB1DE6DFBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjDLQyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDLQy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:54:28 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F81729D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:53:54 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id z9so3486104ejx.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681318394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kG5Bp9G8GHRtnaihhtMcFrai7auGDwatUysUi5rRPM4=;
        b=t3PMe32EZJV9cCoDIkveen1Mt0ZXC8V8Nwx01NlHfKa11Vx+CgCN03HLEdyF8L8B5N
         oxOXpHaRyvfb6AHDx289+vJStY+EJwIsxz2SoGGR9JMf7YslsfW4HNlOOoo+dKnwip6n
         n4ama1PFbDfxjtqwO9pD3cphtlWR6ziTaHcEeMg+nZ3IlSDCV/4n3PbMXeNk4kQBLG5j
         HyJ10opdEQ2AkrTWCC35fBqxipAajjYHeKzzyPpWbYjyiLh5Q521hbEOmgX8gzX8F7cB
         bjzUidW9notC7XkN9Ge7pxmkLJbN2txGTjI6U5bpvpvlXMT7gUpenEbW7xSWjhcUiFps
         FqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681318394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kG5Bp9G8GHRtnaihhtMcFrai7auGDwatUysUi5rRPM4=;
        b=gXrR+AyW7fr5laHripJT7D+4/rueiCKZ36HE717S6i2zTeu+wFOslySuvEuiEI4VkV
         mFLNQ8TFzXdD4PFNw8kxoU4MAZHaHYwlmTbAuPVf2NbQcAhmKuvaAwMXxjI1unnavFs7
         yD0vB99nx8tM68vHkoB2gq7Bm73dYcsKWqj8qPB6PrC8TThghe7KkvrSuQnAJw7jksGx
         176n6E/vugQKDiw+MPkiEnEJDyu/caRv8ik+YXg7UxA3rAYGQt7//390ySYcH52V6Vz6
         aVg5BslkbnUJM37M98V/5ateAfEZPWURghlmiL8HPrW2nLlsxKc85rVY0Ljt71yh/BTz
         tZdw==
X-Gm-Message-State: AAQBX9dmQP+iT+vNAj3u5uM+OwkP71ajmUhD5O9mKMs/tsNi0eEVldFv
        9Z6GASYBPEud0mpVn3ig15flaA==
X-Google-Smtp-Source: AKy350ZUDGBcr74cMS/N8WuiTB3okSg9uQJyGCy/5y+jKVibXQJYbcWciy75St+Vcb18YTNBYHTENQ==
X-Received: by 2002:a17:906:686:b0:931:ed:e379 with SMTP id u6-20020a170906068600b0093100ede379mr2931945ejb.67.1681318394546;
        Wed, 12 Apr 2023 09:53:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:938a:b3db:7c59:795e? ([2a02:810d:15c0:828:938a:b3db:7c59:795e])
        by smtp.gmail.com with ESMTPSA id ta20-20020a1709078c1400b0094770cf8b1fsm7455180ejc.5.2023.04.12.09.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:53:14 -0700 (PDT)
Message-ID: <15f48b06-a6be-1295-5deb-d3594bce6699@linaro.org>
Date:   Wed, 12 Apr 2023 18:53:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Marc Zyngier <maz@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230328-topic-msgram_mpm-v2-0-e24a48e57f0d@linaro.org>
 <20230328-topic-msgram_mpm-v2-1-e24a48e57f0d@linaro.org>
 <168069726278.2356075.14351594478003012447.robh@kernel.org>
 <20230405134727.GA2461305-robh@kernel.org>
 <1e6e2590-ac78-400b-35ce-321d5e52f385@linaro.org>
 <9df12111-ec84-c4f7-fbcb-bccaef91b048@linaro.org>
 <3ce9b5ec-8b02-537a-c663-c849e80cab66@linaro.org>
 <ZDAAToSzNLVo6le8@gerhold.net>
 <198523f5-d06f-15cd-af6c-f391c02bcaa9@linaro.org>
 <1f8fc036-380b-0a42-bb29-a3e275ed6a33@linaro.org>
 <2e648a97-083e-8ee2-1695-4af299bb222a@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2e648a97-083e-8ee2-1695-4af299bb222a@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 14:09, Konrad Dybcio wrote:
> 
> 
> On 12.04.2023 13:55, Krzysztof Kozlowski wrote:
>> On 12/04/2023 13:47, Konrad Dybcio wrote:
>>>> For unrelated reasons I actually have some patches for this, that switch
>>>> the /smd top-level node to a "remoteproc-like" node dedicated to the
>>>> RPM, similar to how WCNSS/ADSP/Modem/etc are represented. I need this to
>>>> add additional (optional) properties like "resets" and "iommus" for the
>>>> RPM, but it would allow adding arbitrary subnodes as well:
>>>>
>>>> https://github.com/msm8916-mainline/linux/commit/35231ac28703805daa8220f1233847c7df34589e
>>>>
>>>> I could finish those up and post them if that would help...
>>> Krzysztof, what do you think?
>>
>> I don't know what is there in MSM8916 and how it should be represented.
> Similarly to other Qualcomm SoCs, MSM8916 has a RPM (Cortex-M3) core,
> which communicates over the SMD protocol (or G-LINK on >=8996).
> 
> The Qualcomm firmware loads the RPM fw blob and sets it up early in
> the boot process, but msm8916-mainline folks managed to get TF-A
> going and due to it being less.. invasive.. than the Qualcomm TZ,
> RPM needs a bit more handling to be accessible.
> 
> The M3 core is wired up through the CNoC bus and we communicate
> with it through the MSG RAM and the "APCS mailbox".

Thanks, that's actually good description. Yet I still do not know what
is exactly the problem and the question. Linking some out of tree
commits does not give me the answer, at least I cannot get that answer
form the link.

For example what I don't understand is: why additional resources (like
resets) can be provided only in new binding, but not in the old.

Best regards,
Krzysztof

