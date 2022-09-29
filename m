Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0315EF149
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiI2JHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiI2JHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:07:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C0613FB5B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:07:10 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a10so862306ljq.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 02:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=BgfSaXaz1zXc5P9tbbwdP68iTN9st+1bzf5UzrFtKn0=;
        b=nHkoa1A8iH9uJHyJ4dbRA5NP2CALm3oT4F15UkFvprXThuucEVU2v7jne36IUoxzml
         c1JwecdrA47q74SJ1zWo92K85uJTuItZKrJhTX2YR52x33hyT2eFD0DvrdrOzKzBkOfb
         AAG5SDX6HWQhS5eM/JfjOZyyDdoS8G88OFbM44c6PpVb6LiMDFOe4IlrVU3L8msbFFUU
         yv7U4VxRPAGiCWhB87m9U43l7iEZIBxzhCnsHMQL90R7sTawOCGoIRMByr1BGOVpsJWX
         jczQZTGC9RLGCFWfKAxjS6UXbe1mORaIh0OHuaQ4tg2wJwUvee6xeAz3Z08RKAV+xOwi
         YrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=BgfSaXaz1zXc5P9tbbwdP68iTN9st+1bzf5UzrFtKn0=;
        b=LDUzPJNXoZeppVwxC1e5f+OMJOXEFgSyo7vC6QRu+JA+BmYPR5h+sQIACS+8JTY8Po
         wA/THU3xUJyAmofaJTDromYdHfg6RFJTgg8z1GAZkfUwyqjlwJYaqPsMhF771ljY2YGs
         s+kqhMdpMLaeC7Zhrqm1NWYmpeVAAzxQkY8iB04HfYKXlJRSh0GOMhl4R0YWes9PxnkP
         ch6TAcrBFFigd8HWOcNQ3D6GWOeANQv6W2ym57ZAzrK18cIaRyaqRe7ior+IoNvLxHXf
         4bmD97nvupJdwg7zwbP9HPyVG9LhHv/n3QdztueS4zyCXJXpIAK7ALcByMxJ+5x559UW
         Jhgg==
X-Gm-Message-State: ACrzQf1cBB1WxDDwJ3gvDV9jvjQ2xP0JBToR9NlcBR32t2CNKXKt2Dqt
        6T7mczn/r+LjoldiR4N7LwQjUA==
X-Google-Smtp-Source: AMsMyM5t2Wq64cR0qdS2uRMZIEG/WamoxgBuWgMAQoKhLKt0VRuwaAA+wA1qvEmY4WqX2DIkQZRQYQ==
X-Received: by 2002:a05:651c:a05:b0:26c:5010:39ce with SMTP id k5-20020a05651c0a0500b0026c501039cemr747965ljq.53.1664442428289;
        Thu, 29 Sep 2022 02:07:08 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bj39-20020a2eaaa7000000b0026ab0087ff3sm656057ljb.54.2022.09.29.02.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 02:07:07 -0700 (PDT)
Message-ID: <153ada3a-f24e-fef5-6343-dcc584fc0079@linaro.org>
Date:   Thu, 29 Sep 2022 12:07:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 07/13] phy: qcom-qmp-pcie: clean up power-down handling
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220928152822.30687-1-johan+linaro@kernel.org>
 <20220928152822.30687-8-johan+linaro@kernel.org>
 <c3d39c4e-2099-b09a-8486-8abae7336611@linaro.org>
 <YzVIhK5z3I6hjzLU@hovoldconsulting.com>
 <7f577974-7433-107a-a43a-4a3a5f999018@linaro.org>
 <YzVflom04uK0gojn@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YzVflom04uK0gojn@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 12:04, Johan Hovold wrote:
> On Thu, Sep 29, 2022 at 10:30:20AM +0300, Dmitry Baryshkov wrote:
>> On 29/09/2022 10:25, Johan Hovold wrote:
>>> On Wed, Sep 28, 2022 at 10:15:46PM +0300, Dmitry Baryshkov wrote:
>>>> On 28/09/2022 18:28, Johan Hovold wrote:
>>>>> Always define the POWER_DOWN_CONTROL register instead of falling back to
>>>>> the v2 offset during power on and power off.
>>>>>
>>>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>>>> ---
>>>>>     drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 20 ++++++--------------
>>>>>     1 file changed, 6 insertions(+), 14 deletions(-)
>>>>>
>>>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>>> index eea66c24cf7e..47cdb9ed80cd 100644
>>>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>>>> @@ -90,12 +90,14 @@ static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>>>>>     	[QPHY_SW_RESET]			= 0x00,
>>>>>     	[QPHY_START_CTRL]		= 0x08,
>>>>>     	[QPHY_PCS_STATUS]		= 0x174,
>>>>> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
>>>>>     };
>>>>
>>>> Without symbolic names it's not obvious that 0x04 (and thus this
>>>> regs_layout) can be used for v2 and v3, but not for v4.
>>>
>>> It's no less obvious than it was when we were falling back to the v2
>>> define when it wasn't in the table.
>>
>> Yes, that's without doubts. Anyway, I've sent my view on the regs
>> layouts standing on top of your six patches from this series. Could you
>> please take a glance?
> 
> Sure, but I don't think doing that separate change should be a blocker
> for this series. Especially since you run into issues like it not
> always being clear which version of the IP is being used (IPQ).
> 
> I'd rather respin this series and drop the two patches that merged the
> two redundant layout structs.

I'm fine either way.

> 
> Then you can work on further clean ups on top for 6.2 since that's going
> to require some more careful review and thought.
> 
> Johan

-- 
With best wishes
Dmitry

