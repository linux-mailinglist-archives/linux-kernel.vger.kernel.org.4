Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6705EEF07
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbiI2Haf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiI2Ha0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:30:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281FE186D1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:30:23 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a14so583762ljj.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OqkWyQYUuDRkm7zgyVEX1I32YrHW4vNoTuwMudpxXDQ=;
        b=M/Of4/LnK1AKOSsdNO9WzfJyoy+sI5QdeIZBrmSLoV6q6cONr8NMF6++ud4b0nZG+0
         1Wps92ejomNXmRTLhs/T6mzAVkiqDO8tICuzDTPYoll3Qi6Uk5RjkXNEZfiX8nTgsNWA
         lNfH3p4+t/1H/1B9G6up7jplAXvEoZSyiQ/wvG7w7P1/U/auLaNBXrdb9qXnmO37+pub
         pjRGwON+EuskIqrOrms7cdUFsQAAZVaYz0KWu54s1MMUgxBViPxLYzCP/cgg7u0NRzGE
         cdFSX+O/d3fAhafn7JxYSvnBBLmvuYD3gM3ZbY0fhdpD26C1wUAoXw3yHU1ApJ70Y3nK
         D9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OqkWyQYUuDRkm7zgyVEX1I32YrHW4vNoTuwMudpxXDQ=;
        b=3T2f6h9jwyoPU9Q+e8ZA8FwdwmPpa7XTJ7La+pRFIfhi+jaPq4XDCyn3rhxyjF+QkH
         qqkzDmCj62jycggaguN2/0yxT2AHdtRPeqZJjGFfQSsgKq0zbJBjsPL79mxKQmHkBDRA
         qa+DTB4HmQzATOG7B08v7tc2sKPWYeDfy+ziiLWQGdd8t1Lrl0kGQqj359xR0oomnvd7
         62L/8TSq/Ielq/6PG07s63319Kv+MSOe4k6wmnglQ/vukacJHEh+tCjP0YC9tfEW5d7c
         vET5DWbYZy2noL6ikBo50PhdPm6770CCqPRg9VRmFu+53rdy4VkY0NGwnFyaLbtBLL3d
         At7Q==
X-Gm-Message-State: ACrzQf1Jlhzji8vENESI2miMbqVOvYD6l5TWsKaQRtfK6HbK4+THW5zL
        m0uIvj1m+z++CooSAxyQxa3BHFML2EC6/w==
X-Google-Smtp-Source: AMsMyM4ILN/PXRDClqWGg7oAxUN4BU0A6IzD09RlvPlrnNNjJZ4iA+Hmfs/JXaRi7sEpTeApVP+N0Q==
X-Received: by 2002:a2e:be0a:0:b0:26b:eb1d:9651 with SMTP id z10-20020a2ebe0a000000b0026beb1d9651mr641868ljq.196.1664436621484;
        Thu, 29 Sep 2022 00:30:21 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id a5-20020a056512200500b0049301e29e41sm700855lfb.233.2022.09.29.00.30.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:30:21 -0700 (PDT)
Message-ID: <7f577974-7433-107a-a43a-4a3a5f999018@linaro.org>
Date:   Thu, 29 Sep 2022 10:30:20 +0300
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
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <YzVIhK5z3I6hjzLU@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 10:25, Johan Hovold wrote:
> On Wed, Sep 28, 2022 at 10:15:46PM +0300, Dmitry Baryshkov wrote:
>> On 28/09/2022 18:28, Johan Hovold wrote:
>>> Always define the POWER_DOWN_CONTROL register instead of falling back to
>>> the v2 offset during power on and power off.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 20 ++++++--------------
>>>    1 file changed, 6 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> index eea66c24cf7e..47cdb9ed80cd 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>>> @@ -90,12 +90,14 @@ static const unsigned int pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>>>    	[QPHY_SW_RESET]			= 0x00,
>>>    	[QPHY_START_CTRL]		= 0x08,
>>>    	[QPHY_PCS_STATUS]		= 0x174,
>>> +	[QPHY_PCS_POWER_DOWN_CONTROL]	= 0x04,
>>>    };
>>
>> Without symbolic names it's not obvious that 0x04 (and thus this
>> regs_layout) can be used for v2 and v3, but not for v4.
> 
> It's no less obvious than it was when we were falling back to the v2
> define when it wasn't in the table.

Yes, that's without doubts. Anyway, I've sent my view on the regs 
layouts standing on top of your six patches from this series. Could you 
please take a glance?

> 
>> @@ -1872,13 +1874,8 @@ static int qmp_pcie_init(struct phy *phy)
>>        if (ret)
>>                goto err_assert_reset;
>> -     if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL])
>> -             qphy_setbits(pcs,
>> -                             cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
>> -                             cfg->pwrdn_ctrl);
>> -     else
>> -             qphy_setbits(pcs, QPHY_V2_PCS_POWER_DOWN_CONTROL,
>> -                             cfg->pwrdn_ctrl);
>> +     qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
>> +                     cfg->pwrdn_ctrl);
> 
> This is the cruft I'm getting rid of.
> 
> Johan

-- 
With best wishes
Dmitry

