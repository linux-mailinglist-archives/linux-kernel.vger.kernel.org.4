Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFD962C93B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 20:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiKPTu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 14:50:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiKPTuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 14:50:54 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A5643AC2;
        Wed, 16 Nov 2022 11:50:53 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id jr19so11408281qtb.7;
        Wed, 16 Nov 2022 11:50:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BN5F/4SLMsWjv+SqMlOL2vb1K62iKbshTk4wJRTKB4w=;
        b=KaRNy+FTK13YzDLsfA5pYPI1a2aN6CSlBrS/XRrHwrSJD4DhoSG1XVVxL/38rdnVSj
         8YRCtseQE0WFZ1M5xEYKXOzRI4N2O2HuetXHdNK7HbYsItFS0XUZZ55HVMLqZGW98KQC
         hntaGWxaN00I6KwK31vgcNcTf+FNoXVa/zlFKeLDjDExq2aPpNKhe0MB9Wr4fRiShjX6
         xpZHCRJ5Qn5BGOogKi3U1JaaSwVetpE87CxksX3Z77mIybUpFNc2/wVyq4S7JjiIITkG
         /kpzcDWs8Xo1k33n9Nha3sekNlMACqUnV9U5yq7fef5WX/dwyOp+HFzjgvapShhi9bHB
         838w==
X-Gm-Message-State: ANoB5pmn929xuMgpZmgbbnpuv1Vy02Q6AtgG2L02drVyf12zcknEUdPA
        8oVLnZGVp/jIAoyvoyA4JcC1/t8xtv6kgk4hl+A=
X-Google-Smtp-Source: AA0mqf5DdYqVIQKzGyroYxqt/YMnjdICg0KGWwqFQ9FMq3AQOkcuLpJHYmrtoJMEEiDV53G8U4yyuMX3mH3i7gaYbO0=
X-Received: by 2002:ac8:5198:0:b0:3a5:1e6f:7e05 with SMTP id
 c24-20020ac85198000000b003a51e6f7e05mr22586496qtn.357.1668628252715; Wed, 16
 Nov 2022 11:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20221108170103.3375832-1-nathan@kernel.org> <Y3U7MWezkc8aizuo@dev-arch.thelio-3990X>
In-Reply-To: <Y3U7MWezkc8aizuo@dev-arch.thelio-3990X>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 16 Nov 2022 20:50:41 +0100
Message-ID: <CAJZ5v0iJ0quqN2ErfmPmiN0YRTTfJcC5BiCq+joe_RKBkfYCng@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: ACPI: Remove unused variables
 'acpi_cpufreq_online' and 'ret'
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 8:34 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi all,
>
> Small ping, was there an issue with this change? It seems pretty
> straight forward to me and it is wreaking havoc on our build matrix due
> to -Werror.

Applied now, thanks!

> On Tue, Nov 08, 2022 at 10:01:03AM -0700, Nathan Chancellor wrote:
> > Clang warns:
> >
> >   drivers/cpufreq/acpi-cpufreq.c:970:24: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
> >           acpi_cpufreq_online = ret;
> >                                 ^~~
> >   drivers/cpufreq/acpi-cpufreq.c:960:9: note: initialize the variable 'ret' to silence this warning
> >           int ret;
> >                 ^
> >                   = 0
> >   1 error generated.
> >
> > Both ret and acpi_cpufreq_online are now unused so they can be safely
> > removed, clearing up the warning.
> >
> > Fixes: 13fdbc8b8da6 ("cpufreq: ACPI: Defer setting boost MSRs")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1757
> > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  drivers/cpufreq/acpi-cpufreq.c | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> > index c8fdfcf659e6..74ef0e05ff7b 100644
> > --- a/drivers/cpufreq/acpi-cpufreq.c
> > +++ b/drivers/cpufreq/acpi-cpufreq.c
> > @@ -953,12 +953,8 @@ static struct cpufreq_driver acpi_cpufreq_driver = {
> >       .attr           = acpi_cpufreq_attr,
> >  };
> >
> > -static enum cpuhp_state acpi_cpufreq_online;
> > -
> >  static void __init acpi_cpufreq_boost_init(void)
> >  {
> > -     int ret;
> > -
> >       if (!(boot_cpu_has(X86_FEATURE_CPB) || boot_cpu_has(X86_FEATURE_IDA))) {
> >               pr_debug("Boost capabilities not present in the processor\n");
> >               return;
> > @@ -966,8 +962,6 @@ static void __init acpi_cpufreq_boost_init(void)
> >
> >       acpi_cpufreq_driver.set_boost = set_boost;
> >       acpi_cpufreq_driver.boost_enabled = boost_state(0);
> > -
> > -     acpi_cpufreq_online = ret;
> >  }
> >
> >  static int __init acpi_cpufreq_init(void)
> >
> > base-commit: 21cdb6c18f85fe538ca8740bc79f11fbe08d0197
> > --
> > 2.38.1
> >
