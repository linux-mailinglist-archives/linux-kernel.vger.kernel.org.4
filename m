Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5334B6ADDF0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 12:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjCGLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 06:49:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjCGLsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 06:48:42 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0506A6F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 03:47:56 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s11so51035100edy.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678189649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zXmsPUQYwGJMekA8Fy8rD+9tRxaJGDIKc6SP+399FoE=;
        b=vQMimmeoShJhHytbnlC85/RZg8J73ZyWQScnYNdFmQL0c2eO6eHU6pYSBPEaQ8hy+L
         FoHj4aY9HT4N6R4T+XNBbq7mOJ6EA4bjPC+DCF106P4ZrYK0YF/k/9X2daPocewHYyYw
         EgdivDNQKJwLRLH9Mb5R6Jv5izZZduEwCicEHFNS88MwnJ8D1ZVwz8wyXc/5im2jeaDJ
         cjYIWBz0OBw+3eU5Y/wzdPksJvoi7irwos+2CeAyGF2uC66mJrSfT0huLuazGO3iyXA/
         xqHWPk8sQbFhrWixuity/g/uJPY6CqU8Ts+OxHOq0VtBDnTvvg4PXcW4aQSXgl+vCV6W
         ezUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678189649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zXmsPUQYwGJMekA8Fy8rD+9tRxaJGDIKc6SP+399FoE=;
        b=T/KtpwrCb0oNWvbKwTBAZsgXgS8OH75ABdyi9Gl0QuGnNY1afWUVdJ67Zg4kRcWht6
         4jjECnTPBUkfm0cuW53LFYi/MNq0Goz4lT/kccBOk6QKvOLN55Mvr9SiMBEqtQRSQsj0
         AKbwr2ptcKPLrL3iGPZF9bM7cvkdBXQ5iUk62Ums0YuBUu/TMzFMFVQXzYGy7BTUSA9j
         K78zpWQIekgYeomA/mrtC9y+huxM3Z3L1xioO4V4VhIjdykYcfteszgB5Uq6926yiwbI
         vBhAhEk8q169ChIod7rtcdMg6Bt7/Bvsh/zYfjuL+0cMIIfmTMQKyRlDzTBx6NDflxYc
         rLtQ==
X-Gm-Message-State: AO0yUKXyPzp9faHkfDoXuNq+nHNPV67+1zONmm2SQSVv8pR57IbjKdWu
        2WZNWf2/S9GQ8B1RW0yE6KLLww==
X-Google-Smtp-Source: AK7set/1gpL/LLC2huoOCatJikHhDjXi04XynN+FMDrg5BYAUanVJbwTkH0/o6MQETKaewMXnljpog==
X-Received: by 2002:a05:6402:1a4d:b0:4a2:223d:4514 with SMTP id bf13-20020a0564021a4d00b004a2223d4514mr13782735edb.8.1678189649366;
        Tue, 07 Mar 2023 03:47:29 -0800 (PST)
Received: from [192.168.2.107] ([79.115.63.78])
        by smtp.gmail.com with ESMTPSA id w22-20020a17090633d600b008b907006d5dsm6072533eja.173.2023.03.07.03.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 03:47:29 -0800 (PST)
Message-ID: <f88b7164-881b-5ada-0d52-05fe418f7b85@linaro.org>
Date:   Tue, 7 Mar 2023 11:47:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V5 09/15] spi: Add stacked and parallel memories support
 in SPI core
Content-Language: en-US
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pratyush@kernel.org" <pratyush@kernel.org>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230306172109.595464-1-amit.kumar-mahapatra@amd.com>
 <20230306172109.595464-10-amit.kumar-mahapatra@amd.com>
 <1bbda9e6-37fb-195b-fd62-0e437847c636@linaro.org>
 <BN7PR12MB2802992D71DDA252B008AFDADCB79@BN7PR12MB2802.namprd12.prod.outlook.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <BN7PR12MB2802992D71DDA252B008AFDADCB79@BN7PR12MB2802.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/23 11:37, Mahapatra, Amit Kumar wrote:
> 
> 
>> -----Original Message-----
>> From: Tudor Ambarus <tudor.ambarus@linaro.org>
>> Sent: Tuesday, March 7, 2023 9:51 AM
>> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>;
>> broonie@kernel.org; miquel.raynal@bootlin.com; richard@nod.at;
>> vigneshr@ti.com; jic23@kernel.org; pratyush@kernel.org
>> Cc: linux-spi@vger.kernel.org; linux-mtd@lists.infradead.org; linux-
>> kernel@vger.kernel.org
>> Subject: Re: [PATCH V5 09/15] spi: Add stacked and parallel memories
>> support in SPI core
>>
>> There were too many recipients in To and Cc and I couldn't reply to the
>> email. I whipped off the Cc filed and most of the people from To and added
>> the lists in Cc.
>>
>> On 3/6/23 17:21, Amit Kumar Mahapatra wrote:	
>>> Multi CS support using GPIO is not tested due to unavailability of
>>> necessary hardware setup.
>>
>> Please don't add code that is not used or tested.
> 
> During our discussion on the RFC, Mark had suggested to add multi-cs support
> via GPIO as well. We had agreed to add multi-cs support via GPIO, but had also
> mentioned that we don't have a hardware setup to test the CS GPIO use case.
> https://lore.kernel.org/linux-arm-kernel/BN7PR12MB2802E2A9079E505932832270DC979@BN7PR12MB2802.namprd12.prod.outlook.com/
> 

Ok, his call then.
Cheers.
