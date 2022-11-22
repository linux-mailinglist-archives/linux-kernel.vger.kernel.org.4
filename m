Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1863633738
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiKVIdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiKVIdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:33:15 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FEC2AC52
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:33:14 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id y10so11770075plp.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 00:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICq6wKj+fTCmm2GjCUS1L0jcKrWJpIWh5rHEbpke/Aw=;
        b=F97DvddPsXnZFYx+QA0dfxA6f30QqDBS69xRYssBkziviud34e1LSnX9q7xF/57AuE
         dP0StyJf+OaVouXPLVZ/Ce+C/uKXJ3gYoZLnAf3E2UnKyLAaykL9jHZe/J0qxWLvcb/3
         g33c/xMTGng9r4Aucbbcy2yDCaxrt1nzY+QrQn+7LJY5gScK/lNJ81AxkYA6Mkxa0BX6
         QNcoi8zGYqUflEtd5A7aOuBkTkGgviLK1RaQ5ICYAt2/4eupEedkUzUNheoKnfMJYl/X
         LaEncu+bZgFb7Dv0ZAnsZdMJJ7eXn3+HMe/TtL6Im+9ZI7GtgiKzgFhM8R9Oej5E7otX
         0UOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ICq6wKj+fTCmm2GjCUS1L0jcKrWJpIWh5rHEbpke/Aw=;
        b=2HuPb6rrVUDVFdvtJ9gGacJYEPFB9SDazrJRG8AV64eMdZ6GXmAbX/DX5RaByLAi4M
         rvs4k2KPLkSE6VaX0IJwXrBiQzRsBq7O1N3ePLgoV/6n70Br5vrBjSX00u9DBFthj0qn
         IUZrFWyXf4RWmuay7ftW8tBTcVLLfWwd9YY7adJEnLX2im5658wYBkWJnVg158hF7yCh
         cR9aQgkRYUbBvjtR+3AZ2FCmtwN0rQPul/rP+aJCfRWIl4oD+1mBZRsBFtVcnHECkJXf
         7MlaTlblByHJbeSdaDjXfMY2yxYGZIEsCktP5IpsG0Ni8/tqLBHEGM7nGi62wwdPIY0F
         aHXg==
X-Gm-Message-State: ANoB5pnQPXr+3BN1pOSqzswT59hRHyxU2enyXn6nG9yTzCYy9LrUsI3m
        qsJ5I/kWNhii9APXn7aLYmaK0g==
X-Google-Smtp-Source: AA0mqf4vL/diUtsIX5LpP10tBGJx/S2/Ws+e7zKi3MOsrP9d2mD1bwtgXW5DaRmMpVUpuJIekszqkg==
X-Received: by 2002:a17:90a:d38a:b0:218:a7e6:60df with SMTP id q10-20020a17090ad38a00b00218a7e660dfmr11210368pju.38.1669105993608;
        Tue, 22 Nov 2022 00:33:13 -0800 (PST)
Received: from [10.254.109.138] ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903120c00b0016c5306917fsm11448352plh.53.2022.11.22.00.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:33:13 -0800 (PST)
Message-ID: <ff3e9255-028a-7174-3608-2d9c362bdaf7@bytedance.com>
Date:   Tue, 22 Nov 2022 16:33:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [External] Re: [PATCH v2] mm: add new syscall
 pidfd_set_mempolicy().
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, corbet@lwn.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org
References: <20221111084051.2121029-1-hezhongkun.hzk@bytedance.com>
 <20221111112732.30e1696bcd0d5b711c188a9a@linux-foundation.org>
 <a44f794e-fe60-e261-3631-9107822d5c36@bytedance.com>
 <Y3IqLzvduM6HqPJV@dhcp22.suse.cz>
 <3a3b4f5b-14d1-27d8-7727-cf23da90988f@bytedance.com>
 <Y3KFFfMFE55lVdNZ@dhcp22.suse.cz>
 <82c9c89c-aee2-08a3-e562-359631bb0137@bytedance.com>
 <0bd0b744-3d97-b4c3-a4fb-6040f8f8024a@bytedance.com>
 <Y3T6SqZvAmSG5I6W@dhcp22.suse.cz>
 <6433156f-34a8-400f-e282-91268b242279@bytedance.com>
 <Y3uNWbPmwHtytKzY@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y3uNWbPmwHtytKzY@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal, thanks for your replay and suggestions.

> 
> Yes the memory consumption is going to increase but the question is
> whether this is something that is a real problem. Is it really common to
> have many vmas with a dedicated policy?

Yes, it does not a realy problem.

> 
> What I am arguing here is that there are essentially 2 ways forward.
> Either we continue to build up on top of the existing and arguably very
> fragile code and make it even more subtle or follow a general pattern of
> a proper reference counting (with usual tricks to reduce cache line
> bouncing and similar issues). I do not really see why memory policies
> should be any different and require very special treatment.
> 

I got it. It is rather subtle and easy to get wrong if we push forward
with the existing way and it is a good opportunity to get from the
existing subtle model. I will try that on next version.

__
Best Regards,
Zhongkun
