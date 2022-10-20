Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4E6605763
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 08:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbiJTGgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 02:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiJTGgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 02:36:01 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807E117D863
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:36:00 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id n130so21833651oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 23:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9yPgA2yIJJGvpsOzVCK8eCOQT23TSOiZHVqQFRZS8o=;
        b=RTfIr8JRgVChsXiFhP0hMDHOmFixjWr3FiBV0CGbHmztfBYXRrLxefCQkxdILK/LFw
         37pC6dtm0xUCBSGFSvdqSecLVAK6mbrdGnVN0pJhsbMTeVEQAE/KuIN0WRiIYvuE/Vn6
         CD/YsovsqJAfmXWaMdc4hrCgj+raf15jEFoK3vO8QX+zq7FnzqZa6rblOqKbjwqFbkhc
         Y3EfDeXm/csg4JGmtvbKX6Rc/iBm+TTekZSWS5Q1XrXVzT8MZxRkrr/t4rjUlZqFJW50
         COpjzbN5uaJ1oH4jik3s/yasxPMuz+EdO9xNUSEjdWWrpaYErc5E5fMP65e9iGfKn5by
         2tMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I9yPgA2yIJJGvpsOzVCK8eCOQT23TSOiZHVqQFRZS8o=;
        b=7jsF4TWRNxqKyIqS4ZJXtVb0UbppIFPZTzdCdGdi3Dwyxc0MwOkACKBxiF0seaaX53
         Si1UhoCMKXEMcK1sxM35kX68+gvLgp+HOjMSL2jpr8anR3GTwHiixf4DhMAocymu9+F1
         BrB4tWkryafHFdQw8Jhr8Al+xM4rjwPJyqib3wpKpykYiEpf/XyUmwQ7NiC01Ah/T7qm
         9ED9UEMpH8rtX7X2sjhO8C81hxw3D9tYmpXSwaJS35dIK0FUValucatjmDMcEXg9q8Mx
         4CSWcGi+JJP8njXWwqPDYizQHGPwA4WV+QS9XAQxajBqjSWze2wJAczn0YElqFyzgu5C
         9CSQ==
X-Gm-Message-State: ACrzQf1oJCeAaKpqAK3jAr3PNMagUSB7Sd6owTswpLORXjpYVXOTWh6E
        Zty5CZ5cclzAmn8QB1vg9djh+3zT91/pRg==
X-Google-Smtp-Source: AMsMyM7UkRDgjozXnfwUPjrqz3QtA0RUCNQT2B2G1SodahprncPILXufrI2uIWDRO7MGjNsEwP7YZA==
X-Received: by 2002:a17:90b:3555:b0:20a:c2d5:d361 with SMTP id lt21-20020a17090b355500b0020ac2d5d361mr14470974pjb.50.1666247749035;
        Wed, 19 Oct 2022 23:35:49 -0700 (PDT)
Received: from [10.85.117.81] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id x14-20020a17090a294e00b00208c58d5a0esm975797pjf.40.2022.10.19.23.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 23:35:33 -0700 (PDT)
Message-ID: <3f6935de-d80f-0aa0-efd8-94a1076ce8d3@bytedance.com>
Date:   Thu, 20 Oct 2022 14:35:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [RESEND] sched/fair: Add min_ratio for cfs bandwidth_control
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-kernel@vger.kernel.org, htejun@gmail.com
References: <20221019031551.24312-1-zhouchuyi@bytedance.com>
 <Y1BqT59ovFitahJa@slm.duckdns.org>
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
In-Reply-To: <Y1BqT59ovFitahJa@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/10/20 05:21, Tejun Heo 写道:
> Hello,
> 
> On Wed, Oct 19, 2022 at 11:15:51AM +0800, Chuyi Zhou wrote:
>> Tasks may be throttled when holding locks for a long time by current
>> cfs bandwidth control mechanism once users set a too small quota/period
>> ratio, which can result whole system get stuck[1].
>>
>> In order to prevent the above situation from happening, this patch adds
>> sysctl_sched_cfs_bandwidth_min_ratio in /proc/sys/kernel, which indicates
>> the minimum percentage of quota/period users can set. The default value is
>> zero and users can set quota and period without triggering this constraint.
>>
>> Link[1]:https://lore.kernel.org/lkml/5987be34-b527-4ff5-a17d-5f6f0dc94d6d@huawei.com/T/
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> Suggested-by: Abel Wu <wuyun.abel@bytedance.com>
> 
> This is a bit of a bandaid. I think what we really need to do is only
> throttling when running in userspace. In kernel space, it should just keep
> accumulating used cycles as debt which should be paid back before userspace
> code can run again so that we don't throttle at random places in the kernel.
> 
> Thanks.
> 
Got it. Thanks for your advice.
Chuyi Zhou
