Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5DD5FB4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJKOlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJKOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:41:32 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6846E5141C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:41:31 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id b2so21442998lfp.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L6X11cP/UuvWsmC5+JuzfzTsN8jfZXH1VKI3byABTrk=;
        b=l9ffPAt40gUOCMlYqkfjDGnFdUwMK21YU6Tl+TgF1rex0RCnlsSGG3VWpNY/8JV+jD
         R3aqOZcdkOSLoaXxRm4TvkdOb2bsAb49/c8d057cxJUyd6oTAweqojh4ni33/fAjsOmL
         aTn8S6YwujhKPaKSX6e/qJv7pEAGVvNoBDFFkI7vULfKjH+FvbrN/1toIf+kpAK6Y1Oq
         So/PbhDWsklYINBk+kbhG0C8TJTpLXZ5MIEKTbDBOr5AdmZTyHAuyPujQ/0/oEFPZ6bi
         GtxUzLl47VWCeqFwCyHeWO5fKuVLng4y5mAX/mwDorRLoJ+H4NyEJqLhjlIEc0+jYRel
         hy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L6X11cP/UuvWsmC5+JuzfzTsN8jfZXH1VKI3byABTrk=;
        b=xHPO5nQ/lBeWHjeHxwP8bsiQMojYLXXIrqN2iaukDU6q66irms735XlIRbMIyw5BoX
         wiwnkuAfmKa0j6ZplYBs+hwIrJS9Vbwr+sLqZqKWiW6QZzLO9fnRpHkBFHPHbeTScB01
         y/e4GWoa7kLETEHEBHdCYjOD4F14KgFbVXPu9+mtrbLPSq+5K7BSGUvsDDAZaHrONdD7
         Di2hRaueAfzYU1uAJ7++RE6uepv3Mi3r94ykk4eTXNv/ByzFFcfz2au7SX0vaRlIoLse
         sfed1AjjGJxGO4jXvFjwG77GxTZ8ZnWqcvlVyHbg3qjNisAw1U9p/RBrhoV3DzjZnV6c
         XVUQ==
X-Gm-Message-State: ACrzQf3HmMcCi72SefKwys0AwKqV6HwAaYjA2Bf5D4xhsfzH4pQqXi4W
        tO2g9qCKM80mqMXQGcgd3ddNKw==
X-Google-Smtp-Source: AMsMyM777wQ9nWguMeYr7N7mq+Bdd14bNohbJtWdNzwjLNWojR+TZ3UstXaUlwi4BsWWwmZRrD8C9w==
X-Received: by 2002:a05:6512:3090:b0:4a2:7db9:b15c with SMTP id z16-20020a056512309000b004a27db9b15cmr8204163lfd.424.1665499289726;
        Tue, 11 Oct 2022 07:41:29 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p20-20020a056512235400b004a05622a852sm1880189lfu.241.2022.10.11.07.41.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:41:29 -0700 (PDT)
Message-ID: <dbd85c78-86dc-8dd0-83d2-43af933e5a92@linaro.org>
Date:   Tue, 11 Oct 2022 17:41:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 08/13] phy: qcom-qmp-pcie: drop power-down delay config
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-9-johan+linaro@kernel.org>
 <66261491-530d-c368-6cc8-daeef74fcbda@linaro.org>
 <Y0V1TIBySTPhYqX/@hovoldconsulting.com>
 <ebe1e26a-7335-29ac-4990-6b8fdb02ba7c@linaro.org>
 <Y0V66q53I4ivlXI+@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y0V66q53I4ivlXI+@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 17:17, Johan Hovold wrote:
> On Tue, Oct 11, 2022 at 05:04:04PM +0300, Dmitry Baryshkov wrote:
>> On 11/10/2022 16:53, Johan Hovold wrote:
>>> On Tue, Oct 11, 2022 at 04:46:53PM +0300, Dmitry Baryshkov wrote:
>>>> On 11/10/2022 16:14, Johan Hovold wrote:
>>>>> The power-down delay was included in the first version of the QMP driver
>>>>> as an optional delay after powering on the PHY (using
>>>>> POWER_DOWN_CONTROL) and just before starting it. Later changes modified
>>>>> this sequence by powering on before initialising the PHY, but the
>>>>> optional delay stayed where it was (i.e. before starting the PHY).
>>>>>
>>>>> The vendor driver does not use a delay before starting the PHY and this
>>>>> is likely not needed on any platform unless there is a corresponding
>>>>> delay in the vendor kernel init sequence tables (i.e. in devicetree).
>>>>>
>>>>> Let's keep the delay for now, but drop the redundant delay period
>>>>> configuration while increasing the unnecessarily low timer slack
>>>>> somewhat.
>>>>
>>>> Actually, the vendor driver does this 995..1005 sleep. But contrary to
>>>> our driver it does that after programming whole PHY init sequence, which
>>>> includes SW_RESET / START_CTL, but before programming the pipe clocks.
>>>
>>> Right, it does it after starting the PHY which means that you don't have
>>> to poll for as long for the PHY status.
>>>
>>> It's a different delay entirely.
>>
>> No-no-no. The 995-1005 delay was added guess for which SoC? For ipq8074,
>> where the config tables contain the ugly CFG_L writes for SW_RESET /
>> START_CTRL. So, it is the same delay, but added by somebody who didn't
>> care enough. The original 10-11 delay is a completely different story,
>> you are correct here.
> 
> Yeah, I noticed that ipq8074 was the first to abuse the prwdn_delay
> and possibly because of it starting the PHY already in its PCS table
> (which it never should have).
> 
> I'm talking about the intent of pwrdn_delay which was to add a delay
> after powering-on the phy and before starting it.
> 
> The vendor driver has a 1 ms delay after starting the PHY and before it
> starts polling as the PHY on newer SoC tend to take > 1 ms before they
> are ready.
> 
> So, I still claim that that delay in the vendor driver is a different
> one entirely.
> 
>> Thus, I'd say, the PCIe delay should be moved after the registers
>> programming.
> 
> No, not necessarily. Again, that's an optimisation in the vendor driver
> to avoid polling so many times. Since I can say for sure that there are
> no PHY that start in less than 1 ms, I wouldn't add it unconditionally.

I don't think it's an optimization. For me it looks like some kind of 
stabilization delay before touching pipe clocks.

> 
> Either way, separate change.
>   
>>>> I think we can either drop this delay completely, or move it before
>>>> read_poll_timeout().
>>>
>>> It definitely shouldn't be used for any new platforms, but I opted for
>>> the conservative route of keeping it in case some of the older platforms
>>> actually do need it.
>>>
>>> My bet is that this is all copy-paste cruft that could be removed, but
>>> I'd rather do that as a separate follow-on change. Perhaps after testing
>>> some more SoC after removing the delay.
>>>
>>> SC8280XP certainly doesn't need it.
>>
>> I think in our case this delay just falls into status polling. We'd
>> probably need it, if we'd add the noretain handling.
> 
> I'm not sure I understand what you're referring to here ("noretain
> handling")?

 From what I see in the downstream (4.19 at hand), the sequence is the 
following:

program_phy_config() // including SW_RESET & START_CTRL

delay

for pipe clocks:
clk_set_flags(info->hdl, CLKFLAG_NORETAIN_MEM)
clk_set_flags(info->hdl, CLKFLAG_NORETAIN_PERIPH)

set clock rates, prepare & enable pipe clocks

wmb()

poll for the PHY STATUS


-- 
With best wishes
Dmitry

