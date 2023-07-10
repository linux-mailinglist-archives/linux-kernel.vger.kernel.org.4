Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9BE74DAC1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGJQJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGJQJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:09:14 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD08C4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:09:13 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-401d1d967beso403781cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 09:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689005352; x=1691597352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTiYEcrVX04kfMcNb49jfpkl4E2yxYs1bGPg7/V1/HA=;
        b=mLTPgOWBxSD1SPV0oWxhxXSDCPtH7csxYjduUf1FBy0FfTGa4VxNA6UvwkixjZo6jw
         f6egEr8mzqDOnNAnLXTMhCGug1ADybHUXbZerPjiLPu+VOrJTlz77PDwc39tUXeQ7L8o
         EStpUmOxA3HYNQI003MetXllZgwWR9lBjkAbWzdnOmEB7H4EBOlM1bg/XkwKNJT+d7Af
         XjkUWByDGfSW9o/JeWgM9XSda+ezynO3Jjcn2OaY/Pl5VnPOvwD4QNExOPbru0Jd0XHI
         Bz1vHLxiLD1iQ5BsuUU1UZFOrgZZk9qZRUuwClabYnBsoPX91J5r0n1NJdOFwM4e2O+g
         clTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689005352; x=1691597352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTiYEcrVX04kfMcNb49jfpkl4E2yxYs1bGPg7/V1/HA=;
        b=AlAbUePhTSdceyQ2bVRNekaGBpsH2BAcgppzU0hV3yxOiGIlJcFdrR2d264aXbhpo3
         x6VF77wuA0zsWBitPDgdm+f5MIpUNgWlqFipVKxZIU+IAA+7lxBTDPMpIywH6E5bGyFA
         NPXb2ZOqL2Bb+HsTtrsblea8uiI3F/l7Gw45Op3UXQt8HOyDynSrRJsMRgkYoXTwrqSq
         27bIfnCEJXgJfgoBVpna/dtYkZzFIY60z4rtL7+S7GvJSTp8qkSjU6YfYKHeqd9dG/FT
         PRaW5HzKdkNN3lM/3ZIaunf7rJt4KGOAxfD2a92fg4Ve8Ugch4gFAe2AVvH3IxdbvVqp
         gHxg==
X-Gm-Message-State: ABy/qLZbM7e7FmwcYNfbX4SeUNhqG/Eh/JmaOFMw79KnskCXObg1+heD
        PxBvtqFmUN0mltTsXEGPkmLM5eTO4v20dv5NEa9D5A==
X-Google-Smtp-Source: APBJJlHGZmfLfuEEqzR21NS5OF7E+xlM5zHBTw1/jIFXFYPfQfiXQkAbo1dOcHcob7SZnW2XzV2V2eNYPTiX4sgDfUo=
X-Received: by 2002:a05:622a:11ca:b0:403:affb:3c03 with SMTP id
 n10-20020a05622a11ca00b00403affb3c03mr186410qtk.10.1689005352318; Mon, 10 Jul
 2023 09:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230710122138.1450930-1-james.clark@arm.com> <20230710122138.1450930-5-james.clark@arm.com>
In-Reply-To: <20230710122138.1450930-5-james.clark@arm.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Jul 2023 09:09:01 -0700
Message-ID: <CAP-5=fWggOQChrPj6UkSBCkpTcs5iu4SPU0JoVwpKFqm8xJDQA@mail.gmail.com>
Subject: Re: [PATCH 4/4] perf: Remove unused PERF_PMU_CAP_HETEROGENEOUS_CPUS capability
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Will Deacon <will@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 5:22=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
>
> Since commit bd2756811766 ("perf: Rewrite core context handling") the
> relationship between perf_event_context and PMUs has changed so that
> the error scenario that PERF_PMU_CAP_HETEROGENEOUS_CPUS originally
> silenced no longer exists.
>
> Remove the capability to avoid confusion that it actually influences
> any perf core behavior. This change should be a no-op.
>
> Signed-off-by: James Clark <james.clark@arm.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index d5628a7b5eaa..3f4d941fd6c5 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -288,7 +288,7 @@ struct perf_event_pmu_context;
>  #define PERF_PMU_CAP_EXTENDED_REGS             0x0008
>  #define PERF_PMU_CAP_EXCLUSIVE                 0x0010
>  #define PERF_PMU_CAP_ITRACE                    0x0020
> -#define PERF_PMU_CAP_HETEROGENEOUS_CPUS                0x0040
> +/* Unused                                      0x0040 */
>  #define PERF_PMU_CAP_NO_EXCLUDE                        0x0080
>  #define PERF_PMU_CAP_AUX_OUTPUT                        0x0100
>  #define PERF_PMU_CAP_EXTENDED_HW_TYPE          0x0200
> --
> 2.34.1
>
