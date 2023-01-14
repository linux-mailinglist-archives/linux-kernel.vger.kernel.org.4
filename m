Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3840766AC7B
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 17:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjANQKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 11:10:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjANQKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 11:10:46 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F015B93D8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:10:23 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o18so4099144pji.1
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 08:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tmmmURYnaqXjy0ldHbAtARGn0vizyYaKMEULToh+0I=;
        b=c2s0IXU3l8eNBBMsvmSxpNtjT1wNRVaOwP6RpaA336u4c4z1FKdblhotnmCIlldYo9
         MV3/556EpjW1UiCQ/957UMTG/pBjmx0sVm6PzJvzkiVrIvS69Bzct5pgPHSHbxdAKPwG
         7SJyeb/NgB4s50vtfmoIgOaT0ieNvv0qpvwOZ5itAocqxzWrJ9m3GZJlKpJ/8GJnFZqb
         OZN0vxIE5mKffCChGJF3bOGq+2v836I/4mZmfyXfKcu4SO6BhbvETLhzOn/9y+L6Aiac
         UrvAC3pFNTla4es9faq0rEz5wxhaubdrB12xxDk9ZuxYTkw0fPB+gbYfRu8s0nEQP0R7
         pRWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/tmmmURYnaqXjy0ldHbAtARGn0vizyYaKMEULToh+0I=;
        b=3RKQd/ZyDKEKB2y3UeS4kKfJrQ0bT+bLnnz04+ZULY/k1MlT/2egEbe6WIVBTRYg8t
         K6LA8QRDwiI8wwiSmxFGWa7jCxJushpBLaVBDA1wN9NNmoOXQ1K6DbrthGRl9pkOrrn+
         rHITj4LEjNVIVbamcD/6Oipj/PD4577S9AYaK6R3VBH4b56se5UW/Abq0KXPMlV8IrF8
         rBrK+waUWFY7GM0YSkbXVgU5KVYvxOC2bAaF1a6HVE5M92n8WRKE+dYSMPlmQF1S7PaR
         +MxiVxeTyt3gu1q4/NgkRKYrA1oaloBaddo3DtmnC7xGYon+khT6plehxhl6Sjt27l3n
         lHiA==
X-Gm-Message-State: AFqh2kokwVUVHJPa34O2OsAHdCZfqg/a/CInau1VD8ta7hubRgGsqfi2
        2W5/GB4In0eqmU1aaEhJfPwP5g==
X-Google-Smtp-Source: AMrXdXsvS1Zq+8xnq2l6HFG5hM4Mu2ldnNenuKeIOmKOsuI/t6rUkL8pfWsO59uskSrv4x+O7CDVog==
X-Received: by 2002:a17:90b:952:b0:229:472d:af43 with SMTP id dw18-20020a17090b095200b00229472daf43mr2718718pjb.44.1673712623514;
        Sat, 14 Jan 2023 08:10:23 -0800 (PST)
Received: from [10.5.37.157] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id ca1-20020a17090af30100b00226daa7b377sm1445174pjb.52.2023.01.14.08.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jan 2023 08:10:22 -0800 (PST)
Message-ID: <36e3df6c-0f70-96e5-51e2-55870b134713@bytedance.com>
Date:   Sun, 15 Jan 2023 00:10:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [External] Re: [PATCH 0/3] mm: replace atomic_t with percpu_ref
 in mempolicy.
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        wuyun.abel@bytedance.com
References: <20221204161432.2149375-1-hezhongkun.hzk@bytedance.com>
 <Y8GE1r9/c1DHsHj0@dhcp22.suse.cz> <Y8GFUiSih8f0mUoU@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y8GFUiSih8f0mUoU@dhcp22.suse.cz>
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

> On Fri 13-01-23 17:20:39, Michal Hocko wrote:
>>
>> This is really hard to follow. Without having the context from previous
>> discussions I would be completely lost. Please structure your cover
>> letter but also other patch in general in the form:
>> - what is the problem you would like to deal with
>> 	- want to introduce pidfd_set_mempolicy because XYZ
>> - what stands in the way
>> 	- mempolicy objects access constrains (reliance on operating in
>> 	  the current context)
>> 	- reference counting needs to be unconditional
>> 	- why regular reference counting is not sufficient (performance)
>> - what is this patchset proposing
>> 	- per cpu reference counting
>> 	- how is it implemented
>> - how is the patch series structured
>> 	- make the reference counting unconditional
>> 	- special case static (never released) policies
>> 	- replace standard ref counting by per-cpu reference counting
> 	- introduce pidfd_set_mempolicy
>> - how has this been tested?

Hi Michal, thanks for your review and suggestions.

I will follow the advice above to structure the letter and
split the patches smaller on next version.

Thanks.
