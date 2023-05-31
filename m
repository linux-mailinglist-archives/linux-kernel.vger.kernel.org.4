Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0052A717310
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 03:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjEaBT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 21:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjEaBTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 21:19:52 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B90C9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:19:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b025aaeddbso48425ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 18:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685495990; x=1688087990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAglrf8PCd1V6N2W8Uz36FXrK3c4ZLEoDhLUPZcuTSY=;
        b=rD1tRmQ1Fck5LJpxqUAqcYBVbzyaUltLUrkhuX+3a11rRgFrGU6Q0UQJWw0q+4N5ZS
         tlgb8H2pcD6SRCs9zfE4oAu4oA31A+1iqJgmN4Ex8Vuz8DMhl0p2EFxpCw7H5XzGccKb
         aoL3I0eZHZ2W2DmAkp+bvsQ6c/wynAInNPFhwLWr8vNGW+b4apDjK9DhQCz5YSZQT4kd
         RkyZZdS7HfnBKxRI994pW1J5M8NV/3cBg2LlWi68bubpFBzkCP4rsSqt6X1uW79Maah8
         AlWaJUSiQEQG1AGyKiWyEYwa4LmsuJJXr18zxR0mY1MKg8LKgYQoOy/ocZuQuTSKL1qc
         s8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685495990; x=1688087990;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAglrf8PCd1V6N2W8Uz36FXrK3c4ZLEoDhLUPZcuTSY=;
        b=YowiIEQfz4TYIKsmg8nIixLgva+ABTO3UGBVpWLSxMmeN3YaghDcikfJNU13Hklsf6
         x1xfF/iycgcTPF3FWLpylzBAvYpjb0pRBhN3pnMLP5NiH2HzjJyPKavha1Xo+wQx/Jfg
         Z0LOHCHu/5spsAp1BgwJ0llcACGT5gaTfgtcDnUVUc1F++SX5egAquDT87rywBa0WEhP
         45U3UEUvUFSq9+CE4Xl2bBCibkZKFEnUQhQsg3OwMntmsstIOS8OAo9RXQqTm0+i/uiD
         u8gLqOkl8yjSLMcntst4evw3zWOc9slhQS7EQBt7PwXOCYFE4uSEhocgWvEdrONcg988
         9MxA==
X-Gm-Message-State: AC+VfDycPG9MiMH4ou5hO6FotRJCgr0AZpGK/59hmKqq3/69kzksPy6O
        /55lQJZGW4Ft1Mz1SOJpsbKYweB7VwZAgKzUq6fpvg==
X-Google-Smtp-Source: ACHHUZ7FuWl4H6Symmfi8dFQJKTmmnG59YHutkIhpHo/Nh7GAwlGpglbKMOYoXADLXEYkUP/NLRZqJ2znsogsOrQoGQ=
X-Received: by 2002:a17:903:74f:b0:1b0:cea:2952 with SMTP id
 kl15-20020a170903074f00b001b00cea2952mr21011plb.25.1685495990418; Tue, 30 May
 2023 18:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com> <1685438374-33287-8-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1685438374-33287-8-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 30 May 2023 18:19:39 -0700
Message-ID: <CAP-5=fWadoqvUfEYKNEvfQ-5q4cdm8j0fXh7TJgPnA9u3Rz+-g@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] docs: perf: Update metric usage for Alibaba's
 T-Head PMU driver
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 2:19=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> Alibaba's T-Head ali_drw PMU supports DDR bandwidth metrics. Update
> its usage in the documentation.
>
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  Documentation/admin-guide/perf/alibaba_pmu.rst | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/admin-guide/perf/alibaba_pmu.rst b/Documentati=
on/admin-guide/perf/alibaba_pmu.rst
> index 11de998..7d84002 100644
> --- a/Documentation/admin-guide/perf/alibaba_pmu.rst
> +++ b/Documentation/admin-guide/perf/alibaba_pmu.rst
> @@ -88,6 +88,11 @@ data bandwidth::
>      -e ali_drw_27080/hif_rmw/ \
>      -e ali_drw_27080/cycle/ -- sleep 10
>
> +Example usage of counting all memory read/write bandwidth by metric::
> +
> +  perf stat -M ddr_read_bandwidth.all -- sleep 10
> +  perf stat -M ddr_write_bandwidth.all -- sleep 10
> +
>  The average DRAM bandwidth can be calculated as follows:
>
>  - Read Bandwidth =3D  perf_hif_rd * DDRC_WIDTH * DDRC_Freq / DDRC_Cycle
> --
> 1.8.3.1
>
