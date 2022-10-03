Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A110C5F3305
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJCP7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 11:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiJCP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 11:59:38 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D5138E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 08:59:34 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-354c7abf786so110798267b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 08:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LjD35+EgrmTPsU4Ykx2Ec7FHUSe93L0NcK+pYBE9B4E=;
        b=dI3aqOLQ49oGruKOrzcF09CLHI/WTgFI8KqF0hZ51qkOOpP0N1nyYjBZKBBHgHaeT/
         qLC3oTnctjQFlStJ8Jw2xHE7Hpp1Recl2HHAauakTt7U247aFZeGMxk9sZvYyaoMrFhL
         9Uid9pAu0w+ki4+Wg6qGM5raanW1hEdrZRHFOiO0euT77WEacS5lm8XpEBjrIa576hud
         N9qjtGNAsJq22kA8N29CEHOJysb95L4PeZPAa6sZAWL7308spwSsj+4mFk2GyCQwpjWB
         gxcmUWXziwMmq356d4SIe/uQFSk71ViGSQYZYBjIvvEnCMLC156S+oMHueWunLsGnE8l
         TprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LjD35+EgrmTPsU4Ykx2Ec7FHUSe93L0NcK+pYBE9B4E=;
        b=nH7MJGSMb5OsOwjzvn5GQ233RXIloEboy8dNccymR1BCnUTm+mCMh6KJs4VPjymQm/
         c5miCD4IFH+80w7BrtCZa+RICQJ1Q6uA4TkWft6PoS5T2QhLw5RKRftsbgbmgSCZ3Lvy
         aoDhz0Oswxywm/10n2X7WapCTUkWXHaQ9Nea1TPqZDfTLhLNXgWs0llx31IZfFE0sdb+
         rXcMJMFcnIpEnmG4TgXLLiL5bAyNYPMiZflg6t5Da5MVoH/ANhOBMPhohn6tf/pNBZIj
         NvPPzUoc09ZXoknletn1EgvAhQzczkLuUES45ZcIpak7+oGClM4TJICfkga/jD/vheQZ
         Ipzg==
X-Gm-Message-State: ACrzQf2swg69o5M+XWckOn08sB67u/objKIT7hs04ZYDoq4TsGTQOFND
        U6MCpNv5+wfZd4I0tfuhpEbh6kqtviWajcF5gbk=
X-Google-Smtp-Source: AMsMyM7GNFiVuGANFp31gl/LOulqhZo7CEVH8fjJPKg8mpgcsq2EBbqcwABNf6O7PcHHMESuhTX/UShVrW4W8vQH4vk=
X-Received: by 2002:a81:6944:0:b0:358:afb5:5d92 with SMTP id
 e65-20020a816944000000b00358afb55d92mr8054927ywc.173.1664812773809; Mon, 03
 Oct 2022 08:59:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220920014036.2295853-1-daeho43@gmail.com> <f4ce9486-f104-b0e2-25ed-f6de96316b76@kernel.org>
 <CACOAw_z=9H6jEQNd8C99c6xO55PJXWJOW7Q=78qtppgysebN2A@mail.gmail.com>
 <4aca0d00-d3b7-975f-6b72-ccd6f07d22e5@kernel.org> <CACOAw_wVU1gmH1gyWHYNqCpgy4KGKB+EZK6pbGL-h_1ToDV=vg@mail.gmail.com>
 <53df1b78-c611-6a22-88b1-74cc83a9e148@kernel.org> <CACOAw_w_09sz8PxnSGzNmJwh1-y_3JoKbBu80VjgZgV1uxo7KA@mail.gmail.com>
 <CACOAw_wjcFr1fg3QRYPUyOGyo-G9D9U6=qprkPUP8PzoxPQkMQ@mail.gmail.com> <d3992e1c-3251-f900-97be-049b1e1e4e37@kernel.org>
In-Reply-To: <d3992e1c-3251-f900-97be-049b1e1e4e37@kernel.org>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Mon, 3 Oct 2022 08:59:23 -0700
Message-ID: <CACOAw_xCdjT8CzVNV1LHZ3bGZvyWG+Q0=Vz2eX2B0Pt9GA=ewA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What I mean is:
>
> ---
>   fs/f2fs/file.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e4b6e51086a3..31b229678b1d 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2053,6 +2053,9 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>
>         isize = i_size_read(inode);
>         fi->original_i_size = isize;
> +
> +       set_inode_flag(inode, FI_ATOMIC_FILE);
> +
>         if (truncate) {
>                 set_inode_flag(inode, FI_ATOMIC_REPLACE);
>                 truncate_inode_pages_final(inode->i_mapping);
> @@ -2063,7 +2066,6 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
>
>         stat_inc_atomic_inode(inode);
>
> -       set_inode_flag(inode, FI_ATOMIC_FILE);
>         set_inode_flag(fi->cow_inode, FI_COW_FILE);
>         clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
>         f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
> --
>
>
> Let's set FI_ATOMIC_FILE flag before f2fs_i_size_write(inode, 0), so
> - f2fs_ioc_start_atomic_write
>   - f2fs_i_size_write(, 0)
>    - f2fs_mark_inode_dirty_sync
>     check f2fs_is_atomic_file() and return correctly.
>

Ah, I got it.

> And for the case the inode is dirty before f2fs_i_size_write(, 0), we
> can call f2fs_write_inode() to flush dirty feilds into inode page, and
> make inode clean.
>

Thanks for the tips~

> >
> >>
> >> Thanks,
