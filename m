Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60246627A25
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiKNKMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236570AbiKNKMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:12:01 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77054205C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:10:46 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id a15so12474485ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzkRo4x4df26Ftl89WHvSf17LxMJ10o70KQdLoo03zQ=;
        b=IAJ4BC+52sSeaa0Xk4+57wuo/GDX1mtIbPMNyUb1sI/KgLrwrZaLs81Qph6nikQBgY
         67s164yycg/oIghhwuMN0BVxo/p2GK8xWe7ATMPdlqSroeP1zko4Kl/EJV/UDUNMXCp8
         rSB7eyQIcW9CSv94wbe7+ixYyRb54fPcwi+BQfE3dytp54+1tlVKFmT6fiQCkNNKX5Gh
         mPJN6BoB+tV803MDwmsTqe8DsMB7LjlUhNT4qLck3cCGqsAFV32xEY7esYl5Z+1XCRHK
         JUbv4HfVhcpeQe0xPbPlsuaSgVjkG5k+nZG20scx6k7AKiPuNkzgonHfNmYt89IW/mIj
         lMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzkRo4x4df26Ftl89WHvSf17LxMJ10o70KQdLoo03zQ=;
        b=mJqxqD75C9IOybVGj81+N/YONzAbtxAFQDhY4ROv0Y7i0PNEABpaBMzV7nqCV8+14x
         ki1ytEl62w7MSwnKps4zPJtjP+4Z594+dUE8C98A8E6xGjLQ6J7eUDT+z1+wTaJZCz3e
         bYNCGKElohqaffMy/qNamxIeAhn4lm/gGXj1kDPDJZvDDpcW3nHlUcTeFJ+lJ9JwoXn0
         oiNeei9PQsrOYFf7gRnS7SvTVA87eo5evy0ntCNSe5t3IvmtQPgnGqsJhdUBIgt0elru
         HfosE02OzW2UOy7N1xJRF8xNOfLnldIlfzL4heMcmw0dC+fBUaLeynTRcMYwyWfuawle
         O0OQ==
X-Gm-Message-State: ANoB5pmZKw98uFvxZxvvGoj+A3hsn4N6z2qwYRB2K1mF3SumHosc+ZXu
        qNDj4lZXJ1OTR8HpF7esTco/JQ==
X-Google-Smtp-Source: AA0mqf6I/gCN8/WIbRN/kWXopgh6mgdY4xaKDdudvkK45MavgULyoBOTXpSA9DRfgtkR4Zh/YTeg7w==
X-Received: by 2002:a2e:a401:0:b0:277:37a8:ba87 with SMTP id p1-20020a2ea401000000b0027737a8ba87mr3629887ljn.14.1668420644879;
        Mon, 14 Nov 2022 02:10:44 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b004a45ed1ae21sm1757875lfa.224.2022.11.14.02.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 02:10:44 -0800 (PST)
Message-ID: <8802255c-16a9-1fb7-bbc5-d8e0d44a6f1f@linaro.org>
Date:   Mon, 14 Nov 2022 13:10:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 17/22] phy: qcom-qmp-combo: merge USB and DP
 configurations
Content-Language: en-GB
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-18-johan+linaro@kernel.org>
 <5fd7a56f-db12-deb3-753a-22867526d90b@linaro.org>
 <Y3ICOwr2ld9cdgrK@hovoldconsulting.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <Y3ICOwr2ld9cdgrK@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 11:54, Johan Hovold wrote:
> On Sat, Nov 12, 2022 at 10:43:14AM +0300, Dmitry Baryshkov wrote:
>> On 11/11/2022 11:56, Johan Hovold wrote:
>>> It does not really make any sense to keep separate configuration
>>> structures for the USB and DP parts of the same PHY so merge them.
>>>
>>> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
>>> ---
>>>    drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 182 +++++++---------------
>>>    1 file changed, 57 insertions(+), 125 deletions(-)
>>>
>>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> index b27d1821116c..249912b75964 100644
>>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
>>> @@ -798,10 +798,7 @@ static const u8 qmp_dp_v5_voltage_swing_hbr_rbr[4][4] = {
>>>    
>>>    struct qmp_phy;
>>>    
>>> -/* struct qmp_phy_cfg - per-PHY initialization config */
>>>    struct qmp_phy_cfg {
>>> -	/* phy-type - PCIE/UFS/USB */
>>> -	unsigned int type;
>>>    	int lanes;
>>
>> int lanes doesn't really make sense here in my opinion. It should be
>> usb_lanes and dp_lanes.
> 
> It doesn't make much less sense than having it here currently do.
> 
> All of these USB-C PHYs are dual lane for bi-directional SS USB and
> quad lane for uni-directional DP (even if only CC1 orientation and lanes
> 2 and 3 are currently supported).

I was under impression that sdm845 has just a single lane for each of 
USB and DP. After rechecking the phy/next, I see that it was my mistake 
(quite logical, SS is two lanes, so the compliant PHY must have two 
lanes too).

I wander how/if 4-lane DP works. The only thing that we do is 
programming of the QSERDES_DP_PHY_PD_CTL register, however judging e.g. 
your 4-lane PCIe changes, one should probably also program the other two 
lanes. Maybe it is handled automatically inside the hardware.

> I should probably just drop the lanes parameter completely, either as a
> preparatory clean up or as follow-on one (e.g. also a bit depending on
> if there are other reasons for respinning a v2).

I think a follow up is enough, but let's get it. Having a single lanes=2 
field looks... strange.

-- 
With best wishes
Dmitry

