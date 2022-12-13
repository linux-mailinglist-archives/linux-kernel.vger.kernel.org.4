Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6AD64B8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbiLMPof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiLMPoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:44:20 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83EDC66
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:44:18 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id g7so5562224lfv.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGstHtifQPW5GO3v7hxlfERswPjhZXfr0wahKT87Wbg=;
        b=cdQmXOl+woEiaypum/Th1omypryAPzX//HQ/hCldqepnH8fUd7OI4/+pAsXuQKfgcR
         OhWVHeeAqCzRuYcp0xNRJ2A9bAB/QkkGQRfV3/uBqMDOQInUS3MaUdL1r8G+htDpL48E
         HUHqY4E9T3VIyRjmf1z8VxCjxZ59ngpflZKhpjLKvvSmJ1i8TaNbMZgQMb/xoRycEjOX
         V/sAAnni9mcHle0mlarWzd8w159pDGIrydPsokHSBiCraVtx0/1+33iCy+Cxt0KWlGuh
         4OC+dM8kwPHmYQpbllKuc9V7vFid/Ep6Wb/oF6PsMT8KrrMN2KQaA52v5XXZrYXYg0GT
         epew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EGstHtifQPW5GO3v7hxlfERswPjhZXfr0wahKT87Wbg=;
        b=8I85EVsII+N7I3qhhV0W0vBKMJUHh9+fDCj2++gTt2R5ZjiT9hs4ZPErbmNA1tLjN1
         LF9yy98QzitgsbYSGf+ARFC1hwNM6hj0w2It0cV5fWWq95ZGxUoHy66jTkv0htnvOEis
         vu6iZ2m+6/rFtkG7id8Ht25NtxPZrlJvxUpUaQ4zBiK2IfQhjShG0A+PtXpq4WFcfe1K
         8B/eDAcNBDLenbDbcvB7pFw7vSXLVZFfHYdbmZLUeovFVGr+4oPKNuk2+LSUUzClkF51
         FMx1MUpvmcU0lvyZQ/igv8XoUBBaTQ43itYEpgAsisySdEpy/kgGvsNqkpDYhfUlPV17
         +Evw==
X-Gm-Message-State: ANoB5pnmDkd3o2nxaay8/H9Z+gU7YrF+fyhIyOziOUyZMrGjTV9gyKcH
        yVLJTT7elxmUhVYWndKRMazgug==
X-Google-Smtp-Source: AA0mqf5/eioldK0Ihu8+1CQheeMf4HYHScxc0xfuWrWmdsCn7jqwdvf58iRG6fQe109pDxdiJo79lg==
X-Received: by 2002:a05:6512:298c:b0:4b5:b2b1:69a9 with SMTP id du12-20020a056512298c00b004b5b2b169a9mr4642149lfb.20.1670946257217;
        Tue, 13 Dec 2022 07:44:17 -0800 (PST)
Received: from [192.168.1.101] (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id e13-20020a05651236cd00b00498fc3d4d15sm411410lfs.190.2022.12.13.07.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:44:16 -0800 (PST)
Message-ID: <c2be661a-87e4-864e-3571-75032484f66f@linaro.org>
Date:   Tue, 13 Dec 2022 16:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     Brian Masney <bmasney@redhat.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com> <Y5iWeTk2zOp9rInx@x1>
 <Y5iaDP+nV9B59U2b@hovoldconsulting.com>
 <03252ccd-e200-a112-b4dd-ba9fbf25c480@quicinc.com>
 <Y5icyo7I5ZGAL02q@hovoldconsulting.com>
 <Y5idf5dP2ttBSOUa@hovoldconsulting.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <Y5idf5dP2ttBSOUa@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.12.2022 16:42, Johan Hovold wrote:
> On Tue, Dec 13, 2022 at 04:39:54PM +0100, Johan Hovold wrote:
>> On Tue, Dec 13, 2022 at 09:04:39PM +0530, Shazad Hussain wrote:
>>> On 12/13/2022 8:58 PM, Johan Hovold wrote:
> 
>>>>> So qup2_i2c18 becomes qup2_i2c2. Would I use the flat naming scheme for
>>>>> the alias like so?
>>>>>
>>>>>      aliases {
>>>>>          i2c18 = &qup2_i2c2;
>>>>>      }
>>>>
>>>> Or perhaps the i2c controllers should use a zero-based index instead of
>>>> being named after the serial engines (e.g. as we do for the console
>>>> uart).
>>>>
>>>> How are they named in the schematics?
>>>
>>> We should use from 0 to N.
>>
>> With N being 23 after the number of serial engines, or the number of
>> available i2c buses on a particular board minus one?
> 
> Looks like the more recent Qualcomm platforms use aliases that reflect
> the engine number (i.e. 0 to 23) for i2c and spi.
IMO it makes the most sense, as it tells the userspace "hello, this
device is connected to the physical I2Cn on the SoC" as opposed to
"hello, this device is connected to the nth enabled bus on this
particular board".

Konrad
> 
> Johan
