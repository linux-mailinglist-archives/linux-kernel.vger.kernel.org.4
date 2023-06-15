Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ACF731F15
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234582AbjFORbo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Jun 2023 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233801AbjFORbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:31:42 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6ABAC;
        Thu, 15 Jun 2023 10:31:41 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-98273ae42d0so57085866b.0;
        Thu, 15 Jun 2023 10:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686850300; x=1689442300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/sM9ZKm/nCF0lklmf7m/glMFLEBBKkwZOUnhWahQng=;
        b=ZcH9gBAG1hwg9GZTic3ULAexuFQ4oT8P7PnH/iaJQ8OjgrkDOXKCr5tUmYzBTdhtlX
         SZULnf8vZnrcMesc3fT7xiPPoJtKSPbuaV/+20REf3QtQDQSwCNMjho7IhSyBY7DMb90
         MMeFsBrRCyqHmdx7SCRTlsm8sLVsziDdV1Lx8WxPRhfhS2Yzed4/SESUOEaesZjhTg+c
         aeUjHVVnq6IxsyTBGGl+sn8a5DYjxRQZf3onpDkrW5S9MUha01DBxN5fsp/i+pepmVsH
         9Y58kMsG6btwz8OT24eT44j0ADROd2wrssblU9utOkeXTp09qUEkmDOMhH9krgrvmM75
         yDOQ==
X-Gm-Message-State: AC+VfDwpIzrpITPWBRCGjKewFckSQWL7zZOcSsn8lnllQzE+I918snNL
        Fe5rEw8Gb3+nfp51Bcfi4j64KKxHf8ByDtraYlM=
X-Google-Smtp-Source: ACHHUZ6adQi8fGgJOzHknwPKsDDZSenpotWOuhMkM7ceH6A7bDrFr0ABlMEtuwlurHkAZ1mOwDhNPv/jd3otEPYL2AE=
X-Received: by 2002:a17:906:5185:b0:976:50a4:ac40 with SMTP id
 y5-20020a170906518500b0097650a4ac40mr14038604ejk.0.1686850299719; Thu, 15 Jun
 2023 10:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230612113615.205353-1-wyes.karny@amd.com> <20230612113615.205353-2-wyes.karny@amd.com>
In-Reply-To: <20230612113615.205353-2-wyes.karny@amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 15 Jun 2023 19:31:28 +0200
Message-ID: <CAJZ5v0gfqGj9X=3bdf6X4HqQDxg+gCJN10DXLruYD5p3kZ59Uw@mail.gmail.com>
Subject: Re: [PATCH 1/6] amd-pstate: Make amd-pstate epp driver name hyphenated
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     rafael@kernel.org, ray.huang@amd.com, viresh.kumar@linaro.org,
        trenn@suse.com, shuah@kernel.org, gautham.shenoy@amd.com,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 1:37 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> amd-pstate passive mode driver is hyphenated. So make amd-pstate active
> mode driver consistent with that rename "amd_pstate_epp" to
> "amd-pstate-epp".
>
> Cc: stable@vger.kernel.org
> Fixes: ffa5096a7c33 ("cpufreq: amd-pstate: implement Pstate EPP support for the AMD processors")
> Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
> Signed-off-by: Wyes Karny <wyes.karny@amd.com>

How much does the rest of the series depend on this patch?

I can apply it right away and push it out to a forward-only branch if
that helps.

> ---
>  drivers/cpufreq/amd-pstate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
> index ddd346a239e0..a5764946434c 100644
> --- a/drivers/cpufreq/amd-pstate.c
> +++ b/drivers/cpufreq/amd-pstate.c
> @@ -1356,7 +1356,7 @@ static struct cpufreq_driver amd_pstate_epp_driver = {
>         .online         = amd_pstate_epp_cpu_online,
>         .suspend        = amd_pstate_epp_suspend,
>         .resume         = amd_pstate_epp_resume,
> -       .name           = "amd_pstate_epp",
> +       .name           = "amd-pstate-epp",
>         .attr           = amd_pstate_epp_attr,
>  };
>
> --
> 2.34.1
>
