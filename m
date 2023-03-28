Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B0A6CC13E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjC1Nm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbjC1Nmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:42:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1119778;
        Tue, 28 Mar 2023 06:42:39 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id d10so7205741pgt.12;
        Tue, 28 Mar 2023 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680010959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zhuOF8Ho5g7rK8i7Gjjphp+Xz2ush8RYPAJ3+nO8+hU=;
        b=ohv1R6BsJ0apfHnfIaYD0x+ssyU4aWoNEXnATWn2rcvn29C/EsJGK7p6IDnuM9fJMo
         UOtC34kKxAZjwY84umK4/vicnSdHCBd6qgMiRWHpE7h/hgRFM82W+dJglled/echbUQ1
         E1K0v84j+vnl7V5Zy5Fn5uaLHHhFKkCsjRx3vtPfrC9FHjGApF/xGMzc2CigYWS919Dr
         jaxtUJy1iRunvTtsHeYhd3a8LnyWhjQV0DNnURVouXTAG0jex6sTV43umwktvLXRVyIb
         j7iKNpcsPY13un2CQi4of8BswcmImAdR6XvOD/CnYM47BUz/tzStpE44TF+MzCXZn3gG
         iB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680010959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhuOF8Ho5g7rK8i7Gjjphp+Xz2ush8RYPAJ3+nO8+hU=;
        b=28KtK3M+11nHcfYTmCM8YCs3Wpw9m0puVpAIXttkbwzYBq6HPOfxC59viamiE6Yvlv
         BPn8cjPSGsqxcyiSA8OfrvEfZfgUitsrtR7meyVkiNQR+1xSs/bVp8yTpKB62nBIrt/+
         ONumljC+ZrQekRguepbUsf6LkpFLzL/NC11xTQvVOOm8bUEDq1poJrSd98Z95VQJi3zS
         Dwj+qJCmfDUOqN2joGqWkdzI7Pnxyj7eO13QT39xOzlKiNYP8o9Xk6k81/YS3Q0mOhjL
         cyuTNBD/KoKuH+Ef4bqTIHWXJcLV7suA6kdu1jHy6N8a452AFkio11j3Lf8Ch07Dcz8z
         eVOw==
X-Gm-Message-State: AAQBX9del6dtMsjzJc6qTP+ZqBXYuO+1JtCMe4umlGBKghEVyWd5Jx49
        DJJ1chOmd5j8MrnHPkkz3JO+r0Cobnc+8mAyPuqC766n
X-Google-Smtp-Source: AKy350bVKJbK4HdlOq50XmTjRNX5ftQ2y602rndF1NQGJZJwBaI0ysvg4ceiDozOC6jOtPOZm9kKgj2yO8M4S5/4mqU=
X-Received: by 2002:a63:ef0c:0:b0:50f:aafa:6bc9 with SMTP id
 u12-20020a63ef0c000000b0050faafa6bc9mr4067379pgh.6.1680010958857; Tue, 28 Mar
 2023 06:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
In-Reply-To: <20230327174402.1655365-1-kent.overstreet@linux.dev>
From:   Phillip Lougher <phillip.lougher@gmail.com>
Date:   Tue, 28 Mar 2023 14:42:28 +0100
Message-ID: <CAB3woddAP_6uOUJ4Yjj_PATme-CQao3p2JErBBtjtpzYxQejng@mail.gmail.com>
Subject: Re: [PATCH 0/2] bio iter improvements
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Phillip Lougher <phillip@squashfs.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 7:02=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
>
> Small patch series cleaning up/standardizing bio_for_each_segment_all(),
> which means we can use the same guts for bio_for_each_folio_all(),
> considerably simplifying that code.
>
> The squashfs maintainer will want to look at and test those changes,
> that code was doing some slightly tricky things. The rest was a pretty
> mechanical conversion.

An eyeball of the changes doesn't bring up anything obviously wrong.

I'll apply and do some tests.

Phillip

BTW please CC me on the cover letter as well as patch [1/2].


>
> Kent Overstreet (2):
>   block: Rework bio_for_each_segment_all()
>   block: Rework bio_for_each_folio_all()
>
>  block/bio.c               |  38 ++++++------
>  block/blk-map.c           |  38 ++++++------
>  block/bounce.c            |  12 ++--
>  drivers/md/bcache/btree.c |   8 +--
>  drivers/md/dm-crypt.c     |  10 ++--
>  drivers/md/raid1.c        |   4 +-
>  fs/btrfs/disk-io.c        |  10 ++--
>  fs/btrfs/extent_io.c      |  52 ++++++++--------
>  fs/btrfs/inode.c          |   8 +--
>  fs/btrfs/raid56.c         |  18 +++---
>  fs/crypto/bio.c           |   8 +--
>  fs/erofs/zdata.c          |   4 +-
>  fs/ext4/page-io.c         |   8 +--
>  fs/ext4/readpage.c        |   4 +-
>  fs/f2fs/data.c            |  20 +++----
>  fs/gfs2/lops.c            |  10 ++--
>  fs/gfs2/meta_io.c         |   8 +--
>  fs/iomap/buffered-io.c    |  14 +++--
>  fs/mpage.c                |   4 +-
>  fs/squashfs/block.c       |  48 ++++++++-------
>  fs/squashfs/lz4_wrapper.c |  17 +++---
>  fs/squashfs/lzo_wrapper.c |  17 +++---
>  fs/verity/verify.c        |   4 +-
>  include/linux/bio.h       | 123 +++++++++++++++++++++-----------------
>  include/linux/bvec.h      |  70 ++++++++++++++--------
>  25 files changed, 302 insertions(+), 255 deletions(-)
>
> --
> 2.39.2
>
