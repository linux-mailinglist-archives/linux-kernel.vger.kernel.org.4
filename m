Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3602E6A2443
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBXW2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBXW2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:28:34 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4D417159
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:28:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id p26so676621wmc.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 14:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/NyMBqJPXAtbFE6QfoEt0ShoiVYWsmZyw6lZIW+hMhI=;
        b=mCKNrSsWccliXsjAtwUObNGFGWCC9tox/Kye5+fSI3ZkWNqgJH4+VVsxqqUjQjLQYt
         bWwU4Ty3Y58DQyWPDg7Vu+d1DwyoW1DnV7fskLqUTNO3txqpvOaqG+9ZszKab2xkl1vq
         9LOzcvXL3Jd4hMOJ/EJrniuFOiCi4JHiNioS9gsuQqeCQIKTVBWVpdGFYytwK+alxmsx
         0E31kwU+Q6dDD1YPu+R5EB5UO5N+A+gwcTbZdnN+deEiFtXgy9VQy87bSNGmV/+Px2dw
         lsxg8tQvJo27NafXd6XMW4knBbZ+BEb2daq09WTJ8RLHsQ9f2BPTtCYqJLv7EI9wFxLx
         Qeqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/NyMBqJPXAtbFE6QfoEt0ShoiVYWsmZyw6lZIW+hMhI=;
        b=No/4gV1Iy99SUtfYPC8w6KOp0E8a7rD/95eKieDyp9CH9KwQEvcKn92tc7HEMxGiRA
         jr5jHVROMIQ8kFESGjFObb2agZtCHkYH85n1TLx4J6ef012IBIITRPuR542iBsc7cPU2
         IoesKl/vauKp0hcI9FrJHeMjy6+fGL9NeDy0+i3zXKaPyszwVleNXu9OxInvhHd+cU3Q
         UzKwvmUzqMIrwVFmIg3FLCyke7OowBH55INkOIkGPBoOiTj9RI9mTsRZFcC3Oqc5/+iq
         zSIjfzRbI/vVWjCAlnfWp9Bmtj8/BuR22qwcXoEyuo4IqtiGeGlQ4oriVhJFxBTVQmBT
         rYcw==
X-Gm-Message-State: AO0yUKXpAUht8jUypcQ328JNpDLiauVkiUSUgrIO5itf9PnMNtj9f0y5
        sAlcFt0kzuGF+1Zh36ADVK1d6Q==
X-Google-Smtp-Source: AK7set8wxYzcLZjEgC80AAfy0pLilux9eS9KmtMdA3ECEPrQc/S+DtFqk8p8qWkTm2nk6Ub/bPjgOQ==
X-Received: by 2002:a05:600c:4e89:b0:3e2:5f6:3647 with SMTP id f9-20020a05600c4e8900b003e205f63647mr967650wmq.16.1677277711671;
        Fri, 24 Feb 2023 14:28:31 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h18-20020a05600c351200b003eb192787bfsm541692wmq.25.2023.02.24.14.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 14:28:31 -0800 (PST)
Message-ID: <d768c2b8-1649-6565-0367-a0e07cc01b03@linaro.org>
Date:   Fri, 24 Feb 2023 22:28:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH] dmapool: push new blocks in ascending order
To:     Keith Busch <kbusch@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Keith Busch <kbusch@meta.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230221165400.1595247-1-kbusch@meta.com>
 <Y/UHOohEMg+oyO8j@infradead.org> <Y/UIZC+plt9Y0nr1@kbusch-mbp>
 <20230223124137.e6fe921659e6f6f1c10668b6@linux-foundation.org>
 <Y/kA1Tp5wIZSiY4q@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <Y/kA1Tp5wIZSiY4q@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 18:24, Keith Busch wrote:
> On Thu, Feb 23, 2023 at 12:41:37PM -0800, Andrew Morton wrote:
>> On Tue, 21 Feb 2023 11:07:32 -0700 Keith Busch <kbusch@kernel.org> wrote:
>>
>>> On Tue, Feb 21, 2023 at 10:02:34AM -0800, Christoph Hellwig wrote:
>>>> On Tue, Feb 21, 2023 at 08:54:00AM -0800, Keith Busch wrote:
>>>>> From: Keith Busch <kbusch@kernel.org>
>>>>>
>>>>> Some users of the dmapool need their allocations to happen in ascending
>>>>> order. The recent optimizations pushed the blocks in reverse order, so
>>>>> restore the previous behavior by linking the next available block from
>>>>> low-to-high.
>>>>
>>>> Who are those users?
>>>>
>>>> Also should we document this behavior somewhere so that it isn't
>>>> accidentally changed again some time in the future?
>>>
>>> usb/chipidea/udc.c qh_pool called "ci_hw_qh".
>>
>> It would be helpful to know why these users need this side-effect.  Did
>> the drivers break?   Or just get slower?
> 
> The affected driver was reported to be unusable without this behavior.
>   
>> Are those drivers misbehaving by assuming this behavior?   Should we
> 
> I do think they're using the wrong API. You you shouldn't use the dmapool if
> your blocks need to be arranged in a contiguous address order. They should just
> directly use dma_alloc_coherent() instead.
> 
>> require that they be altered instead of forever constraining the dmapool
>> implementation in this fashion?
> 
> This change isn't really constraining dmapool where it matters. It's just an
> unexpected one-time initialization thing.
> 
> As far as altering those drivers, I'll reach out to someone on that side for
> comment (I'm currently not familiar with the affected subsystem).

We can always change this driver, I'm fine to do that in-parallel/instead.

The symptom we have is a silent failure absent this change so, I just 
wonder are we really the _only_ code path that would be affected absent 
the change in this patch ?

---
bod


