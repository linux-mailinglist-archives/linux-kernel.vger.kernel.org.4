Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1AB5F1318
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 22:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiI3UB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 16:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiI3UBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 16:01:50 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D3A15C5A1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:01:49 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-3560e81aa1dso32036257b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 13:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fHw5bthHkZ6wVmpLXXlxKzX4awvmiLNTfGvvpOnBM54=;
        b=i0eKJXZV7PNaL5CKCGGCLZHqCiIHNgG3V5nkz1Q0kfRN2gINoeslisnPK53cEJTbdB
         CiRwPUtD6MgLXUC4cqlsW16i4l71U6c+YG8G4SgeA+GpEvJWu2E5DT/0cf4CG0NEtpzo
         6UZKjO5t/G1MWSt6PgcaFVhlsDWJsvvpq8J73DIGGzEIbHTAGJle3TFRmgBlHQuxWqNp
         OmnRTXUvdIg+zG3x+yBdk5HUqMODaPvPjEHkWiLEPQmIRvkBpTNl1E080zbWS9bkuA4G
         rD/xbANuIssEuiH53YaGbuw0K4ouPbLt0fq1s+DjYBSWnRjwXaaLwdSAr0cLLTZZ4fAr
         F3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fHw5bthHkZ6wVmpLXXlxKzX4awvmiLNTfGvvpOnBM54=;
        b=2iM16nH6sOoDSegWella3VtWQb5RNZugPff0H6xO73MTSUHUqx8O39bhPl8+ldDGdP
         WHYwfNd0wld8onyyu9wgxwcTtITeaKNGtq0BGXaXS1IN6Kj3SH27vbCUhH6zwoYbFCIa
         BC/649p57u6qKJ4GxFIPOXBZU/W+VLhaoD25XLG8hfTBgDO7bYOakRsCy9nbg90CfAsP
         XY+lsUrPf33acR637V5zIxrwiUQHN/xj3IY+yPHnMk9bvPI1LAfn2SP0p71H8uWCsJ5m
         7ZoIdXFy1n1Auy5txlNLbUncIsRvxBszceZWTnI5FuxD7S76SaF6vpn3pvIMrhUEWCSN
         /gow==
X-Gm-Message-State: ACrzQf2MMbeBFZtedCIuxzG5wfWdmWnQo3GOyb0PMdp4EBsd74LkZKqP
        rNfcIl4vy/mNTJi4V5AWRVTMZScjUTIQuNE4F24=
X-Google-Smtp-Source: AMsMyM5KIlevA693ocjInV1CEQU3ztoIk5GG/H6QPUNePLEzde8O6y4OzyTFwxR55yBMM2FoY4qcSAVrQoqRF72vP7E=
X-Received: by 2002:a81:9ca:0:b0:354:fce9:814b with SMTP id
 193-20020a8109ca000000b00354fce9814bmr9625750ywj.458.1664568108388; Fri, 30
 Sep 2022 13:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220920014036.2295853-1-daeho43@gmail.com> <f4ce9486-f104-b0e2-25ed-f6de96316b76@kernel.org>
 <CACOAw_z=9H6jEQNd8C99c6xO55PJXWJOW7Q=78qtppgysebN2A@mail.gmail.com>
 <4aca0d00-d3b7-975f-6b72-ccd6f07d22e5@kernel.org> <CACOAw_wVU1gmH1gyWHYNqCpgy4KGKB+EZK6pbGL-h_1ToDV=vg@mail.gmail.com>
 <53df1b78-c611-6a22-88b1-74cc83a9e148@kernel.org> <CACOAw_w_09sz8PxnSGzNmJwh1-y_3JoKbBu80VjgZgV1uxo7KA@mail.gmail.com>
In-Reply-To: <CACOAw_w_09sz8PxnSGzNmJwh1-y_3JoKbBu80VjgZgV1uxo7KA@mail.gmail.com>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Fri, 30 Sep 2022 13:01:37 -0700
Message-ID: <CACOAw_wjcFr1fg3QRYPUyOGyo-G9D9U6=qprkPUP8PzoxPQkMQ@mail.gmail.com>
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

On Fri, Sep 30, 2022 at 9:04 AM Daeho Jeong <daeho43@gmail.com> wrote:
>
> > >>>>
> > >>>> Hi Daeho,
> > >>>>
> > >>>> isize should be updated after tagging inode as atomic_write one?
> > >>>> otherwise f2fs_mark_inode_dirty_sync() may update isize to inode page,
> > >>>> latter checkpoint may persist that change? IIUC...
> > >>>>
> > >>>> Thanks,
> > >>>
> > >>> Hi Chao,
> > >>>
> > >>> The first patch of this patchset prevents the inode page from being
> > >>> updated as dirty for atomic file cases.
> > >>> Is there any other chances for the inode page to be marked as dirty?
> > >>
> > >> I mean:
> > >>
> > >> Thread A                                Thread B
> > >> - f2fs_ioc_start_atomic_write
> > >>    - f2fs_i_size_write(inode, 0)
> > >>     - f2fs_mark_inode_dirty_sync
> > >>                                          - checkpoint
> > >>                                           - persist inode with incorrect zero isize
> > >>
> > >>    - set_inode_flag(inode, FI_ATOMIC_FILE)
> > >>
> > >> Am I missing something?
> > >>
> > >
> > > So, f2fs_mark_inode_dirty_sync() will not work for atomic files
> > > anymore, which means it doesn't make the inode dirty.
> > > Plz, refer to the first patch of this patchset. Or I might be confused
> > > with something. :(
> >
> > I mean FI_ATOMIC_FILE was set after f2fs_i_size_write(), so inode will be set
> > as dirty.
> >
> > Thanks,
> >
>
> Oh, I was confused that f2fs_update_inode() is called in
> f2fs_mark_inode_dirty_sync().
> That is called in f2fs_write_inode(). Let me fix this.

Hmm, I think the issue was already there before my patch.
So, how about making the inode flushed and clean if the inode is
already dirty when starting atomic write?

>
> Thanks,
