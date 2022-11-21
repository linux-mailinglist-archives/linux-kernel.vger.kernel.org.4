Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDE3632A47
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 18:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiKURFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiKURF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 12:05:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344CFC9AAD
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:05:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v1so20778162wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 09:05:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uAhMDGyM6Mu00oQqbenfJR6XolkWxTwD70LEM2vZY50=;
        b=j8h40C0M7V/jU09PjuZo0L21V/WuiMTtk+xlVnA4+qWUUpaML5vGeXPw916ROtRQbg
         sUNF4KMq9dxCgz12UzP7I5/cwvPF03PfMLeb9Sq25BPp5yOw/Qc8qv080MAkSJT6FryY
         6vlYcd8LJ9drK17/4RojiNE9S/5VJt6e+HgqzwV3R3MRONl12pEUCXiQdmOYMpWMOcuP
         EJE+NPArPbyGmU32+SFTnq3YpNCMQcNvo+4g5wnxtvkJ7V3Kv5mqmjoSp/ernX92mnsG
         0lPuDH0bo1mU4nsJoAzIjXr3GjzJOlwRzxm75atXjSr0eWVAnovtN8U1l6FRjkklqY1A
         xRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uAhMDGyM6Mu00oQqbenfJR6XolkWxTwD70LEM2vZY50=;
        b=iuJs/O8o0i6YHv6sds69D1k5E+b0uKzI/WPwde3i2FhSQy06D0Lls0O7/FvhugvtCp
         eBTbNi/mgxsunzowQmFO0AuXtzw3wgBVPb7ibf84N+z6zkGu7dvMG9FKtHYhNbSWGbEm
         nvwQOmLhqFNSTOeeGa2O8iS+D8GMgqDtP+9v+6xpqc3DgY/Sn1i7MlB7bq0JQeaBrvOV
         f5RkLMIOp5aqpkQ4hJJww8mvp5eg71/jct6TQ1522lH5wW/aJAgG9jC59SNCnmldX80+
         flTIDjlxGsUXoYecuYam+t3lUdQp26zG8qRDqcRPtNMHU0xbdDhfSIa76WcEJhLoRIWZ
         uLNA==
X-Gm-Message-State: ANoB5pnCbGwu96JsjOk6InxDA+C7Aj1pjfndMP04FsphDWoH840n5Ttc
        ziRYqBuBfv4Ns42qMpaUYfwpGxu2r1lsWgnllYr9Jg==
X-Google-Smtp-Source: AA0mqf4FeQf6K8LNzD3P2zmQIxzZUbCH+yD5d8P8GvWxDHPnexp/cnQU+5z1w1kK0h9Q2DaUtfEE45Swq90ibr8FFcU=
X-Received: by 2002:a5d:6747:0:b0:22e:34ee:c67d with SMTP id
 l7-20020a5d6747000000b0022e34eec67dmr1128924wrw.300.1669050326395; Mon, 21
 Nov 2022 09:05:26 -0800 (PST)
MIME-Version: 1.0
References: <20221121075237.127706-1-leo.yan@linaro.org>
In-Reply-To: <20221121075237.127706-1-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 21 Nov 2022 09:05:14 -0800
Message-ID: <CAP-5=fVHpzT1Q0U=e_svzQ2+a0iSoYppL8hRmOTAHZ0_nk2Z_g@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] perf trace: Cleanup and remove unused bpf map
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 11:52 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> The initial purpose of this series is to cleanup the unused bpf map
> 'syscalls' in the eBPF program augmented_raw_syscalls and perf trace
> tool.  The relality is perf trace tool initializes system call table
> based on map 'syscalls' and wrongly returns syscall pointer for
> non-existed system calls based on the previous initialization.
>
> So the patch set firstly addresses the issue for handling non-existed
> system calls, then it removes unused local variable and bpf map in
> augmented_raw_syscalls.c.
>
> Patch 01 is a minor refactoring to use macro to replace number, patch 02
> is to return error if a system call doesn't exist, especially when we
> cannot find corresponding trace point in sysfs node, patch 03 is to fix
> the issue that trace__syscall_info() returns a syscall pointer even the
> system call doesn't exist, the corrected result is to always return NULL
> pointer for non-existed system call.
>
> The last two patches remove the unused local variable and bpf map
> 'syscalls'.
>
> This patch set has been tested with mainline kernel on Arm64 Ampere
> Altra platform.
>
> Leo Yan (5):
>   perf trace: Use macro RAW_SYSCALL_ARGS_NUM to replace number
>   perf trace: Return error if a system call doesn't exist
>   perf trace: Handle failure when trace point folder is missed
>   perf augmented_raw_syscalls: Remove unused variable 'syscall'
>   perf trace: Remove unused bpf map 'syscalls'


Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>  tools/perf/builtin-trace.c                    | 131 +++---------------
>  .../examples/bpf/augmented_raw_syscalls.c     |  18 ---
>  2 files changed, 18 insertions(+), 131 deletions(-)
>
> --
> 2.34.1
>
