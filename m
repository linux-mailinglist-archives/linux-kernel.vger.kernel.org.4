Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B446D461A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbjDCNre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjDCNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:47:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CC230CB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:47:31 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t10so117420783edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680529650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pvt16joZ5xG45COfnzqBt6KieWi0E35IQbDyvI0Q3U0=;
        b=bdX6ABQ/ntd69OXo+fwQWvZ7bJ6AjKgp9EU0eD7F+As5cOUgjRpJvnjz3PdTssp14y
         djRKJZ1Ivksql07WgFGsowhZJR8Wqu/FYr3jZHdDCjoet9+giBEo9U/7Orw+EpUWsgAW
         Jl64ouzB6OFwPnWYwJeAy3Wpx4GB0uMBPyosxxxI0YrC1eBe8dIX/0pSCAPT+49hdBVv
         jnrmWdJQ+kWgy+xZx8v8IbXppbsUue/70Aeafku6vzSuQZo6o8GFUEyMaTHb1sa4PMF8
         Wuu9qs5QIOZ8Ek39//rkECZVc/0xRCM2Atr8rAhe3PZTBa/9UKPt0dbDbh5Fg+3HbVfH
         QQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680529650;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pvt16joZ5xG45COfnzqBt6KieWi0E35IQbDyvI0Q3U0=;
        b=yhQACeYy8D+yqbb+Xc17BtIMOOJOfVbhhRIbq72pyfQ6vJOtpTTCXRFnftixy5UeuL
         M280AzyBd3Bppb8PStgAaawXznE5Q+iSgMqAwN1cKk8WFqs2A03D+QdFOandXblIRlxe
         CEIAQ5t0sgFrDckS0+iHycsnDHem2ruC4VdUaTfEffeF5Y1/iUcSq25x8UDgEdNmqt60
         Bcq8o5KCghdBVM7VbrS4mMI2dkRMHeTdgcDwSifWHiKmJkJoR3s1NOxE7bFPQlxYnHUN
         6lsXW+v/0sU0mg01lVbm9LBMJ/xqlBzZ0uf7j1sCIWteyoSHK4qDZlp9kMUPcqqZzmj1
         rtAw==
X-Gm-Message-State: AAQBX9fl6jqVS+P/USiUhojaeziISOcdgBZDx7SDJ6TkhOETF3coAokJ
        5nVfdeAYxUQnZOmu5XZmb3A8BA==
X-Google-Smtp-Source: AKy350Z4u2eEo7nsmptLf0ouaXqizmrSmMOHKwtrutSQboFNnJA9Kqh8Bg73ZV/KPK8fo9PiJc9wrA==
X-Received: by 2002:a17:906:6946:b0:92f:8324:e3b7 with SMTP id c6-20020a170906694600b0092f8324e3b7mr31585587ejs.37.1680529649775;
        Mon, 03 Apr 2023 06:47:29 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id f24-20020a50a6d8000000b004acbda55f6bsm4655027edc.27.2023.04.03.06.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 06:47:29 -0700 (PDT)
Message-ID: <fac15b28-ef4a-dd7d-f0ac-51518d9dc1be@linaro.org>
Date:   Mon, 3 Apr 2023 15:47:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: fix pon compatible and
 registers
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230327122948.4323-1-johan+linaro@kernel.org>
 <48f71f9a-0d00-16df-fff8-5aa455918378@linaro.org>
 <ZCqwWwdhhJdOK+5Y@hovoldconsulting.com>
 <5dfb81df-8ae2-eb62-01a2-b26c6b8d2597@linaro.org>
 <a04ca2bd-72f9-c89a-3fcb-36dd710b107f@linaro.org>
 <ZCrQe2ASeQXQJKS0@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZCrQe2ASeQXQJKS0@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 15:11, Johan Hovold wrote:
> On Mon, Apr 03, 2023 at 02:46:41PM +0200, Krzysztof Kozlowski wrote:
>> On 03/04/2023 14:33, Krzysztof Kozlowski wrote:
>>> On 03/04/2023 12:54, Johan Hovold wrote:
> 
>>>> The problem is that the driver was updated before the binding was so the
>>>> above mentioned probe error has been there since this file was merged.
>>>
>>> I grepped and that commit did not have such compatible. Are you saying
>>> that the kernel which was released with this commit already had that
>>> compatible in driver (through different merge/tree)?
>>
>> So I double checked, the commit ccd3517faf18 (which is being "fixed")
>> was introduced in v6.0-rc1. v6.0-rc1 did not have "qcom,pmk8350-pon"
>> compatible, thus it could not be fixed that way. Therefore this cannot
>> be logically fix for that commit from that release.
> 
> Now you're just making shit up. A fix is a fix for mainline, period. If

Since this is your second mail in such tone and such phrases, I am not
going to keep discussing this. Regardless of differences in opinion, you
should keep the tone appropriate.

Best regards,
Krzysztof

