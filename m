Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C1967A067
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjAXRsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbjAXRsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:48:06 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF3547EC1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:48:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h12so10674664wrv.10
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V93YxZhrel3xAN+VbeEKoEVG6oQBY24r4YdHRWPADfw=;
        b=hCp28AR562gw9+yHIiIUyudi367Y3L7CmwYpvsr3AQgZAdH0an41tROwZob6N/xLjY
         mpGGLlg2f4kTD52FhLolXpf9OqGCFY+pZFCQzy/DuyA0nddhAdVCUxYtUq3pYii9glpq
         /XXHU+JsgalXO5S9TBv12omLbp91V9pyhX/G3g4NjpQxV7ucz6zSRW69PlKS8OD38cL0
         5TYsk0DnEaOa0rRqhsQTRdoineoXhJhF2wKhKL/SUd72g/7pI1688MCug22+C/MKvUtd
         L/5cDsy9ZW2K4JvXRJMEuh2duzGs7UTwn+c4fD7eCi3XjWAoZLyo7zB7N2xPwssb3tem
         5PrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V93YxZhrel3xAN+VbeEKoEVG6oQBY24r4YdHRWPADfw=;
        b=2/GGpcN+UrmyWowKMr2b//wPGRl4KWZXpSIRrkbVKaRSnn26GI5QltD+z02+FNwc5d
         tq1c/JFa4YIEnfxqKIrLzQ8HYPzOs8Y2i4BrD1XRiGsQ8SEcIVZXPgAc2bvPpWHXqUiy
         poVrL6grlK098txS+uNurhFDa/4oYpgidcEF0tExnf6XUdlmwywoPSxXT6XY6BWtYWSe
         gRPcN0wkbQZRrFsIATqOUvU8KclYvwAZsFKukorhvWVFM6gIr4mbHuKMiSQw29ZVJxih
         zIFDoQUKn8wrMcHJbHm0rRG/YnlhcGlGXL6UOKSXGB/GRLzwYKqu9CSUv2hCFGI1fXIV
         3hCw==
X-Gm-Message-State: AFqh2kpShkwAIMGKXEZYFTggrBq+ZwQ/ZvzFQvjqGqm5rmHTf5ftISFh
        n7w20xNVWL8g+fjtFYAkq9XQ3agc/FiaJetD9Vl/xA==
X-Google-Smtp-Source: AMrXdXsyIcklioxlZg1vEE5buJVj4ZQPzS8jI+Ui7FFhw3IHXHrCAgiMSoHx7FEZiY7f8bcnpNpsZewmCvGJH6kX/B8=
X-Received: by 2002:a05:6000:124f:b0:2bd:df97:13f4 with SMTP id
 j15-20020a056000124f00b002bddf9713f4mr1146504wrx.654.1674582483784; Tue, 24
 Jan 2023 09:48:03 -0800 (PST)
MIME-Version: 1.0
References: <1673940573-90503-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1673940573-90503-2-git-send-email-renyu.zj@linux.alibaba.com>
 <06d33eb8-d2a9-4792-fa83-c64059ab7326@oracle.com> <80e8fc50-af91-3191-dc47-83940236a49a@linux.alibaba.com>
In-Reply-To: <80e8fc50-af91-3191-dc47-83940236a49a@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 24 Jan 2023 09:47:50 -0800
Message-ID: <CAP-5=fUAV5+B=KTR6DZGZ_kkcbrqBw4MPj11PxaN3ZKC-_+2PA@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] perf pmu: Add #slots literal support for arm64
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        John Garry <john.g.garry@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 7:54 PM Jing Zhang <renyu.zj@linux.alibaba.com> wro=
te:
>
>
>
> =E5=9C=A8 2023/1/17 =E4=B8=8B=E5=8D=884:45, John Garry =E5=86=99=E9=81=93=
:
> > On 17/01/2023 07:29, Jing Zhang wrote:
> >> The slots in each architecture may be different, so add #slots literal
> >> to obtain the slots of different architectures, and the #slots can be
> >> applied in the metric. Currently, The #slots just support for arm64,
> >> and other architectures will return NAN.
> >>
> >> On arm64, the value of slots is from the register PMMIR_EL1.SLOT, whic=
h
> >> I can read in /sys/bus/event_source/device/armv8_pmuv3_*/caps/slots.
> >> PMMIR_EL1.SLOT might read as zero if the PMU version is lower than
> >> ID_AA64DFR0_EL1_PMUVer_V3P4 or the STALL_SLOT event is not implemented=
.
> >>
> >> Signed-off-by: Jing Zhang<renyu.zj@linux.alibaba.com>
> >
> > Reviewed-by: John Garry <john.g.garry@oracle.com>
>
> Hi Ian,
>
> Do you think there are other problems with this patch? Can I get your tag=
s?
>
> Thanks,
> Jing

Sorry for not seeing this earlier, I see it is already in Arnaldo's tree:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=3D=
perf/core&id=3Dacef233b7ca749fda153a06bbd2d9feb2bb16857

Thanks,
Ian
