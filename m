Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4D77028B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238957AbjEOJfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238458AbjEOJev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:34:51 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A168E4F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:34:49 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f139de8cefso64035876e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684143287; x=1686735287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YedmYbdsrC2oJUHY1z9NJXgEQNuEGTV8E4CJL4N6VY=;
        b=fskEsyQcAdq8PC2Nxu3GlvJLGyq3C9x7laMPhFMB9a1uvDfMf7pDo/ExTHAOpsv8mG
         GemhbAHzUgOBWu/rKgNUgx1n3iQ5bm80CMBzVjKAxJ0KdnznPqFn7A9R3PyEofYwbZSm
         6COHZEtoJ/leOAXzs1Xz3JW5i/LpufIb9jVQvHbQQNAgICVZsEG99wZFqC04wzGOMHM6
         8pTwZRSPEBY2qsQB6XuRafXBSHFOqq/pUTY6Jgbt7mr214jPgfcJFvE8gtiiogK1sMlM
         BtP0hVsPb4eb+FV9yJUZbIMCRo5p4XbslCQ8/ctAcahuTtvjQ7qTueIErM5hJnE3kk/d
         cTUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684143287; x=1686735287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YedmYbdsrC2oJUHY1z9NJXgEQNuEGTV8E4CJL4N6VY=;
        b=KlTLe7uxnhuIAJJFaLnOFWk3WT19JR3L54NCtsohz8+T8pqNUsBBJIw8ECDzXvmQnt
         2uJ7Tvs3gldx7fI20k2HR46QYhtf5ckD+Bs+kkTXKZV0CgGXpZtCEE41eoj8K2oeaQ4Y
         Pfj5YaEWc53GqpsNyqr0vIEJIOZeHBzNCnXd1R9YaestJHQ+xFOBNTUUy4nRb377suyB
         J8eqFC1gbyQWqzqRhyT/u8OQPnlBSHk7w67hQnvhbKa47JL10oJMLz6BVJRLuclHqbRA
         tQ0XrnEjkBl2/nPRMt38TGL3xZ2YrxLwsedKuBmgyeTtcBaL4TZS0PP6CvFvmI9TKcXm
         FwBQ==
X-Gm-Message-State: AC+VfDwkekOVlGFFYr+5V7YbJgFjeGo48nsJbczRSxAN3V5a9T2MOE/m
        rD4QTpbxrafbchpD/NFUvNNPtg==
X-Google-Smtp-Source: ACHHUZ7FkbPUTfccsX857fp2xm+ZueBlVsh69VDsUlwbviqwPga6gfRNcsV1UwQjuuvem1VLYpYeKg==
X-Received: by 2002:a2e:8058:0:b0:2a8:baea:2554 with SMTP id p24-20020a2e8058000000b002a8baea2554mr7088081ljg.3.1684143286788;
        Mon, 15 May 2023 02:34:46 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id a15-20020a05651c010f00b002ad988efd73sm2731114ljb.14.2023.05.15.02.34.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 02:34:46 -0700 (PDT)
Message-ID: <1ecd0cba-296e-b036-f59e-f679c771ae9f@linaro.org>
Date:   Mon, 15 May 2023 11:34:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Flush RSC sleep & wake votes
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230512150425.3171122-1-quic_bjorande@quicinc.com>
 <f6ecd66b-e207-0ed9-0ff3-1febfdf5bce9@linaro.org>
 <20230515023828.jqrrqkit5ygovimp@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230515023828.jqrrqkit5ygovimp@ripper>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15.05.2023 04:38, Bjorn Andersson wrote:
> On Sat, May 13, 2023 at 11:09:07AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 12.05.2023 17:04, Bjorn Andersson wrote:
>>> The rpmh driver will cache sleep and wake votes until the cluster
>>> power-domain is about to enter idle, to avoid unnecessary writes. So
>>> associate the apps_rsc with the cluster pd, so that it can be notified
>>> about this event.
>>>
>>> Without this, only AMC votes are being commited.
>> Ouch.
>>
>> Should we make this required: in bindings and add it to all
>> platforms?
>>
> 
> I though this was an optimization and in the absence of this callback
> the driver would just write out wake and sleep sets as well. But per the
> current implementation (and perhaps some underlying cause?) it is indeed
> required, if you care about power consumption.
Hm.. since it's not strictly required for operation, would something
like this be fitting?:

oneOf:
  - required:
      [...]
      - power-domains

  - required:
      [...]
    deprecated: true

(if it even works this way)

Konrad
> 
>>>
>>> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
>>> ---
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
>>
> 
> The Fixes sounds reasonable.
> 
> Thanks,
> Bjorn
> 
>> Konrad
>>>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> index 8fa9fbfe5d00..5c68f2182c2f 100644
>>> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
>>> @@ -3982,6 +3982,7 @@ apps_rsc: rsc@18200000 {
>>>  			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
>>>  					  <WAKE_TCS    3>, <CONTROL_TCS 1>;
>>>  			label = "apps_rsc";
>>> +			power-domains = <&CLUSTER_PD>;
>>>  
>>>  			apps_bcm_voter: bcm-voter {
>>>  				compatible = "qcom,bcm-voter";
