Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7155B40DA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 22:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiIIUoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 16:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIIUoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 16:44:02 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C05133A34
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 13:44:01 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-127f5411b9cso7000090fac.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 13:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=GUxuNPeeQ+ibx1PJlSAFNGg7X0SdVaxQlF5DdweLpFo=;
        b=naVN2k5ytQZbAozlRF5lg+T98ZF+pQ/UbExkYjhh+GQAhysuPXJt6IjV04Wh+pNoj5
         PxaxoRjavVSCDvVfUy1K+6E7hXwCIJC+5ORqXbWgZkMUnHnUaSexE9p92hJdzNvWLHuo
         Bnk1j0IMwblRGXgIklxYDYb+ZN6wr/WbLqVxkqhJeiM8SUHVLJ+vXxPoURYosE3VFLcT
         1p2i5DgtYwBXk1iJ+ZTNd38PGyL/qdfx0gkeKmVzFJ+8KtFddSeoaHn6H06BqBrE1uOH
         6jEJBDcijgys4ABVkyfy6gOpiohG0fUkHFl9hRyckFEsJGYcuVy47LJpBvzVEUFlbr43
         MDeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=GUxuNPeeQ+ibx1PJlSAFNGg7X0SdVaxQlF5DdweLpFo=;
        b=N0c2ip6pTm5LxxhyQmqhPWHSJl7AiTnVvYpkJxrA7QM74CsqLV4EPkkjdbrKWyaj2R
         E9nVyDwNO7jj8Nc2OqIabMMC48qvCWS5ZmuDffO7wbC/6WQn15uIC6oaKfy2yMtotQk6
         elpc2xM6RbNEYQnounavfm1MGOMkBoVo3ou6yY23GCNmzb6FdAqbJSzK5Bn/F0PV0BPM
         PaSXhERHtMOj/07fDl8aI9R4QpZ3sfksvNAlpx4d9y/x7t7I3MwrrlijzqAbs4DTcHfS
         zSo4bfyznABS0ENrI2SDNuoRsfWf1Ox9gVHlWJnJJ0EVzNY2Ug6za1wCVzjewOqslt0K
         6NCQ==
X-Gm-Message-State: ACgBeo0kIxLmh+wqNbMnZMmjqM8inODPsIB6EUCyWh7J5atMxbQXhwal
        SHQdSipYVOqalkS6eofHRVhXD3UkeFY+sO2J4iM=
X-Google-Smtp-Source: AA6agR6L8wg9JJlb/kbQdMVmMf2Zk5IuD8ksk64/jtGU/IRX+6msTqj+PAoa0oPXjmLJUL6EDBaI3SlqzBqOJYptMbo=
X-Received: by 2002:a05:6808:2187:b0:344:eccd:3fc5 with SMTP id
 be7-20020a056808218700b00344eccd3fc5mr4800902oib.46.1662756240547; Fri, 09
 Sep 2022 13:44:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220901083438.105561-1-yang.lee@linux.alibaba.com>
In-Reply-To: <20220901083438.105561-1-yang.lee@linux.alibaba.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 9 Sep 2022 16:43:49 -0400
Message-ID: <CADnq5_NAWok8spV=A6JKoRL+Cz3ACTtp8HGt5OA_c16zDOQr1A@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove possible condition with no
 effect (if == else)
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     alexander.deucher@amd.com, sunpeng.li@amd.com,
        Abaci Robot <abaci@linux.alibaba.com>, Xinhui.Pan@amd.com,
        Rodrigo.Siqueira@amd.com, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Thu, Sep 1, 2022 at 4:34 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>
> Conditional statements have no effect to next process.So remove it.
>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2028
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  .../drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c   | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> index e4fd540dec0f..8f1c0e12dd86 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
> @@ -4663,10 +4663,6 @@ void dml32_CalculateMinAndMaxPrefetchMode(
>         } else if (AllowForPStateChangeOrStutterInVBlankFinal == dm_prefetch_support_uclk_fclk_and_stutter) {
>                 *MinPrefetchMode = 0;
>                 *MaxPrefetchMode = 0;
> -       } else if (AllowForPStateChangeOrStutterInVBlankFinal ==
> -                       dm_prefetch_support_uclk_fclk_and_stutter_if_possible) {
> -               *MinPrefetchMode = 0;
> -               *MaxPrefetchMode = 3;
>         } else {
>                 *MinPrefetchMode = 0;
>                 *MaxPrefetchMode = 3;
> --
> 2.20.1.7.g153144c
>
