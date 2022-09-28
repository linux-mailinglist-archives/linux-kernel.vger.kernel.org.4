Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0671E5EDC74
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 14:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbiI1MVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 08:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiI1MVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 08:21:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F0085A83
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:21:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id c11so19475902wrp.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 05:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yycV/tARchEebUxR90rT+mBw6ecchN0PU41HEt0bzFA=;
        b=oX7MAdLWdKMTLHC01wMtflGfDV/oLsUISdCCZETawsLjfeh1k79I6PlADnaEIRFzr8
         qQD/MfhBAq6115l79HVhCMSAw4DZe+DoxsXfAi+4BLtkFwPN/TZLu/ycfJ2FZs8IhzFV
         c7g+YsngBjgB9whJp50gVVK2O8hN32QoVgwdS/huLkQ9ZF2/2j/E2PJX8/3PkiMlhJya
         xkHzOxKQ9h9+pp0Za87AVgiIdP8DoaXMHVCyQkEh2mTiAoqO0pm74VbxQu0oBsnggEI4
         K6FdIGu3OcFKYaM65SBF5XEI4nfRPVpJB94nPPN1azQbbCbDwWARD0XB8mMgXSsiPLfh
         0tqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yycV/tARchEebUxR90rT+mBw6ecchN0PU41HEt0bzFA=;
        b=OFNjCzztIXn+lVH2sO+zc0Mf167rSKGGAKcb920mXY6yiDwIczdbSUl+CISZ/jUz/H
         iQLB0wJYcrb67XySGQpVNnjEUQE+KlJjd4S2KnAmxIaHfJvhl+AIlzCmdG/Y/8uN+ex6
         oaQCwo+6B6nOlHsNOBAhHNhjLe66sIm4etuJ02ItUG4LPBFpkY6VkVVLZ5PQzGLE6mzA
         m9GbWvMdObJ14fNABtOrnhrOh/Ho/2TE4BYRieRMNBDT+RMM14AVZ7NVEeGgnJ6UR4ly
         cSe6UpxENzFr667izLzPFmBbX+oY8i+pYy6uRrEABWg1TOEYxR56MAIfOqZEOdfE4VnS
         3/vQ==
X-Gm-Message-State: ACrzQf0ZhRJiEpMrzwT0yUNMB/rpDFjgaT64dJYXJ3wJAYJDJNhqv8Fc
        OruX9IxEZ0YJ5wryczWyMJ12Vg==
X-Google-Smtp-Source: AMsMyM5lZ92jxHW5qGCdPCcYX3jOhn6kbMa/XUiLP9cBQN9smtYXX0teegU3ejEjPcIE02lqM3YjYQ==
X-Received: by 2002:a5d:5942:0:b0:225:7425:4e39 with SMTP id e2-20020a5d5942000000b0022574254e39mr19749440wri.566.1664367697233;
        Wed, 28 Sep 2022 05:21:37 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id r7-20020adfab47000000b0022ccc22ca95sm243800wrc.13.2022.09.28.05.21.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 05:21:36 -0700 (PDT)
Message-ID: <9dda83cb-53e5-b905-31b0-adb0708bf9af@linaro.org>
Date:   Wed, 28 Sep 2022 13:21:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] Documentation/process: Add text to indicate supporters
 should be mailed
Content-Language: en-US
To:     Thorsten Leemhuis <linux@leemhuis.info>, corbet@lwn.net,
        konstantin@linuxfoundation.org, krzysztof.kozlowski@linaro.org,
        linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20220928003006.230103-1-bryan.odonoghue@linaro.org>
 <9df735b7-2963-9fca-aa7e-6ae993e8b948@leemhuis.info>
 <9a321c25-32ba-6ea0-67a0-07617a1131b2@linaro.org>
 <ef8bd881-50aa-f317-981a-ef7e57a10b1b@leemhuis.info>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <ef8bd881-50aa-f317-981a-ef7e57a10b1b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 13:02, Thorsten Leemhuis wrote:
> On 28.09.22 13:48, Bryan O'Donoghue wrote:
>> On 28/09/2022 05:34, Thorsten Leemhuis wrote:
>>> On 28.09.22 02:30, Bryan O'Donoghue wrote:
>>>> Recently when submitting a yaml change I found that I had omitted the
>>>> maintainer whose tree the change needed to go through.
>>>>
>>>> The reason for that is the path in MAINTAINERS is marked as Supported
>>>> not
>>>> Maintained. Reading MAINTAINERS we see quote:
>>>>
>>>>              Supported:   Someone is actually paid to look after this.
>>>>              Maintained:  Someone actually looks after it.
>>>>
>>>> The current submitting-patches.rst only says to mail maintainers
>>>> though not
>>>> supporters. When we run scripts/get_maintainer.pl anybody who is
>>>> denoted a
>>>> paid maintainer will appear as a supporter.
>>>>
>>>> Let's add some text to the submitting-patches.rst to indicate that
>>>> supporters should similarly be mailed so that you can't do as I did and
>>>> mail every maintainer get_maintainer.pl tells you to, without actually
>>>> mailing the one supporter you need to.
>> [...]
>>> Which leads to two other question: Are there any other places that might
>>> benefit from such a clarification? Or would it be even make sense to
>>> change the format of MAINTAINERS to avoid the problem in the first
>>> place? Maybe something like "Maintained(v)" (Someone volunteered to look
>>> after it in spare hours.) and "Maintained(p)" (Someone is actually paid
>>> to look after this.). Ahh, no, that doesn't look good. But you get the
>>> idea.
>>
>> We could update get_maintainer to print out something else
>> such as
> 
> I really like the idea of just changing get_maintainer, but also...
> 
>> scripts/get_maintainer.pl
>> Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>>
>> Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
>> Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM
>> SUPPORT)
>> Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM
>> SUPPORT)
>> Lee Jones <lee@kernel.org> (maintainer-supporter:MULTIFUNCTION DEVICES
>> (MFD))
>>
>> or say
>>
>> scripts/get_maintainer.pl
>> Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
>> Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
>> Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM
>> SUPPORT)
>> Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM
>> SUPPORT)
>> Lee Jones <lee@kernel.org> (supporting-maintainer:MULTIFUNCTION DEVICES
>> (MFD))
>>
>> it would be less churn but, I still think we would need to update the
>> documentation to be very explicit that "supporting-maintainer or
>> maintainer" needs to be emailed with your patch so that sufficiently
>> talented idiots such as myself, know who to mail.
>>
>> Although thinking about it we would be introducing yet another term
>> "supporting-maintainer" to which people would say "what is that"
> 
> ...agree with this.
> 
>> Feels a little less confusing to me to leave supporter as-is and just
>> document expectations for patch submission better.
> 
> Hmm, how about this:
> 
> scripts/get_maintainer.pl
> Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
> Lee Jones <lee@kernel.org> (maintainer[supported]:MULTIFUNCTION DEVICES
> (MFD))
> Andy Gross <agross@kernel.org> (maintainer[volunteer]:ARM/QUALCOMM SUPPORT)
> Bjorn Andersson <bjorn.andersson@linaro.org>
> (maintainer[volunteer]:ARM/QUALCOMM SUPPORT)
> Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
> 
> Not totally sure about this myself. And there is a risk that any such
> change might break scripts that rely on the current approach used by
> scripts/get_maintainer.pl :-/

So it feels to me like the right thing to do is change get_maintainer 
and accompanying documentation but, I'll wait to hear back from Jonathan.

---
bod
