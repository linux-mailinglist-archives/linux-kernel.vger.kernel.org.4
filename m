Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C15690EF2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjBIRNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:13:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjBIRNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:13:01 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093DE66ED5
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:13:00 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso2056256wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 09:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5GPjhCbZ3et3vqmx7KmUEtwowI7Pr60n/KjlExkXei0=;
        b=GJo9WWtu1ZnJB6gV0M9juIZhKwkPObGpPjeXCInDvaP2nsf1ITStqZGZQQV+ZjiWti
         aAccOoexxwUkoZ9158tN7UCC5Q6zmuoBhcaDtUEtx5qoO+U8OL8EJl98oqXjOyrXPfI7
         hoD0I3pY/CyPkL8L67Iknvof2RekRnJ5O5yh8JIoDKKWIcPAHPbf170L0+LiV55OP2j8
         HUsSNYTCkPeyNROVSNBRw74cgYSJMoWBk2fLKNNMPPfncsewgYenOfRIsRMbabGYt4hE
         PwwYd1JXThN3vxJ60GglkM12+5w9y8tXt4sGS6igxVyrw4d56+pGK7bHtn55VQpGelS8
         10vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5GPjhCbZ3et3vqmx7KmUEtwowI7Pr60n/KjlExkXei0=;
        b=lvRTrr2yVfK2Ib0u+Ikn96i/2CoPbLqi3BbzVChQRNv8Q28bHyvXHK/2C0xnRWOLgo
         Zf7p6VKJ5wOzHn4IkW+tKu167nt1tweiZJZUgtnsYmFDNlWjiu1dTsFwLO8SBOrL1NuQ
         khbYKyF0DfXvHJBv/J0lv5xkA44QyXn+y7FRHltTc0necepbhU9FumP4oWyRE/LGytJi
         pbUKw04XFULV2DjzUB8OCbgHLxUWRSMi+XJdOxXrrHnz8LQLQ9oQGOV7X29Rxl6P91+E
         l+8B6jhQlclhGqM2v4WKTGhqdX1pAbwE3PCsnd6nMSLknqzMDacD5/59qCQBYEdAAQu5
         pCMw==
X-Gm-Message-State: AO0yUKUtY/kFEwCKg7jXkrFwtFQBOZlq1FUy24jlpmBdodkziGNCWHW+
        dc9xWhXVCKDzPX2CuHNkxby4Gvd3LRKgxH/u
X-Google-Smtp-Source: AK7set/40YxIru/Sg20+glOLA2RW2JIQUYkNBT2cAqfx+XkBJi1WBwHaILu2BCyKH2Dxn4lAVSA0Vg==
X-Received: by 2002:a05:600c:308a:b0:3dc:43a0:83bb with SMTP id g10-20020a05600c308a00b003dc43a083bbmr10774960wmn.3.1675962778601;
        Thu, 09 Feb 2023 09:12:58 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id j7-20020a5d6047000000b002c53a89f042sm1526667wrt.30.2023.02.09.09.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 09:12:57 -0800 (PST)
Message-ID: <8fb08ac8-13ae-cd87-869e-34af894407e8@linaro.org>
Date:   Thu, 9 Feb 2023 17:12:55 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/5] soundwire: qcom: wait for fifo to be empty before
 suspend
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
 <20230209131336.18252-4-srinivas.kandagatla@linaro.org>
 <dbec6aab-6456-72b3-39b6-3490dfdf083c@linux.intel.com>
 <a1d79008-3ec4-d7b5-12b5-ea5c6c5a8370@linaro.org>
 <f956351e-de37-062b-c02e-5cbdf9a3bdfd@linux.intel.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <f956351e-de37-062b-c02e-5cbdf9a3bdfd@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/02/2023 16:33, Pierre-Louis Bossart wrote:
> 
> 
> On 2/9/23 09:52, Srinivas Kandagatla wrote:
>>
>>
>> On 09/02/2023 15:23, Pierre-Louis Bossart wrote:
>>>
>>>
>>> On 2/9/23 07:13, Srinivas Kandagatla wrote:
>>>> Wait for Fifo to be empty before going to suspend or before bank
>>>> switch happens. Just to make sure that all the reads/writes are done.
>>>
>>> For the suspend case that seems like a valid approach, but for bank
>>> switch don't we already have a bus->msg_lock mutex that will prevent the
>>> bank switch command from being sent before the other commands are
>>> handled?
>>
>> All read/writes are fifo based, so writes could be still pending.
> 
> I am not following. The bank switch happens with this function, where a
> mutex is taken.
> 
> int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
> {
> 	int ret;
> 
> 	mutex_lock(&bus->msg_lock);
> 
> 	ret = sdw_transfer_unlocked(bus, msg);

Qualcomm controller uses fifo to read/write, so return after writing to 
fifo might not always indicate that write is completed.

Qcom Soundwire controller do not have any synchronous interrupt 
mechanism to indicate write complete.

--srini


> 
> 	mutex_unlock(&bus->msg_lock);
> 
> 	return ret;
> }
> 
> The transfer_unlocked is synchronous and waits for the command response
> to be available.
> 
> In other words, there's both a mutual exclusion and a synchronous
> behavior, so not sure how commands *before* the bank switch could be
> pending?

