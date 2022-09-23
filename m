Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81F05E7E57
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiIWP0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 11:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiIWP0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 11:26:39 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208613FB60
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:26:38 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so8143272pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 08:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=ZWy71aF5Z4g2M7EPQKOVM2PfzynmTIcPbYGqsH4ugQ0=;
        b=Mc/z/AW6VhBGHjGOwfn5PkruFSYFBqwRa5tn3GQM1lteEuCJ+V+6CTTP+G7dOZobuq
         SWkg0q7JprL6fPbvwir3O3D3qKy1ydWGK8W7Kf+IVk+byBRnLMC2DbHJPNBWSU9TBi8L
         VCy9giJRvqA10AGLkdx52plKJ0ZUGujwB2zWMv44LDqZYgwCHropbLoWHZ0KrdngDhws
         GGKp3HoKQvAzGeeqFPEHPEeieFN5NfrQtixeYoOb3q1x11vmTs681STsJInjzjbG2HER
         BS9VPdRm5uNaGZMm5QmPMjCheLjyDIeN8yS14WY2ESUAL5Kc/XQgKtaI5foIEeeb2JTf
         fTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=ZWy71aF5Z4g2M7EPQKOVM2PfzynmTIcPbYGqsH4ugQ0=;
        b=Y4mDNJkVWEEHrIGMxkoN7hVaS71/yhokLL+6DPox5mWp9z5jIlrRMoI5bPYzKcbnE9
         2TrJrb6lgCNXmSszdVNVs5VlQSzLz14J+JduTy4+lgdBFPCs7899Psi5QqsnkB6JFZsI
         6TWqCfZ0bp0ttOw+odNSlX9E+9MHtLaEI3XMBeCRBfqpLY8dyCAzMuD0vqEsgf4VqN5o
         9EBjOi2ztlHsnc9RSzTPqanFlad/DAzMLhobgZWWdFSlZmXGkL7i0jk3epA5oJuGQVZO
         WbgTBAaoGQwx/wDlce5idg/0NUupQWH/yOpZOGuW9S8pPjvNuW2J0zdMGOQBVZSgg5yT
         wpkw==
X-Gm-Message-State: ACrzQf28rF81tfz6zMjjJIfofIBHWOESpHux5Gxfh+7y7tNGXf56u8xf
        ZsotiKu7chyEpO9ZmDVMvq4AN8cRoEgytg==
X-Google-Smtp-Source: AMsMyM4GYd6v9EMcN/Fb6ZH7c8imRbDWdoMZ8VzP/mcwqALCzvBDvUx78UKS9xewkApkxFvEyWUvAQ==
X-Received: by 2002:a17:903:130f:b0:178:b6fd:7eb3 with SMTP id iy15-20020a170903130f00b00178b6fd7eb3mr9012080plb.82.1663946798026;
        Fri, 23 Sep 2022 08:26:38 -0700 (PDT)
Received: from [10.4.89.86] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id y7-20020a623207000000b0053f9466b1b2sm6610523pfy.35.2022.09.23.08.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 08:26:37 -0700 (PDT)
Message-ID: <ecceec1b-d201-fef5-de91-476c44151517@bytedance.com>
Date:   Fri, 23 Sep 2022 23:26:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [External] Re: [PATCH] cgroup/cpuset: Add a new isolated
 mems.policy type.
To:     Michal Hocko <mhocko@suse.com>
Cc:     hannes@cmpxchg.org, roman.gushchin@linux.dev,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, lizefan.x@bytedance.com,
        wuyun.abel@bytedance.com
References: <20220904040241.1708-1-hezhongkun.hzk@bytedance.com>
 <YxWbBYZKDTrkmlOe@dhcp22.suse.cz>
 <0e5f380b-9201-0f56-9144-ce8449491fc8@bytedance.com>
 <YxXUjvWmZoG9vVNV@dhcp22.suse.cz>
 <ca5e57fd-4699-2cec-b328-3d6bac43c8ef@bytedance.com>
 <Yxc+HZ6rjcR535oN@dhcp22.suse.cz>
 <93d76370-6c43-5560-9a5f-f76a8cc979e0@bytedance.com>
 <YxmXeC7te2HAi4dX@dhcp22.suse.cz>
 <fa5e5a79-aa1a-a009-d0c8-0a39380a71b6@bytedance.com>
 <120cb50d-d617-a60a-ec24-915f826318f1@bytedance.com>
 <Yy1gP7wcoCqzRa0B@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Yy1gP7wcoCqzRa0B@dhcp22.suse.cz>
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

> 
> set_mempolicy is a per task_struct operation and so should be pidfd
> based API as well. If somebody requires a per-thread-group setting then
> the whole group should be iterated. I do not think we have any
> precendence where pidfd operation on the thread group leader has side
> effects on other threads as well.

Hi Michal,

I got it, thanks for your suggestions and reply.
