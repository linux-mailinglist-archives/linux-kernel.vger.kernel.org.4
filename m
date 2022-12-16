Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0865C64EA1A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbiLPLRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiLPLRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:17:43 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26472CD0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:17:38 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id bf43so2990846lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:17:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Npm0qC2z5bK4IeTsFeJwXcTQn9mcTYSVK3FkIJ19lwU=;
        b=eACeL1KczoRwXedhzceBIrHn5CjgkwVZtysnkyPS+niPeZ2PpO5TTe6XL9unxRzVZi
         yZ6jhvp+nmI8VYl+67ypRuzdsuu5Wj+VbLeBuhDr4iz+uYuhVDmzJdw//LGI5LK+kC1P
         L6nIHbCBxU5fnLP0uBzTFsg9XOCH/kD/fFfgR8RM+eNhtfkRIalmkNvB+Qm3pAYfwSQE
         mGhpnKWPxrcYedaxcsTSwE7YrI9tjQ4naUa+1BZuJ2GK5LtXyse4XGZyh6UvpdQc/AwY
         CXI1iv4c+gTHWFQa+bLln+wtPcZzC9FAXnWpQl7ahRpodDvY0No7udMkiyBDw2EWzPla
         ebMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Npm0qC2z5bK4IeTsFeJwXcTQn9mcTYSVK3FkIJ19lwU=;
        b=U7QnAWNd1p9P7ka9JJnCSZGX1/POOEJE6Nh1wxIMYqURqd31okBmyZIUDc6FCuX/qE
         3+2I0oeaNMTpnV6fHXxAsFyO9Ms//8JK4LFO54u5EqLA9HsvNja270C8W1aYqieskEP6
         WHN/3IBAgMtMLBLswFLp8GNW6Pl2ioHqZpaa2vf+LwqViSWo4JPPQaJ2oh7YdyV7CKlU
         NGuKPtvmWrAsujAMHNNb/QTvP2StFFDtEGR0+AAk5QU6nZcaKx33QQAz/gbZpuRBiYy8
         jithWsIbtOuYmDzc9QfE/IP7nOf0PnEMwkzBHw+vbS6QwoAaJlA/ogjlHcP3/pQyhP+N
         khiw==
X-Gm-Message-State: ANoB5pmTj1AEVlKPdeGsIv4pPFrpXH0ESX5lfxIH5s2RYFVyRzjSfXfU
        qqWr0fbi2BzwyQJyxGTx2PABaCG+Rn10swt5eZc=
X-Google-Smtp-Source: AA0mqf6WqqEOXvWoWNeXWZzJXj45PepuDgvEoOgs9zdHLw7wJg8K/kVdDGQz641m9vutM4VCYYc7iaQ3BYKAZkkntLg=
X-Received: by 2002:a05:6512:2a8d:b0:4b5:6639:a64a with SMTP id
 dt13-20020a0565122a8d00b004b56639a64amr9598178lfb.438.1671189456350; Fri, 16
 Dec 2022 03:17:36 -0800 (PST)
MIME-Version: 1.0
References: <20221208050808.2448146-1-zhoudan8@xiaomi.com> <Y5OYYJYx9G2LbRmc@google.com>
 <20221212122109.GA714122@mi-ThinkStation-K> <Y5ezpOwd8sOTTaW5@google.com> <20221213022100.GA841758@mi-ThinkStation-K>
In-Reply-To: <20221213022100.GA841758@mi-ThinkStation-K>
From:   zhou dan <zhuqiandann@gmail.com>
Date:   Fri, 16 Dec 2022 19:17:24 +0800
Message-ID: <CAHDnOD7W0eo-ZMU8nXsPhXrxbpR3U+kooTVaTU8VL67QHbYH3A@mail.gmail.com>
Subject: Re: [PATCH] f2fs: don't set FI_COMPRESS_RELEASED if file is not compressed
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
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

Hi, about this patch, I haven't received any reply recently.
Maybe you have some new ideas to solve this problem?


zhoudan <zhuqiandann@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=BA=8C 10:21=E5=86=99=E9=81=93=EF=BC=9A
>
> However, 'f2fs_compressed_file()' only determines whether the file can
> be compressed, not whether the file has been compressed. As far as I
> know, when compress_mode is user, files marked FI_COMPRESSED_FILE
> will be compressed only after 'f2fs_ioc_compress_file()' is called.
> On Mon, Dec 12, 2022 at 03:05:08PM -0800, Jaegeuk Kim wrote:
> > On 12/12, zhoudan wrote:
> > > Maybe I'm not describing it clearly enough, but I think there is
> > > something wrong with the logic here.The 'f2fs_release_compress_blocks=
'
> > > method does not determine if the file is compressed, but simply adds
> > > the FI_COMPRESS_RELEASED flag.
> >
> > I firstly lost your point since f2fs_release_compress_blocks() checked
> > f2fs_compressed_file().
> >
> > > In particular, in the current Android system, when the application is
> > > installed, the release interface is called by default to release the
> > > storage marked as compressed,  without checking whether the file is
> > > actually compressed. In this case, when compress_mode is set to user,
> > > calling the compress interface returns ENVAL and the file cannot be
> > > compressed.
> > > So I think the implementation of release needs to be modified, and
> > > only set FI_COMPRESS_RELEASED when it's really compressed and the
> > > storage is released.
> > >
> > > On Fri, Dec 09, 2022 at 12:19:44PM -0800, Jaegeuk Kim wrote:
> > > > On 12/08, zhoudan8 wrote:
> > > > > In compress_mode=3Duser, f2fs_release_compress_blocks()
> > > > >  does not verify whether it has been compressed and
> > > > >  sets FI_COMPRESS_RELEASED directly. which will lead to
> > > > > return -EINVAL after calling compress.
> > > > > To fix it,let's do not set FI_COMPRESS_RELEASED if file
> > > > > is not compressed.
> > > >
> > > > Do you mean you want to avoid EINVAL on a file having FI_COMPRESS_R=
ELEASED
> > > > with zero i_compr_blokcs?
> > > >
> > > > I think the current logic is giving the error on a released file al=
ready.
> > > >
> > > > >
> > > > > Signed-off-by: zhoudan8 <zhoudan8@xiaomi.com>
> > > > > ---
> > > > >  fs/f2fs/file.c | 3 +--
> > > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > > > index 82cda1258227..f32910077df6 100644
> > > > > --- a/fs/f2fs/file.c
> > > > > +++ b/fs/f2fs/file.c
> > > > > @@ -3451,14 +3451,13 @@ static int f2fs_release_compress_blocks(s=
truct file *filp, unsigned long arg)
> > > > >         ret =3D filemap_write_and_wait_range(inode->i_mapping, 0,=
 LLONG_MAX);
> > > > >         if (ret)
> > > > >                 goto out;
> > > > > -
> > > > > -       set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > > > >         inode->i_ctime =3D current_time(inode);
> > > > >         f2fs_mark_inode_dirty_sync(inode, true);
> > > > >
> > > > >         if (!atomic_read(&F2FS_I(inode)->i_compr_blocks))
> > > > >                 goto out;
> > > > >
> > > > > +       set_inode_flag(inode, FI_COMPRESS_RELEASED);
> > > > >         f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
> > > > >         filemap_invalidate_lock(inode->i_mapping);
> > > > >
> > > > > --
> > > > > 2.38.1
