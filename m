Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51CD6FE489
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 21:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236090AbjEJTcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 15:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236032AbjEJTcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 15:32:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B486E8B;
        Wed, 10 May 2023 12:32:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24de2954bc5so5365382a91.1;
        Wed, 10 May 2023 12:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683747152; x=1686339152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ijF4JgZZ8UFh46m5QLshrYR4lf9mtf0Ki3Uhm/eh+mU=;
        b=EeA4kqbs/2ShXxyXSqeEgub903IcQoIVk9QHMk/WTKOYXtPzEDkrTF571IR1lchCB+
         3aOz0mbDORZd4rt70dqqaOlm1YlilzCB90u+esIDRmBB8b4iVYDmNz47qLx+hktv12AQ
         eM/OOFh7PWAWB49LF9gEGypXCP17gZKMRmfqJCZP7MJtqX8yanaHOWdDVSbzljRf8bdn
         bgqY0MfeDP7Jslg/K8TV3NoVq/fp5nNGfGKcQA5/NjcTDQziUs+GNZkR3U65fBo84Vk1
         Wa0TylLoO93rBBYHoD7mD+XbhEyeTHLz2EyF+RojWwGVdaJKzNA0oS1GXg4uG7NO/MGD
         +A/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683747152; x=1686339152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ijF4JgZZ8UFh46m5QLshrYR4lf9mtf0Ki3Uhm/eh+mU=;
        b=A/dabpc9Wk2FISAPGotdPCe4hN5o8NQhKn8WErwh0BNhOtAjzwMVQCAXfcSmgnA7Pj
         yX4m1MqZP9+yCkfJ6/lAb+BNo9RSZ+Flh3794aRXWnksJ19dHxVgPvRPdOmmpwVWw+c2
         MJg59w0Avl1VUk6rMaDzGmOHXdveTGQLWBH58eXeBC5ZlUqIf1ESAPkUQ6R3IYIaQIUH
         iRmFPXBuzX5SW6qhbSeKSBhhL1gJnl3JJLRHg46Mz3hXNGCuxgTbRa2Axn9xHKmvwzER
         aqLed21J/Fyor4UP5BlDcKwVog1kqLBAbz8646GrmaWKfo5qPPpIFMqrBXwroeRXqZp3
         SGNA==
X-Gm-Message-State: AC+VfDzbcfdNF6X6wOxs3fG45VIlV3iMtnqAMqikuf49i+uqvWV/JvS3
        rzRkGUjv4fx40FeJBvS7NiamupSl7Xw/jFwQ4sY=
X-Google-Smtp-Source: ACHHUZ6BOFYp0nK8Weo52A11Jq55ELUDLkcEf5hVS+AWnlPdz/PLLsNoX2B0dchmv6Qb9zAF/RbBwpp6FVBwIIRPhPI=
X-Received: by 2002:a17:90a:a60d:b0:24e:2021:b410 with SMTP id
 c13-20020a17090aa60d00b0024e2021b410mr18111638pjq.14.1683747151922; Wed, 10
 May 2023 12:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230508075507.1720950-1-gongruiqi1@huawei.com> <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
In-Reply-To: <CAB=+i9QxWL6ENDz_r1jPbiZsTUj1EE3u-j0uP6y_MxFSM9RerQ@mail.gmail.com>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Wed, 10 May 2023 20:32:20 +0100
Message-ID: <CAKbZUD1vpgke_-9sijF5rwbHZ8dfcLfyNMCRYcoa4izsKmYNKQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2] Randomized slab caches for kmalloc()
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     "GONG, Ruiqi" <gongruiqi1@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        kasan-dev@googlegroups.com, Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>
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

On Wed, May 10, 2023 at 7:44=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gmail.com>=
 wrote:
>
> On Mon, May 8, 2023 at 12:53=E2=80=AFAM GONG, Ruiqi <gongruiqi1@huawei.co=
m> wrote:
> >
> > When exploiting memory vulnerabilities, "heap spraying" is a common
> > technique targeting those related to dynamic memory allocation (i.e. th=
e
> > "heap"), and it plays an important role in a successful exploitation.
> > Basically, it is to overwrite the memory area of vulnerable object by
> > triggering allocation in other subsystems or modules and therefore
> > getting a reference to the targeted memory location. It's usable on
> > various types of vulnerablity including use after free (UAF), heap out-
> > of-bound write and etc.
> >
> > There are (at least) two reasons why the heap can be sprayed: 1) generi=
c
> > slab caches are shared among different subsystems and modules, and
> > 2) dedicated slab caches could be merged with the generic ones.
> > Currently these two factors cannot be prevented at a low cost: the firs=
t
> > one is a widely used memory allocation mechanism, and shutting down sla=
b
> > merging completely via `slub_nomerge` would be overkill.
> >
> > To efficiently prevent heap spraying, we propose the following approach=
:
> > to create multiple copies of generic slab caches that will never be
> > merged, and random one of them will be used at allocation. The random
> > selection is based on the address of code that calls `kmalloc()`, which
> > means it is static at runtime (rather than dynamically determined at
> > each time of allocation, which could be bypassed by repeatedly spraying
> > in brute force). In this way, the vulnerable object and memory allocate=
d
> > in other subsystems and modules will (most probably) be on different
> > slab caches, which prevents the object from being sprayed.
> >
> > The overhead of performance has been tested on a 40-core x86 server by
> > comparing the results of `perf bench all` between the kernels with and
> > without this patch based on the latest linux-next kernel, which shows
> > minor difference. A subset of benchmarks are listed below:
> >
>
> Please Cc maintainers/reviewers of corresponding subsystem in MAINTAINERS=
 file.
>
> I dont think adding a hardening feature by sacrificing one digit
> percent performance
> (and additional complexity) is worth. Heap spraying can only occur
> when the kernel contains
> security vulnerabilities, and if there is no known ways of performing
> such an attack,
> then we would simply be paying a consistent cost.
>

And does the kernel not contain security vulnerabilities? :v
This feature is opt-in and locked behind a CONFIG_ and the kernel most
certainly has security vulnerabilities.

So... I don't see why adding the hardening feature would be a bad
idea, barring it being a poor hardening feature, the patch being poor
or the complexity being overwhelming.

--=20
Pedro
