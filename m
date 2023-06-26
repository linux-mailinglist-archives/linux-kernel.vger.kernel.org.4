Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7E73EF17
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 01:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbjFZXPA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 26 Jun 2023 19:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFZXO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 19:14:59 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB42F10D2;
        Mon, 26 Jun 2023 16:14:57 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5701e8f2b79so41583987b3.0;
        Mon, 26 Jun 2023 16:14:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687821297; x=1690413297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM73dDXJJ2LQE16TI30w/dkhZfJCFiiWEY4v9vd3CAI=;
        b=LDX72YnIUSr+k4xLstF51E7GaDxYyBd6KxcvBbZNYLVFq/ugCcPmyF7e/qlFrs+Dwl
         b22mLaJen3XLfYOFittbcOp6jCcq1lOMnNF3ujmJ/YNxntuRoEpnc828EVLyKt3pUL+i
         gRv+1SqBEijiwFdNt4Pwn5t9/lM3QjolL2MwwbAVokjrizCNr2vUXB8BN6xdjj72bg3N
         u/iVqTOh1Gk9fJfhzjkGfhUN9Jk5KBDhXDv8c7RcYsWgSmyRmdPZhmWxncb7LvjJZcl3
         HdH4JtRM0QbD0S8JrRBcIAPxiM6OMnrZ8WhqwbaxpyywQVLnaik1qKIaY2dsD7gy56eF
         xLMQ==
X-Gm-Message-State: AC+VfDxnXkVzmVdIdpc81pblavP9+yE6qUi04NPzqM+V6bQiRkguUIZ4
        dkNIzQek31lUrb98FBHtDGKywk5jT6y8mk3z7wA=
X-Google-Smtp-Source: ACHHUZ6SlNxvS+0k1RkdHbPMGvtR/zIR689flvvkM6fGCsnFYzBJ3gb7C/t8rh8Gglh4bBOZPBk7Q91WVqTWMmesHvU=
X-Received: by 2002:a25:2903:0:b0:bff:d530:f06 with SMTP id
 p3-20020a252903000000b00bffd5300f06mr14953523ybp.41.1687821296805; Mon, 26
 Jun 2023 16:14:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjtisDVPijfU=iEGxc0YF=RnAt+r18Jg+8Av-+RAO=jeg@mail.gmail.com>
 <IA1PR20MB49536C0DA47122E9E3CB7CBBBB20A@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAM9d7cis-rb0fozK+T6R8MCEcT0ZF=RRNpv1qAWsLkMfsG6KxA@mail.gmail.com> <20230624-supermom-disparity-37546ffed0a4@spud>
In-Reply-To: <20230624-supermom-disparity-37546ffed0a4@spud>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 26 Jun 2023 16:14:45 -0700
Message-ID: <CAM9d7cjHndHrcH95uwmYRMRpm-a0kX2BHQ1jzmyo6f48w69jbg@mail.gmail.com>
Subject: Re: [PATCH V3] perf vendor events riscv: add T-HEAD C9xx JSON file
To:     Conor Dooley <conor@kernel.org>
Cc:     Inochi Amaoto <inochiama@outlook.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nikita Shubin <n.shubin@yadro.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, Jun 24, 2023 at 1:54 AM Conor Dooley <conor@kernel.org> wrote:
>
> On Fri, Jun 23, 2023 at 09:35:01PM -0700, Namhyung Kim wrote:
> > On Fri, Jun 23, 2023 at 6:33 PM Inochi Amaoto <inochiama@outlook.com> wrote:
>
> > >
> > > As for c9xx wildcard, the T-HEAD provides a `MCPUID` vendor CSR to allow
> > > its CKLINK to get the detail CPU info. The format of this CSR are:
> > >
> > > ------------------------------------------------
> > > |31   28|27  26|25    22|21   18|17    8|7    0|
> > > | index | WLRL | family | class | model | WLRL |
> > > ------------------------------------------------
> > >
> > > And for C9xx series (only index 0000 is vaild for us, as `MCPUID` also
> > > provides other index).
> > >
> > > | 0000 | xx | 0100 | class | xxxxxxxxxx | xxxxxxxx |
> > >
> > > The class codes are:
> > >
> > > C910: 0011
> > > c906: 0100
> > >
> > > The CSR is a M-mode only CSR, so now I'm exploring a clean way to
> > > integrate this CSR into the kernel. Any advice?
>
> See for example how riscv_cpuinfo_starting() reads mvendorid & Co.
>
> > I don't know about the details.  Is this CSR available from user space?
> > If not, you could add it somewhere in the sysfs.
>
> Machine mode is the highest privilege level, Supervisor mode is next &
> User mode is the lowest. Typically the kernel runs in Supervisor mode.

Maybe you're interested in this thread for user visible identifiers.

https://lore.kernel.org/all/1687245156-61215-1-git-send-email-renyu.zj@linux.alibaba.com/

Thanks,
Namhyung
