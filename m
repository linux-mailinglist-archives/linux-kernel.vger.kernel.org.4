Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B2F5E5B89
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIVGlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiIVGk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:40:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B31EB6D6D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:40:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j16so13084234lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=CzXRCK2IG+QiEk8VkCDJeJkkF52iVy5YTfg9HZImjvY=;
        b=ws6HG2eAZetPyUECyjfgZiIzihmvBuQRn5Rlc3G7bw+z6eb19FZOsdT5dKIccwNUwY
         dzW0+tmsxJekFSO3u6QnyzFi8u+aA3Pc3rEvE2BA3QR5xNjV+WxRz07OgNuSY+0mbLg5
         A2dkBe9SKw3fzofiyuHGNH6vCbz/4geAspeD7U4THOB8+1X9XgP1Y8eviTEVH+ccUDq3
         K0ukQCzwzTM40scUwHb+mM9L48FQDikcuyw0sSIPH5qND0fHLy2yVq2PGbs95iFHOXln
         rKe/epApKCYa3pKY+3vXd7lx1UW+4pjS2bTRHfuZXAz3K940F10+peefMy4RCllt2kKC
         4C9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=CzXRCK2IG+QiEk8VkCDJeJkkF52iVy5YTfg9HZImjvY=;
        b=qnnypi7V83NrsnlFlGx8U/lmDsbt45gMDhwmKdt95jD7lTo2NpleDs7bYWJ14SrvPU
         tnS3sjH1HaXq9pkHiVnvEBStyE8o+fIfiy8HMpwB1+GqaeM+6stl+DrwNX3VYyMfpJLm
         sjco8t2XdTZ6C8h1EB5F0zkN2OJscuiNtZj/5GpAWhDRWHEgU4CS0Qq/4GRNUIXineyT
         I4sP+VoUpv6r18DshJiQ06qLrznGejUIqwECAhHGKLPpFHPFjlZEHt/b+N5C1ZYbVcjw
         tyIBcWGxSUN1RK8u72Jz50eyZCTveUYZY6/dkvk5grY7eflccDUsoqmZpEw9+R4GOnMN
         spuQ==
X-Gm-Message-State: ACrzQf1joO2PtQWDF6O9xlW4x3186Uf0lzU23lmeunnWSRZkPe1/fpBC
        QTX1MXtFzL+dbVReLX3ZeCTe8tXhAZNor2SqzWypwA==
X-Google-Smtp-Source: AMsMyM47CNyVKKtlB6i2kN5jbR/KyanyUMb96Q6n6vzqQv7PziSjblfyht55TZQVrjTgqz81gkDkRFaFQnvYsnPPsdM=
X-Received: by 2002:a19:490b:0:b0:49f:52cf:aeaf with SMTP id
 w11-20020a19490b000000b0049f52cfaeafmr630419lfa.46.1663828848225; Wed, 21 Sep
 2022 23:40:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-7-vincent.guittot@linaro.org> <000c2893-feb4-373d-2234-2ca74be94714@arm.com>
 <CAKfTPtASminP4ogVRhcvQ4R3-x-E+UUzuMaEu-xQU_MtLr9+Xg@mail.gmail.com>
 <YyioI4iBFq8ib9JT@slm.duckdns.org> <20220921155521.qb3jb74nbjoenau6@airbuntu>
 <YytAa9a8DSyuJWhT@slm.duckdns.org> <CAKfTPtBCUu80dpGneyhsZneTtcqcm3DrVVoqv6rH60oX_vEz+Q@mail.gmail.com>
 <YytF7MoZxeZ6tpCM@slm.duckdns.org>
In-Reply-To: <YytF7MoZxeZ6tpCM@slm.duckdns.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 22 Sep 2022 08:40:36 +0200
Message-ID: <CAKfTPtD1P0oTf6drOW9XwVnQ8MsCihs0rV6j+L2HV93JP-U9Lg@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sched/fair: Add sched group latency support
To:     Tejun Heo <tj@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        parth@linux.ibm.com, chris.hyser@oracle.com,
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

On Wed, 21 Sept 2022 at 19:12, Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 07:02:57PM +0200, Vincent Guittot wrote:
> > > One option could be just using the same mapping as cpu.weight so that 100
> > > maps to neutral, 10000 maps close to -20, 1 maps close to 19. It isn't great
> > > that the value can't be interpreted in any intuitive way (e.g. a time
> > > duration based interface would be a lot easier to grok even if it still is
> > > best effort) but if that's what the per-task interface is gonna be, it'd be
> > > best to keep cgroup interface in line.
> >
> > I would prefer a signed range like the [-1000:1000] as the behavior is
> > different for sensitive and non sensitive task unlike the cpu.weight
> > which is reflect that a bigger value get more
>
> How about just sticking with .nice?

Looks good to me. I will just implement the cpu.latency.nice

>
> --
> tejun
