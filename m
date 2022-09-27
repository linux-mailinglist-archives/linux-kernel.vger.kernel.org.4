Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8225EC25A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbiI0MSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiI0MRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:17:55 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94D2E3EC3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:17:51 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k3-20020a05600c1c8300b003b4fa1a85f8so5321442wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 05:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4ogea3WbGQNROO4GDudodaBubNp8zU7tRTzmzFeN2aU=;
        b=BxOOwgm/6Ld837iwwpgNIpstKEV1EyVj2cWg2z0mhC008QSmLdSZLa11UaSDLUK7uY
         l9V5kh/sxdx7um6yUGrf7kDbEeNlFugibX2fKs7b6LfWuunuUMazDIrCiJA+szeaHIh3
         W4F/5XmrkStgyv+G/3C307l5tv67j0FSfolgPs+iSqfUnfRpJu60B8LVZz75ULDBdaDH
         iQrInFwRH0KnKqr149qQK3Vt0yiEkOV2bvI8sbxSTos46UR2aIFVsYNd6HfRJ91lZk0A
         5pkdtkFciS4zeU+gSMwzD+A1CLvwH/3ZIe8L5TKvJ8BAG+2w6cVDbI+ah1wILoFOv+1d
         +5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4ogea3WbGQNROO4GDudodaBubNp8zU7tRTzmzFeN2aU=;
        b=M0GWwCB+zlsVs5CTTkXA6ILE81QeZQey25+6je7lNkHPNCd3039FsOc8iiFMBJd8/W
         vxKdTABRHiMqMWP2e1e23qvP21FNhaQvfJIJQSVEtxoOCVQhYYJ28MoVSY1Le2Y7p3/b
         shnsI9HF+LkMCkSw81vt7AaTAZV39WZVOVavQnyP/4j+/mL0sS2tzRbSGRXrR3SCLDIJ
         RY5H/ojMf2OHfyK+dm3D30nS6s91cpav7YD41MsZ/woWDjhMLCgFQyFWslPMB5IyiD6/
         Xm1hPRfgf88A/mJnUuF6YkdAOemRFuDSK3Vn8NmaJgt+tiTfIvkjapTAKLi2J5/OV/WJ
         1jog==
X-Gm-Message-State: ACrzQf2/nGhG3abMMFf1w1hbB10VjUvo74D4dabGE1RyUg6RgNuCLPj2
        EIPGdIEjkgx0TiRMgI5x9DGUWT9C3dM+Q/LqPRORGw==
X-Google-Smtp-Source: AMsMyM7mHbYck+RPBQ6Ixg32GjtTNI8+8lcZHHGwbNFHcvsLDzau4CgxByHm3tP86XCjR9yHdJzd4Wf3xIEqGSvIZeY=
X-Received: by 2002:a1c:f311:0:b0:3b5:18ca:fc5e with SMTP id
 q17-20020a1cf311000000b003b518cafc5emr2457169wmq.70.1664281069784; Tue, 27
 Sep 2022 05:17:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220927084317.138-1-avri.altman@wdc.com>
In-Reply-To: <20220927084317.138-1-avri.altman@wdc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Sep 2022 14:17:13 +0200
Message-ID: <CAPDyKFpbMQOhANrKR9wkn=Z=KnjodCPpQm4AnTH47T=r8qPuQA@mail.gmail.com>
Subject: Re: [PATCH] mmc-utils: Fix a typo for ATP mid
To:     Avri Altman <avri.altman@wdc.com>
Cc:     linux-mmc@vger.kernel.org, Mark Kanczak <Markk@us.atpinc.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sept 2022 at 10:43, Avri Altman <avri.altman@wdc.com> wrote:
>
> Manufacturer id 0x44 is assign to ATP by 3c-LLC, and not to SanDisk.
> mmc-utils inherited this typo when lsmmc got merged into it.
>
> fixes: 4af1749d2350 (mmc-utils: Merge the lsmmc tool into mmc-utils)
>
> Reported-by: Mark Kanczak <Markk@us.atpinc.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
>  lsmmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lsmmc.c b/lsmmc.c
> index 05d59e8..55da3aa 100644
> --- a/lsmmc.c
> +++ b/lsmmc.c
> @@ -237,7 +237,7 @@ struct ids_database database[] = {
>         {
>                 .type = "mmc",
>                 .id = 0x44,
> -               .manufacturer = "SanDisk",
> +               .manufacturer = "ATP",
>         },
>         {
>                 .type = "mmc",
> --
> 2.17.1
>
