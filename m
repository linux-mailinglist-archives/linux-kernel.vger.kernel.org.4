Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676DF6F8492
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbjEEONF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 5 May 2023 10:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbjEEOND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:13:03 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0B81156D;
        Fri,  5 May 2023 07:13:02 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-50bc2807bfdso481512a12.0;
        Fri, 05 May 2023 07:13:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295981; x=1685887981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COt8eLF+9whaNTsfWLZgTR7V8EAHqmVDFLI+sXLZ3Hs=;
        b=NxI2M5MWW/M3T3pjbpyio1T+BTXXsmVqpGTMKqAB9pnHduWM8iUl5KLWn6R4cjtquu
         xnnNnkVkDkJnRPuwvR39SgHTpNQKecOBrCR2oNd3qbExfuNWKEwYAjkHL2bQFFSA5qXf
         CuoFFaP5CU5v+NtEgQdyUF++Mtgt8eIG4pnUrancsFlji/2nv1k58TLyefK1+SzafFDB
         Qe/TBVBXieiIEmda6BVNb7bjJmR11e4EX95CsgJ1NW80slvSdbfoGdetLsfeocKh2yHk
         xJzOMpi+9E4cuj5hNwwL8LBienUGGqZs5nS2ey4FyZQ/FDinbRDmREwV6R8Wj0am1z8f
         2bYA==
X-Gm-Message-State: AC+VfDxY695uPgnUorNR566a9y94GbttEK10MVOmwOSfRaZulBozX8RI
        lrCjXFKcmGzyHsz3Rcxjcg4vzCaG3XtDouCf7Aw=
X-Google-Smtp-Source: ACHHUZ5ALIRIIvSP+g0GXfwXKBdEwDyf5getvNIifhn3lcQA0HLsNw7t746ZRw5+H177fpWKcyhoU71rkQIylvg8EuE=
X-Received: by 2002:a17:906:1045:b0:929:b101:937d with SMTP id
 j5-20020a170906104500b00929b101937dmr1260671ejj.1.1683295980463; Fri, 05 May
 2023 07:13:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230505043605.22272-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230505043605.22272-1-lukas.bulwahn@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 May 2023 16:12:48 +0200
Message-ID: <CAJZ5v0jM6bquTeF6L7L6yPD0=LU9xnJoLVNPxYj8XvGM2AeB+A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: remove section INTEL MENLOW THERMAL DRIVER
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 6:36 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Commit 2b6a7409ac39 ("thermal: intel: menlow: Get rid of this driver")
> removes the driver drivers/thermal/intel/intel_menlow.c, but misses to
> remove its reference in MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
>
> Remove the INTEL MENLOW THERMAL DRIVER section in MAINTAINERS.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  MAINTAINERS | 6 ------
>  1 file changed, 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 39a00522ca37..08b37d967cc9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10564,12 +10564,6 @@ F:     drivers/hwmon/intel-m10-bmc-hwmon.c
>  F:     drivers/mfd/intel-m10-bmc*
>  F:     include/linux/mfd/intel-m10-bmc.h
>
> -INTEL MENLOW THERMAL DRIVER
> -M:     Sujith Thomas <sujith.thomas@intel.com>
> -L:     linux-pm@vger.kernel.org
> -S:     Supported
> -F:     drivers/thermal/intel/intel_menlow.c
> -
>  INTEL P-Unit IPC DRIVER
>  M:     Zha Qipeng <qipeng.zha@intel.com>
>  L:     platform-driver-x86@vger.kernel.org
> --

Applied as 6.4-rc material, thanks!
