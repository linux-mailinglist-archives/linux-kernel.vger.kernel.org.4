Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E92E725A35
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbjFGJYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234349AbjFGJYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:24:13 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726491994
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:24:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-655d1fc8ad8so2157007b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 02:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686129847; x=1688721847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QuG7FJt7+/guVeJ8/c8dvfJd5cbH1CGDk8/6AW8Yle8=;
        b=JVvaPbMqp4LAFR4QpYZzogKYRLoKfxK3tlP4kX9km/P7Amy4CSW20UV7Dtwlf/sFpA
         +h9sUjqyT0GGma2DBwq5HQ2EHVCMGdBN8opTBjST/w08+sCt9Q3ui4XIpCxgtUxO2kjn
         qWwzEXy4t+F5S9h0UnfTs3/RLsoYvyZwze+0IrgaP/RSHaSo/j8oZCppu69le3TdUBVW
         jw8ciSuGRJVnW1J2vSEuvt8i+yGO73LdiGwzmboc/HGv5Bk8X3ZnWIaBOYUyBujZnpfM
         +zWQIdj3nPBAxVCcO++FtOMThMO589mTvpmbPAvx/l7lQIUrrLsZ5Tv7xbDTePiTnp/y
         Zq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129847; x=1688721847;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QuG7FJt7+/guVeJ8/c8dvfJd5cbH1CGDk8/6AW8Yle8=;
        b=hTnddIhn0QqCiyB+/0DQL0n5YMbQ+10QKLRLRhVO/Vs0NsAOFg8kDWcv0Wj9KgBGh7
         VfsXTE7Q22+YP/jX4S3bkNkymdpBthFxQ7THoBJVQj0vmgSYd7CivHKiEHAfMqdu+59B
         Dst10P/otjRQtmtvzDGxDSh2i3U6Qi4F5HosJkZ48+/efTavWdaLivB3659XwiRTgLzu
         /U1RswIy9OLylGONGzsiqp5Cg8yD9loGmMwTbZv0QAD+0EZFLruq7Py2Bgs9Pl9LmTp0
         zIdxOBcN2SRD13hEmlfKZqgX7NboK9Mo781OPrHc/VSGPMxjHRcfslDLfDBiEN+6Pffc
         9eSw==
X-Gm-Message-State: AC+VfDw9UzJm7FOpRH+ASSR0Zl53dH5tIAzUbhqe4q6n5TQFvlOCqxha
        thxNB56kWDE00h0jPzMFBzI9qaeg2nOcxfmVkt4=
X-Google-Smtp-Source: ACHHUZ6olcbywFiJ8o2+fYH6jVdA9wf81hv7Hxa6DgDi2MZmsm2OOwaCjynLV2r5U8nYY0yDoNYbtQCmV7yFbYBx+6U=
X-Received: by 2002:a05:6a20:a110:b0:10b:4a5d:87e with SMTP id
 q16-20020a056a20a11000b0010b4a5d087emr762824pzk.53.1686129846787; Wed, 07 Jun
 2023 02:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230606145611.704392-1-cerasuolodomenico@gmail.com> <CAJD7tkad3cWs2CkZE2pV4kzNjn+0crmT2YYpSKU9SynQf7S24Q@mail.gmail.com>
In-Reply-To: <CAJD7tkad3cWs2CkZE2pV4kzNjn+0crmT2YYpSKU9SynQf7S24Q@mail.gmail.com>
From:   Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Date:   Wed, 7 Jun 2023 11:23:55 +0200
Message-ID: <CA+CLi1j-tQ8DJzShmBr_9feaSWJLvteFXZ+bwafP0YK=MDVVuA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] mm: zswap: move writeback LRU from zpool to zswap
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     vitaly.wool@konsulko.com, minchan@kernel.org,
        senozhatsky@chromium.org, linux-mm@kvack.org, ddstreet@ieee.org,
        sjenning@redhat.com, nphamcs@gmail.com, hannes@cmpxchg.org,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com
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

On Wed, Jun 7, 2023 at 11:16=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Tue, Jun 6, 2023 at 7:56=E2=80=AFAM Domenico Cerasuolo
> <cerasuolodomenico@gmail.com> wrote:
> >
> > This series aims to improve the zswap reclaim mechanism by reorganizing
> > the LRU management. In the current implementation, the LRU is maintaine=
d
> > within each zpool driver, resulting in duplicated code across the three
> > drivers. The proposed change consists in moving the LRU management from
> > the individual implementations up to the zswap layer.
> >
> > The primary objective of this refactoring effort is to simplify the
> > codebase. By unifying the reclaim loop and consolidating LRU handling
> > within zswap, we can eliminate redundant code and improve
> > maintainability. Additionally, this change enables the reclamation of
> > stored pages in their actual LRU order. Presently, the zpool drivers
> > link backing pages in an LRU, causing compressed pages with different
> > LRU positions to be written back simultaneously.
> >
> > The series consists of several patches. The first patch implements the
> > LRU and the reclaim loop in zswap, but it is not used yet because all
> > three driver implementations are marked as zpool_evictable.
> > The following three commits modify each zpool driver to be not
> > zpool_evictable, allowing the use of the reclaim loop in zswap.
> > As the drivers removed their shrink functions, the zpool interface is
> > then trimmed by removing zpool_evictable, zpool_ops, and zpool_shrink.
> > Finally, the code in zswap is further cleaned up by simplifying the
> > writeback function and removing the now unnecessary zswap_header.
> >
> > Based on mm-stable + commit 399ab221f3ff
> > ("mm: zswap: shrink until can accept") currently in mm-unstable.
>
> I tested this + commit fe1d1f7d0fb5 ("mm: zswap: support exclusive
> loads") currently in mm-unstable, using zsmalloc and
> CONFIG_ZSWAP_EXCLUSIVE_LOADS=3Dy. I only ran basic zswap tests with
> manual writeback induction and made sure everything is sane. I
> obviously hope you did more involved testing :)
>
> The only problem I came across is the conflict with fe1d1f7d0fb5, and
> I suggested the fix in patch 1. With the fix, everything seems
> correct.
>
> So I guess, FWIW for all the patches except 2 & 3 (for zbud and z3fold):
> Tested-by: Yosry Ahmed <yosryahmed@google.com>

Thanks a lot for the effort! I'll rebase and test it again before submittin=
g the
new version.

>
> >
> > V2:
> > - fixed lru list init/del/del_init (Johannes)
> > - renamed pool.lock to lru_lock and added lock ordering comment (Yosry)
> > - trimmed zsmalloc even more (Johannes | Nhat)
> > - moved ref drop out of writeback function  (Johannes)
> >
> > Domenico Cerasuolo (7):
> >   mm: zswap: add pool shrinking mechanism
> >   mm: zswap: remove page reclaim logic from zbud
> >   mm: zswap: remove page reclaim logic from z3fold
> >   mm: zswap: remove page reclaim logic from zsmalloc
> >   mm: zswap: remove shrink from zpool interface
> >   mm: zswap: simplify writeback function
> >   mm: zswap: remove zswap_header
> >
> >  include/linux/zpool.h |  19 +-
> >  mm/z3fold.c           | 249 +-------------------------
> >  mm/zbud.c             | 167 +-----------------
> >  mm/zpool.c            |  48 +----
> >  mm/zsmalloc.c         | 396 ++----------------------------------------
> >  mm/zswap.c            | 186 +++++++++++---------
> >  6 files changed, 130 insertions(+), 935 deletions(-)
> >
> > --
> > 2.34.1
> >
