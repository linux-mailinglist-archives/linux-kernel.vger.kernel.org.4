Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADED36C54B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 20:16:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCVTQl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 22 Mar 2023 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjCVTQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 15:16:38 -0400
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCEE61320;
        Wed, 22 Mar 2023 12:16:35 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id ek18so77262549edb.6;
        Wed, 22 Mar 2023 12:16:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679512594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzwFY37hLcbFrp/171eLlZheyW72j6O2ewbOp7Pv5N4=;
        b=F2Fnp95GRCish/MkF3fuXKejpIWk1BzlX84r52xAOYX/ucwCC2crOR49Vv/WcEecK5
         azFXfgyZnJiScNtTyECM6v43RRL/w7ICndoLea7w/5SuAAgN8j2flL79dVR3oxvstV+K
         ssy+21PggrlZRgZlRio0kzlRz3AcMa24ctlwEPGuTxkX2rmEoiia4Ki4xwAAMQTPcpa7
         uhVxWVpJJlwY/OfJKacBnKTt5znm65g/DEMvjLT8iA2gEglQaRWx2LV5n5xGyaohZKUs
         hSikRjCbwlkHOLkePtscMDuElU+hFu8H7gBP/94WdkQUD56B39Zo7pjojaHLtYNlLkvL
         JjEQ==
X-Gm-Message-State: AO0yUKVThmTA4M+L4PQ8dy8e1MFnynadbIGdsTBTs8lvjoNB4tEmzCUe
        qZnlyJGAeFf7xXkaBeFvZYL97RSDokE1ButDZkwNSlTC
X-Google-Smtp-Source: AK7set8zLikabLWIv5bjuJ/++HNk28bJ+CiLNXX7FIk6lb/GSxlaB3sBkFq4z9Qp96SExJ3kx4JRHGgxtJbq6JjGhRA=
X-Received: by 2002:a17:906:614a:b0:8d7:edbc:a7b6 with SMTP id
 p10-20020a170906614a00b008d7edbca7b6mr1818011ejl.2.1679512593795; Wed, 22 Mar
 2023 12:16:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230308122830.166728-1-jingyuwang_vip@163.com>
In-Reply-To: <20230308122830.166728-1-jingyuwang_vip@163.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 22 Mar 2023 20:16:22 +0100
Message-ID: <CAJZ5v0jfWoWvvUk6h-L0h5FRL8EdBmiHKFEmfgd3HOOj=PjrKQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: fix repeated words in comments
To:     Jingyu Wang <jingyuwang_vip@163.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 1:30 PM Jingyu Wang <jingyuwang_vip@163.com> wrote:
>
> Delete the redundant word 'to'.
>
> Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
> ---
>  drivers/cpufreq/Kconfig.arm | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
> index 97acaa2136fd..123b4bbfcfee 100644
> --- a/drivers/cpufreq/Kconfig.arm
> +++ b/drivers/cpufreq/Kconfig.arm
> @@ -95,7 +95,7 @@ config ARM_BRCMSTB_AVS_CPUFREQ
>         help
>           Some Broadcom STB SoCs use a co-processor running proprietary firmware
>           ("AVS") to handle voltage and frequency scaling. This driver provides
> -         a standard CPUfreq interface to to the firmware.
> +         a standard CPUfreq interface to the firmware.
>
>           Say Y, if you have a Broadcom SoC with AVS support for DFS or DVFS.
>
> --

Applied as 6.4 material under a modified subject and with some edits
in the changelog.

Thanks!
