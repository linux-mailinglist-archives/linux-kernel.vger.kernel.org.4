Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523BF74825B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 12:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjGEKnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 06:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjGEKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 06:43:17 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA591E63
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 03:43:14 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f86e6e4038so754513e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 03:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688553793; x=1691145793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12A9qcUVJY2HjTp99aSPBCbjL3RJ6iwTw28gJjZZd5I=;
        b=maLNQ7kVki8KKtj9rXkDPl0YLHRDT2SzUZQxgQ04P6nRQTNf9aMfk59zaRwYRBZCG9
         ni8rtwdFGDibilatQ4az5XJvPypiqCCCXGx8fRtqZinJ+3Oa6Gb8/hNwGkpCRLDTOXcO
         Awbwkh5zMygJoh5wX+Y/FveBTHQBgSaBemz88mlaSWFhb5VBJZ0yzvfWKeVDF6a6YAgL
         LNEx40Pwr3Ichr2pVfUOm13ReDYKnzGUP+O1zZbM756DqeEu+8FZYHDC/kH1jWdeiRqo
         hq9Bkq+25oLHiEaKiKk9X6wn6nDNYYV7b3NeMbajI/a6hFO6jcM/v/Nw2aD/zHGTuBYz
         Ga2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688553793; x=1691145793;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=12A9qcUVJY2HjTp99aSPBCbjL3RJ6iwTw28gJjZZd5I=;
        b=BhDa4491Mt5HcwdZkpaCBRjLiQQb1/Yl/5gWHkeGyQhQ5bERRx8n4DfGyuUnNGuMGJ
         maBGbQY7LNdHDbg/ceQP05IGJgvrjDKlUc8hxOKIVP8wa0eErVDfRbPfy+oaUaROOAJk
         f3nfra9TI9e+UsywTWAqGQ55g3rZYqcjrTOExPw4RwtQhuSAenlzwDK0hfHNG2hlbG5g
         ujXm0gk0XUh0Dxf0iffOkt9dy2dLo+o8ms3WCHeEOXeWS1d8FskF0qDBUF8BcVQqy+UT
         WFnnsFHfPAyAsa7rbGhJgpFlfJLBXFbEMaDKD/pqRAwIgDRV6xPGl2vUDxmsk6iwUUuW
         Ygbw==
X-Gm-Message-State: ABy/qLaqKP4Fu5V4kB5Gica3ji5kxe2+mBL8OlElaSKGL75lupn8LO5t
        leGFgFXt/yVsfcWNbHUCfEIOYg==
X-Google-Smtp-Source: APBJJlFl4J5Bz/jVEqr/boTDXtZr5d6EOFdZrFDRQJguSRxRTxcwf03MCbEG98IUqQVthdUKAZjqGg==
X-Received: by 2002:a05:6512:e86:b0:4fb:7624:85a5 with SMTP id bi6-20020a0565120e8600b004fb762485a5mr799188lfb.0.1688553792793;
        Wed, 05 Jul 2023 03:43:12 -0700 (PDT)
Received: from [192.168.1.101] (abyj26.neoplus.adsl.tpnet.pl. [83.9.29.26])
        by smtp.gmail.com with ESMTPSA id x8-20020ac24888000000b004fba4e27abesm2988053lfc.241.2023.07.05.03.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 03:43:12 -0700 (PDT)
Message-ID: <553bd028-aaf3-b128-ae4c-7f938c23e889@linaro.org>
Date:   Wed, 5 Jul 2023 12:43:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 02/10] dt-bindings: power: Add rpm power domains for SDX75
Content-Language: en-US
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        sboyd@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <1688395346-3126-1-git-send-email-quic_rohiagar@quicinc.com>
 <1688395346-3126-3-git-send-email-quic_rohiagar@quicinc.com>
 <0d468d08-6410-e424-b4f3-5245cdb0334a@linaro.org>
 <85456057-c4ef-68a6-4fc5-c9fd03b01b71@quicinc.com>
 <06506ed7-f861-0bca-8b87-e2da6a6bc789@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <06506ed7-f861-0bca-8b87-e2da6a6bc789@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5.07.2023 10:54, Rohit Agarwal wrote:
> 
> On 7/4/2023 11:47 AM, Rohit Agarwal wrote:
>>
>> On 7/3/2023 8:29 PM, Konrad Dybcio wrote:
>>> On 3.07.2023 16:42, Rohit Agarwal wrote:
>>>> Add RPM power domain bindings for the SDX75 SoC.
>>>>
>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> ---
>>>>   Documentation/devicetree/bindings/power/qcom,rpmpd.yaml | 1 +
>>>>   include/dt-bindings/power/qcom-rpmpd.h                  | 8 ++++++++
>>>>   2 files changed, 9 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>>> index afad313..58e1be8 100644
>>>> --- a/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>>> +++ b/Documentation/devicetree/bindings/power/qcom,rpmpd.yaml
>>>> @@ -40,6 +40,7 @@ properties:
>>>>         - qcom,sdm845-rpmhpd
>>>>         - qcom,sdx55-rpmhpd
>>>>         - qcom,sdx65-rpmhpd
>>>> +      - qcom,sdx75-rpmhpd
>>>>         - qcom,sm6115-rpmpd
>>>>         - qcom,sm6125-rpmpd
>>>>         - qcom,sm6350-rpmhpd
>>>> diff --git a/include/dt-bindings/power/qcom-rpmpd.h b/include/dt-bindings/power/qcom-rpmpd.h
>>>> index 1bf8e87..8092d0d 100644
>>>> --- a/include/dt-bindings/power/qcom-rpmpd.h
>>>> +++ b/include/dt-bindings/power/qcom-rpmpd.h
>>>> @@ -57,6 +57,14 @@
>>>>   #define SDX65_CX_AO    4
>>>>   #define SDX65_MXC    5
>>>>   +/* SDX75 Power Domain Indexes */
>>>> +#define SDX75_CX    0
>>>> +#define SDX75_CX_AO    1
>>>> +#define SDX75_MSS    2
>>>> +#define SDX75_MX    3
>>>> +#define SDX75_MX_AO    4
>>>> +#define SDX75_MXC    5
>>> Please instead introduce a set of defines without the SoC prefix
>>> (i.e. CX, CX_AO, MX etc.). We've been putting this off for too long
>>> and you're the first unlucky guy that submitted new RPMhPD support after
>>> we've concluded it'd be the way to go! :D Sadly, we can't replace the
>>> existing ones retroactively..
>> Surely No issues. Will update it.
> 
> I have a doubt here. Cant we completely omit the #defines here and directly index this as 0,1,...
> because if the intention of this #defines is to understand the name of the pd then we can get
> it from the .name attribute in rpmhpd as well, right?
> 
> The problems with a common set of #define would be, lets say if we define CX_AO as 1 and some platform
> doesn't have CX_AO then wouldnt it leave a null entry in the driver entry of that platform?
Yes.

We already do this in the rpmh clock driver, as:

1. there are domains that all chips share (like CX etc.)
2. wasting a couple of bytes lets us massively save on convolution

Konrad
> 
> Thanks,
> Rohit.
> 
>>
>> Thanks,
>> Rohit.
>>> Konrad
>>>> +
>>>>   /* SM6350 Power Domain Indexes */
>>>>   #define SM6350_CX    0
>>>>   #define SM6350_GFX    1
