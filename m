Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B1A653761
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 21:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234731AbiLUUKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 15:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiLUUKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 15:10:21 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863BB23329
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:10:20 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d7so16608691pll.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 12:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MRo9Es4TETaumZ0Gxh+CRtCG1EOUJSXBFePVu0YqELs=;
        b=Gdp/X9ZO8QsRjK2/43/LcFJUwmY+g/lSRUEsJVySFafLQDUptRrB4Xy2ykTmmcJiTz
         +1sKFk/UGU0Ch5nn2zZ+BAav12RGnOcgMNNt8K73TkM2ywbkF/dAw8AbqCLsDj65omTo
         YL/WuNKJ2qTSq9ECNo5hso0vVqjn1H+4QUSZBAgWtKV3ZIuQ03SzKPLFNCPg4QhxKkKl
         yFcmJDe0+JIa79wfcZXOXVom/WbeZFzSFVyNjxBu1+oj9WCiu/eAvMHaMU2Sgfcm5sDi
         iNb8FFFxhp+1Kv0DRnJu47oxG+bCHvFH7EzOZnUSeDl4nt31gOt2tjX9fxpirasQhg+W
         bedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MRo9Es4TETaumZ0Gxh+CRtCG1EOUJSXBFePVu0YqELs=;
        b=2RSbOnTb6ih6RsqOHYfvwEeYMD4vtfBA/2ssJhfZPBENRI5gUjXtxc9kf9XIfLUYjU
         2UIaaXMlPppNC5gQd4nF/t9ukoOD3sMKavrm9GOu02aEHkwmigUS8iZskU5MSrlY9f0F
         P4PEpNFpze1ZBJXQMjnT8ekA8VBK26hRLEQn1IwZUn9OO1UB1xOvtGB284WqQKjRBYf1
         1bZOLQpUS536vUtzJKXMlMinmAJRKmmS4/TtjoAUCvuK5vj7QFiXb2RYDr5odAesHvWF
         ZJ/U6OtiAFfTknn8/3mPUJpjDqhqaD9G9hfNgPFuIIbGN8WR4Jfysnv0yI3ncRiR/2Dm
         9DtA==
X-Gm-Message-State: AFqh2koqStCEFMLBFvnxdqA4HIi23fgHJxBzSWC29LeaTvPpf8K36/dX
        c1/JmaD8Aep0SJSLXQmXpmRuFxECdwesvOIs6bwCUuGdgVWcvHBDBfU=
X-Google-Smtp-Source: AMrXdXtSL2991sZl7FGLuAbG6D0mSxAHu9HjVO6nlaX2DvQw3r/xb2+aTruwlTYuMd0rb3bMrWxUQuviChgfgDLTJoY=
X-Received: by 2002:a17:902:a506:b0:189:97e2:ab8b with SMTP id
 s6-20020a170902a50600b0018997e2ab8bmr301811plq.131.1671653419884; Wed, 21 Dec
 2022 12:10:19 -0800 (PST)
MIME-Version: 1.0
References: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org>
In-Reply-To: <20221221-bpf-syscall-v1-0-9550f5f2c3fc@chromium.org>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 21 Dec 2022 12:10:08 -0800
Message-ID: <CAKH8qBuLhZ+T9fvP=DXeYevdrNofTPpEiQqq2RenBUKVghPmtA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Remove unused field initialization
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Song Liu <song@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Dec 21, 2022 at 11:55 AM Ricardo Ribalda <ribalda@chromium.org> wrote:
>
> Maxlen is used by standard proc_handlers such as proc_dointvec(), but in this
> case we have our own proc_handler. Remove the initialization.

Are you sure?

bpf_stats_handler
  proc_dointvec_minmax
    do_proc_dointvec
      __do_proc_dointvec
        vleft = table->maxlen / sizeof(*i);

Maybe we should really do the following instead?

.maxlen: sizeof(int)

?

> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> bpf: Trivial remove of unitialised field.
>
> I have inspired myself in your code and heritaded this bug :). Fixing this
> here so none else makes the same mistake.
>
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: John Fastabend <john.fastabend@gmail.com>
> To: Andrii Nakryiko <andrii@kernel.org>
> To: Martin KaFai Lau <martin.lau@linux.dev>
> To: Song Liu <song@kernel.org>
> To: Yonghong Song <yhs@fb.com>
> To: KP Singh <kpsingh@kernel.org>
> To: Stanislav Fomichev <sdf@google.com>
> To: Hao Luo <haoluo@google.com>
> To: Jiri Olsa <jolsa@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  kernel/bpf/syscall.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 35972afb6850..8e55456bd648 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5319,7 +5319,6 @@ static struct ctl_table bpf_syscall_table[] = {
>         {
>                 .procname       = "bpf_stats_enabled",
>                 .data           = &bpf_stats_enabled_key.key,
> -               .maxlen         = sizeof(bpf_stats_enabled_key),
>                 .mode           = 0644,
>                 .proc_handler   = bpf_stats_handler,
>         },
>
> ---
> base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> change-id: 20221221-bpf-syscall-58d1ac3f817a
>
> Best regards,
> --
> Ricardo Ribalda <ribalda@chromium.org>
