Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB995FA2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 19:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiJJRX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiJJRWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 13:22:33 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5107677E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:22:31 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d7-20020a17090a2a4700b0020d268b1f02so4232525pjg.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 10:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F5WjtwkWqyZfTkRZ7Dsd4jLoL8mM3gEkTkPHRcfvo4g=;
        b=MrE3tXu8TDG6zOfhEmsInCfwvAiODq68nqtZY/yfBW8V2YVuNSR9scamB+u00paSkG
         tNPfU2CJSqy1W1hYxg3dCA2qgCm+uf3gOelQdO4JXmCxf89IkliLYDeQfhE4pLLA5q+z
         BbeFcCdjOG3N7ISAhzXlFdKMj1RyXHyxPFTfBwRzFMA2HlJPHpoQwt/e7SAyAhfkVKDp
         V2uQsRJF+qMJFBxJz9EvFF0mlAKfSa5aDXM/nhpKqyCo5hkTUTsvJB8eSVxj24RO7Gyd
         BMgXG0ZmnPJfe+nxW6oncw4cW4I+tv+rZmMbsIIltWFnwU4llLRDONowEzFS29YAOtXZ
         D9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F5WjtwkWqyZfTkRZ7Dsd4jLoL8mM3gEkTkPHRcfvo4g=;
        b=K7hEJDGI1DeKUS3o0etGgpMm67IGAewARL9axRV/u7eCGtTkpReYiQpSU1UJzOC83a
         fEizsE7V1mIapM31opYNSK5RVNrNV68F3ijCSLLW2ye9AmeMVil7ZEdcx9x1MlzNl6MP
         kZffZkOOoQscZQyLovRkixSYVdiMPG8ItnbLs7pxUaOBrHoCB/o6LyOO1Up4oogmQVZl
         Pv0Pfe8qX1gwg31SKvDQrDYY6omWz48Z+juS2tnm26mhXTOrP3BNaEnBIgqS11yCyFsF
         QKDU6PhcmaRWLWS/CcDlu7/DUVfo4r5GesT7mSMeTZnzNSP5dECnYfm9UivAutkZ2RbU
         o/Yg==
X-Gm-Message-State: ACrzQf2Ibq1r1dgomsM7eJF9WO0v9+x4zK3hSIpBn6EhDQkqgAThnYvp
        VD7NUydFUrKjjyELTJeo0SAlScUVYr+iPnH6a/5GHA==
X-Google-Smtp-Source: AMsMyM4BBmpGvvWElKj1WQXEwLMvfUsq5M+DqNNScs04BxqOKDqc6btaucnzkmIMHRMBlnIjMglNbUXS3Ej00ptKpKg=
X-Received: by 2002:a17:902:a411:b0:178:9e4c:2ef8 with SMTP id
 p17-20020a170902a41100b001789e4c2ef8mr20717513plq.95.1665422550436; Mon, 10
 Oct 2022 10:22:30 -0700 (PDT)
MIME-Version: 1.0
References: <5a10dda2a06b92f040ec7a18876db4c8107b4989.1665026261.git.quic_gurus@quicinc.com>
 <edc9712e479c433471a5c6b14d3e7ede9c228f5c.1665026261.git.quic_gurus@quicinc.com>
In-Reply-To: <edc9712e479c433471a5c6b14d3e7ede9c228f5c.1665026261.git.quic_gurus@quicinc.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Oct 2022 10:22:18 -0700
Message-ID: <CAKwvOdm9fOEEQ9cYud7U16Zgd+uahM6Gnv+evoQPjfOc13gZEA@mail.gmail.com>
Subject: Re: [PATCH 2/2] scripts/clang-tools: Remove core.uninitialized.Assign check
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>,
        Tom Rix <trix@redhat.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Elliot Berman <quic_eberman@quicinc.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, matt@codeconstruct.com.au,
        David Howells <dhowells@redhat.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        jackm@dev.mellanox.co.il
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

On Wed, Oct 5, 2022 at 8:24 PM Guru Das Srinagesh
<quic_gurus@quicinc.com> wrote:
>
> Remove this check as it leads to false positives in some cases (not all):
>
> warning: Assigned value is garbage or undefined
> [clang-analyzer-core.uninitialized.Assign]
>       list_for_each_entry_safe(page, tmp_page, &pages, lru)
>       ^

I don't think we want to disable this.  Tom and others have fixed bugs
from this report. See also:
commit d1bd5fa07667 ("lib: remove back_str initialization")
commit 33b5bc9e7033 ("octeontx2-af: initialize action variable")
commit 8d783197f06d ("mctp: Fix warnings reported by clang-analyzer")
commit eed1a5c74216 ("drm/amdgpu: check return status before using
stable_pstate")
commit 3da4b7403db8 ("ALSA: usb-audio: initialize variables that could
ignore errors")
commit 38ac2f038666 ("iio: chemical: sunrise_co2: set val parameter
only on success")
commit afe6949862f7 ("afs: check function return")
commit d108370c644b ("apparmor: fix error check")
commit d52e419ac8b5 ("rxrpc: Fix handling of an unsupported token type
in rxrpc_read()")
commit 6a6516c024bb ("USB: storage: avoid use of uninitialized values
in error path")
commit f71e41e23e12 ("iio:imu:st_lsm6dsx: check
st_lsm6dsx_shub_read_output return")
commit 3a61cdf43e67 ("hwrng: intel - cleanup initialization")
commit 094dd0d73062 ("rndis_wlan: tighten check of rndis_query_oid return")
commit e3914ed6cf44 ("ieee802154/adf7242: check status of adf7242_read_reg")
commit c2a3d4b4cac1 ("net/mlx4_en: Cleanups suggested by clang static checker")


>
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> ---
>  scripts/clang-tools/run-clang-tools.py | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/clang-tools/run-clang-tools.py b/scripts/clang-tools/run-clang-tools.py
> index a72c4c7..714cb82 100755
> --- a/scripts/clang-tools/run-clang-tools.py
> +++ b/scripts/clang-tools/run-clang-tools.py
> @@ -54,6 +54,7 @@ def run_analysis(entry):
>          # List of checks to be excluded
>          exclude = []
>          exclude.append("-clang-analyzer-security.insecureAPI.DeprecatedOrUnsafeBufferHandling")
> +        exclude.append("-clang-analyzer-core.uninitialized.Assign")
>
>          checks += ''.join(["," + e for e in exclude])
>      p = subprocess.run(["clang-tidy", "-p", args.path, checks, entry["file"]],
> --
> 2.7.4
>


-- 
Thanks,
~Nick Desaulniers
