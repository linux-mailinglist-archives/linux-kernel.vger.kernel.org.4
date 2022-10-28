Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE986118D2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiJ1RF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiJ1RE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:04:26 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806022EE13;
        Fri, 28 Oct 2022 10:04:01 -0700 (PDT)
Received: by mail-qk1-f182.google.com with SMTP id i10so3671318qkl.12;
        Fri, 28 Oct 2022 10:04:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JElIA9LePDbKf27U3pzxRqWF9A+WS8s4+82DDmZaDeo=;
        b=inMb21mBmr4Jxtt/ZegkkAknNvJgimCQDFS6/UOglO9NYXkIXcRhpVSTM5In/t0GYc
         fyHhQqEpw57JT1ueH/l4EP/Cv9Xi4IuG/9fGL5vy3RDA41B8rYPMbl7/hUvOBC5x4k4a
         PGtzApryszMYqAKEUXdcMpnGOPGqYjrRuDhv9lxKBoOk2BZ8FTvTjbJ2yyrCR8K2+KYC
         1zlRFOyQkI2mjfB0r8hbSqWQckLRstLN72AFUvv3p0P/bxnT1q2Sma7dQAS8HeYqnL8j
         B2o/5LyUm8qBxmS9WRunkSIgmS2H2PM3rOUyQC4D4WaIqU4xe4NSKdhCmnZgjb34eqof
         6iSw==
X-Gm-Message-State: ACrzQf2pm5AUA0PkfyDAP688H+Q6hhmaNPj6ndsiJikwnCH9Jig84W2W
        4Koz8sZ0TXgLvUz2iIVA3A0Lhgm9h49D1wa9E6I=
X-Google-Smtp-Source: AMsMyM7L21SPn8693hFZN1+o5PLPNqWUFkd7F0dX8sLWov8hd745AlOQQdR52EMmJc8TSOKa15IrNul6xe8t4lJkUtU=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr140154qkl.443.1666976640511; Fri, 28 Oct
 2022 10:04:00 -0700 (PDT)
MIME-Version: 1.0
References: <20221024133258.2158083-1-colin.i.king@gmail.com>
In-Reply-To: <20221024133258.2158083-1-colin.i.king@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 19:03:49 +0200
Message-ID: <CAJZ5v0jJPHrfUpY4ZxJYhNR334XZC_iUvetYgRGZW+iLgGrUzg@mail.gmail.com>
Subject: Re: [PATCH] ACPI: processor_throttling: remove variable count
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 3:33 PM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Variable count is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/acpi/processor_throttling.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index a822fe410dda..00d045e5f524 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -50,7 +50,7 @@ static int __acpi_processor_set_throttling(struct acpi_processor *pr,
>
>  static int acpi_processor_update_tsd_coord(void)
>  {
> -       int count, count_target;
> +       int count_target;
>         int retval = 0;
>         unsigned int i, j;
>         cpumask_var_t covered_cpus;
> @@ -107,7 +107,6 @@ static int acpi_processor_update_tsd_coord(void)
>
>                 /* Validate the Domain info */
>                 count_target = pdomain->num_processors;
> -               count = 1;
>
>                 for_each_possible_cpu(j) {
>                         if (i == j)
> @@ -140,7 +139,6 @@ static int acpi_processor_update_tsd_coord(void)
>
>                         cpumask_set_cpu(j, covered_cpus);
>                         cpumask_set_cpu(j, pthrottling->shared_cpu_map);
> -                       count++;
>                 }
>                 for_each_possible_cpu(j) {
>                         if (i == j)
> --

Applied as 6.2 material, thanks!
