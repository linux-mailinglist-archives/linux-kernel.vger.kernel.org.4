Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDE573DD61
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 13:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjFZLX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 07:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFZLXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 07:23:49 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340F10C8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:23:32 -0700 (PDT)
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A94423F266
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 11:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1687778611;
        bh=Z5dfNx1riqTyw4HtL2XD/3WFjVhdY5Y5WByZUvpoBs0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=iptwfWe8s/q7f9sbiO8O63S6p+3LBY8clumDh7H3vftnoE1WscaVnuucmcJUeXudr
         03qP/FplNCeyysLXU/wd8+D5bDk+da8zoi5VAJP1vmt+H2nAxyhPvZ7/DHPl0H1UjN
         Aevfx3Vo4DYNXW6u3bwQ5uWq0sQ6bE1jT//eMCutwk9AjDsTcgiEEbRgpHinnAtl0K
         R4uUKp0AAScMWZ4OG8Cr90+ss4BYVJGfHgJgTUH/U4cnBt+7oWY01VmqG+3a1sqx6/
         Z72UcNvy9axBaKG0lg5qlMp/jtEG76Wehpoo46a3B5QrS0Dq9iO8iE85udbAgy93Fw
         Ys/SKW1ZaFn9A==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-bfee66a6398so3058777276.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 04:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687778608; x=1690370608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5dfNx1riqTyw4HtL2XD/3WFjVhdY5Y5WByZUvpoBs0=;
        b=U50+XNPgKR+tET7+JpdesHTiDrfGoY6+gN0BofFmdHaGpubLoOG2B3xEFMa/Qua+pj
         9IsU3pJlZm/lQ0BxmjznUzj4cyLen0MZX/arqRj40ajuywmTO5Xtn52ERJGNC6m8V/eN
         jXVeS5/upJGnPTWzTofwcPE9YUKBMyxnUbyWo74O+wj3CZyRCMuTYZOv3uzHMe3n6JaJ
         mhJuHIWKeC/ALNX12vqXlBIwbsJfZoKe7xTLybaG2+hmtPrQpcvjlPH+C+SqPhLCtLAo
         UTBp0AsKumjEOHqxNSajS/tPLQAxfXqFJnZ6vqDKMZvhdSBsa6w3+ey9VlEbj/En8aIo
         /s8g==
X-Gm-Message-State: AC+VfDxszSVtdTNXk3ghw+oGxQZWoBwrttm5NakXVkZ/5X8UsjoizyyQ
        Y1XhQUaZLFRgJ1fRXUvgc1qaXMn10jg2Xsm8NKk0tycSCa0X4L78DKgCUkyxZIyZhwycbvtTckA
        +FMweA8nz8ZIGsWyC36ER1pMkRsyiVOgNH2TDr+9ye3SG3+PCQLSZoIiuJ4QYn7MiZg==
X-Received: by 2002:a25:ae50:0:b0:bc8:56b0:dbf9 with SMTP id g16-20020a25ae50000000b00bc856b0dbf9mr19465330ybe.24.1687778608060;
        Mon, 26 Jun 2023 04:23:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AI9fbk3WwSsbUOyoxAuMs9m0uDlRR6nSOYCE2kIustaiqTCjBZBy1yMaUIjS2hoP+K9ivcZ3ctKP2S0PPS9M=
X-Received: by 2002:a25:ae50:0:b0:bc8:56b0:dbf9 with SMTP id
 g16-20020a25ae50000000b00bc856b0dbf9mr19465313ybe.24.1687778607661; Mon, 26
 Jun 2023 04:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
 <f3864ed6-8c97-8a7a-f268-dab29eb2fb21@redhat.com> <CAEivzxcRsHveuW3nrPnSBK6_2-eT4XPvza3kN2oogvnbVXBKvQ@mail.gmail.com>
 <20230609-alufolie-gezaubert-f18ef17cda12@brauner> <CAEivzxc_LW6mTKjk46WivrisnnmVQs0UnRrh6p0KxhqyXrErBQ@mail.gmail.com>
 <ac1c6817-9838-fcf3-edc8-224ff85691e0@redhat.com> <CAJ4mKGby71qfb3gd696XH3AazeR0Qc_VGYupMznRH3Piky+VGA@mail.gmail.com>
 <977d8133-a55f-0667-dc12-aa6fd7d8c3e4@redhat.com> <CAEivzxcr99sERxZX17rZ5jW9YSzAWYvAjOOhBH+FqRoso2=yng@mail.gmail.com>
 <626175e2-ee91-0f1a-9e5d-e506aea366fa@redhat.com> <64241ff0-9af3-6817-478f-c24a0b9de9b3@redhat.com>
 <CAEivzxeF51ZEKhQ-0M35nooZ7_cZgk1-q75-YbkeWpZ9RuHG4A@mail.gmail.com> <4c4f73d8-8238-6ab8-ae50-d83c1441ac05@redhat.com>
In-Reply-To: <4c4f73d8-8238-6ab8-ae50-d83c1441ac05@redhat.com>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Mon, 26 Jun 2023 13:23:16 +0200
Message-ID: <CAEivzxeQGkemxVwJ148b_+OmntUAWkdL==yMiTMN+GPyaLkFPg@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] ceph: support idmapped mounts
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Gregory Farnum <gfarnum@redhat.com>,
        Christian Brauner <brauner@kernel.org>, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 4:12=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 6/24/23 15:11, Aleksandr Mikhalitsyn wrote:
> > On Sat, Jun 24, 2023 at 3:37=E2=80=AFAM Xiubo Li <xiubli@redhat.com> wr=
ote:
> >> [...]
> >>
> >>   > > >
> >>   > > > I thought about this too and came to the same conclusion, that
> >> UID/GID
> >>   > > > based
> >>   > > > restriction can be applied dynamically, so detecting it on mou=
nt-time
> >>   > > > helps not so much.
> >>   > > >
> >>   > > For this you please raise one PR to ceph first to support this, =
and in
> >>   > > the PR we can discuss more for the MDS auth caps. And after the =
PR
> >>   > > getting merged then in this patch series you need to check the
> >>   > > corresponding option or flag to determine whether could the idma=
p
> >>   > > mounting succeed.
> >>   >
> >>   > I'm sorry but I don't understand what we want to support here. Do =
we
> >> want to
> >>   > add some new ceph request that allows to check if UID/GID-based
> >>   > permissions are applied for
> >>   > a particular ceph client user?
> >>
> >> IMO we should prevent user to set UID/GID-based permisions caps from
> >> ceph side.
> >>
> >> As I know currently there is no way to prevent users to set MDS auth
> >> caps, IMO in ceph side at least we need one flag or option to disable
> >> this once users want this fs cluster sever for idmap mounts use case.
> > How this should be visible from the user side? We introducing a new
> > kernel client mount option,
> > like "nomdscaps", then pass flag to the MDS and MDS should check that
> > MDS auth permissions
> > are not applied (on the mount time) and prevent them from being
> > applied later while session is active. Like that?
> >
> > At the same time I'm thinking about protocol extension that adds 2
> > additional fields for UID/GID. This will allow to correctly
> > handle everything. I wanted to avoid any changes to the protocol or
> > server-side things. But if we want to change MDS side,
> > maybe it's better then to go this way?

Hi Xiubo,

>
> There is another way:
>
> For each client it will have a dedicated client auth caps, something like=
:
>
> client.foo
>    key: *key*
>    caps: [mds] allow r, allow rw path=3D/bar
>    caps: [mon] allow r
>    caps: [osd] allow rw tag cephfs data=3Dcephfs_a

Do we have any infrastructure to get this caps list on the client side
right now?
(I've taken a quick look through the code and can't find anything
related to this.)

>
> When mounting this client with idmap enabled, then we can just check the
> above [mds] caps, if there has any UID/GID based permissions set, then
> fail the mounting.

understood

>
> That means this kind client couldn't be mounted with idmap enabled.
>
> Also we need to make sure that once there is a mount with idmap enabled,
> the corresponding client caps couldn't be append the UID/GID based
> permissions. This need a patch in ceph anyway IMO.

So, yeah we will need to effectively block cephx permission changes if
there is a client mounted with
an active idmapped mount. Sounds as something that require massive
changes on the server side.

At the same time this will just block users from using idmapped mounts
along with UID/GID restrictions.

If you want me to change server-side anyways, isn't it better just to
extend cephfs protocol to properly
handle UID/GIDs with idmapped mounts? (It was originally proposed by Christ=
ian.)
What we need to do here is to add a separate UID/GID fields for ceph
requests those are creating a new inodes
(like mknod, symlink, etc).

Kind regards,
Alex

>
> Thanks
>
> - Xiubo
>
>
>
>
>
> >
> > Thanks,
> > Alex
> >
> >> Thanks
> >>
> >> - Xiubo
> >>
>
