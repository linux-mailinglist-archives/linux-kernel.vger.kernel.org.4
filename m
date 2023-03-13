Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D946B802C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCMSQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCMSP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:15:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F1377CB8;
        Mon, 13 Mar 2023 11:15:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y10so8190308pfi.8;
        Mon, 13 Mar 2023 11:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678731356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlFPtKHfCjZ7hFcG725CdyIieAxGOw83mG6tgIjYd0I=;
        b=I5EJVvuG8+H5r4JISqONKqo52EimvwOiUXI2hBsF+6DblFw6jPteCln6Es3CuT1LLA
         5Gsk0b7F/6XCIoWAAeETEo5TndayeT9W8xUpmzx1mO9N8u1Ii8xyxeFGPebQk9cgyB4v
         pVelDhQnuPiW6Qc326FDyGOXFYjeZPvDCtvQMDoVsg34w0Wlz47vA+XcVgCcJgpMSIMD
         9OhHneoEbqrct9CrvKYZwWhxU5b374BGItQoEoDijLiZ6o+UwhJNch2OKE1MfqNCzMxF
         3/kWVDW6dvpOzvacitmLH2JRHsgpkGunVArMvLSPt7DZ4BczlMHpwoead++SrEq/9kIK
         0cIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678731356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlFPtKHfCjZ7hFcG725CdyIieAxGOw83mG6tgIjYd0I=;
        b=0Fk0912Ew+iaMG/7scCIOmcrlviPaXJ/xhaCwy13PgSZ1ci32KVZw9ON9UjW1JdnnI
         VFZQ0zdEp/2l7SZ4stngFjvDdwKaNO8vt8QZVlF3Vwbl7ZwI3BV4XMetbqLLm8FjRtah
         5oUyje4HedSdZNKO7eqz0O7HgGxPQppswW6KCebXqKiYP3CFJIW60lh0vZyJMMXgOVrY
         GaMfcvUZTswSK+b1H7GFotzM2vhnVHQOLlFSuvf1wnCfLKNInvccJgeAzkRPQAfvCOOK
         dti1C82OT1vl1zRgdlJoLu5Tb2QRuRBN1c2dBUNE9A5cS23qwqRAaUqjdxjyRv2T76p8
         fjtQ==
X-Gm-Message-State: AO0yUKUwawN7mEwDFG50CxXAvJvVJOLyBoT5CmpsUscxy/k6V9j2lNwf
        mVKcdoJhNPU7DHSe5CVP+Rb3mN9LFb31GMMIiUk=
X-Google-Smtp-Source: AK7set+VmSBXdhB+Z6f8/4GulZiGPhX9WCQo45A0GE+qnhRK/dtu/Tpv2vLYuscXgOxNXf0473KLta7QhVvQLfeQqa4=
X-Received: by 2002:a62:1acb:0:b0:622:bfcd:149 with SMTP id
 a194-20020a621acb000000b00622bfcd0149mr2529789pfa.0.1678731356374; Mon, 13
 Mar 2023 11:15:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHbLzkrJQTrYBtPkf=jf3OpQ-yBcJe7XkvQstX9j2frz4WF-SQ@mail.gmail.com>
 <8ca2b07e-674e-afb6-ff12-87504f51f252@arm.com> <CAHbLzkpf4RUZugKdn-uXC5m3RpAQH5aDmRXdsxPZi0Cbf-yiyw@mail.gmail.com>
 <CAHbLzkq_7aXcys1cpgGFsfMDDDKMsT3e7zdNW=0jAkw7kBtJ0Q@mail.gmail.com>
 <20230309113851.GF19253@leoy-yangtze.lan> <CAHbLzkpvLHnyL5J5kB_ke3CWVq2=MOEdEQsGex56+Esfgqh1=g@mail.gmail.com>
 <20230313121420.GB2426758@leoy-yangtze.lan>
In-Reply-To: <20230313121420.GB2426758@leoy-yangtze.lan>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 13 Mar 2023 11:15:44 -0700
Message-ID: <CAHbLzkpZjrd401DEKnnCNMdra0f6kGRe1Nh_rTovNTmyD8aBpg@mail.gmail.com>
Subject: Re: [BUG] perf: No samples found when using kcore + coresight
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LAK <linux-arm-kernel@lists.infradead.org>,
        coresight@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mathieu.poirier@linaro.org, adrian.hunter@intel.com,
        Jiri Olsa <jolsa@kernel.org>, acme@redhat.com,
        mike.leach@linaro.org, Will Deacon <will@kernel.org>,
        suzuki.poulose@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 5:14=E2=80=AFAM Leo Yan <leo.yan@linaro.org> wrote:
>
> On Thu, Mar 09, 2023 at 10:06:41AM -0800, Yang Shi wrote:
>
> [...]
>
> > > I reviewed your shared dump, the bad and good perf data both contain =
the
> > > dummy event with 'text_poke =3D 1'.  Could you confirm the shared dum=
p in
> > > your previous email is correct or not?
> >
> > Oops, sorry. I pasted the wrong log. The good one looks like
> > (generated by v5.19):
> >
> > # captured on    : Wed Mar  8 18:02:58 2023
> > # header version : 1
> > # data offset    : 408
> > # data size      : 22640
> > # feat offset    : 23048
> > # hostname : fedora
> > # os release : 6.2.0-coresight+
> > # perf version : 5.19.g3d7cb6b04c3f
> > # arch : aarch64
> > # nrcpus online : 128
> > # nrcpus avail : 128
> > # cpuid : 0x00000000c00fac30
> > # total memory : 2108862504 kB
> > # cmdline : /home/yshi/linux/tools/perf/perf record -e
> > cs_etm/@tmc_etf63/k --kcore --per-thread -- taskset --cpu-list 1 uname
> > # event : name =3D cs_etm/@tmc_etf63/k, , id =3D { 3832 }, type =3D 9, =
size
> > =3D 128, { sample_period, sample_freq } =3D 1, sample_type =3D
> > IP|TID|IDENTIFIER, read_format =3D ID, d
> > isabled =3D 1, exclude_user =3D 1, exclude_hv =3D 1, enable_on_exec =3D=
 1,
> > sample_id_all =3D 1, { bp_len, config2 } =3D 0x12792918
> > # event : name =3D dummy:u, , id =3D { 3833 }, type =3D 1, size =3D 128=
,
> > config =3D 0x9, { sample_period, sample_freq } =3D 1, sample_type =3D
> > IP|TID|IDENTIFIER, read_format =3D ID,
> >  disabled =3D 1, exclude_kernel =3D 1, exclude_hv =3D 1, mmap =3D 1, co=
mm =3D 1,
> > enable_on_exec =3D 1, task =3D 1, sample_id_all =3D 1, exclude_guest =
=3D 1,
> > mmap2 =3D 1, comm_exec =3D 1,
> > context_switch =3D 1, ksymbol =3D 1, bpf_event =3D 1
> > # CPU_TOPOLOGY info available, use -I to display
> > # NUMA_TOPOLOGY info available, use -I to display
> > # pmu mappings: armv8_pmuv3_0 =3D 8, software =3D 1, arm_cmn_0 =3D 10,
> > uprobe =3D 7, cs_etm =3D 9, breakpoint =3D 5, tracepoint =3D 2, arm_cmn=
_1 =3D
> > 11, kprobe =3D 6
> > # contains AUX area data (e.g. instruction trace)
> > # CACHE info available, use -I to display
> > # time of first sample : 18446744073.709551
> > # time of last sample : 18446744073.709551
> > # sample duration :      0.000 ms
> > # MEM_TOPOLOGY info available, use -I to display
> > # missing features: TRACING_DATA CPUDESC BRANCH_STACK GROUP_DESC STAT
> > CLOCKID DIR_FORMAT COMPRESSED CPU_PMU_CAPS CLOCK_DATA HYBRID_TOPOLOGY
> > HYBRID_CPU_PMU_CAPS
>
> Thanks for confirmation.
>
> Just a quick summary, here we have two issues:
>
> - With command:
>   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
>   -- taskset --cpu-list 1 uname",
>
>   perf doesn't enable "text poke" attribution.

No, it enables "text poke" and perf fails to decode coresight trace
data too. It doesn't matter whether "--kcore" is after or before "-e
cs/etm/@tmc_etf63/k".

>
> - With command:
>   perf record -e cs_etm/@tmc_etf63/k --kcore --per-thread \
>   -- taskset --cpu-list 1 true (in your previous email), or ...
>   perf record --kcore -e cs_etm/@tmc_etf63/k --per-thread \
>   -- taskset --cpu-list 1 uname (in your shared perf data file),
>
>   perf enables "text poke" attribution, in this case, perf fails to decod=
e
>   Arm CoreSight trace data.

Yes.

>
> [...]
>
> > > Do you mind to share the bad perf.data file with James and me?
> >
> > Please check the attachment out. Thanks for looking into this problem.
>
> Thank you for sharing the data.  We will look into it.

Thank you.

>
> Leo
