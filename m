Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01A873C516
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbjFXARw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 23 Jun 2023 20:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFXARs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:17:48 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E081826A9;
        Fri, 23 Jun 2023 17:17:47 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-bcd0226607bso3620539276.1;
        Fri, 23 Jun 2023 17:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687565867; x=1690157867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hPv8x0shEc/k1aN0by01gtPFzohHEguHvDTQ7Gv+Rw=;
        b=ZpQr62wsKyCw6n+3cqyp5FJwZM0bv9bYpRMAAiRyOJDlWu5isKghF+n6lb2TtyPoMc
         O4eHWYqONFJgLVxe32/g+GBCEy0v2J5qxvJ0XG5PoSVhCr+rbOiPwi7kEd100zOfus4p
         qpaaX/bsMZr2vMgjmJqNrDPFGOEsahvyfpiP4gpgcb4bKxMg68RaxuVeJv7PfK2go5wW
         sPRWLmMoz3B+TgRsvnh6hMH0VqO5qN/8leIeORLRYXjWde1ylWTRS8IbTUV78ofumiGT
         ZKVT3KsWBOMVX4TUA2WRvv8gdKTmapjursFgbdFIaK6eVZ1Cqr/qqZFIFo27WhasmHcV
         rJTw==
X-Gm-Message-State: AC+VfDyB94lNKBl8nzuOEO3ThX3jIGgqVpgS4DftqUhWSDzihcX8aEYH
        vU9kI8ZdXClvMzzIb0v5mRvihUu80xng5/4yf/c=
X-Google-Smtp-Source: ACHHUZ6l3TbHPX8wI1PbnOY0McB4XZDCxRwUFIviGRz4FHEneTHHeSQaYtHtraYCmbboUltMOGHqhaF47c92hM7Zwlc=
X-Received: by 2002:a25:6a43:0:b0:ba8:2a74:155 with SMTP id
 f64-20020a256a43000000b00ba82a740155mr21475536ybc.32.1687565866927; Fri, 23
 Jun 2023 17:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <36fcef74ba3d21250f4c9605e691d1e2dac20ebb.camel@maquefel.me> <IA1PR20MB4953FCC20C89F2659EB34896BB7F9@IA1PR20MB4953.namprd20.prod.outlook.com>
In-Reply-To: <IA1PR20MB4953FCC20C89F2659EB34896BB7F9@IA1PR20MB4953.namprd20.prod.outlook.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 23 Jun 2023 17:17:35 -0700
Message-ID: <CAM9d7cjtisDVPijfU=iEGxc0YF=RnAt+r18Jg+8Av-+RAO=jeg@mail.gmail.com>
Subject: Re: [PATCH V3] perf vendor events riscv: add T-HEAD C9xx JSON file
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, May 18, 2023 at 2:50 AM Inochi Amaoto <inochiama@outlook.com> wrote:
>
> > licheerv # perf record
> > [  432.015618] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> > [perf:117]
> > [  460.015617] watchdog: BUG: soft lockup - CPU#0 stuck for 52s!
> > [perf:117]
> > [  488.015616] watchdog: BUG: soft lockup - CPU#0 stuck for 78s!
> > [perf:117]
> > [  516.015617] watchdog: BUG: soft lockup - CPU#0 stuck for 104s!
> > [perf:117]
> >
> > But that's not related to your patch anyway.
>
> Same issue on c920, but it did not always occur.
> Like a sbi issue for T-HEAD cpus.
>
> > I am strongly against using "c9xx" wildcard, i would prefer declaring
> > them separate (especially taking in mind that c920 is c910 with vector
> > - AFAIK), but that's up to Arnaldo to decide.
>
> AFAIK, there is no reliable way to distinguish c906 and c910 cores. And
> the events of c910 and c920 are the same (according to the draft document
> of the c920).
>
> Anyway, I agree to let Arnaldo decide.
>
> > Tested-by: Nikita Shubin <n.shubin@yadro.com>

I'm collecting patches on behalf of Arnaldo this time.
It seems this patch was not picked up for a long time.

I think we can make changes for the c9xx wildcard later
if needed.  I'll process it in the current form.

Thanks,
Namhyung
