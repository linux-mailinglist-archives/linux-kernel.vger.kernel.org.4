Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C01B6D16FB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 07:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbjCaFuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 01:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCaFuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 01:50:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5B11EAD
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:50:33 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id q102so19427433pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 22:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680241833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzgUwKsTXlcKR3IZP1bVNxBagrJvGQ4VZm8bOrKutDM=;
        b=xaAE32ETbzPfQ38td8hI3jF6TeQaETDeGClpg3d7IlaSPGhI7kqCo/7S40gHEWyMq8
         m0x2nzdeKrfSyZnb8HgwWhKo4rNRxYcO11zByLfWIf7vmGp8vgvw2W2OD6cJC+KEjL31
         rQPHiFQgUDPP+C7IpOD0w1C7z1/QmeO4GHbab/QwlT+jteRwg6dqqWq6qdMrhFxH+LmA
         8HScU9P8tF3BCrHaKQJmf+kqUGqMEfRFBJ917ag4S5QxlEIVFOoPR8P26c0wRawjZNrr
         BrZ0zI+7RhpmR98rWxu84x9znPNDae0LfHxNnJfO5suyA26h/Zzct9kVeQT0Fpy+0xBL
         ynEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680241833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzgUwKsTXlcKR3IZP1bVNxBagrJvGQ4VZm8bOrKutDM=;
        b=HBIgoGu/TaGsbUkaHzgcFzpHLkVEpdumCpD+Is1zu5NJIS/PmbcxMpZuNaj8Rlz9CZ
         mMmpcUqe+AlsmRDI8Oh0Nrsrii4m/8wfkLRUeYSf/bEsvS8XkeRikK6x1fbObhAhzD8K
         7XckAuSfnlnIPIgAvGcbfzGhMZEQ7MLg3Dck6LGumgRRtq9h67R9iOR6aOhl6eNeVhrt
         yUpU0usnFzn6c4CmBQBjJ9Y490yBcSgOAKvu5Wig8DxU0XJDd6gt2iWP0TVTV+NI9QLh
         OzuyfD4Dg995/PZuW3OctPSEKvLEa5pkyClNuQN8BQvyp783xiFid7gRwteQ64DQVo2F
         /DjA==
X-Gm-Message-State: AAQBX9caTXDmZLBEHMIcw0id8xgecSV29XamY6Jqbcc+6dH1quSpJUiw
        c58Q9MZlYCR+deYOweMGWNongFtOhLmPf30OvgWlpw==
X-Google-Smtp-Source: AKy350aJ2MdnJe836h4peLGe+7yJUEWRJ/iVZhGH4oxEsAv3J7nFUhrtHqK96PUMTfwbcGDndhEhvnUdJ+STEIW6aYA=
X-Received: by 2002:a17:903:41d1:b0:1a0:5402:b17f with SMTP id
 u17-20020a17090341d100b001a05402b17fmr9406603ple.6.1680241832638; Thu, 30 Mar
 2023 22:50:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230329111422.3693-1-mike.leach@linaro.org> <20230329111422.3693-2-mike.leach@linaro.org>
 <ZCQx5HlPnxCIFaNQ@kernel.org> <ZCQyNnk/vfHZkSda@kernel.org>
 <CAJ9a7VhhoGoOVL4sqcgpDYnZzzce_2=-wupK8K178tzZnoqrPA@mail.gmail.com>
 <ZCQ7nhrISA+jCfnI@kernel.org> <CAJ9a7VhJRnRe0A43=_X463432LvjL=S5buVgeq6rB8K8nDZb6A@mail.gmail.com>
 <ZCSRU8zvjjBHhq+x@kernel.org> <ZCS4XJaWg7NvaWb7@kernel.org>
 <20230330031307.GD252145@leoy-yangtze.lan> <20c28979-53a7-19eb-16fd-4d8535454d4e@arm.com>
In-Reply-To: <20c28979-53a7-19eb-16fd-4d8535454d4e@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 31 Mar 2023 06:50:21 +0100
Message-ID: <CAJ9a7VjxHkf4SsmmoRhPBeS=68igtOrwSsgJdcTy+9JWT1sBCA@mail.gmail.com>
Subject: Re: [PATCH v8 1/3] perf: cs-etm: Move mapping of Trace ID and cpu
 into helper function
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Leo Yan <leo.yan@linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, gankulkarni@os.amperecomputing.com,
        darren@os.amperecomputing.com, James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 30 Mar 2023 at 11:55, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 30/03/2023 04:13, Leo Yan wrote:
> > On Wed, Mar 29, 2023 at 07:14:52PM -0300, Arnaldo Carvalho de Melo wrote:
> >
> > [...]
> >
> >>> Not here, I'll check after a call:
> >>>
> >>>    50     9.90 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
> >>>      arch/arm/util/cs-etm.c: In function 'cs_etm_save_ete_header':
> >>>      arch/arm/util/cs-etm.c:720:29: error: implicit declaration of function 'coresight_get_trace_id' [-Werror=implicit-function-declaration]
> >>>        data[CS_ETE_TRCTRACEIDR] = coresight_get_trace_id(cpu);
> >>>                                   ^~~~~~~~~~~~~~~~~~~~~~
> >>
> >> This function was removed in:
> >>
> >> Author: Mike Leach <mike.leach@linaro.org>
> >> Date:   Wed Mar 29 12:14:21 2023 +0100
> >>
> >>      perf cs-etm: Update record event to use new Trace ID protocol
> >>
> >>      Trace IDs are now dynamically allocated.
> >>
> >> I'm removing this series from perf-tools-next, please address this issue
> >> and send a v9.
> >
> > I can reproduce this building failure.  I am curious for how to verify
> > building for patch wise, the link [1] gives me some hints and below
> > command works for me:
> >
> >    $ git rebase -i --exec "make -C tools/perf clean && \
> >      make -C tools/perf VF=1 DEBUG=1 CORESIGHT=1 && \
> >      make -C tools/perf clean && \
> >      make -C tools/perf VF=1 DEBUG=1" HEAD~3
>

Thanks Leo. However, I've now written a python script that given a
patch directory will run:

foreach patch in dir
     git am patch
     build

so that can work directly on patches before they are sent - or when
they are received in future.

> Looks like perf-tools-next has some changes that has not reflected
> elsewhere. The ts_source patches are queued there, which is causing
> the above build failure.

> Mike,
>
> Are you able to rebase your patches on perf-tools-next branch ?
>
perf/core and perf-tools-next are both on the same commit.
v9 tested against perf/core

Mike

> Kind regards
> Suzuki
>
> >
> > Thanks,
> > Leo
> >
> > [1] https://stackoverflow.com/questions/26983700/git-run-shell-command-for-each-commit
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
