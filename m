Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4365BDDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiITHD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiITHDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:03:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559B75D125
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:03:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id l12so1837616ljg.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 00:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=bGs+aSQq2Qk5rmbnEnjfdxSFGQT5XmvGJzcNQP5piIM=;
        b=UeyAkhrDUnWE93ejNQ+ruy96x1cHibdWL5MLJrZeSet/39rVCvs0frH/kC45DCRt1J
         rMi14QqElNQOasgrZW4ozCIWQ5qOhfS9O3OokjSlQ7B8J5OSLrChKRecmcNJ2D6ZNzfi
         IyRPOjjojgn5bE4QW4JV89O4Ju8NVdhi91vxdnxXRXt1nR7tBWrEQaP4FMAHZhyenH2R
         h5W3uETq1nCCpEtq2JM0jBKE3q+Y2DWhBW2BPaXFr/MQQPu+uIa4azqGHJDHiS98e7pj
         jJ7ACAuVvWrtEkf5Bwl17bjE6wYvvKKGn1nB3cI9uzHelREoxAqxD/2BhFi3oGu6fBGL
         g76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=bGs+aSQq2Qk5rmbnEnjfdxSFGQT5XmvGJzcNQP5piIM=;
        b=OZTe85+F4upFD71CQ/ZNC9lA0AB3y/bVtPd2I2h0D7vR8mjayNCUHga7ya5Ko9q/S/
         oS5g2sYF9oVOLTxbPx085/dMxyNhIIh3dlr20P6NkP2E52pOoYMhs28MXbmo1THfJ7Pl
         ASUKvaYlwQLW5AMJ6y9PzELvAguZzW3b2I0YhacWeRagj4AXr7bO8xgr1uGv/V7Sdzf3
         eAz1yDF1tDK2UjziOFihY+F//ZDGto9Rkj7NeOwqx6rn6fa584jKnoIbpW0z30JV4Dxz
         iTz0pDXnDB3RtbqLbOCJiuoxZTRaF4QmLW7MZpOk7AlLyVKLoieV0jxbel9HOxH3Nj4J
         QD+w==
X-Gm-Message-State: ACrzQf0Jw1m6t/rVaqOqKW7vwvPn9jZ9BF9Fd+6N4QQacX+Ga6qPaU4e
        ozpqk+7bopkgZCpRXcKA2JLneY6bz0siJRO4XW6ILw==
X-Google-Smtp-Source: AMsMyM4+lFHVm1APr372lgvz5bsW9pzbVDcS/NcdxUXevVZvelWnRbNkSEU1Pbwc0UgBkRyXtK71dh25tOOivQVc4Xo=
X-Received: by 2002:a2e:be8d:0:b0:26c:f4b:47a0 with SMTP id
 a13-20020a2ebe8d000000b0026c0f4b47a0mr6177879ljr.92.1663657416601; Tue, 20
 Sep 2022 00:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org> <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com> <YyioI4iBFq8ib9JT@slm.duckdns.org>
In-Reply-To: <YyioI4iBFq8ib9JT@slm.duckdns.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 20 Sep 2022 09:03:25 +0200
Message-ID: <CAKfTPtBDPk_JMR87x-y6NXkPO94YiP7srhsN0JLvrK7qUWtdbQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
To:     Tejun Heo <tj@kernel.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sept 2022 at 19:34, Tejun Heo <tj@kernel.org> wrote:
>
> On Mon, Sep 19, 2022 at 05:49:27PM +0200, Vincent Guittot wrote:
> > > For `nice` we have `cpu.weight.nice` next to `cpu.weight` in cgroup v2 ?
> >
> > If everybody is ok, I can add back the cpu.latency.nice interface in
> > the v5 in addition to the cpu.latency
>
> Yeah, that sounds fine to me.

Thanks

>
> Thanks.
>
> --
> tejun
