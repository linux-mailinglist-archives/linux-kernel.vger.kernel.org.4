Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F9363B848
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbiK2CxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiK2CxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:53:08 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498B140918
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:53:07 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so12055219pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tVdaZGcP4j88Qml5mJfIo0BmHi+s/R7fEtpX29Aegis=;
        b=eOWHOBNDHn0V8MqJlRrEQyiG3etYoyVj6HwWZjScS+ro7oXp5NnHwhu5V0XnAqkFOl
         6coP5VmkxdS1kKd8anif+2CIXOCyWCUw00MMJ/B7ruMCC30ZGevpet4thlWyKu6g7Mmo
         oxCduW3h3rMAWAq4cf/olag3GY2b+yPIMI2YBT05xMmL0/RfvpD0b99A2JEK5SsjTDsA
         q4MgDxRM4yNHBfjWC2SAQEVHEA+qr+wd4kJUk8aa600dSny2BZsIut+ApQTNkGX8gD+g
         KnPhKTw4NnFHV0or2ZKsD9P0kbjJ7CMEEo6YXfNUfZKQF5scF01DdHZt5KqHaUvgR0oI
         XWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tVdaZGcP4j88Qml5mJfIo0BmHi+s/R7fEtpX29Aegis=;
        b=TrTHK8rX6ETdOCIjvB47bXVzo9fyygzM3J76vEZ0cQ8QjabG2u0wXn0dw/CJFHIadV
         i2POYd1obWcuGkxH+47W/tRk7RzCP7WQuZIS5dcwCvjMPPCr8Ape6ZGxb2+L6EQqXgiB
         vPFBORhFXOMydlS3spLXZz3ssxvwLjDXr0OjD0HhC5nnZl1dV7/IpMesTCHkcotw5bsl
         bwPqwiSS2liz4fn9f/glWWzei+eEr6R9Lu0LbiKOGOfTiOfsS4dyNs6ImdUQoC9VihkG
         FTkorgr2YQMJLhxWZEuYRl8jGH6IwfyvdH3w7A1Tx3jDMvIs+9ad003Z1YXyHIvVDuKk
         DkGg==
X-Gm-Message-State: ANoB5pnl4QmNnibhOBtfrPMcFPzgX9+e+5Jfbom8h+jsJAgCfR5RUUEj
        5Z216L5SQdt6dsJtiOetdoWTcw==
X-Google-Smtp-Source: AA0mqf5ciHYvPxuAaaVEz4jM+nFvHbYtSONxjtEHHR65kdwaI8ehoRIKYMPx9p3MtfkJfVceVwamuw==
X-Received: by 2002:a17:902:6505:b0:186:a7ff:e8ae with SMTP id b5-20020a170902650500b00186a7ffe8aemr34845364plk.77.1669690386709;
        Mon, 28 Nov 2022 18:53:06 -0800 (PST)
Received: from [10.54.24.49] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a764400b0020087d7e778sm172073pjl.37.2022.11.28.18.53.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 18:53:06 -0800 (PST)
Message-ID: <db6284ba-b936-b38c-662d-3189c14596e7@shopee.com>
Date:   Tue, 29 Nov 2022 10:53:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] cgroup/cpuset: Clean up cpuset_task_status_allowed
To:     Tejun Heo <tj@kernel.org>
Cc:     longman@redhat.com, lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221125075133.12718-1-haifeng.xu@shopee.com>
 <Y4TqvlOmXqY/CBEc@slm.duckdns.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <Y4TqvlOmXqY/CBEc@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/11/29 01:07, Tejun Heo wrote:
> On Fri, Nov 25, 2022 at 07:51:33AM +0000, haifeng.xu wrote:
>> cpuset_task_status_allowed just shows mems_allowed status, so
>> rename it to task_mems_allowed. Moreover, it's only used in
>> proc_pid_status, so move it to fs/proc/array.c. There is no
>> intentional function change.
>>
>> Signed-off-by: haifeng.xu <haifeng.xu@shopee.com>
> 
> mems_allowed being a very much cpuset feature, I don't see how this is an
> improvement. The new code is different and can be another way of doing it,
> sure, but there's no inherent benefit to it. What's the point of the churn?
> 
> Thanks.
> 

Hi, tejun.

In proc_pid_status, task_cpus_allowed is used to show cpus_allowed, similar to that,
task_mems_allowed is more specific to show mems_allowed. Also cpuset_task_status_allowed
is used to dispaly memory status in '/proc/<pid>/status' and isn't used in other files, so
keep it in the fs/proc/array.c.

Thanks,
Haifeng.

