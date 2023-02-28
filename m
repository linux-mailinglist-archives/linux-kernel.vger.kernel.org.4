Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0515D6A6064
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbjB1Uah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1Uaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:30:35 -0500
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D763332E64;
        Tue, 28 Feb 2023 12:30:34 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id ee7so45331293edb.2;
        Tue, 28 Feb 2023 12:30:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677616233;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TO0UqDEdNc0UYMM3lLiT6qUY68t+NUFmoAALBWAzxLs=;
        b=yop9XxhN1SUB9UIM4pC3d17b4S3h/Pc14p8LtwErzBxAfrHbQ7kZyEPZZ1QHdwymq9
         8B4Muss58ux4Bs0xTvzD2zr7Op4m3la3qrFtMnSJDyxxuaSD7IZ2xfb4DGZjTDW6zK+D
         7V1mddwRIzUGBTP+Nrb71XnaRR0TUQsk/icK4wg4KZDaAlCbonWvfTm2S4qd2afAbs7a
         K8wGmAjGT0K/3XAwppKSvXftoycK5sJHw1yYYYPPx2TRZtLnV5qb2H5rUzHqW/OGfksQ
         lMZMtzZqcVD4CY9OqLVHZ448Z6mxuCGQn1Uwvl36cIo+w5mxpgZBCiMX4H+YsJvcfeLs
         07Vw==
X-Gm-Message-State: AO0yUKXc+lcXqVBhxP3pU7CCR53uAw6H4qofI1r/zPfJcnLWO/ZxvsFr
        1+HXnx3UZsgOZOcViLkEvlHQLYI0A0ZKLy9Be4A=
X-Google-Smtp-Source: AK7set8zuZrvSq++2p4EHSf4m6hn99SNIS9+wXIMduUvr3S/WvcjLtx9vAl4VRYq6tyNYFhcYQZQefDKuVc6ifuS/0g=
X-Received: by 2002:a50:c007:0:b0:4ab:4933:225b with SMTP id
 r7-20020a50c007000000b004ab4933225bmr2478922edb.6.1677616233240; Tue, 28 Feb
 2023 12:30:33 -0800 (PST)
MIME-Version: 1.0
References: <20230224150811.80316-1-nick.alcock@oracle.com> <20230224150811.80316-6-nick.alcock@oracle.com>
In-Reply-To: <20230224150811.80316-6-nick.alcock@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Feb 2023 21:30:21 +0100
Message-ID: <CAJZ5v0gTmjUsZ_cLdmOm473V8Jn7EaMNy-1Z8_JQK9S1NUVsMQ@mail.gmail.com>
Subject: Re: [PATCH 05/27] cpufreq: intel_pstate: remove MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 4:09 PM Nick Alcock <nick.alcock@oracle.com> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/cpufreq/intel_pstate.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index fd73d6d2b808..0f3e1a1aab4c 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -3530,4 +3530,3 @@ early_param("intel_pstate", intel_pstate_setup);
>
>  MODULE_AUTHOR("Dirk Brandewie <dirk.j.brandewie@intel.com>");
>  MODULE_DESCRIPTION("'intel_pstate' - P state driver Intel Core processors");
> -MODULE_LICENSE("GPL");
> --

Applied as 6.3-rc material, thanks!
