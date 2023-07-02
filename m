Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCE3745310
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 01:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGBXgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 19:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGBXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 19:36:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F39E40;
        Sun,  2 Jul 2023 16:36:33 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso56200641fa.1;
        Sun, 02 Jul 2023 16:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688340991; x=1690932991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHFK0zYmI9rlbwJHus0Wv+AFb/pa/A+qTUs5Ldro9ys=;
        b=PHvb5Cg8BbZDJ4YrFM5VPTFAHADQN6xV3I+4zRrZKdXeKuUeFGmiP3paqBW/qHRqU3
         eJDAMHnrU5E4y+/bBFH/Ivu2mMqcD2lcvlTa25sIX/04Dhbtio9Khh9T75r+htEUQuzK
         JKngACNRLS8BtF13CE8Inhypux4V9yA0toA8P/jou3SP028huxGXw3d4qrAOoyPtFbrC
         H0Y0kNusvB0n6bymhMEoSls7TUFGk+BUrwS01wTkjjLXtujw1f/YG1bZwTatZ+xoIMZp
         Rcuq8xp87ril7dNXgBcR3aGxObq7J9fL8xgDynNd3Yh+jqOx9RB+hTofE2CD/eL+3frR
         n9fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688340991; x=1690932991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aHFK0zYmI9rlbwJHus0Wv+AFb/pa/A+qTUs5Ldro9ys=;
        b=T0wNqywozC8q1O8AKKQM8FvnWzcH+8ARp3vzBzGH5wHCEbI7XHsrT4gM9qoDGiUqy6
         AG2F0hhEThzp8kmxNjsKB7xK3iA8t+PXo+4tWPL8N/78/9y0wNx1hpaUdLFeoKn71JpF
         9Rn+9a5Tw2Uf4rfDv5rvUsGOM9jnneEH+bGaK96A0UP56z+aVrGDABO+HUO/YEnpc8Ug
         IRuR2Awz15ts9g6s14x5sVjb8SkUVQZzj6kgm5fcik8l5eeA7yYVo4UCshynZJLN4gFx
         IbDF8ceKR+67L0oAx1eSIdn6EX4itMLkgkZ/c2BEY4JGo8WHj3qLfXqrPQK0iaw4auhx
         0SdA==
X-Gm-Message-State: ABy/qLY8PMR3VByubvy/m7VAnj4DdBNz3vcHlF90vTBTMHX8vLVk4gPJ
        JY6EUhDIwrt+N8utUMHd6W0FQSxG4K84gsmI+M4=
X-Google-Smtp-Source: APBJJlGN/fuohbhJPjsFEtjooRsxjY/wQdtV8zUm4WJTk+M+D0zxJeC/LQFxPvO+NnqdjcxdO89yJzErPM02gej3v08=
X-Received: by 2002:a2e:80d9:0:b0:2b6:a3a0:5f7 with SMTP id
 r25-20020a2e80d9000000b002b6a3a005f7mr5158743ljg.9.1688340991083; Sun, 02 Jul
 2023 16:36:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230702130310.3437437-1-trix@redhat.com>
In-Reply-To: <20230702130310.3437437-1-trix@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 2 Jul 2023 18:36:19 -0500
Message-ID: <CAH2r5mtuyXgfkNk65y0JjkUfaxxUuWHYOPuAXO8f_sp4_VDFAA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: remove unused variable 'server'
To:     Tom Rix <trix@redhat.com>
Cc:     sfrench@samba.org, pc@manguebit.com, lsahlber@redhat.com,
        sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch - but this was removed a few days ago by Colin's patch

smfrench@smfrench-ThinkPad-P52:~/cifs-2.6$ git log fs/smb/client/dfs.c
commit dfbf0ee092a5d7a9301c81e815b5e50b7c0aeeda
Author: Colin Ian King <colin.i.king@gmail.com>
Date:   Fri Jun 30 12:33:37 2023 +0100

    smb: client: remove redundant pointer 'server'

    The pointer 'server' is assigned but never read, the pointer is
    redundant and can be removed. Cleans up clang scan build warning:

    fs/smb/client/dfs.c:217:3: warning: Value stored to 'server' is
    never read [deadcode.DeadStores]

    Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
    Signed-off-by: Steve French <stfrench@microsoft.com>

On Sun, Jul 2, 2023 at 8:43=E2=80=AFAM Tom Rix <trix@redhat.com> wrote:
>
> gcc with W=3D1 reports
> fs/smb/client/dfs.c: In function =E2=80=98__dfs_mount_share=E2=80=99:
> fs/smb/client/dfs.c:146:33: error: variable =E2=80=98server
>   set but not used [-Werror=3Dunused-but-set-variable]
>   146 |         struct TCP_Server_Info *server;
>       |                                 ^~~~~~
>
> This variable is not used, so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  fs/smb/client/dfs.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
> index 26d14dd0482e..1403a2d1ab17 100644
> --- a/fs/smb/client/dfs.c
> +++ b/fs/smb/client/dfs.c
> @@ -143,7 +143,6 @@ static int __dfs_mount_share(struct cifs_mount_ctx *m=
nt_ctx)
>         struct smb3_fs_context *ctx =3D mnt_ctx->fs_ctx;
>         char *ref_path =3D NULL, *full_path =3D NULL;
>         struct dfs_cache_tgt_iterator *tit;
> -       struct TCP_Server_Info *server;
>         struct cifs_tcon *tcon;
>         char *origin_fullpath =3D NULL;
>         char sep =3D CIFS_DIR_SEP(cifs_sb);
> @@ -214,7 +213,6 @@ static int __dfs_mount_share(struct cifs_mount_ctx *m=
nt_ctx)
>         } while (rc =3D=3D -EREMOTE);
>
>         if (!rc) {
> -               server =3D mnt_ctx->server;
>                 tcon =3D mnt_ctx->tcon;
>
>                 spin_lock(&tcon->tc_lock);
> --
> 2.27.0
>


--=20
Thanks,

Steve
