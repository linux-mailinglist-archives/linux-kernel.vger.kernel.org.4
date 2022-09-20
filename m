Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E7D5BE0D2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiITIzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiITIyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:54:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B7129CB6
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:54:41 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id u18so2617292lfo.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/R9hqooZ2WhPjRpl0VQUVEHIhAT+zabNTgearvK0bTY=;
        b=QZxxvmqBSRxXPI03uhpH6teHa41fSx8Q25y66FPLTN/JTJtgg/dPVbcu14r12s0TGE
         D3e8WTBxm6B9UviRF+ewiOjn0s/HqmLa1jr8hEffLXiR/ZqIjy4NHGyPzlMlZ6eqR+8U
         vRpNjd4/22GLDHhu3/aKOdZ4GXgnvkax30g28yJoJjRBznK1GqtSkAERb+B8vG/7Caeu
         xCBC/kxix+T+GSDahNZTGTEsfMyVTVOaNo6DShICRb3eT4Uy388jVS01k2P15orbHXih
         9QpEWbu4Tc9BZsQIQD/qR5WQNICzKzdIipdSESjFeqniVRo9019+Mn3Hh871kIRZeSwW
         GeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/R9hqooZ2WhPjRpl0VQUVEHIhAT+zabNTgearvK0bTY=;
        b=4/T6UyatWmn07DpRJI8W3HuqmlyAxcASPusuzPjIxP3KJDL0jvVfgCiekYH6Cx0iw3
         cz9GRtI0MPpAVbELoTNqP2S0ORjyw0G4kCAwBcTmzunyzkmPMTtEJMlXixte19Uv4X3+
         GhIEi/8t+TrwXvptwdx6uAVP76s6Hpipu8H9/AdmSKDZqAQUS26LADqDqTSBWSLKzFz1
         dAgvcuanQW6FFis8eEi2WMKCO7soU7yqS40Eh6PKcRyvh7MG7egirml6YQZZ673/LAf4
         8Q2MjUKWs4qjoyoKEaR8Od9ozFxDbudO5jMtwJgxwPuBS5bNSuCKu+uHPzAGoVmS4N4z
         T8uQ==
X-Gm-Message-State: ACrzQf17BQt9ezrWjC0BWvvGs4HJtF9MMNzUMHCSwPRpf6Gb2tdL88+B
        3tTGXbgJrjylU07JV7PE+UBZlA==
X-Google-Smtp-Source: AMsMyM5pioa34SQt+KAmG2EUQFfy9zDDTHSE8Z9k2mKkZ2Bf0+l/mvjxkzbKEMv0lXSeJrRzOYksJg==
X-Received: by 2002:a05:6512:3b10:b0:498:fd40:51d2 with SMTP id f16-20020a0565123b1000b00498fd4051d2mr7546367lfv.11.1663664079033;
        Tue, 20 Sep 2022 01:54:39 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bu25-20020a056512169900b0048afbe8a6a1sm201785lfb.241.2022.09.20.01.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 01:54:38 -0700 (PDT)
Message-ID: <2ad436c8-8b7a-80ed-9c91-d2293eff70ab@linaro.org>
Date:   Tue, 20 Sep 2022 10:54:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v6 0/4] dt-bindings: qcom-qce: Convert bindings to yaml &
 related changes
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, Jordan Crouse <jorcrous@amazon.com>
References: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
 <36bd1c19-8fbd-0903-704d-447117b2007a@linaro.org>
 <dfe1bc9e-2ab9-d2dd-7daa-dddb8d66fd77@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dfe1bc9e-2ab9-d2dd-7daa-dddb8d66fd77@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:48, Bhupesh Sharma wrote:
> 
> On 9/20/22 12:58 PM, Krzysztof Kozlowski wrote:
>> On 20/09/2022 00:08, Bhupesh Sharma wrote:
>>
>> (...)
>>
>>
>>>
>>> Qualcomm crypto engine (qce) is available on several Snapdragon SoCs.
>>> The qce block supports hardware accelerated algorithms for encryption
>>> and authentication. It also provides support for aes, des, 3des
>>> encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
>>> authentication algorithms.
>>>
>>> Note that this patchset is dependent on the dt-bindings patchset (see [1]) sent to devicetree list.
>>>
>>> [1]. https://lore.kernel.org/linux-arm-msm/20220919195618.926227-1-bhupesh.sharma@linaro.org/
>>
>> If it is dependent on the bindings only, keep them together. However I
>> don't think this is the only dependency. You add here several
>> compatibles which are not supported.
> 
> 
> Please go through the cover letter where I mentioned that:
>    'As per Bjorn's suggestion on irc, broke down the patchset into 4
>    separate patchsets, one each for the following areas to allow easier
>    review and handling from the respective maintainer(s):
>          'arm-msm', 'crypto', 'dma' and 'devicetree'
>    This patchset is directed for the 'devicetree' tree / area.'
> 
> Basically now the patchset which had around 23 patches in v5 will send 
> out as 4 separate patchsets one each for 'arm-msm', 'crypto', 'dma' and 
> 'devicetree' trees.
> 
> So when all the respective subsets are picked up, all the compatibles 
> are in place.

and none of reviewers can find them, because you linked only bindings.
Keeping bindings separate from everything is not good approach. Either
they should be with DTS or with driver changes. Otherwise how can we
even look that they are matching DTS?

Keeping them separate even makes impression there are no ABI breaks and
bisectability issues...


Best regards,
Krzysztof
