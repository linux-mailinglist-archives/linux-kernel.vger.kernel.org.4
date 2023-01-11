Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9EE6651FB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 03:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbjAKCr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 21:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjAKCr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 21:47:57 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49C213F69
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:47:55 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id d30so16525745lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocEkMtRJ8bZ/SWiwwRdpx68LT7h2+7yKYSWkWdMvGTw=;
        b=CRt7yf14lf0nBZZVSZRFJBJ/YEmjkYS9W/Ftrg6T7dTeP6S8wr6L6rJZn2mNypA2AM
         V45kHPS5Oac4sWjCGxD/RzPE1AC4Lwh2WCvVQgd2O60mYyGGcK3ISbe4GtCeGogCEb6G
         qEV5qsc9JIbZbnKhWalras7vZv6JN36C5iS1TIvY6M9cSOX9fomQUjx6x8LsIcgR7ycT
         fvEVRZv2V9e6JZsUsDLrSGVzTW7dxSfz2ta1xbUtKu+pTZgpm4jCb8zD5mvYoJV78hEk
         MU6a8mEitzfwVeASdISoDUKUYBk3cBFeNK8/0+LGRW8A0hJwSw7oduPfidruiRdUrqRJ
         oSjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ocEkMtRJ8bZ/SWiwwRdpx68LT7h2+7yKYSWkWdMvGTw=;
        b=ECtMHfzC84sqx7MosTnlhHus904bGadelf75IXIBKTVdrck12XJ5eT8WFJSyMJ/M6h
         cEvCAFRV1WcCe7p1Z8eMZxE2v0OKd1DE/yLbVDhi5NkBj33Nqj4jPUPTKQNB4jEgSkbp
         USXeuGgF738mN+Y7RbJ9XGjPsb2OOB9lU7u+acO/b8xu5xbxbCdB0P5/HYenMyGylROo
         rbXlUO/qcySL3SDofkgLQWvM/rAyV7v6a1w6TLjxyCPHSDIw5K+wQeeywEtbeYpLa6sB
         QPAPvwaZmDr3Gz+T+jMwYz1t4Y8sOeAkRQYZNwji5w47HJ9TSjLLboE538pzPkfn1uBO
         /BNA==
X-Gm-Message-State: AFqh2kr9sTtrfQcnEp9neG31IvxsBDs8R8pY62WCy0n3WyEsBjJVlyTF
        M59L0hjtOIrF7/kprqm+Kt5VNBMW/jghKL40oh6h5UJRPSA=
X-Google-Smtp-Source: AMrXdXsrH2ZAKAxl1stn92+zRoWzo3vjL1Qc8NMyezVHHLS1v36bTeMq9g1Z7uwA5WET+fnkvfWpfYOy8Vf6UAt8feI=
X-Received: by 2002:a05:6512:406:b0:4cb:114:ff66 with SMTP id
 u6-20020a056512040600b004cb0114ff66mr2516067lfk.422.1673405274185; Tue, 10
 Jan 2023 18:47:54 -0800 (PST)
MIME-Version: 1.0
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com> <Y5OYYJYx9G2LbRmc@google.com>
 <20221212122109.GA714122@mi-ThinkStation-K> <Y5ezpOwd8sOTTaW5@google.com>
 <20221213022100.GA841758@mi-ThinkStation-K> <CAHDnOD7W0eo-ZMU8nXsPhXrxbpR3U+kooTVaTU8VL67QHbYH3A@mail.gmail.com>
 <Y7TkjnSbHnDj76qd@google.com>
In-Reply-To: <Y7TkjnSbHnDj76qd@google.com>
From:   zhou dan <zhuqiandann@gmail.com>
Date:   Wed, 11 Jan 2023 10:47:17 +0800
Message-ID: <CAHDnOD4wNVc_XKBi2qyi3oNRENidf4mSYCCTYYxCofy=iqc=Zg@mail.gmail.com>
Subject: Re: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not compressed
To:     Jaegeuk Kim <jaegeuk@kernel.org>, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, zhoudan8@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Android S, after the app is installed, it will judge whether the file
is allowed to be compressed and release it. In the case of compress_mode=3D=
user,
the file is not compressed at this point, causing EVNAL to be returned on
subsequent executions to release.
In the method 'isCompressionAllowed', there is also such a notice:"NOTE:
The return value does not mean if the given file, or any other file on
the same file system, is actually compressed. It merely determines whether
not files <em>may</em> be compressed."

On Wed, Jan 4, 2023 at 10:29 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> On 12/16, zhou dan wrote:
> > Hi, about this patch, I haven't received any reply recently.
> > Maybe you have some new ideas to solve this problem?
>
> Could you please describe the exact flow that you're suffering from?
>
> >
> >
> > zhoudan <zhuqiandann@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8813=E6=
=97=A5=E5=91=A8=E4=BA=8C 10:21=E5=86=99=E9=81=93=EF=BC=9A
> > >
> > > However, 'f2fs_compressed_file()' only determines whether the file ca=
n
> > > be compressed, not whether the file has been compressed. As far as I
> > > know, when compress_mode is user, files marked FI_COMPRESSED_FILE
> > > will be compressed only after 'f2fs_ioc_compress_file()' is called.
> > > On Mon, Dec 12, 2022 at 03:05:08PM -0800, Jaegeuk Kim wrote:
> > > > On 12/12, zhoudan wrote:
> > > > > Maybe I'm not describing it clearly enough, but I think there is
> > > > > something wrong with the logic here.The 'f2fs_release_compress_bl=
ocks'
> > > > > method does not determine if the file is compressed, but simply a=
dds
> > > > > the FI_COMPRESS_RELEASED flag.
> > > >
> > > > I firstly lost your point since f2fs_release_compress_blocks() chec=
ked
> > > > f2fs_compressed_file().
> > > >
> > > > > In particular, in the current Android system, when the applicatio=
n is
> > > > > installed, the release interface is called by default to release =
the
> > > > > storage marked as compressed,  without checking whether the file =
is
> > > > > actually compressed. In this case, when compress_mode is set to u=
ser,
> > > > > calling the compress interface returns ENVAL and the file cannot =
be
> > > > > compressed.
> > > > > So I think the implementation of release needs to be modified, an=
d
> > > > > only set FI_COMPRESS_RELEASED when it's really compressed and the
> > > > > storage is released.
> > > > >
> > > > > On Fri, Dec 09, 2022 at 12:19:44PM -0800, Jaegeuk Kim wrote:
> > > > > > On 12/08, zhoudan8 wrote:
> > > > > > > In compress_mode=3Duser, f2fs_release_compress_blocks()
> > > > > > >  does not verify whether it has been compressed and
> > > > > > >  sets FI_COMPRESS_RELEASED directly. which will lead to
> > > > > > > return -EINVAL after calling compress.
> > > > > > > To fix it,let's do not set FI_COMPRESS_RELEASED if file
> > > > > > > is not compressed.
> > > > > >
> > > > > > Do you mean you want to avoid EINVAL on a file having FI_COMPRE=
SS_RELEASED
> > > > > > with zero i_compr_blokcs?
> > > > > >
> > > > > > I think the current logic is giving the error on a released fil=
e already.
> > > > > >
> > > > > > >
> > > > > > > Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
> > > > > > > ---
> > > > > > >  fs/f2fs/file.c | 3 +--
> > > > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > > > index 82cda1258227..f32910077df6 100644
> > > > > > > --- a/fs/f2fs/file.c
> > > > > > > +++ b/fs/f2fs/file.c
> > > > > > > @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_bloc=
ks(struct file *filp, unsigned long arg)
> > > > > > >         ret =3D filemap_write_and_wait_range(inode->i_mapping=
, 0, LLONG_MAX);
> > > > > > >         if (ret)
> > > > > > >                 goto out;
> > > > > > > -
> > > > > > > -       set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > > > > > >         inode->i_ctime =3D current_time(inode);
> > > > > > >         f2fs_mark_inode_dirty_sync(inode, true);
> > > > > > >
> > > > > > >         if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
> > > > > > >                 goto out;
> > > > > > >
> > > > > > > +       set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > > > > > >         f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > > > > > >         filemap_invalidate_lock(inode->i_mapping);
> > > > > > >
> > > > > > > --
> > > > > > > 2.38.1
