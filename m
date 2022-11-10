Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51B4624D6C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKJWFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKJWFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:05:14 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C986219
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:05:14 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id m6-20020a17090a5a4600b00212f8dffec9so3124393pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a34ppdWbivNAxs0hZgRllXVIJs8hvYA2VZe5Kyhs1OM=;
        b=P6vqEdFmeiejzHVbCjsfMpsQ29zuzTvwlvxMocFOI12tWCjBgBJRuRlA+3jh1ZXKMJ
         pKwCFuHwJg0GAlwoZUSh+uPcDwx6PD7PMLM78itRlOqjv9aJ6DEiluMK2qYiBzIXn4ff
         hPrcfEgTfO6Vnm2bGWzIyCbABoCOD/OOkD0GKHd8QfQaiX2UXizd45S+gUzReYaIso5K
         +6EFD/K2fB668OQhEkpkTtm8DdTAcVBLQxxxLCfPnFsQ9BpxubAIuD9RGxjUG96z2hvs
         C1sBF2PRjlxLQuF8ilQGh7Z8EhhwqXBhoEY5b76cHp7gHNRdprJR//0/dKheg/k4/s7U
         AYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a34ppdWbivNAxs0hZgRllXVIJs8hvYA2VZe5Kyhs1OM=;
        b=ET3LFp/it4gu7f00CrmaUF3l8RtrQnAOXR9bZzBsk1pIgo2zSITcGZpwYc6sZnhZXM
         CPsxIzKN0zn8QIyV3fnAtYGJBFwXxtYtRVtFupaStp+WYRvG1JUw+h+ekYcCUrsz6Kwb
         PFgfC4VwSp3HQy6C+dI6bQBJ16VkP2xq9vL6Kb61ZFbgVCm7Ew+6gOtm81VtCAZoKE/E
         Cd0rhqjo87CNi8HUdczPLY97/Y1+2q6xNIPRZ/KnXCFBOIfiV7d3zFJh5BgX7kifGg6j
         fvkxCCodONDieJkAe1x5FeUUtGqXf4dr9JAyH2xLfwCK38ZBFN6ApY/hdE3zonS7ExFx
         3DJQ==
X-Gm-Message-State: ACrzQf1djPxEcaUGH+mVEAPNdi+ghilvZNr4sE5iO1WjIiEb4eIk7QRg
        wVReLR3BBkmT/CeZ9EinVWwk44Tt/cjmaGtLqzH7pA==
X-Google-Smtp-Source: AMsMyM5GZRwbXU2IPHXYp9E6tIoCnNMxsz/56yVCJT0f0ThtNxVVkvDuqpCVob8hLMLuQlSbW/bMatrnBQRCNPQoQx4=
X-Received: by 2002:a17:902:7b98:b0:186:8558:ded2 with SMTP id
 w24-20020a1709027b9800b001868558ded2mr2238985pll.95.1668117913389; Thu, 10
 Nov 2022 14:05:13 -0800 (PST)
MIME-Version: 1.0
References: <20221108170103.3375832-1-nathan@kernel.org>
In-Reply-To: <20221108170103.3375832-1-nathan@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Nov 2022 14:05:01 -0800
Message-ID: <CAKwvOdkzs3YrtE9MWMOF=ssxx_9gdXWak06OEcJhHr5z+j0mqg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: ACPI: Remove unused variables
 'acpi_cpufreq_online' and 'ret'
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Tue, Nov 8, 2022 at 9:01 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Clang warns:
>
>   drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>           acpi_cpufreq_online = ret;
>                                 ^~~
>   drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable 'ret' to silence this warning
>           int ret;
>                 ^
>                   = 0
>   1 error generated.
>
> Both ret and acpi_cpufreq_online are now unused so they can be safely
> removed, clearing up the warning.
>
> Fixes: 13fdbc8b8da6 ("cpufreq: ACPI: Defer setting boost MSRs")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1757
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  drivers/cpufreq/acpi-cpufreq.c | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index c8fdfcf659e6..74ef0e05ff7b 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -953,12 +953,8 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
>         .attr           = acpi_cpufreq_attr,
>  };
>
> -static enum cpuhp_state acpi_cpufreq_online;
> -
>  static void __init acpi_cpufreq_boost_init(void)
>  {
> -       int ret;
> -
>         if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
>                 pr_debug("Boost capabilities not present in the processor\n");
>                 return;
> @@ -966,8 +962,6 @@ static void __init acpi_cpufreq_boost_init(void)
>
>         acpi_cpufreq_driver.set_boost = set_boost;
>         acpi_cpufreq_driver.boost_enabled = boost_state(0);
> -
> -       acpi_cpufreq_online = ret;
>  }
>
>  static int __init acpi_cpufreq_init(void)
>
> base-commit: 21cdb6c18f85fe538ca8740bc79f11fbe08d0197
> --
> 2.38.1
>


-- 
Thanks,
~Nick Desaulniers
