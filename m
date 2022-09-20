Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377435BE2E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 12:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230382AbiITKSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 06:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiITKSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 06:18:43 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9E96D9CA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:18:41 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id e18so3132596edj.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date;
        bh=ojqGQlEPGOEHUcbzH9trFvn4MIEoxiachedxhJsWyIE=;
        b=K7AoEzUNe+z9cEXFQjxunY5YOq8nhGvHI3tSR5KZLRLohGZfVxk4f64d1a35s+CHIw
         h4cDFJ/gEww4nHvoBSm84SH2hz+1vht4oyqcOgVtI4nfu/28NwsYwXHDhyisp6cMJzaq
         /7yPCugttsvF46Px50zSg55Leyz/tSvxlFo30hvDqM0yBsCO7rENVUcwbW2EM7BUjEVr
         gGKugloNkst1QHeq8a5SBJ7xw8AEenXeSWtkjJcqwYgWAWj5CYN4+eT7QWtP4tGPc6Ed
         oJfo4Ly9oTc3zmLb8Z6c/HR6EJ7UlVkH/NB5X6ATVGTirUPX8WKYsgw6l2fOncrgmtwK
         Kq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date;
        bh=ojqGQlEPGOEHUcbzH9trFvn4MIEoxiachedxhJsWyIE=;
        b=01/LR26MeY6E3ymmXyhp0yKKs98EHcQgaq7dv9viGatOj0pHzMKM2+KQZSkuktpwwN
         CM2YpJGhAfTFoOp40LyCWDBzg4cf3IEAQkLHgPMCsFOtaEiog+vkQtTk8fx+ObVtWsQ8
         Gj1Mri9yYt3lhNLwnQ3r9hbenRUmCuRjAUQ22H+Oug/uV5yK8xUkiv/SMbOhMvU1r7/u
         2GeToVH76V3bDzUpJG5PLwFwhTNNjFuxaaHuNov5ISbznIVS2uUHBiSNJzRUpAczg2xi
         XhYPGbVQGbV4uJcPU9GI4tTCxdz9rf/8SwF4NRh6nSEpv+JvTzs8eLzDJDRszDPMFZq2
         eGzQ==
X-Gm-Message-State: ACrzQf3VtwzvIg6A7xNONLOGkZd9X/5wpdTIJSe/ACHPVmJVBCS58KlG
        oJn+pNUpx0bI5bfr8mVELr4=
X-Google-Smtp-Source: AMsMyM4AUP3OHaRowjGf3oeIkXjECi/N/HqBppxuiuHKE5pUvvCzZsBb2zWRjibSmXT75uLOvqCzjg==
X-Received: by 2002:aa7:cb87:0:b0:43b:e650:6036 with SMTP id r7-20020aa7cb87000000b0043be6506036mr19545777edt.350.1663669120206;
        Tue, 20 Sep 2022 03:18:40 -0700 (PDT)
Received: from [10.111.3.51] (103-253-142-46.pool.kielnet.net. [46.142.253.103])
        by smtp.gmail.com with ESMTPSA id x12-20020a1709064bcc00b0077fc47605b4sm575363ejv.217.2022.09.20.03.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 03:18:39 -0700 (PDT)
Sender: Tim Janik <tim.janik@gmail.com>
Message-ID: <ca9231c6-ef15-959f-f028-e55fbe686699@gnu.org>
Date:   Tue, 20 Sep 2022 12:18:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4 4/8] sched/core: Add permission checks for setting the
 latency_nice value
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-5-vincent.guittot@linaro.org>
 <5c060322-b132-c9b6-1253-6657ad08a63d@gnu.org>
 <CAKfTPtB8OeRzbDjfKoNUGLC1XUXT07G9QedCJ8stSMGvAD5hNg@mail.gmail.com>
From:   Tim Janik <timj@gnu.org>
In-Reply-To: <CAKfTPtB8OeRzbDjfKoNUGLC1XUXT07G9QedCJ8stSMGvAD5hNg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 19.09.22 14:41, Vincent Guittot wrote:
> Hi,
> 
> Thanks you for describing in detail your use case.

> Ok, Your explanation makes sense to me especially because we want to
> ensure to not provide more cpu time with this latency prio. I'm
> curious to see the feedback from others about the reason we want
> CAP_SYS_NICE other than following nice priority.
> 
> Side question, Have you tried this patchset (minus this patch) with
> your use case ?

I have now tested a modified version of the ALSA Test_latency.c program 
that acquires latency nice as non-root:
   https://gist.github.com/tim-janik/88f9df5456b879ecc59da93dc6ce6be1

With a busy but not overloaded CPU, the short time latency tests are 
often better, measured with: ./lnice-latency -p -s 1

But the results aren't very reliable with this test. I.e. requesting a 
latency nice value of -20 reduces the chance for underruns somewhat but 
doesn't eliminate them (and lnice-latency.c gives up on the first XRUN 
in the given time period). It might be better to instead count the XRUN 
occurances over a given time pertiod.


-- 
Anklang Free Software DAW
https://anklang.testbit.eu/
