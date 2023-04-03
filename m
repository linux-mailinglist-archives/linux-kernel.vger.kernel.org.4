Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475A66D3F72
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjDCIvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjDCIvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:51:40 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2653AB2;
        Mon,  3 Apr 2023 01:51:39 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id m5so20276578uae.11;
        Mon, 03 Apr 2023 01:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680511899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FymDryzt1xBzbE+SpKvnTozEFbclbNgIFpbMS++SyVU=;
        b=WQLhONVAXpN5OHyuTesxZLQCVH84lLcS8R//4zp4N5W1jHxF5GlEOMu++thn0Z8osa
         wse+65L8OESh9bizgwSYVrNCi5XOk2wqGxaeu9Jxmgn9TswzAZPTyxn8SbhIhHNbLlwk
         giSe4Ewsddb2G9rIwlLNlJdMjHjB19E39XCmz6rhVoPMVxtkOKu0NmFmvPeczy7Lmq/+
         Ne6t3WZ+wZXYABufxAHZokA+Q9B2D8HCKfkyK+yTg4Sa5g5/DiZnb7eYyOKjkmS56/BD
         13NPRof6md+4O6dicSgoOh5+j6l/+pCyvlFC5fZ2DLSyGJjreVZCYeHqHgz1x/zNg8lH
         0BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680511899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FymDryzt1xBzbE+SpKvnTozEFbclbNgIFpbMS++SyVU=;
        b=Hjx5KhezhMm0BT3/r1LXb1qyNPu6+boXvynn1o560iA7QVj+FBn0B3gZZqjWxqoNu/
         L/W0hBdtYDN8KxMiPV1lQy2GPsAF4QOxesM0HHC5VYQVQxIwodMroIvdWoAa5iV9HQmu
         hALKT/oWDwJB9ANiFqj58jwPiTTdIuAPUynKiG8OCnLz1ETbRNd3hsweT5cwV6+i251W
         w7Wpj1e153GlMkQ/qT641G+gBkMlPO30SDi+MuCsjgbYLd15IsMo/e1UD7eFSVf5KNrl
         rW2hax6p+c4xD02z62fHowQpPeEn+W6xGrSpZyoFOuiqKr0U+l35A0pjahWXVJ5wcK0h
         aTnA==
X-Gm-Message-State: AAQBX9crVi7l5+mLaawslpggxErt99Qt2912gHz0UcqWszmhsCfXNRnS
        pqJNe+CxA4tj38poVQJ6Dddo97yuQTfZDb6IpXk=
X-Google-Smtp-Source: AKy350b4qh7ooTYUZmD0lqPsElUdZR/+GMJIQH4u47foRbem0nU3YeXjFhuoxUqXFrG8UrY6FG7/2VR2qiQ4iBbIXAk=
X-Received: by 2002:a1f:a8d4:0:b0:43c:6ef1:7200 with SMTP id
 r203-20020a1fa8d4000000b0043c6ef17200mr1391338vke.3.1680511898929; Mon, 03
 Apr 2023 01:51:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230403121617.61e2a929@canb.auug.org.au>
In-Reply-To: <20230403121617.61e2a929@canb.auug.org.au>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 3 Apr 2023 16:51:27 +0800
Message-ID: <CAKGbVbv=eyaKPQM8QfD-999-=vbrrqnEXkhuE7dy=vpK7OFY6Q@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Erico Nunes <nunes.erico@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think you can just revert the following three lima commits when merge:
* 4a66f3da99dc ("drm/lima: add show_fdinfo for drm usage stats")
* 87767de835ed ("drm/lima: allocate unique id per drm_file")
* bccafec957a5 ("drm/lima: add usage counting method to ctx_mgr")

Regards,
Qiang

On Mon, Apr 3, 2023 at 10:16=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the drm-misc tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> drivers/gpu/drm/lima/lima_ctx.c: In function 'lima_ctx_do_release':
> drivers/gpu/drm/lima/lima_ctx.c:53:45: error: 'struct drm_sched_entity' h=
as no member named 'elapsed_ns'
>    53 |                 mgr->elapsed_ns[i] +=3D entity->elapsed_ns;
>       |                                             ^~
> drivers/gpu/drm/lima/lima_ctx.c: In function 'lima_ctx_mgr_usage':
> drivers/gpu/drm/lima/lima_ctx.c:125:43: error: 'struct drm_sched_entity' =
has no member named 'elapsed_ns'
>   125 |                         usage[i] +=3D entity->elapsed_ns;
>       |                                           ^~
>
> Caused by commit
>
>   bccafec957a5 ("drm/lima: add usage counting method to ctx_mgr")
>
> interacting with commit
>
>   baad10973fdb ("Revert "drm/scheduler: track GPU active time per entity"=
")
>
> from Linus' tree.
>
> I can't see any obvious way to fix this up, so I have used teh drm-misc
> tree from next-20230331 for today.
>
> --
> Cheers,
> Stephen Rothwell
