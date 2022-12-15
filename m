Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E4864D56C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 04:03:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiLODDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 22:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLODDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 22:03:22 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 948B650D5A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 19:03:19 -0800 (PST)
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 02AC14432C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 03:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1671073398;
        bh=Shp823L6RZfDJayvg71t5HMZdkNSNeqW9yhC4NveSrM=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=eSdALwIKruHELBDfE8fEDOiA+gWUE+kdepfXayxK85a/4mPIG510C9jb9q227naK8
         cFN3TOrWCvsyhnqxpnvogOlyaBWoD6Walw5K1hFwmKrZBq8GP4GQhE1BlwmbcGl6JT
         Sn0OImFCwHQtUsrEhqJWhf9PlkW+PzgGME8jJXu68PLHUNrbYyc+pZp9rO99Efmi1a
         2d0Ai03F77/Aa9VSd754gp246P/+ThjCM62hPuFVIGmiO7nTxh+Z0tCvNmMIDZEz4L
         QvoArqLiqedG7ZvghcXM38CO51Sjrf6fzqj9qD8c6GxykVr2hnKHd1V1zOVW8WjXAx
         uUo5hYiBpEr9Q==
Received: by mail-vk1-f199.google.com with SMTP id 20-20020a1f1714000000b003bc77fdf3c9so3145116vkx.14
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 19:03:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Shp823L6RZfDJayvg71t5HMZdkNSNeqW9yhC4NveSrM=;
        b=d4TYSpFYoJuFFZpGt7ZTfGdkVL1zeph8E94z/GK+5vYWqv8N4plbT2M9tRq0/gmb85
         Uo0593AiMy+/6P/GxVT+0CA//64zCMCr0w4qqVFDONS2+YNd49O/8UuO2ZZeHYIzwPk8
         Langl7X/a2ert8rZAsckQb+IJKx1gZ0sTp7X5pzSuCobISRrrgbqVdrZZ1FbwMeR7d0T
         vNsxzrBqbaHLY3ij2o+RTG5GiI7GCqh3Q1jy50gZ6rtsfwsANutpMQT2qa1rybCnSJBn
         JcXj54dg55cud+xEUVsVncU24i2NIcanAH1iaJZnnldOIuCpog9L/HEeFDC8gIs9rK2o
         e60g==
X-Gm-Message-State: ANoB5pkgM67KHqx+rqN6LPHiJFP1pS+RjF7klx72/XwD8jrEOZxO3Otq
        wYkZ2uElSoGMhD60x8eKeHGjnUS/sRrdN5gIX8TbUKp77wl+aVQd+m6c5N6qNdzEM/u7P8WIap0
        QU4HXtQ0YtV4I4nBxoxXhBs4hvMJmx1CVJYNa8CB9ATosQpzGeztpgwQF4w==
X-Received: by 2002:a1f:5f4c:0:b0:3be:70c:a357 with SMTP id t73-20020a1f5f4c000000b003be070ca357mr3380394vkb.33.1671073395750;
        Wed, 14 Dec 2022 19:03:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf46V6j7wzDnosdj+mEU9Q0vSVnXoj4ddMLL3vH6ARqPUJaQ33n20wStZ51pvKCVN9OTKGVL+cbJSwoyOemQZN8=
X-Received: by 2002:a1f:5f4c:0:b0:3be:70c:a357 with SMTP id
 t73-20020a1f5f4c000000b003be070ca357mr3380392vkb.33.1671073395491; Wed, 14
 Dec 2022 19:03:15 -0800 (PST)
MIME-Version: 1.0
References: <20221214084730.296936-1-chengen.du@canonical.com> <2B6CD9C5-EE21-4275-9F6E-AF1C1C5E164F@hammerspace.com>
In-Reply-To: <2B6CD9C5-EE21-4275-9F6E-AF1C1C5E164F@hammerspace.com>
From:   Chengen Du <chengen.du@canonical.com>
Date:   Thu, 15 Dec 2022 11:03:04 +0800
Message-ID: <CAPza5qdWzbNcBt7ZvUxtonB38v07cDVPkBOtdBPvK=3_Y+rWgg@mail.gmail.com>
Subject: Re: [PATCH] NFS: fix client permission error after adding user to
 permissible group
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Charles Edward Lever <chuck.lever@oracle.com>,
        Jeffrey Layton <jlayton@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

Hi Trond,

Thanks for your information.

Best regards,
Chengen Du

On Thu, Dec 15, 2022 at 3:42 AM Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>
>
>
> > On Dec 14, 2022, at 03:47, Chengen Du <chengen.du@canonical.com> wrote:
> >
> > The access cache only expires if either NFS_INO_INVALID_ACCESS flag is =
on
> > or timeout (without delegation).
> > Adding a user to a group in the NFS server will not cause any file
> > attributes to change.
> > The client will encounter permission errors until other file attributes
> > are changed or the memory cache is dropped.
> >
> > Steps to reproduce the issue:
> > 1.[client side] testuser is not part of testgroup
> >  testuser@kinetic:~$ ls -ld /mnt/private/
> >  drwxrwx--- 2 root testgroup 4096 Nov 24 08:23 /mnt/private/
> >  testuser@kinetic:~$ mktemp -p /mnt/private/
> >  mktemp: failed to create file via template
> >  =E2=80=98/mnt/private/tmp.XXXXXXXXXX=E2=80=99: Permission denied
> > 2.[server side] add testuser into testgroup, which has access to folder
> >  root@kinetic:~$ usermod -aG testgroup testuser &&
> >  echo `date +'%s'` > /proc/net/rpc/auth.unix.gid/flush
> > 3.[client side] create a file again but still fail
> >  testuser@kinetic:~$ mktemp -p /mnt/private/
> >  mktemp: failed to create file via template
> >  =E2=80=98/mnt/private/tmp.XXXXXXXXXX=E2=80=99: Permission denied
> >
>
> Thanks, but the correct way to deal with this is to log out and log back =
in again, the way the POSIX gods intended. See commit 0eb43812c027 ("NFS: C=
lear the file access cache upon login=E2=80=9D).
>
> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
