Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A995675985
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 17:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjATQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 11:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjATQH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 11:07:26 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF43A5B0;
        Fri, 20 Jan 2023 08:07:24 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id y18so5943827ljk.11;
        Fri, 20 Jan 2023 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=31/1A9dhqHwbHkaUB6c82meJOceUdfVoWN5PLNgf4Dw=;
        b=nFbO/Yxjt207GzVx0yZACuPxvSjmLDh8YvAFoupxTNQTEmyiDcPazHCupQYuqYv7sp
         KHbDjKCvGrxTxDowMAfCJ1jY3sc9ziwhElOeQkWjQXS3Dp/auoKMrlQQBOXMIL6IFPqi
         5l9v/7YlqXXX1D1eLC0YKIO00rQTKzDVdKsrr9ZV1PpPFgfCylIqfJ1T4q88OE//EcW0
         E2EwoJnNwqC3s4DSvAvFQeOrM26YunzQi9hBfutsekf51UG1bpgw9jcXyz6pgnJfE1xd
         Kbho3/jZMFoPr0xkj5OL5w8MIX839zcW9JIq2jHjoqFwpkuoWcWKoboFje9RYH7fSV+S
         6asA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:reply-to:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=31/1A9dhqHwbHkaUB6c82meJOceUdfVoWN5PLNgf4Dw=;
        b=CA2aqX+BeqytJbpp8jWbBNlTiVJu5mwrqaJFXQVNQGUXDDYl0RFusOkV24e+xod/Sv
         l//6vgGChhiLaQ4Hbl13Uuc0iEO7th8jnwgNFbtJn28jfi09y2B0z5W9IxZSXtwrNE+L
         iMJzTpwa4qGCYi2XE2nwURGCm4fqyocmUYjmoplUVdWC+uAylI5vSBO9pWYmIHeLhbO2
         +LzC7ropz/bgzy9/j1QruPITXJslxKun7phaB2xC33yp6PTkrFCf7N1+IcxW0zgHxPF6
         x+BDGeJqGDfj6JvFUIwEJxCtm9dL5k1fUMrE/ezjJj3xo8YBTebkKFsYZYLGphk7Tg5h
         Ig9g==
X-Gm-Message-State: AFqh2kqtKcEqjJOkJPWcMSoLkeQxmBLuq0iOfm32TJMMmDQ1ZDdGDLeR
        G2JOy7ktYgOnmM5pTdRidz5Kv4IG0IJK06o3nCk=
X-Google-Smtp-Source: AMrXdXvdkC0X15+gNjWIs4uevtutCXYsTvMFQuxtje0h4v/nisC86J1d49XlBttjxY0o7xfX5tTZiwgM3OMpd4lk7/c=
X-Received: by 2002:a2e:9dda:0:b0:28b:6e91:de25 with SMTP id
 x26-20020a2e9dda000000b0028b6e91de25mr768001ljj.204.1674230842957; Fri, 20
 Jan 2023 08:07:22 -0800 (PST)
MIME-Version: 1.0
References: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
In-Reply-To: <001201d92c93$98c8a040$ca59e0c0$@telus.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 20 Jan 2023 17:06:45 +0100
Message-ID: <CA+icZUX-JEPR0obhwNgvRM6u=ifn4KZHaEFVdwRL8WffGe8hAQ@mail.gmail.com>
Subject: Re: [PATCH] selftests: amd-pstate: Don't delete source files via Makefile
To:     Doug Smythies <dsmythies@telus.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Huang Rui <ray.huang@amd.com>, li.meng@amd.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2023 at 6:54 AM Doug Smythies <dsmythies@telus.net> wrote:
>
> Revert the portion of a recent Makefile change that incorrectly
> deletes source files when doing "make clean".
>
> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>

Hi Doug,

Thanks for the patch!

Small nit, I saw this with:

$ make -C tools/ clean

Otherwise:

Reviewed-by: Sedat Dilek <sedat.dilek@gmail.com>

BR,
-Sedat-

> ---
>  tools/testing/selftests/amd-pstate/Makefile | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/testing/selftests/amd-pstate/Makefile b/tools/testing/selftests/amd-pstate/Makefile
> index 5f195ee756d6..5fd1424db37d 100644
> --- a/tools/testing/selftests/amd-pstate/Makefile
> +++ b/tools/testing/selftests/amd-pstate/Makefile
> @@ -7,11 +7,6 @@ all:
>  uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>
> -ifeq (x86,$(ARCH))
> -TEST_GEN_FILES += ../../../power/x86/amd_pstate_tracer/amd_pstate_trace.py
> -TEST_GEN_FILES += ../../../power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> -endif
> -
>  TEST_PROGS := run.sh
>  TEST_FILES := basic.sh tbench.sh gitsource.sh
>
> --
> 2.25.1
>
>
