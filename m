Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E53F640970
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233682AbiLBPcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233520AbiLBPcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:32:16 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60EAD9B29
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:32:15 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id d3so5809336ljl.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qrJQRjYSCGh+5IRAzVY1UpfODdiJfmCsnRpLOeAqkM4=;
        b=crqOMyl/estFD5kYlrRUY6dijClq49pSi5308P6RU8HUq30aX3L/NC6fM2btqWywEW
         GUR+gaxaPuKdYqA27ShtkaCCBUDMRfP9YuqVIPOQ/hzBrEYJPrORJzJtnll0osBvyyZJ
         WIV+M7YOAKYkA+O8Zb57+uHj2sMc3Xxg3InlaT3wegHfEeSYnZY+fdaW0koZiVL+Y1V+
         QCWl82X758M43z/m6pEtafNNcBvNtmHw/zH39ZBB8wYLw+ti3+jopAMRfvaPoZFbg/oh
         Zy1stSHpq4lUyjy6xTpf9EKaptRSu0T8avi8Vkm/RBC128/stFkjKzTOrKSB+PX8BWQ/
         t0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrJQRjYSCGh+5IRAzVY1UpfODdiJfmCsnRpLOeAqkM4=;
        b=CJ0CkCs0ItVXkMFpP4OH3Ve4wMqFUbcMViv1tPPAorhk7m/Mnbg7CJCzg9Oa00Z/X6
         7DblA1PaP7hjxhLpeqQbcelyTunPve8L4Y6w/7ypF1ym7721AVMi++VqAnOdngWQb/Er
         zi/wJi7/nzBYvxyAmJHwhx5dju6VXAGPZy38VdvquRUYLf9MeVefpt1sHQW0+emuvEBI
         FPFcMr4yZHYdlMUlfJ0Q1jSDh/AN5B1f+KYcowy2v69ZTvavMbKqUkZjkR7G9gM5z2xX
         PUduHOYXG8/jpMFxWHx8nPT7q7r3o4OxU92DFgu+ItE/5aOKqmD3jv+LjR4MvIvYV5dd
         +siA==
X-Gm-Message-State: ANoB5plsnleNfospPnMZJOz3E88Dcjww1LJmGjPLTtgQcV8j3GXLyjbs
        BMiWnLsipFWOIj2DHRlN9nxSiw==
X-Google-Smtp-Source: AA0mqf6DnG5jpKp7S6oQgFmUYGc2Csfby4Uyfz44ydtW+WC5OiN2K4wSHd+zA8p8nheYkdvSZqzyaw==
X-Received: by 2002:a2e:a452:0:b0:277:9c2:d5db with SMTP id v18-20020a2ea452000000b0027709c2d5dbmr18170905ljn.168.1669995134188;
        Fri, 02 Dec 2022 07:32:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id w10-20020ac2598a000000b004b4ea0f4e7fsm1043826lfn.299.2022.12.02.07.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:32:13 -0800 (PST)
Message-ID: <7ef76a8b-c45b-2a94-d0ad-9136757af684@linaro.org>
Date:   Fri, 2 Dec 2022 16:32:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFT PATCH v2 2/2] arm64: dts: qcom: sdm845: align TLMM pin
 configuration with DT schema
Content-Language: en-US
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Fritz Koenig <frkoenig@google.com>
References: <20221118164201.321147-1-krzysztof.kozlowski@linaro.org>
 <20221118164201.321147-2-krzysztof.kozlowski@linaro.org>
 <CAD=FV=XeaskcBRVRQDoha7Xiv9j57fuvtcSJUeN7HCZSGVJ8uQ@mail.gmail.com>
 <68bcdf25-e8e3-f817-f213-efb0bce3f43a@linaro.org>
 <CAD=FV=WBNpeWK31dCgzX5QAuR7AySkp_dEyY8WK3o8+SaiPxOg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAD=FV=WBNpeWK31dCgzX5QAuR7AySkp_dEyY8WK3o8+SaiPxOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 15:36, Doug Anderson wrote:
> Hi,
> 
> On Fri, Dec 2, 2022 at 12:15 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>>>>                         qup_uart6_4pin: qup-uart6-4pin-state {
>>>> -
>>>> -                               cts-pins {
>>>> +                               qup_uart6_4pin_cts: cts-pins {
>>>>                                         pins = "gpio45";
>>>>                                         function = "qup6";
>>>> -                                       bias-pull-down;
>>>
>>> After your patch, where is the above bias set for cheza, db845c,
>>> oneplus, shift-axolotl, ...?
>>>
>>>
>>>>                                 };
>>>>
>>>> -                               rts-tx-pins {
>>>> +                               qup_uart6_4pin_rts_tx: rts-tx-pins {
>>>>                                         pins = "gpio46", "gpio47";
>>>>                                         function = "qup6";
>>>> -                                       drive-strength = <2>;
>>>> -                                       bias-disable;
>>>
>>> After your patch, where is the above bias / drive-strength set?
>>
>> They don't use 4-pin setup. If they use, I would assume they will
>> override the entries just like sdm850 boards (where I override it to set
>> these).
>>
>> Alternatively I can keep it in DTSI, but it is not really property of
>> the SoC.
> 
> I see things like:
> 
> .../sdm845-cheza.dtsi:     pinctrl-0 = <&qup_uart6_4pin>;
> 
> ...before your patch that would get the bias/drive strength from the
> SoC dtsi, right? After your patch, you've removed it from the dtsi but
> not added it to the board. ...so I think it's a net change. Did I mess
> up / miss something?

I missed something or rather my git grep failed. I'll bring them back to
DTSI.

Best regards,
Krzysztof

