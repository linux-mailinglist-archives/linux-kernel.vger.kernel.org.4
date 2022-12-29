Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB54658A2D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiL2IGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiL2IGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:06:15 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60AABA8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:06:13 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id p36so26539587lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 00:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ben8+4oiArxexQJyJIBwbQtQ9giuKq12emDFPOAB0/A=;
        b=jufpxaDQuVBA0SebIRrM4IEex4ljQthZbGvev2zfkGOV/gkQ+/y36QDPqFDhUpOLdB
         md5nPBiW5qSbkYYISL+qf1hh07zuo6X8/peed5sHge+qh0ZCXqT0Gsbq6H8XADK0D7bD
         fMMDbnIj1oxGmllKQ1upIjpqwH+xb7wfGNsfNDkH0gpv9Xyu2OutUCjKr65X0K4WwdqE
         CZXCWg6A4TgTvbhOFy0467qt3gdO1easnHGL7bsnu8lVXhu+uocBJLLppPxb9ypvspSj
         qVSmDLyaDopfP2csfVO8wu0dPb4eafmJiSajVISsX3RCpUFcx4eFL28gH5/ErN+0xSVY
         eCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ben8+4oiArxexQJyJIBwbQtQ9giuKq12emDFPOAB0/A=;
        b=ENiO763zbYNJ0i1KbZvMBnz0MebbEjrfpPg5oqkinBXU3wO8vRq2mSabwleeJQBtSK
         Hyr9YdBHzRhKfNQLEKoTBqjUN/OkH1y3FpTYE2TlYuEWyBJLkGc1IKvu3V6FJzVWn40m
         7xznnSBJbIVyEM8fNagvFUSTC8ZtsXZhZi3QPVDBITLAg/BnWM7haJKm94WDEi3I4NkE
         27gZqTpcBQTX2J/UbyAZSay1SlwGCIQ1rdUaE5jLnxAkqUlcsBCDG4lcfF3W9rIOQZUS
         K13bX63fd0sBtFcfcsPSRtR1g7vvOaBrtx9CcO2wIwtstAJMxNNEL209IYyStIyo2w37
         TiSQ==
X-Gm-Message-State: AFqh2koAUrfjpbX/nH1L5u00PNnE+YZZPDjIlM8+8uoGCxdb17M45sIj
        pn2xFyAQb2dqVodXSkRpX2jCMgW7yYpIMJU5
X-Google-Smtp-Source: AMrXdXtAmfVtj1IoPnGmK4xqeGUXuvnkJ8kCHhPjHiGxwb3HU1LujrXhq0Ja4bqnsKuNo/EyORORyA==
X-Received: by 2002:ac2:528f:0:b0:4b5:6504:a556 with SMTP id q15-20020ac2528f000000b004b56504a556mr7164960lfm.61.1672301172157;
        Thu, 29 Dec 2022 00:06:12 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d21-20020ac24c95000000b0049465afdd38sm2979222lfl.108.2022.12.29.00.06.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 00:06:11 -0800 (PST)
Message-ID: <0180241f-4f10-f914-1288-371106c4fa1c@linaro.org>
Date:   Thu, 29 Dec 2022 09:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] dt-bindings: ufs: qcom: Add reg-names property for ICE
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209-dt-binding-ufs-v1-0-8d502f0e18d5@fairphone.com>
 <c4109766-22f1-7227-47bb-9273a027bb0c@linaro.org>
 <CPDFHXBPSP76.5CWNQK4N1KGI@otso>
 <5391e6e5-3773-a012-c396-b59b1f54ea51@linaro.org>
 <CPDJZJHDL1XJ.2UY1U1E19CTUH@otso>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CPDJZJHDL1XJ.2UY1U1E19CTUH@otso>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 16:24, Luca Weiss wrote:
> On Wed Dec 28, 2022 at 12:58 PM CET, Krzysztof Kozlowski wrote:
>> On 28/12/2022 12:53, Luca Weiss wrote:
>>> Hi Krzysztof,
>>>
>>> On Wed Dec 28, 2022 at 12:50 PM CET, Krzysztof Kozlowski wrote:
>>>> On 09/12/2022 15:29, Luca Weiss wrote:
>>>>> The code in ufs-qcom-ice.c needs the ICE reg to be named "ice". Add this
>>>>> in the bindings so the existing dts can validate successfully.
>>>>>
>>>>> Also sm8450 is using ICE since commit 276ee34a40c1 ("arm64: dts: qcom:
>>>>> sm8450: add Inline Crypto Engine registers and clock") so move the
>>>>> compatible to the correct if.
>>>>>
>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>> ---
>>>>> (no cover subject)
>>>>>
>>>>> The only remaining validation issues I see is the following on sc8280xp-crd.dtb
>>>>> and sa8540p-ride.dtb:
>>>>>
>>>>
>>>> Any plans on fixing the patch (after testing it) and resending?
>>>
>>> I wasn't quite sure how to fix the comments, but re-reading them this
>>> comment from you is how you expect it to be in v2?
>>
>> The patch fails testing, so I meant this.
>>
>>>
>>>> Just add it to top-level with minItems: 1 and per variant customize:
>>>> 1. maxItems: 1
>>>> 2. minItems: 2 + required
>>>
> 
> I tried a bit now but couldn't get it to work when using 'items' so that
> we have the "std" and "ice" names in there.
> 
> Documentation/devicetree/bindings/ufs/qcom,ufs.yaml: allOf:2:then:properties:reg-names: 'oneOf' conditional failed, one must be fixed:
>         [{'const': 'std'}, {'const': 'ice'}] is too long
>         [{'const': 'std'}, {'const': 'ice'}] is too short
>         False schema does not allow 2
>         1 was expected
>         hint: "minItems" is only needed if less than the "items" list length
>         from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> 
> Since I have 'minItems: 1' in top-level I seemingly cannot use 'items'
> in the 'if' neither alone nor with 'minItems' and/or 'maxItems', getting
> different errors when doing that.

top-level cannot have only minItems:1.

> 
> Can I just put 'reg-names: true' top-level and then specify either items
> for the ones that use ICE or for the others use the 'maxItems: 1'?
> 
> Or am I supposed to ignore 'items' completely but driver expects 'ice'
> name so I'd rather include it.

Use the syntax like:
https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L57


Best regards,
Krzysztof

