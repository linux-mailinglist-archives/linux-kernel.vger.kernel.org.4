Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F68E6F8E38
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 05:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjEFDJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 23:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjEFDJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 23:09:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680337EFF;
        Fri,  5 May 2023 20:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD0B6135B;
        Sat,  6 May 2023 03:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D93AC4339C;
        Sat,  6 May 2023 03:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683342556;
        bh=94DSp8k+H3J+AqmROh/Y6LXMjAfEDuNgrjATTUqIGf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oi4A+bM3GJYMILFGv9WW2BLv73UjF4glWlr9rNrPlG4q2hxKa1PVStT77yBASYe+i
         mRna95Xpo0cXMDq+kLuwMf7YEJd6s+Ng82m+AjTtDUd1+w2ueB0UKGaWBYNCRKNlQ5
         aSaTyJZQM9yaEZpWQl9gPn0u4wMa2vYSTp7d7g5+6rxZJY63VNcMGC1FMdM6WINudX
         wNRi2C/MSuxHjKRZzXJqB3NBk2yFCyEl0qS5KCRY/6yfzVvL1zvzwI3NCFtUfPv6bI
         eAw026lpC2qCHucsoZiYoJ++/CDr6gePHHdCxIPrAd2eKs0CRe6YEq9wcaXlYYcX7n
         xt1eDaqzRv14g==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso440627266b.2;
        Fri, 05 May 2023 20:09:16 -0700 (PDT)
X-Gm-Message-State: AC+VfDyl/trj4YruYMS6Pd96paZ3+iKS8vJMOakv6nwpaBrUWz76NCMq
        4dBvVZw5Ef2qIWqgLDvQVX6XNsHze9fmS23ybrw=
X-Google-Smtp-Source: ACHHUZ5q66Rt3kuFcvOCHyf5q3SCTx0oegflyWNX/hW3kcg5FLjFyT6/1CH0s9pr7aacP/qFhtu3dHWdoaSL+Fp2GWY=
X-Received: by 2002:a17:907:720f:b0:933:1134:be1e with SMTP id
 dr15-20020a170907720f00b009331134be1emr2995754ejc.53.1683342554618; Fri, 05
 May 2023 20:09:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230504080406.1213623-1-suijingfeng@loongson.cn> <20230504080406.1213623-2-suijingfeng@loongson.cn>
In-Reply-To: <20230504080406.1213623-2-suijingfeng@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sat, 6 May 2023 11:09:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4zKGkd2JUyYTDKBEGFEO5V+oRz8iuzF9w+ivz0t6+CFw@mail.gmail.com>
Message-ID: <CAAhV-H4zKGkd2JUyYTDKBEGFEO5V+oRz8iuzF9w+ivz0t6+CFw@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] MAINTAINERS: add maintainers for DRM LOONGSON driver
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nathan@kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jingfeng,

I think you should exchange the order of these two patches.


Huacai

On Thu, May 4, 2023 at 4:04=E2=80=AFPM Sui Jingfeng <suijingfeng@loongson.c=
n> wrote:
>
>  This patch add myself as maintainer to drm loongson driver
>
> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 73b3298b7232..1f5aa8756d87 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6922,6 +6922,13 @@ T:       git git://anongit.freedesktop.org/drm/drm=
-misc
>  F:     drivers/gpu/drm/lima/
>  F:     include/uapi/drm/lima_drm.h
>
> +DRM DRIVERS FOR LOONGSON
> +M:     Sui Jingfeng <suijingfeng@loongson.cn>
> +L:     dri-devel@lists.freedesktop.org
> +S:     Supported
> +T:     git git://anongit.freedesktop.org/drm/drm-misc
> +F:     drivers/gpu/drm/loongson/
> +
>  DRM DRIVERS FOR MEDIATEK
>  M:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
>  M:     Philipp Zabel <p.zabel@pengutronix.de>
> --
> 2.25.1
>
