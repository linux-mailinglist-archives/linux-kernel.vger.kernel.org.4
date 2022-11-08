Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04888621A74
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234297AbiKHRZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:25:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbiKHRZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:25:53 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679971E705
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 09:25:50 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u6so14753636plq.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 09:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mck3R94LhYNk406NiNL9I97e3U5JD8+7t2CAdhzICvI=;
        b=41hH195DPKgo007bMbrxjr9I0oWip9wXLMeY4vGMz89oEGfbItSBF2r72B8+mLwh5b
         LwQCRcDOZH/lcNU73TgDtXor+9cughyeUTNpwysFf+d4LqWiPx1Nl7p8kPiIkb3Oxzvi
         zOA+04XqAjEun79374OtU70Z4SEy0yWffqehBwUNjhc+7R1vc9g8P6PnFiu17/Hpsfda
         2o96k0JqekD/GggiS+gnmBELi5Q1wiunCxZ0F3Lv9to/uS8JGY54ikzjWwcR40Hs8GHo
         3Qr9gwjw3mew3Xu/NN1f7raqX5krmfawwRprhT1Z0fOVQK4onQgPF0CAYNQgcmQCFWcd
         hbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mck3R94LhYNk406NiNL9I97e3U5JD8+7t2CAdhzICvI=;
        b=PSxV5OXvSUG47u80kiZA73ftTr+4trBguXntHaD65LQAL1aOPpgBIG5qCMGNt2+uxC
         xUzEIrm3ruPgzRZCvId9NAxzWX/hZJkpHRu2vZhGxLs+bfIjJ6L0+116gWA6RCN0Wc6H
         EMXc8z8sB1ADifbOXdkhigaBgWEnlQgshBY4hVO4tAZ6kKd0AgnS/kCJ+HnwecgawAtT
         IHALujA+AXjTlcaZbRJUaBrr9OP5cfPTFNmBkyxhS0YRmyYBdIre84omvpsnbwGBlnt4
         qd9rZ4VwkklvMSoBlyfakfSqmdc0sOkK+UHm/mvvM1B5JevArgJmlEUm/9DDomodx3Pd
         1ypw==
X-Gm-Message-State: ACrzQf1mCTJzhh7JZ3kiM0CfVKut30zYf2Y5ORsUYY0R19MDLQ4Hd/PE
        2KMxN4Eupd49RQGX5pqpRGd3nQ==
X-Google-Smtp-Source: AMsMyM6sTBnxvY/NsG71n933NQZ67F/l2/Icp154DLO0ppLjfuN27MFxKkBOhJfyYluxvAX3KJcKeA==
X-Received: by 2002:a17:902:b94c:b0:178:336f:13d6 with SMTP id h12-20020a170902b94c00b00178336f13d6mr58156215pls.64.1667928350306;
        Tue, 08 Nov 2022 09:25:50 -0800 (PST)
Received: from [192.168.50.116] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id p64-20020a625b43000000b0056bdc3f5b29sm6581656pfb.186.2022.11.08.09.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 09:25:49 -0800 (PST)
Message-ID: <d3dc1dac-a17a-4e5d-2584-88bd7645ac1d@rivosinc.com>
Date:   Tue, 8 Nov 2022 09:25:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v10 05/16] riscv: Add has_vector/riscv_vsize to save
 vector features.
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        Greentime Hu <greentime.hu@sifive.com>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        aou@eecs.berkeley.edu,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
        Guo Ren <guoren@kernel.org>,
        Conor Dooley <Conor.Dooley@microchip.com>
References: <cover.1652257230.git.greentime.hu@sifive.com>
 <221f72a2ee62cd5350edb5d6a7e8ebb17a7bc321.1652257230.git.greentime.hu@sifive.com>
 <YoHzkxDmMegp5oOz@infradead.org>
From:   Vineet Gupta <vineetg@rivosinc.com>
In-Reply-To: <YoHzkxDmMegp5oOz@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/22 23:47, Christoph Hellwig wrote:
> On Wed, May 11, 2022 at 08:31:15AM +0000, Greentime Hu wrote:
>> +#ifdef CONFIG_VECTOR
>> +#include <asm/vector.h>
>> +EXPORT_SYMBOL(rvv_enable);
>> +EXPORT_SYMBOL(rvv_disable);
>> +#endif
> 
> As far as I can tell these are not used by any modular code, just by
> the later added kernel mode vector enable helpers.
> 
> Even if they were used this would need to be EXPORT_SYMBOL_GPL.

In the new version, I've made them static inline given the size and 
frequency of them being called. So this becomes moot.

> 
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Copyright (C) 2012 Regents of the University of California
>> + * Copyright (C) 2017 SiFive
>> + * Copyright (C) 2019 Alibaba Group Holding Limited
>> + *
>> + *   This program is free software; you can redistribute it and/or
>> + *   modify it under the terms of the GNU General Public License
>> + *   as published by the Free Software Foundation, version 2.
>> + *
>> + *   This program is distributed in the hope that it will be useful,
>> + *   but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *   GNU General Public License for more details.
>> + */
> 
> No need for all the GPL boilerplate text when you have an SPDX tag.

OK.

