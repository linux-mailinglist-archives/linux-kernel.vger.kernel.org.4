Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D414D68198D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236368AbjA3SnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbjA3SnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:43:01 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F996768D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:42:57 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so34566848ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O4zOFPnvQUmjBeGtP4FRB6E8V1HsYTwI97ynNzQTKWY=;
        b=Uhe4ruEuvSLU4qUidpD7D9Dbo1APlS5ywKHhmCuiSOsmpi3104yLei87Aux25C2AjX
         4NvydmzCtR6VesJYdLcnk80OsNKjoVmUQcTJpR+NIFmvlyaInT9CPJAS1/87rQEiNP43
         z8m+eeujfsxMBSMDkgSI0+ciwqEsDs8wGBm3QqRiX153o4Bd3U8+R3jwgV4eYLFYi2EW
         GAxJuhCaTwPCYohJC32D1BDxECrQk/lgGhyA8T/FHe9iVlWTnHNJrogGofWrjx62UFfI
         gh2M2gZFhKbe2jR1ui+0tchbC24A44c+s4KTV4b8D6y/4RVYh0eC10unln2ZPWfpwQR8
         Kr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O4zOFPnvQUmjBeGtP4FRB6E8V1HsYTwI97ynNzQTKWY=;
        b=DB1D0UhDZFVr6LOhBSuUR9LoTilYBDhrpR/CGNuyRdaFbEvI53PqJ2Q5Wms61vicsw
         oUPLytJ8dWRlaZgAzRH+GrvV255xR3C2R71g2mcFG31uQgTLJUZ5KshbRBOHhwcw4cV3
         W1z5k3Za4lKplQDutdDei1TMIdenDesuEwVZF9HVKNNvqL4p4f2zYl3OC1c7j8EKplOa
         nPQhMU29PG64pQKDaxf1b5DdEoJUFYGnqWugY02erIqjc6fZO3aDftB0FkXxg1NHXyvm
         grR05Xhr6CLDfUK0W1CtHo9wLuclcjk1xRmnMAH4CPbY9cp6xcnSDzGqMIa1HTRw8re9
         SMGA==
X-Gm-Message-State: AFqh2kpcJEtHqWpiU709sV75RC2WePEyEw6C/W0CLzQz/xJbj2zUEKol
        eMCZKNd5nhEsF1XIYlNCdg3+yQ==
X-Google-Smtp-Source: AMrXdXt/DpQYzmUqt9gbZ81bMlze+ik6dIP4e0KF3Bl1YyJAG4gy45/wqekGbHqLE/oWmgxQBsdfJQ==
X-Received: by 2002:a17:906:60d2:b0:872:6bd0:d2b with SMTP id f18-20020a17090660d200b008726bd00d2bmr46720484ejk.45.1675104175927;
        Mon, 30 Jan 2023 10:42:55 -0800 (PST)
Received: from [192.168.1.101] (abyl20.neoplus.adsl.tpnet.pl. [83.9.31.20])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906391300b0088452ca0666sm3744462eje.196.2023.01.30.10.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 10:42:54 -0800 (PST)
Message-ID: <568ebb75-5cb2-af97-bfae-c1e1e6174a45@linaro.org>
Date:   Mon, 30 Jan 2023 19:42:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] ARM: dts: qcom: msm8974: correct qfprom node reg
Content-Language: en-US
To:     Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Craig Tatlor <ctatlor97@gmail.com>
References: <20230130-msm8974-qfprom-v1-1-975aa0e5e083@z3ntu.xyz>
 <3112b531-45df-672c-c0a7-aefbdcceb727@linaro.org> <1886214.taCxCBeP46@g550jk>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <1886214.taCxCBeP46@g550jk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30.01.2023 19:36, Luca Weiss wrote:
> On Montag, 30. Jänner 2023 19:30:04 CET Konrad Dybcio wrote:
>> On 30.01.2023 19:20, luca@z3ntu.xyz wrote:
>>> From: Craig Tatlor <ctatlor97@gmail.com>
>>>
>>> The qfprom actually starts at 0xfc4b8000 instead of 0xfc4bc000 as
>>> defined previously. Adjust the tsens offsets accordingly.
>>>
>>> [luca@z3ntu.xyz: extract to standalone patch]
>>>
>>> Fixes: c59ffb519357 ("arm: dts: msm8974: Add thermal zones, tsens and
>>> qfprom nodes") Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
>>> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
>>> ---
>>
>> Isn't this a raw vs ecc-corrected values problem?
> 
> Not quite sure what you mean.
The QFPROM is split into two parts: one where raw values
are stored, and the other one where ECC-corrected copies
of them reside. Usually it's at offset of 0x4000. We should
generally be using the ECC-corrected ones, because.. well..
they are ECC-corrected.. You may want to check if the
fuse you're adding reads the same value at +0x4000.

Konrad
> 
> The original intention behind this patch is to allow to use the pvs fuse at 
> (now) 0xb0 which was inaccessible with the former definition.
> 
>     pvs: pvs@b0 {
>         reg = <0xb0 0x8>;
>     };
> 
> Regards
> Luca
> 
>>
>> Konrad
>>
>>>  arch/arm/boot/dts/qcom-msm8974.dtsi | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi
>>> b/arch/arm/boot/dts/qcom-msm8974.dtsi index 8d216a3c0851..922d235c6065
>>> 100644
>>> --- a/arch/arm/boot/dts/qcom-msm8974.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
>>> @@ -1132,16 +1132,16 @@ restart@fc4ab000 {
>>>
>>>  			reg = <0xfc4ab000 0x4>;
>>>  		
>>>  		};
>>>
>>> -		qfprom: qfprom@fc4bc000 {
>>> +		qfprom: qfprom@fc4b8000 {
>>>
>>>  			compatible = "qcom,msm8974-qfprom", 
> "qcom,qfprom";
>>>
>>> -			reg = <0xfc4bc000 0x1000>;
>>> +			reg = <0xfc4b8000 0x7000>;
>>>
>>>  			#address-cells = <1>;
>>>  			#size-cells = <1>;
>>>
>>> -			tsens_calib: calib@d0 {
>>> -				reg = <0xd0 0x18>;
>>> +			tsens_calib: calib@40d0 {
>>> +				reg = <0x40d0 0x18>;
>>>
>>>  			};
>>>
>>> -			tsens_backup: backup@440 {
>>> -				reg = <0x440 0x10>;
>>> +			tsens_backup: backup@4440 {
>>> +				reg = <0x4440 0x10>;
>>>
>>>  			};
>>>  		
>>>  		};
>>>
>>> ---
>>> base-commit: 6d796c50f84ca79f1722bb131799e5a5710c4700
>>> change-id: 20230130-msm8974-qfprom-619c0e8f26eb
>>>
>>> Best regards,
> 
> 
> 
> 
