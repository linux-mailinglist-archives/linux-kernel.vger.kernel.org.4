Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C49A728FE9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjFIGXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238099AbjFIGXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:23:38 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1073730FD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:23:35 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-5523bd97c64so1616679eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 23:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686291815; x=1688883815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDfpwEbtdkwWsjyogcTfCoQzLF0dQnPR2AN0SNtNzSA=;
        b=gL+b3BWErI97pjMfxFnrNvc5M9TCMvXlvxQWb2fuR/TEERVDKRfnYfN9O41OYnqh0Q
         CxttWnz2ZIrkZlJefPIU+tzsUQJ2LzdU3RG4wwP+KEuwJih7VvVBEyHPviURJ2BfsZ2x
         4bOZZH9pRfO83VkCREuNaJ7+GxHJl7k6grz+imOut19Qv4UaNg5wQPe5g95Gkh4oU/15
         0MnOJpwukK5kPhoqQy7TtVo4tJsI7n9rhn9vM7Ze9tQUw+7rTywwulpyrRPgsb7VE4z4
         1VdAYzgB/rasZpPHA3pWD6y8gRBA7WPXrVf222JGkVsN9mSLWyMNbBBaGDa1JLNM5r66
         w+WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686291815; x=1688883815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDfpwEbtdkwWsjyogcTfCoQzLF0dQnPR2AN0SNtNzSA=;
        b=OscgXhrSSzvsCPmxir4qobgZro83nVVEIYSvqUdhEvSurxD9KYYcod309KWaGKs4A3
         IE3cgEMpN0yTRTuoYakMU74/xFWZYIVnXq5LlU5Pkfsw2eHTyL0ksyq7kbVt7Abh0Qe4
         3s0BwO3AwT5LtrGPCQHxCFdxxONm4m0zv9fJCTikr4vh84ZhrmZP0y06pWWwAso28PB2
         IoiSIav9xTMofgSIz0pyoyofswaxZHaYjbDrKm6qCESX2xQrKpdHgB+wbXtK7bAWoJb4
         MmwENSv3+AQ4M4jvd46Iac0h8UpAntCTvdW8oli5SagCj4FD3/gKc13OKeQWADrCAFGH
         z34Q==
X-Gm-Message-State: AC+VfDyZfXfFlp8B5IMjwDisj2jAzcAN363NV97Y4/j10MuCI81vU0ie
        uloRWnGo6UdxrE2E5WtCkODeRWdAZatvUakLh6feir7PPzJhWpMD
X-Google-Smtp-Source: ACHHUZ4nAu7DmWhMVHG3ShSe+qV5/1hVFvE6AJ31IqIf+UD+MuQMqp8xzrc2bI5iVp3kfijUALnwIqfh6nepnqQ2UPo=
X-Received: by 2002:aca:d843:0:b0:39a:3dbd:d26d with SMTP id
 p64-20020acad843000000b0039a3dbdd26dmr2139177oig.5.1686291814948; Thu, 08 Jun
 2023 23:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230606093135.GA9077@didi-ThinkCentre-M930t-N000>
 <ZIJbvCcaqjzNteWs@slm.duckdns.org> <CAEQmJ=gLCzoxUR9Eas+w9=bV7Tg5SZNb+TufanNXnPxR8cn5iQ@mail.gmail.com>
In-Reply-To: <CAEQmJ=gLCzoxUR9Eas+w9=bV7Tg5SZNb+TufanNXnPxR8cn5iQ@mail.gmail.com>
From:   Yuanhan Zhang <zyhtheonly@gmail.com>
Date:   Fri, 9 Jun 2023 14:23:23 +0800
Message-ID: <CAEQmJ=gy=ORK9hnxLYL9x_bbJTVozvtpiCfMexROTmYH7ctTBA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: introduce queue_work_cpumask to queue work
 onto a given cpumask
To:     Tejun Heo <tj@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org,
        pmladek@suse.com, zyhtheonly@yeah.net, zwp10758@gmail.com,
        tiozhang@didiglobal.com, fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

// I resend this to put it into the same thread, sorry for the confusion.

> Can you elaborate the intended use cases?

Hi Tejun,

Thanks for your reply! Please let me use myself as an example to explain th=
is.

In my scenario, I have 7 cpus on my machine (actually it is uma, so
queue_work_node
or using UNBOUND do not works for me), and for some unlucky reasons
there are always some irqs running on cpu 0 and cpu 6, since I'm using arm6=
4
with irqs tuning into FIFO threads, those threaded irqs are always running =
on
cpu 0 and 6 too (for affinity). And this would not be fixed easily in
short terms :(

So in order to help async init for better boot times for my devices,
I'd like to prevent
works from running on cpu 0 and 6. With queue_work_cpumask(), it would be s=
imply
done by:

...
cpumask_clear_cpu(0, cpumask);  // actually I use sysfs to parse my cpumask
cpumask_clear_cpu(6, cpumask);
queue_work_cpumask(cpumask, my_wq, &my_work->work);
...


> The code seems duplicated too. Could you do a little refactoring and make
> they (queue_work_cpumask() & queue_work_node()) share some code?

Hi Lai,

Thanks for your advice!

I do the refactoring in PATCH v2, there are some changes:
1. removed WARN_ONCE in previous code
  1). queue_work_node works well in UNBOUND since we have unbound_pwq_by_no=
de()
       in __queue_work() to choose the right node.
  2). queue_work_cpumask does not work in UNBOUND since list
numa_pwq_tbl is designed
       to be per numa node. I comment on this in this patch.
2. remove the previous workqueue_select_cpu_near and let queue_work_node() =
use
    queue_work_on() and queue_work_cpumask().

I test this patch with 100,000 queue_work_cpumask() &
queue_work_node() with randomly
inputs cpumask & node, it works as expected on my machines (80 cores
x86_64 & 7 cores ARM64
& 16 cores ARM64).

Please help review, thanks a lot!

Thanks,
Tio Zhang


Yuanhan Zhang <zyhtheonly@gmail.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 14:07=E5=86=99=E9=81=93=EF=BC=9A
>
> // I resend this to put it into the same thread, sorry for the confusion.
>
> > Can you elaborate the intended use cases?
>
> Hi Tejun,
>
> Thanks for your reply! Please let me use myself as an example to explain =
this.
>
> In my scenario, I have 7 cpus on my machine (actually it is uma, so queue=
_work_node
> or using UNBOUND do not works for me), and for some unlucky reasons
> there are always some irqs running on cpu 0 and cpu 6, since I'm using ar=
m64
> with irqs tuning into FIFO threads, those threaded irqs are always runnin=
g on
> cpu 0 and 6 too (for affinity). And this would not be fixed easily in sho=
rt terms :(
>
> So in order to help async init for better boot times for my devices, I'd =
like to prevent
> works from running on cpu 0 and 6. With queue_work_cpumask(), it would be=
 simply
> done by:
>
> ...
> cpumask_clear_cpu(0, cpumask);  // actually I use sysfs to parse my cpuma=
sk
> cpumask_clear_cpu(6, cpumask);
> queue_work_cpumask(cpumask, my_wq, &my_work->work);
> ...
>
>
> > The code seems duplicated too. Could you do a little refactoring and ma=
ke
> > they (queue_work_cpumask() & queue_work_node()) share some code?
>
> Hi Lai,
>
> Thanks for your advice!
>
> I do the refactoring in PATCH v2, there are some changes:
> 1. removed WARN_ONCE in previous code
>   1). queue_work_node works well in UNBOUND since we have unbound_pwq_by_=
node()
>        in __queue_work() to choose the right node.
>   2). queue_work_cpumask does not work in UNBOUND since list numa_pwq_tbl=
 is designed
>        to be per numa node. I comment on this in this patch.
> 2. remove the previous workqueue_select_cpu_near and let queue_work_node(=
) use
>     queue_work_on() and queue_work_cpumask().
>
> I test this patch with 100,000 queue_work_cpumask() & queue_work_node() w=
ith randomly
> inputs cpumask & node, it works as expected on my machines (80 cores x86_=
64 & 7 cores ARM64
> & 16 cores ARM64).
>
> Please help review, thanks a lot!
>
> Thanks,
> Tio Zhang
