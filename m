Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3C65B41A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 16:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbjABPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 10:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjABPWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 10:22:34 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D29590
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 07:22:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bt23so25284165lfb.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 07:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2xkrS8fYWSKyz1gF+PYu/lMr0iETcvmbHZcGI2STzkI=;
        b=C7OIzlgleAhI1CoWOg48Gmy1xsS3n4nbw1RCe7Jlb6c7EVxU7xngOa4OsW1QyqcIis
         FWvCql9vX8rjiCHzS8J10ParkGCISFKmRb2B2IMk2wdnPsoBASETSMtZfC7xZ7uwCO+B
         /Rm0LbGS0uaTksJehKP1ROlV0FSrsPmwYKaLQOV+lMZ5RFW83RGSSzZHxPTi34j/Mj1W
         OCR7hjViAO4bruytkhytiIoy5T/A/peUCcD3NJpGSbKqzqmB4TVjvZ37CQl3yFEVoAIi
         ChszKjNiDU87mf/X8IoUfLrp9osOqCOfZJYFJpJwIBFLxsItVla0OXksfyLwZRU2d+Ia
         AzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xkrS8fYWSKyz1gF+PYu/lMr0iETcvmbHZcGI2STzkI=;
        b=lcloJ6ta1PEpcMeREr83JyjpnFZ9lyxdt8uR+bXOtKZS0ygfpAXyox6OW7opfr3RkA
         HRUjqOKaP6SlbWpuL4HdYADhBEWKfVC3saHJHztNDb122scMEbFnTfz36hEWFnZVrQDe
         NHi8kfl4ngb/1BPCUDaKkuA+pCKr3bNQKTUG6DQCHuKtdLUpOmtwt29RHswl/48Jehl5
         7GvE7Tf58DURsl92+9XvVhk3ZpbM/dqIw7ezA7KbY2zJJTzR1m9f8YS9M5Aa84lTKek3
         +p/QBHxL1iuekfZLEandIhAkLh5YyUtHEToy1W2bp4tI6/FzfAz0L4LqMGOV09LCRELs
         870Q==
X-Gm-Message-State: AFqh2kqQmlyu21gmdH/gzKSAvY8w2ZTIVtcXstv2422ircOfculrTLLd
        Qt3rHCG7vWcGNTbJkM+IZ+kFYw==
X-Google-Smtp-Source: AMrXdXu/gQk37agSf6EhzLwgb02RXl6v0u328CRYnWVWFnCj8BMzQRbbIMBwEOLOGDOhrkekU9adJQ==
X-Received: by 2002:a05:6512:c1b:b0:4cb:3e50:f5e3 with SMTP id z27-20020a0565120c1b00b004cb3e50f5e3mr259610lfu.61.1672672951651;
        Mon, 02 Jan 2023 07:22:31 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y1-20020a197501000000b004b57162edfasm4491154lfe.117.2023.01.02.07.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 07:22:31 -0800 (PST)
Message-ID: <97ba0421-530e-587b-fef5-16ffefddc0cd@linaro.org>
Date:   Mon, 2 Jan 2023 16:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8250-mtp: fix wcd938x codec node
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230102105038.8074-1-johan+linaro@kernel.org>
 <20230102105038.8074-6-johan+linaro@kernel.org>
 <1a8226ef-b16c-e713-94bd-807ca356ef8b@linaro.org>
 <Y7LyQZ6FotC5Rpmg@hovoldconsulting.com>
 <ae0499ce-f4a2-22a8-840a-6d7640079b93@linaro.org>
 <Y7L1r7ehoo68ZxJQ@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7L1r7ehoo68ZxJQ@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 16:18, Johan Hovold wrote:
> On Mon, Jan 02, 2023 at 04:09:14PM +0100, Krzysztof Kozlowski wrote:
>> On 02/01/2023 16:03, Johan Hovold wrote:
>>> On Mon, Jan 02, 2023 at 01:20:03PM +0100, Krzysztof Kozlowski wrote:
>>>> On 02/01/2023 11:50, Johan Hovold wrote:
>>>>> The wcd938x codec is not a memory-mapped device and does not belong
>>>>> under the soc node.
>>>>>
>>>>> Move the node to the root node to avoid DT validation failures.
>>>>>
>>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>>> ---
>>>>>  arch/arm64/boot/dts/qcom/sm8250-mtp.dts | 40 ++++++++++++-------------
>>>>>  1 file changed, 19 insertions(+), 21 deletions(-)
>>>>
>>>> Don't you base on some older tree? It was alreadt moved. Maybe other
>>>> changes were also implemented...
>>>
>>> If you've moved this node is hasn't made it into linux-next (or the qcom
>>> tree) yet.
>>
>> So you need to update your tree/rebase as this is already in Qualcomm
>> tree. There was no linux-next release since a week, so that's not a
>> solution.
> 
> As I wrote above, it's not in the qcom tree either.

Really?

https://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git/commit/?h=for-next&id=e5b8c08245307a82cdf180cd5d385a34ba1cfd9d

Best regards,
Krzysztof

