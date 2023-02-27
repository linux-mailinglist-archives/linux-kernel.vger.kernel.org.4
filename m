Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459D16A44A8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjB0Ohx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjB0Ohv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:37:51 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB9CDC
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:37:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so6321064pja.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r2vJyeW3YIWU34jo0Sk7OaakdzCDiGTlztTJhpbPSaE=;
        b=RjHcPk9zUBoxQPSa8V7JZSNfz3Iq4/RvhqbXAewHStxMUQMVdr5CDkaOFmsa34Jwuv
         1xSaqD9BHgLB159J06Zycb8z3UIhEFXUaBngbP89mPAPlouMZeiLVvZWTrWlu5fZJGS9
         gINaHIhGrWhZQxqcNMVTCYVmCshOcKBsCE//pzZnDvYYWIpM+JyqpL9012g0zweN2U93
         quqjLWS0zt+oJBdEa80/AD4eZOxoyrZ7kplcGgOM18fcAaqWkP8w39MlnB6ycIOlcSVd
         l3tnQZ9xMLGiZQs6bt1tJJm3JfopzSrRwMfOb20i9Hubzs5ga2m9DVLmH19XB/ux5ZoM
         dz5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r2vJyeW3YIWU34jo0Sk7OaakdzCDiGTlztTJhpbPSaE=;
        b=JPptWRgLJMWzV3aagpgZW3pxxK48A1LkgHc8RXy7HN5pAZLtNt4Iv0EFdHtnSGOiiw
         Wh8MlcyU1c2V5NISy4HmK0nZkqSEuzyKZuc1PuzZgncStl/Qzq5eDAvnZOx2wVCCiK4E
         9UkcgKJfCWjSkXPEsrCPaLIbWLHSVNUvTVhQGYEUz99WpM0gB9duaxbVvuIyyz8t3hGK
         f6TQjWzGv/7T+sWE5cTYOkQywkPjtIInSLqrTEflnfv6Zbzr1MImPLTaRqrX4Pw7FUny
         2+3nqenAW9w1UcgDaVwl+48Pg0BQi9taV+WzMNF4QyrkVGYzNmduUjg1dgeJdgtv1Mv6
         a5LA==
X-Gm-Message-State: AO0yUKW5ELWoBebXKNhl5DfNnnj0qo/qAyPyKWx54Y8ataEQHobW/Sjz
        JRv/dGqlsxhivbg1WQetJ6lH8PmqqU6OV4Yruli72QVBIgH6bA==
X-Google-Smtp-Source: AK7set+kMsBuT/AbRQGP8FTe87yqs4sj5g14qiS1BwjSkc+0Z+sTX58mVAd4uDtegVlNhIYBNHQPcw5h92zAfbHPghk=
X-Received: by 2002:a17:903:4289:b0:19a:9984:558c with SMTP id
 ju9-20020a170903428900b0019a9984558cmr6290491plb.6.1677508668592; Mon, 27 Feb
 2023 06:37:48 -0800 (PST)
MIME-Version: 1.0
References: <20230209193107.1432770-1-rkagan@amazon.de> <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com> <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
 <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com>
In-Reply-To: <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 27 Feb 2023 15:37:37 +0100
Message-ID: <CAKfTPtAq3yBYBxpR=RO8zxrQduOymqkdAEhigjfCuGfsY1uHsg@mail.gmail.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
To:     Roman Kagan <rkagan@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023 at 09:43, Roman Kagan <rkagan@amazon.de> wrote:
>
> On Tue, Feb 21, 2023 at 06:26:11PM +0100, Vincent Guittot wrote:
> > On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrote:
> > > What scares me, though, is that I've got a message from the test robot
> > > that this commit drammatically affected hackbench results, see the quote
> > > below.  I expected the commit not to affect any benchmarks.
> > >
> > > Any idea what could have caused this change?
> >
> > Hmm, It's most probably because se->exec_start is reset after a
> > migration and the condition becomes true for newly migrated task
> > whereas its vruntime should be after min_vruntime.
> >
> > We have missed this condition
>
> Makes sense to me.
>
> But what would then be the reliable way to detect a sched_entity which
> has slept for long and risks overflowing in .vruntime comparison?

For now I don't have a better idea than adding the same check in
migrate_task_rq_fair()

>
> Thanks,
> Roman.
>
>
>
> Amazon Development Center Germany GmbH
> Krausenstr. 38
> 10117 Berlin
> Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
> Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
> Sitz: Berlin
> Ust-ID: DE 289 237 879
>
>
>
