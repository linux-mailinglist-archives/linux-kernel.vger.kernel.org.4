Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE668740FDF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjF1LPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjF1LPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:15:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFDAA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:15:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb761efa7aso4917709e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687950908; x=1690542908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRpDMlSOdjlWJCoFGMItwOJ9PaCH0eJrXnbwCOjqAQ8=;
        b=B8aA7AwH5cdDsrTOl3ocBUZ75+yfTiKsMjDwcTuOXgFC/SClQlWhLdWIUHX5D91Y4j
         uxYA2EwnDEIu1JepUhz9w+UprVffsoWk68PuHhXYYn71cj7l0D1tc3mFJVE30DN0i8IU
         eSe+huJVNFOJ8FXoM11elPI4ZpIrjIOW7ANwcItSTjEsOJ/9R3liIak85ZbH/WQcuxJ7
         /rOmyezc3KZAWmllAhzEn8Ai9vjvd74qhuMc7nrGKV+i8YfG7HJehub+ed9E8VkwQSeK
         zNmOjkZxhiYssey1aDXKPL0wnhG17dAXajo06RaTnl79m4jF3y78KNam12PN7rhzPwMD
         3gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687950908; x=1690542908;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRpDMlSOdjlWJCoFGMItwOJ9PaCH0eJrXnbwCOjqAQ8=;
        b=KA19cO46mp16A79D7qAr85DSlEZisMh71Z7MaDEYK+2tY0mAjqSy2V33fD9/zgAS6s
         9rGCjfXu+EWLZLjqvS91jIoD0Ml0OnckE53nyYmGnK3ulsfp59eLjK7HQWpm7Yr+1CaB
         rD0wltdT/r6bEzNkJAwypa6hUckgx/NkvemzoYY6y4nra0JvauD2eK+xFTTCRUg/f+nX
         z6e3m0Mirtg00o9VGBrwHU1mtkk6v6SQgO6n47onNu7HVX1h7S/ofWyrUNqKKfU3tGQl
         K2u3EcYMpwQN7YMHzj0uMsC+fDBMgt30R4KpNOg3ZjE7FXU8E8QeEMDHyWEgUX2lW4o0
         c4og==
X-Gm-Message-State: AC+VfDxyAHT+mtvLL7a5w1Hkdke8Oz8IXcJNw+d7uWdTh9mYSB+jdJer
        HpVCVgOONOYN98WWU1wtfYtKBsm6qA+hzgTYrN8=
X-Google-Smtp-Source: ACHHUZ5BKDzsJlf5np3IFyFRLJfmAo1gnPmz2jehYTyTkbdTgjA5UsH8zb9DnsQxRJrN4GhaKrpImg==
X-Received: by 2002:a05:6512:3d02:b0:4fb:7392:c72c with SMTP id d2-20020a0565123d0200b004fb7392c72cmr8117318lfv.57.1687950907897;
        Wed, 28 Jun 2023 04:15:07 -0700 (PDT)
Received: from [192.168.1.101] (abyj233.neoplus.adsl.tpnet.pl. [83.9.29.233])
        by smtp.gmail.com with ESMTPSA id b12-20020a056512024c00b004f87571a5c8sm1872343lfo.48.2023.06.28.04.15.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 04:15:07 -0700 (PDT)
Message-ID: <b02789ca-b6a0-d972-7e9e-fdddd3d15538@linaro.org>
Date:   Wed, 28 Jun 2023 13:15:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-pmics: add explicit rtc
 interrupt parent
Content-Language: en-US
To:     Patrick Wildt <patrick@blueri.se>, Johan Hovold <johan@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>
References: <20230627085306.6033-1-johan+linaro@kernel.org>
 <20230627132406.GA5490@thinkpad> <ZJr_5JIqWSGq-E-T@hovoldconsulting.com>
 <20230628052557.GB20477@thinkpad> <ZJvXZDBGBSQfeBdh@hovoldconsulting.com>
 <ZJvv_bcum7nhrgrO@mone.fritz.box>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <ZJvv_bcum7nhrgrO@mone.fritz.box>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.06.2023 10:31, Patrick Wildt wrote:
> On Wed, Jun 28, 2023 at 08:47:00AM +0200, Johan Hovold wrote:
>> On Wed, Jun 28, 2023 at 10:55:57AM +0530, Manivannan Sadhasivam wrote:
>>> On Tue, Jun 27, 2023 at 05:27:32PM +0200, Johan Hovold wrote:
>>>> On Tue, Jun 27, 2023 at 06:54:06PM +0530, Manivannan Sadhasivam wrote:
>>>>> On Tue, Jun 27, 2023 at 10:53:06AM +0200, Johan Hovold wrote:
>>>>>> Unless explicitly specified the interrupt-parent property is inherited
>>>>>> from the parent node on Linux even though this may not be in full
>>>>>> compliance with the devicetree specification.
>>>>>>
>>>>>> Following commit 2d5cab9232ba ("arm64: dts: qcom: sc8280xp-pmics:
>>>>>> Specify interrupt parent explicitly"), add an explicit interrupt parent
>>>>>> also for the PMIC RTC node for the benefit of other operating systems
>>>>>> which may be confused by this omission.
>>>>>>
>>>>>> Note that any such OS must still implement a fallback to the root
>>>>>> interrupt domain as most devicetrees are written under the assumption
>>>>>> that the interrupt parent is inherited.
>>>>>>
>>>>>> Reported-by: Patrick Wildt <patrick@blueri.se>
>>>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>>>
>>>>> It is good to encode this in the binding and fix other such instances.
>>>>
>>>> Not sure about that. Perhaps the spec should be updated to match reality
>>>> instead... We have many more instances like this, even for this very
>>>> SoC, but apparently OpenBSD or whatever OS needs this falls back to the
>>>> root domain then.
>>>>
>>>
>>> Just because linux is doing it in a different way doesn't warrant an amendment
>>> to the spec IMO.
>>
>> My point is that it's apparently not just Linux as most devicetrees work
>> this way at least for the root domain. And then it may be time to update
>> the spec in some way.
> 
> I'm not sure about the point you're trying to make.  In OpenBSD's
> implementation, which I think complies with the spec, for non-extended
> interrupts we check the node's (or all its parents') interrupt-parent
> property.
> 
> Technically the SPMI arbiter could define an interrupt-parent that
> points to itself, because it's using interrupts-extended anyway to
> point to the PDC.  But that would feel a bit stupid and not really
> correct.  Alternatively each child node could have interrupt-parent.
> 
> That said, I understand the point that it might make sense to amend
> the spec so that if a parent node is an interrupt-controller, that's
> most probably interrupt parent, unless an interrupt-parent property
> shows up before.
> 
> I would like to add that OpenBSD supports a number of SoCs for quite
> some years and this is the first time I've hit an issue with interrupts
> that were not designed in a way for the current spec to work.  That said
> we obviously support quite fewer SoCs/boards in total compared to Linux.
Linux does something out of spec here. We should either comply or amend
the dt spec. Perhaps that's a question for Rob Herring.

Konrad
> 
> Cheers,
> Patrick
