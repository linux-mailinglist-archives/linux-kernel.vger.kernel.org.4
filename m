Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C855F3C3F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 06:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiJDEvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 00:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJDEvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 00:51:50 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510B843E6A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 21:51:48 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id s10so14032264ljp.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 21:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=To5KIWjQ/k8Pkoizz5oF7c+oALOtLlXJkcAnbt5DAwY=;
        b=BVsOFVlL0LK5p09g+T8lPowb7PD6WbiAqJHjSWIesIHoOWjt6bqc/xWAZw/1TDb72w
         tmMK1nQgH1Aw35ybK54V7PgUrb67JQkNdJPS2oZaQ6tsKVETZYVlRcgVKc2DlDKj+Ign
         nObvAiinoo2Vd1NZoKh/JQHscEXQPM8F34pbLGKgBWTrgU6atB+e/cp7qHiHyl6KwpFL
         TSeXK3N9cR036vUf3OHyGa7No6641ieTL8w7hnZyrc9ND7RzNAyviRkeHE59KTwzl+xq
         t3OlRTLe4Odsd+u/AvcVi3OxFJo7eQzL1DQDnXnS2pWBAmdK973hz9xZ5DC9P0NZ4VvQ
         qr5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=To5KIWjQ/k8Pkoizz5oF7c+oALOtLlXJkcAnbt5DAwY=;
        b=29VcDwLTFoTC8aSe/vBVCjns4lbH3mh5WT0vKZ3XbMnrjlDUgayYWTGXVgzc11i7l+
         IjIDJAXi1lg8AoC+zfw91+ktT/htAxubs4bXqWbMjd4fjH/kCUsSl0PFhWDd0YdioJ8X
         9VpnBxaSS/5w51yU85dr+zbO8507Z62ABoLzIT7Zgz3KdJJOBzJh4ATdpPvrG+CAu6Se
         oibkXE1WPOgkbNvnsSsKHK/qZoRN5mrgBZ90Hu8j0vFSZwWGWCAwFCrafCpwF5H71bjC
         T3rKnJmE/ibl1wYx9o/q1ORn4LeSoUE85zDQHzhVU6a2DrYIijkHhCaNmxi+RRuWEyWj
         ecvg==
X-Gm-Message-State: ACrzQf0giluVeqmanIDuMyDi4GG8NnJQUJCcnPUxaVvbwmLqt8+Q8GDf
        1D4LJCozPfHOXz2JZrWDZXne5dIAsITLPlqehQKz5g==
X-Google-Smtp-Source: AMsMyM5Gh5QGHx7dBiX81TyO/glq2fj2eYXDxCW4GQyDfJy9rpSOIWfY8zN0S86476LtADxDm5xQw4S4sJQQKXYvZ3s=
X-Received: by 2002:a05:651c:101:b0:250:896d:f870 with SMTP id
 a1-20020a05651c010100b00250896df870mr7952627ljb.235.1664859106609; Mon, 03
 Oct 2022 21:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <1664528184-162714-1-git-send-email-john.garry@huawei.com>
 <1664528184-162714-5-git-send-email-john.garry@huawei.com>
 <CAMGffEkgR6VmfMV1eLVeTn+b8b0GC_B9=vj3HxF6cn5Er6+CTg@mail.gmail.com>
 <5e570c35-ed98-a29b-736f-677aa896f654@huawei.com> <32b0f929-4534-450b-b19c-d3404db63202@huawei.com>
In-Reply-To: <32b0f929-4534-450b-b19c-d3404db63202@huawei.com>
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Tue, 4 Oct 2022 06:51:35 +0200
Message-ID: <CAMGffEkPnrjjzZMca5YQ8NT-xnBFPfFoBxs63jY431FtpFvF3A@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] scsi: pm8001: Use sas_task_find_rq() for tagging
To:     John Garry <john.garry@huawei.com>
Cc:     damien.lemoal@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, ipylypiv@google.com, changyuanl@google.com,
        hch@lst.de, yanaijie@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 1:05 PM John Garry <john.garry@huawei.com> wrote:
>
> On 30/09/2022 11:20, John Garry wrote:
> > BTW, I do notice that we still have this global lock in delivery path
> > which should be removed at some stage:
> > > int mvs_queue_command(struct sas_task *task, gfp_t gfp_flags)
> > {
> >      ...
> >
> >      spin_lock_irqsave(&mvi->lock, flags);
> >      rc = mvs_task_prep(task, mvi, is_tmf, tmf, &pass);
> >      ...
> >      spin_unlock_irqrestore(&mvi->lock, flags);
> > }
> >
>
> oops... that's mvsas. But pm8001 does still use a big lock (which we
> should get rid off):
Yes, would be great to get rid of the per ha lock.
>
> int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
> {
>         ...
>         pm8001_dbg(pm8001_ha, IO, "pm8001_task_exec device\n");
>
>         spin_lock_irqsave(&pm8001_ha->lock, flags);
>
>
> Thanks,
> John
>
> > That really will affect performance...
>
