Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9976A6B83D3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 22:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjCMVNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 17:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCMVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 17:13:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AEB88E3C0;
        Mon, 13 Mar 2023 14:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9D92B8149C;
        Mon, 13 Mar 2023 21:12:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BFEC433EF;
        Mon, 13 Mar 2023 21:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678741935;
        bh=zYJBShYkwWSVXL8WyRJR97m9GVSH3Xk1/B+RUVJG3cQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JH9S+RlT/DdfAYGtquoWHeApkus/ituRl3F76d67/bmm+2TIYoq11R3N+ZsINz5sP
         Qw/mya8wO6vSqrR6VOLvR0dg67GkB1PoZTmqtD9A7nSoeTDRwgC0b4znGUHUnDt90t
         ihgIlqEhh1oUbQ5OJ0LaRPtSircIA3B7oIfftIeV0j82TPELDYuoGvpjD0HVEbFYUu
         rXeuuzEI+C3iLrtPCfu6FCNam6Me1DM4jL1qzUNSSbBcHHoY6oqE4dGvYrVTOQx//S
         ztZ0Zi11M+tFVDGDbuLGe2mrQZd85GKmkbgKSeX+CvNnBba00ZFPWj6cKNAEMMfg1n
         DI3Je75lf9HdA==
Received: by mail-lf1-f50.google.com with SMTP id x17so1306459lfu.5;
        Mon, 13 Mar 2023 14:12:15 -0700 (PDT)
X-Gm-Message-State: AO0yUKUtYTUvqaUfr3DO8MN9eCdEzzoNq42eNlHltb8e9Y4sQ42o/8un
        HhkkYcRqawS9i0YiCI3BK+4qvNfT5DUiJXKE+cM=
X-Google-Smtp-Source: AK7set+DjQ1xvcDa5hV1VdH/Pr6Am7QIxL7TaTlkKoBpFB2dZDT/hkUK+3eGTF4IGCtolqIuEmueTFud7NHOOva8TTQ=
X-Received: by 2002:ac2:5927:0:b0:4db:1a0d:f261 with SMTP id
 v7-20020ac25927000000b004db1a0df261mr10797689lfi.3.1678741933628; Mon, 13 Mar
 2023 14:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230214-kobj_type-md-v1-1-d6853f707f11@weissschuh.net>
In-Reply-To: <20230214-kobj_type-md-v1-1-d6853f707f11@weissschuh.net>
From:   Song Liu <song@kernel.org>
Date:   Mon, 13 Mar 2023 14:12:01 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5atxr8iFS-=scHjhXo19We4Rnms+XU80c9aKANQL1k1g@mail.gmail.com>
Message-ID: <CAPhsuW5atxr8iFS-=scHjhXo19We4Rnms+XU80c9aKANQL1k1g@mail.gmail.com>
Subject: Re: [PATCH] md: make kobj_type structures constant
To:     =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 7:19=E2=80=AFPM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
>
> Take advantage of this to constify the structure definitions to prevent
> modification at runtime.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>

Applied to md-next. Thanks!

Song

> ---
>  drivers/md/md.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 02b0240e7c71..091c1d6f0b87 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -78,7 +78,7 @@
>  static LIST_HEAD(pers_list);
>  static DEFINE_SPINLOCK(pers_lock);
>
> -static struct kobj_type md_ktype;
> +static const struct kobj_type md_ktype;
>
>  struct md_cluster_operations *md_cluster_ops;
>  EXPORT_SYMBOL(md_cluster_ops);
> @@ -3600,7 +3600,7 @@ static const struct sysfs_ops rdev_sysfs_ops =3D {
>         .show           =3D rdev_attr_show,
>         .store          =3D rdev_attr_store,
>  };
> -static struct kobj_type rdev_ktype =3D {
> +static const struct kobj_type rdev_ktype =3D {
>         .release        =3D rdev_free,
>         .sysfs_ops      =3D &rdev_sysfs_ops,
>         .default_groups =3D rdev_default_groups,
> @@ -5558,7 +5558,7 @@ static const struct sysfs_ops md_sysfs_ops =3D {
>         .show   =3D md_attr_show,
>         .store  =3D md_attr_store,
>  };
> -static struct kobj_type md_ktype =3D {
> +static const struct kobj_type md_ktype =3D {
>         .release        =3D md_kobj_release,
>         .sysfs_ops      =3D &md_sysfs_ops,
>         .default_groups =3D md_attr_groups,
>
> ---
> base-commit: f6feea56f66d34259c4222fa02e8171c4f2673d1
> change-id: 20230214-kobj_type-md-a3c7773574cf
>
> Best regards,
> --
> Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
