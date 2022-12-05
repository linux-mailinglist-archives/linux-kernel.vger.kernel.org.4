Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51B664241A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 09:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiLEIIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 03:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiLEIIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 03:08:06 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E75712A84
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 00:08:05 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso6779386otb.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 00:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4Il1L0a9yN5jMi0NqFU5WFtlB3kT0mSKTxZJfZftf5Y=;
        b=HgrtIe3j1lhohq8gcoVCRzfGER7OhK0Av5sp7MNQwjGdhYe0JoL/Z9RjWSYh4ledqv
         ZT5m8dyjBfBDe3o6C5Ql1SHQZnLtbWdhtaOjko9MxUHquSxUcqP1tLMqXDOiasZAvf5M
         I/QHiXBFfgK+uyEVhXfDgO7QzNN2OWYnaYnohJCE53fXeXx+I7fCAA8KLBSGKrq/gmkm
         ToaBF6fyw0ozfBDq7Jn7ikKAcVAUvAmBZm/vLMloXuahOMRFtYKcW4a6b+PTNU8imcqn
         Qvj60HPNX0RkNLUOpqf63PJYFaGB9lbLwqlmF/LMh7FJCL84fkyZI6uLEhGiPXDviUOW
         rE+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Il1L0a9yN5jMi0NqFU5WFtlB3kT0mSKTxZJfZftf5Y=;
        b=btKERIwyUrHPLVNju1nrXFtcEKLwFqrMWiCx2fAjzWrHmP21xrDNYBs8aM33vozdlp
         sHJFz8PP74pFZwN1L/I43ib0JSOU5LrXgdWnhiW7RpUv2FoYQJhnyi85Xfkm8416x2hU
         thwbD5tQ6AYmv5h8oo4w1ZoPxVhOEem9Bi4iQcBW+CzMYyZ9rOi3NvaxnyZ0Tr/f+Yu+
         pcgJ0i1rUrsg+XlOT+lYLm98e4h+rvC4dqQtstIKL+0j4Tm6rp7ZfNDwWzr9/91HsvLq
         dzFJuC5w1pbyMTkVNigRPQMLEAFuPn2RpD6xdiPvuDTNytbQfnkUzAJUUa4ou0IRm+xN
         C7WQ==
X-Gm-Message-State: ANoB5pkDOQXpZh1r9Ecaew6+yLbwsUruKV20VQr34Jv2nOcZrh+DQZnE
        MvOEjbFXZiQndl0A6CmXnGNm8JWB1T5kaWCZIiegKhmvvjwrrdqt
X-Google-Smtp-Source: AA0mqf6mSwCo6Z7/2qaDbw4LMyIg/luO0SArEXXBhkhy4nrxlaYRI1aeLxs5euWhQcZkRwJDCU+YT5T/+ZjEFTM0e6I=
X-Received: by 2002:a9d:351:0:b0:66e:6cf5:770a with SMTP id
 75-20020a9d0351000000b0066e6cf5770amr10433067otv.269.1670227683785; Mon, 05
 Dec 2022 00:08:03 -0800 (PST)
MIME-Version: 1.0
References: <tencent_922CA94B789587D79FD154445D035AA19E07@qq.com>
In-Reply-To: <tencent_922CA94B789587D79FD154445D035AA19E07@qq.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 5 Dec 2022 09:07:52 +0100
Message-ID: <CACT4Y+a1nRTs-yu-5U6dfBB==-WN2ELXM_DdqrtFVRNRGxVRcw@mail.gmail.com>
Subject: Re: [PATCH] kcov: fix spelling typos in comments
To:     Rong Tao <rtoax@foxmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Rong Tao <rongtao@cestc.cn>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        "open list:KCOV" <kasan-dev@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Sat, 3 Dec 2022 at 11:25, Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Fix the typo of 'suport' in kcov.h
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>

+Andrew, please merge this via mm tree

Reviewed-by: Dmitry Vyukov <dvyukov@google.com>

> ---
>  include/linux/kcov.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 55dc338f6bcd..ee04256f28af 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -56,7 +56,7 @@ static inline void kcov_remote_start_usb(u64 id)
>  /*
>   * The softirq flavor of kcov_remote_*() functions is introduced as a temporary
>   * work around for kcov's lack of nested remote coverage sections support in
> - * task context. Adding suport for nested sections is tracked in:
> + * task context. Adding support for nested sections is tracked in:
>   * https://bugzilla.kernel.org/show_bug.cgi?id=210337
>   */
>
> --
> 2.38.1
>
