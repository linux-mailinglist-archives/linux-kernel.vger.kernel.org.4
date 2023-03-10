Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4426B346B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjCJC5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCJC5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:57:17 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752413D63
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 18:57:15 -0800 (PST)
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com [209.85.128.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ADB493F1A0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678417033;
        bh=3sTHzgj+J8hmROSd/9xABa2GjjvjsJIVhxYvLkB5m2o=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=jHCTnyI2xp8jLURDfYFhcuYHaE0AFrq6V7PXJpat9YC+iyQ+FLVDlmHpm9f5OmcWL
         af2yJsdbyGbaW+efGiW5xw8NRP/dPwwrSkkJDbFwPYi9WxXMbWpHq9PenH2RQdjmc1
         /izaR6oBbj2+6JoPGlpqc/ztnaSEhIdn9MK9yCMFNoh8B5GUOmjWZJ0omeWIgTeidS
         LOpLf3ugt8+B0OS3tPPz2AiGrxJd+Q9P+2wslxsgM/ZY1kp2NVmYCtNQUSYedYdnWH
         0quLF0g/wKnP9wES+TDkrnwAyrcrnx0A8kt3BAaLLPIIuGXYMm/6mAHx6kTVU3DhVC
         nRZbnt9h05T+Q==
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-53865bdc1b1so39820627b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 18:57:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678417032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3sTHzgj+J8hmROSd/9xABa2GjjvjsJIVhxYvLkB5m2o=;
        b=AYa6LMwCrrjn7/4LfeZ15HZ9dz73Vt9VW2J9olBYW0Dt5S6Tbk6H38jeiSEK7lx3Ny
         +b0DiXPz0+WpP3Bepq+sAdVHQkyrojqLJX6gKgTfq1ERH7VXzYPYGFKe5HPTadTdN+Ay
         OfUM5YfrjoiK3CDOTUR4eHrfDXZ82uQ89CjdLY8kQ10pMS8engAdPeJhbRuh4JTiVAEg
         537HXngsAetsZ2Nhm1/edzx6LiJ7y9jXc4FcDSVq2vmWj7RKEot2ReEKKzRCEWT7/fL8
         nKFWjqUe12nMklKojt7G/r7hp9o3eK17YGLH8g3wkPLtVD4+ydMZQtDq43hR6p6LjIiQ
         mEKQ==
X-Gm-Message-State: AO0yUKUVFLoZRW9NkbNfCFqUz/g6dcch0DHY7Ow1X65u+VCT7g4+Lup9
        z8SilEKaMdwpzt/BYwFrEbPs90/d6VRgmOWQ5qB74+0S7c02xqWyZO6GNqLk3t6Yd50TlfuiO3M
        6Ja29lWf+U5Z3u0HB5Wt4PhHRXPRYJYB93qX/89oBHB2OLhnJ34EkcdSlh9SO272hC5b+
X-Received: by 2002:a05:6902:2cf:b0:b21:5fb4:c6e6 with SMTP id w15-20020a05690202cf00b00b215fb4c6e6mr3887488ybh.11.1678417032574;
        Thu, 09 Mar 2023 18:57:12 -0800 (PST)
X-Google-Smtp-Source: AK7set/2uO0T6jpQtGwECA9hf15A2/3Lr65afkblWLIB9avG9lKThMGuaTgTiUk65PmSQJqLgUN2k2zDM4Fqoq7n5iM=
X-Received: by 2002:a05:6902:2cf:b0:b21:5fb4:c6e6 with SMTP id
 w15-20020a05690202cf00b00b215fb4c6e6mr3887478ybh.11.1678417032315; Thu, 09
 Mar 2023 18:57:12 -0800 (PST)
MIME-Version: 1.0
References: <20230308080327.33906-1-chengen.du@canonical.com> <1B808CC0-49C6-4AF6-B7E2-0772A71DB490@redhat.com>
In-Reply-To: <1B808CC0-49C6-4AF6-B7E2-0772A71DB490@redhat.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Fri, 10 Mar 2023 10:57:01 +0800
Message-ID: <CAPza5qe=e-CkG+j4NYzF24cv5ZDFbheOFfAi+LQ_OW0pZmfc9g@mail.gmail.com>
Subject: Re: [PATCH] NFS: Correct timing for assigning access cache timestamp
To:     trond.myklebust@hammerspace.com
Cc:     Benjamin Coddington <bcodding@redhat.com>, anna@kernel.org,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We would like to inform you that we have utilized the patch to create
a test kernel,
which has been made available for community testing.
We are pleased to report that the feedback received thus far indicates
that the patch has successfully resolved the issue at hand.

Please refer to the following link for further details on the related
bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2009325

Thank you for your attention to this matter.

Best regards,
Chengen Du

On Wed, Mar 8, 2023 at 10:45=E2=80=AFPM Benjamin Coddington <bcodding@redha=
t.com> wrote:
>
> On 8 Mar 2023, at 3:03, Chengen Du wrote:
>
> > When the user's login time is newer than the cache's timestamp,
> > the original entry in the RB-tree will be replaced by a new entry.
> > Currently, the timestamp is only set if the entry is not found in
> > the RB-tree, which can cause the timestamp to be undefined when
> > the entry exists. This may result in a significant increase in
> > ACCESS operations if the timestamp is set to zero.
> >
> > Signed-off-by: Chengen Du <chengen.du@canonical.com>
> > ---
> >  fs/nfs/dir.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > index a41c3ee4549c..6fbcbb8d6587 100644
> > --- a/fs/nfs/dir.c
> > +++ b/fs/nfs/dir.c
> > @@ -3089,7 +3089,6 @@ static void nfs_access_add_rbtree(struct inode *i=
node,
> >               else
> >                       goto found;
> >       }
> > -     set->timestamp =3D ktime_get_ns();
> >       rb_link_node(&set->rb_node, parent, p);
> >       rb_insert_color(&set->rb_node, root_node);
> >       list_add_tail(&set->lru, &nfsi->access_cache_entry_lru);
> > @@ -3114,6 +3113,7 @@ void nfs_access_add_cache(struct inode *inode, st=
ruct nfs_access_entry *set,
> >       cache->fsgid =3D cred->fsgid;
> >       cache->group_info =3D get_group_info(cred->group_info);
> >       cache->mask =3D set->mask;
> > +     cache->timestamp =3D ktime_get_ns();
> >
> >       /* The above field assignments must be visible
> >        * before this item appears on the lru.  We cannot easily
> > --
> > 2.37.2
>
> Looks good to me.
>
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>
