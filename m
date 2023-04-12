Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5538E6DFC3D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjDLRGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjDLRGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:06:39 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1878511C
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:06:28 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d7so26690218lfj.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681319186; x=1683911186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YMWU8Odwaeq/SVRM7bWqxudWTUga4vVKtqmtQDwWNBI=;
        b=lePux3/Euo0n5p7HK3txuaSevsS1qwKPm+gky8y0kDybxkRMBAf/dWz0iw2YxuKSOL
         VWaKlLwM2iw93KWc5LaSEcMWEoVqyYBN+1EBj9+cL9q9D82CAZujCViEG9Uh+8lrkwWj
         u/dyXL18ES6oSzaQUrH3nYWDPH+tRZvpQihdQ9+kYNCeaTx5y+FG8hbsFH3kuEGtSggf
         PJ+5nnsPxcSvL9RBemjWp0inmqZlJ4lVyrPZbxjfky7Mcmtp08/KaxZJYXweXSNv6Ov7
         W/2fMjGN5OikTOwJKsAQLSi+02qzwbgpMfHJFE/hWFR2C/G9nk8RX4OI/qyfCgz2ly2z
         /w0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681319186; x=1683911186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YMWU8Odwaeq/SVRM7bWqxudWTUga4vVKtqmtQDwWNBI=;
        b=E/KOk942ezOdQF1TLdGpFpK5zEYHDGNrbCcVEP+o1CDiXqh4H3VWBZKI5b0IHSAt+x
         q3YnW6PD73e1n9nw7O3ILo7M6ZogAW6rLVqClEjDB2UZs73bNF7ymTCV/FAGkwWf8xKU
         N8wPFfFiTro8E8qfRPWrHrFOqtXuwn9KynMP50HJjROJL3PoHS8o+LZrfsOY0InQeYl3
         PymH2O9cGve8xifyKkiEspLxBoiFA2sNVOIWreG1138aFCN/QBmCrajqQDc0mgMkSNZc
         NAzXEKmDnjCpcEZ9I0dzYG/c6IuyY1WtPOlg55BxgKFPVkyBcvGdEiRImECsHSyrg+pr
         exrg==
X-Gm-Message-State: AAQBX9cuD8N6pAhMnKe+4J1IBiPAIQrwm1auQ5JaaoAGuLcF2WGMUgnc
        +k38U+bXJR2HGmvUst18LKAEgA==
X-Google-Smtp-Source: AKy350bI4jPRNH/NAaU1a5TiN5ekPVZ5GXEu4ZAzGBUdq56HE44Rd4Ez9wd2aJGqc2KCFWuy+Cn2Wg==
X-Received: by 2002:ac2:53b3:0:b0:4ec:9310:ad4e with SMTP id j19-20020ac253b3000000b004ec9310ad4emr768774lfh.33.1681319186301;
        Wed, 12 Apr 2023 10:06:26 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id q14-20020ac25a0e000000b004db48ae69cbsm3095120lfn.206.2023.04.12.10.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:06:25 -0700 (PDT)
Message-ID: <ec32fc8e-56e0-51a5-dd96-c7cc8b9cf71f@linaro.org>
Date:   Wed, 12 Apr 2023 19:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] dt-bindings: interrupt-controller: mpm: Pass MSG
 RAM slice through phandle
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
 <15f48b06-a6be-1295-5deb-d3594bce6699@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <15f48b06-a6be-1295-5deb-d3594bce6699@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12.04.2023 18:53, Krzysztof Kozlowski wrote:
> On 12/04/2023 14:09, Konrad Dybcio wrote:
>>
>>
>> On 12.04.2023 13:55, Krzysztof Kozlowski wrote:
>>> On 12/04/2023 13:47, Konrad Dybcio wrote:
>>>>> For unrelated reasons I actually have some patches for this, that switch
>>>>> the /smd top-level node to a "remoteproc-like" node dedicated to the
>>>>> RPM, similar to how WCNSS/ADSP/Modem/etc are represented. I need this to
>>>>> add additional (optional) properties like "resets" and "iommus" for the
>>>>> RPM, but it would allow adding arbitrary subnodes as well:
>>>>>
>>>>> https://github.com/msm8916-mainline/linux/commit/35231ac28703805daa8220f1233847c7df34589e
>>>>>
>>>>> I could finish those up and post them if that would help...
>>>> Krzysztof, what do you think?
>>>
>>> I don't know what is there in MSM8916 and how it should be represented.
>> Similarly to other Qualcomm SoCs, MSM8916 has a RPM (Cortex-M3) core,
>> which communicates over the SMD protocol (or G-LINK on >=8996).
>>
>> The Qualcomm firmware loads the RPM fw blob and sets it up early in
>> the boot process, but msm8916-mainline folks managed to get TF-A
>> going and due to it being less.. invasive.. than the Qualcomm TZ,
>> RPM needs a bit more handling to be accessible.
>>
>> The M3 core is wired up through the CNoC bus and we communicate
>> with it through the MSG RAM and the "APCS mailbox".
> 
> Thanks, that's actually good description. Yet I still do not know what
> is exactly the problem and the question. Linking some out of tree
> commits does not give me the answer, at least I cannot get that answer
> form the link.
> 
> For example what I don't understand is: why additional resources (like
> resets) can be provided only in new binding, but not in the old.
The old binding dictates that the rpm node (which in turn
holds all "devices" that only interface with RPM, like RPMCC) is
a child of smd{}, which does not make sense logically, as SMD is
a protocol (e.g. we don't place devices connected over i2c under
/i2c{}). The rpm node lacks a compatible, as it's representing
an "smd channel", so there's no driver so there's no way to assert
resets etc.

On newer SoCs that still implement SMD RPM (like 8996), we do
actually have a driver and a parent node which it binds to
(rpm-glink).

AFAIU:
In both cases, the "final" drivers (rpmcc, rpmpd..) are bound
after hitting a SMD/GLINK callback that tells Linux we're ready
to rock. That's an issue for Stephan, as these callbacks won't
ever happen if the RPM core is not initialized (and TF-A doesn't
do that).

Konrad
> 
> Best regards,
> Krzysztof
> 
