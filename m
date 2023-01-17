Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B766766E821
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjAQVFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjAQVFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:05:09 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54EB1E2A1;
        Tue, 17 Jan 2023 11:31:11 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id e3so22482517wru.13;
        Tue, 17 Jan 2023 11:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xV2A1fLeZZ9IahqVFFk3BS79lTIX6Ls+DU8ZWeitKvU=;
        b=K5X1lVcAOzfTk7jw4Zy049SDb0uON5X++uK3PQHxdg6Yc7+A5vX/ZkfGYqoq8Ppyn3
         Kt9jjXUfP/eCkebdwOO2P1ZwkgzRnFMFRnMXm9H4axcmj7slGi5h/H7KbXUC3Aqpxwrr
         afUXzXC1C4WDHjfd1AeMvtgfqfCxRd544y5TQii2H+b82sjnAzZBPr2UOsqJkx/Wi9wV
         YHk3j5nrGbzyOSEElPPSRJHGrdjwbyGzdSCJLBts6h9yVMymhBdJTAdk2GnFRwtMVCCJ
         QJch991e4H7u3brnsztORgG5X+lMpfnlwcc1IgqsopuL/dAgI8SjlaspQCJ9IC7cj8EM
         mONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xV2A1fLeZZ9IahqVFFk3BS79lTIX6Ls+DU8ZWeitKvU=;
        b=vj/0sx1W9KS/itc+nynXY/8y21rZiVahiArAzOeZ35ms4OL98wjZen/aXFjUwgFFiE
         njgRVoYPpDl4W4PBw1eUWbc1K9szx/CJnXyu1aKWZxWF8SdbqOxAcmJ6Zu0wDEiZrzUY
         hj69Dz4zNQUDC5vFjZx9Nd7iG1VOfMURxW2haj9MRjPFellJWkiWioF078qJr82denF+
         9CLCIItZDkDsvr6GLvCNSlX9NTnPjf45UoUBr2UCJgOfI+jMBxbW2hZWiiKGY6VkWqzl
         ClrS2xPjzo12edR+dgSJ5yTEoAytz4HTCZNprJwrYMq1h8cPInQZqmEf1zTyTO3OMkHW
         g81A==
X-Gm-Message-State: AFqh2koxDDIWK1FWRCwzrJ5UtQ0boR2Hnf33iTvP47xo1seFs+EsWrNb
        70q0QBIlpnYc4joj5f2bJEE=
X-Google-Smtp-Source: AMrXdXtIJnhXu7W2sX7CuGyLsMAfinDsmEp66VJkHTgtRubYDMN83/yFkgQc8LKM8jzsSPTNQLlSmw==
X-Received: by 2002:a5d:42c2:0:b0:2bc:371a:8a1 with SMTP id t2-20020a5d42c2000000b002bc371a08a1mr3848019wrr.22.1673983870355;
        Tue, 17 Jan 2023 11:31:10 -0800 (PST)
Received: from nz (host81-147-8-12.range81-147.btcentralplus.com. [81.147.8.12])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdd4e000000b002366e3f1497sm29824403wrm.6.2023.01.17.11.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 11:31:09 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:31:09 +0000
From:   Sergei Trofimovich <slyich@gmail.com>
To:     James Morse <james.morse@arm.com>
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        matoro <matoro_mailinglist_kernel@matoro.tk>,
        =?UTF-8?B?w4ltZXJpYw==?= Maschino <emeric.maschino@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ia64: Fix build error due to switch case label
 appearing next to declaration
Message-ID: <20230117193109.5650fd6f@nz>
In-Reply-To: <20230117151632.393836-1-james.morse@arm.com>
References: <20230117151632.393836-1-james.morse@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 15:16:32 +0000
James Morse <james.morse@arm.com> wrote:

> Since commit aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to
> report ITC frequency"), gcc 10.1.0 fails to build ia64 with the gnomic:
> | ../arch/ia64/kernel/sys_ia64.c: In function 'ia64_clock_getres':
> | ../arch/ia64/kernel/sys_ia64.c:189:3: error: a label can only be part of a statement and a declaration is not a statement
> |   189 |   s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> 
> This line appears immediately after a case label in a switch.
> 
> Move the declarations out of the case, to the top of the function.
> 
> Fixes: aa06a9bd8533 ("ia64: fix clock_getres(CLOCK_MONOTONIC) to report ITC frequency")
> Signed-off-by: James Morse <james.morse@arm.com>

Out of curiosity what compiler version behaves like that? I think I and
matoro build-/run-tested it on gcc-12 and maybe gcc-11.

Thank you!

Reviewed-by: Sergei Trofimovich <slyich@gmail.com>

> ---
> Found when build testing another series.
> I've only build tested this.
> 
>  arch/ia64/kernel/sys_ia64.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/ia64/kernel/sys_ia64.c b/arch/ia64/kernel/sys_ia64.c
> index f6a502e8f02c..6e948d015332 100644
> --- a/arch/ia64/kernel/sys_ia64.c
> +++ b/arch/ia64/kernel/sys_ia64.c
> @@ -170,6 +170,9 @@ ia64_mremap (unsigned long addr, unsigned long old_len, unsigned long new_len, u
>  asmlinkage long
>  ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *tp)
>  {
> +	struct timespec64 rtn_tp;
> +	s64 tick_ns;
> +
>  	/*
>  	 * ia64's clock_gettime() syscall is implemented as a vdso call
>  	 * fsys_clock_gettime(). Currently it handles only
> @@ -185,8 +188,8 @@ ia64_clock_getres(const clockid_t which_clock, struct __kernel_timespec __user *
>  	switch (which_clock) {
>  	case CLOCK_REALTIME:
>  	case CLOCK_MONOTONIC:
> -		s64 tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> -		struct timespec64 rtn_tp = ns_to_timespec64(tick_ns);
> +		tick_ns = DIV_ROUND_UP(NSEC_PER_SEC, local_cpu_data->itc_freq);
> +		rtn_tp = ns_to_timespec64(tick_ns);
>  		return put_timespec64(&rtn_tp, tp);
>  	}
>  
> -- 
> 2.30.2
> 


-- 

  Sergei
