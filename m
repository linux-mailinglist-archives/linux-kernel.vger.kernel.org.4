Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70ADA74DC42
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjGJRWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjGJRWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:22:11 -0400
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B20128
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:22:08 -0700 (PDT)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-5634db21a78so3374406eaf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689009728; x=1691601728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2URZjHoSzSdFZGhiJ/VRg5MQG2hq7x25wO7hMvPNMM=;
        b=c1SAQjQCpoHXWp5nZdwWBuFYj+dfYWIQZ4DTW397XSdxmeJztJjOJD/zhRL3+fKhmU
         jlMElbbizYtyN7AOXhiQPQ2UWMLebWkNr48afVJoWlDcTPHV1lUyw8HIUDW49VnmpzNZ
         E579nGpBsdIsmT3uvpXshkE60VMBCPepIbsGA8MyqHnCX9GX2ZT6C9MVx2Wzsz+1SL96
         I3PAXdK/OB0rFG0v9M0kLUAPC5zRawGIINBeCBn+hSoqJywGwMtB3M+psItoynLsmGs9
         KzFZ60m0o7jPjVtPm50kf0u1daNpKSuDNJML0PWk7UO2y4ZRQaY41ivNujcHmsz6ZM1D
         2ZcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689009728; x=1691601728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2URZjHoSzSdFZGhiJ/VRg5MQG2hq7x25wO7hMvPNMM=;
        b=EtLdpF4dzy8QDzfoKq9MJOJQ8+ceqDPf1aiS9p8SeUYOIvSTAtoI9XhReX/di8nj6a
         I6cXoQGD7SomY5CF9ZJX1+wdtR3/sKt1JDGODx1N+ml3fm68M/+PaS93pn0Q6SYSmLtW
         xCUdgD9XKRUhNArKpquaD5k0poPiJBWJ1OS6c62TlOa3CihnA7Zr1FOAYkQvrTulzPgy
         hCZYQ+j7NuxPukcL1OUyevPrHEIZhKyQoKhr/KI/dOzxsO1jV9be7ZK+lLoFWC9yQ15s
         aZPEiX+vl2iCt1dI3tAj4deeMYWz3otHCRdVMg1GCmhjvjf36d2dRvLeAuxkcdqbOdXm
         nctg==
X-Gm-Message-State: ABy/qLZoqnRVhLeeiX+ppPbDX145dlhuJ8eLL5k71P5C/Ttl8MB6DbVz
        HE5Q/19FRQEYQcIaA3LhJNIWakkAUEf4CutP3uTtnmav
X-Google-Smtp-Source: APBJJlGRNm/9SaOFBDmmcSSOrC76TrdQEZJHDGjiF19hRgY5GQuIkZPqthqMvq+sqpBGG8TAM6ol9kfvIYhDP0o1W6M=
X-Received: by 2002:a4a:d649:0:b0:565:86fa:5de6 with SMTP id
 y9-20020a4ad649000000b0056586fa5de6mr9890899oos.9.1689009727950; Mon, 10 Jul
 2023 10:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230710074943.54300-1-xujianghui@cdjrlc.com> <21106d58871949c9f301c1bab81ae111@208suo.com>
In-Reply-To: <21106d58871949c9f301c1bab81ae111@208suo.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 10 Jul 2023 13:21:57 -0400
Message-ID: <CADnq5_NMTbJkCyttYCqrYVbaz2qXveHEk4JQiAaFaV73VP2FFw@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: ERROR: "(foo*)" should be "(foo *)"
To:     sunran001@208suo.com
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied.  Thanks!

Alex

On Mon, Jul 10, 2023 at 3:52=E2=80=AFAM <sunran001@208suo.com> wrote:
>
> Fix four occurrences of the checkpatch.pl error:
> ERROR: "(foo*)" should be "(foo *)"
>
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>   drivers/gpu/drm/radeon/radeon_test.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_test.c
> b/drivers/gpu/drm/radeon/radeon_test.c
> index a5e1d2139e80..c9fef9b61ced 100644
> --- a/drivers/gpu/drm/radeon/radeon_test.c
> +++ b/drivers/gpu/drm/radeon/radeon_test.c
> @@ -156,10 +156,10 @@ static void radeon_do_test_moves(struct
> radeon_device *rdev, int flag)
>                         i, *vram_start, gtt_start,
>                         (unsigned long long)
>                         (gtt_addr - rdev->mc.gtt_start +
> -                       (void*)gtt_start - gtt_map),
> +                       (void *)gtt_start - gtt_map),
>                         (unsigned long long)
>                         (vram_addr - rdev->mc.vram_start +
> -                       (void*)gtt_start - gtt_map));
> +                       (void *)gtt_start - gtt_map));
>                   radeon_bo_kunmap(vram_obj);
>                   goto out_lclean_unpin;
>               }
> @@ -207,10 +207,10 @@ static void radeon_do_test_moves(struct
> radeon_device *rdev, int flag)
>                         i, *gtt_start, vram_start,
>                         (unsigned long long)
>                         (vram_addr - rdev->mc.vram_start +
> -                       (void*)vram_start - vram_map),
> +                       (void *)vram_start - vram_map),
>                         (unsigned long long)
>                         (gtt_addr - rdev->mc.gtt_start +
> -                       (void*)vram_start - vram_map));
> +                       (void *)vram_start - vram_map));
>                   radeon_bo_kunmap(gtt_obj[i]);
>                   goto out_lclean_unpin;
>               }
