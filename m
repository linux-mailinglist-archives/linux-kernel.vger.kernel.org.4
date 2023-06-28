Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F574156C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjF1PiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:38:02 -0400
Received: from dfw.source.kernel.org ([139.178.84.217]:50038 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjF1Ph1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:37:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5578C6135B;
        Wed, 28 Jun 2023 15:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8096C433C9;
        Wed, 28 Jun 2023 15:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687966646;
        bh=URRLSvyneAYstNQfgj6lGuC/8vb3HBgmCBmh1P+6bcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=js5MkCrVzbMok4fSTLQ+uDT8alNWZKQsCCjQTWc8hxKzSJDinbBgzZUYFh9UwYnFh
         MyAMRo9QvzzM+9q0hSlveVcve4K/n0cQoNIuMz6By8JhmcjiM1L6cgL7Qcim3CD9/8
         dvwg7sVem3zOBHD1CtPsUMsnmU4G5DTbrq5deKv3U5xk9mDoE5tpd8N1spGQVkSLWJ
         tn8SHBUXWlGwiY5Tn0pXp0QiQSUGCLgo/Hab1vk75NAdo5m/JE6yOh1tqGRYOePyWE
         lK0W/CQ9d8TIxT00qL26GrGLhJmw808fD4Wkf5bTBuaMPdy+1t5+Cis65LCJP9QkT6
         B89LVb+Y6sFDw==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51d7e8dd118so6357061a12.1;
        Wed, 28 Jun 2023 08:37:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDw46TOxyxykQDtm54gg/rdgukSoUHPIlLLWix7daL1EtXK7scmT
        zC7fkExBXR03O/5ZzpOl31lIxPpw3QnHm3kVHaM=
X-Google-Smtp-Source: ACHHUZ6bt/GKONHGgdrgwHXvTepDJy81A3PhB37VRKCiiHQROMrj89C8PTgUdw3VE6MitMrJB6u8gUfAlZKVbYTZeVg=
X-Received: by 2002:a05:6402:1651:b0:51d:afb0:f05 with SMTP id
 s17-20020a056402165100b0051dafb00f05mr2997728edx.37.1687966644940; Wed, 28
 Jun 2023 08:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <7627f2b9-2287-46d2-b461-d33aa69931a8@moroto.mountain> <2217f142-470d-b467-6ad8-b1d7c0aee2c8@xen0n.name>
In-Reply-To: <2217f142-470d-b467-6ad8-b1d7c0aee2c8@xen0n.name>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 28 Jun 2023 23:37:13 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6EisP3BLAPb64To=bX-S-XaPwHmxRB1BpU+YP4McMyzg@mail.gmail.com>
Message-ID: <CAAhV-H6EisP3BLAPb64To=bX-S-XaPwHmxRB1BpU+YP4McMyzg@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Delete debugfs checking
To:     WANG Xuerui <kernel@xen0n.name>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        Immad Mir <mirimmad17@gmail.com>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued for loongarch-next, thanks.


Huacai

On Wed, Jun 28, 2023 at 10:22=E2=80=AFPM WANG Xuerui <kernel@xen0n.name> wr=
ote:
>
> Hi,
>
> On 2023/6/20 16:06, Dan Carpenter wrote:
> > Debugfs functions are not supposed to be checked for errors.  This
> > is sort of unusual but it is described in the comments for the
> > debugfs_create_dir() function.  Also debugfs_create_dir() can never
> > return NULL.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > I spotted this code because I was looking at patches which were sent
> > to stable but without a Fixes tag.  The correct way of checking for
> > error pointers is not IS_ERR_OR_NULL(), it's IS_ERR().  When a function
> > returns both error pointers and NULL, the NULL should be treated as a
> > special kind of success.  Please see my blog for more details.
> >
> > https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-a=
nd-null/
> >
> > I have not included a Fixes tag here, because it's not really a bug fix=
,
> > it's just a clean up.
>
> Thanks for the patch and sorry for the late review. I didn't notice this
> back then (just recovering from covid around that time) but since
> loongarch-next isn't tagged yet I think the patch could make it this
> cycle. (Somehow Huacai didn't see the mail either, weird...)
>
> >
> >   arch/loongarch/kernel/unaligned.c | 2 --
> >   1 file changed, 2 deletions(-)
> >
> > diff --git a/arch/loongarch/kernel/unaligned.c b/arch/loongarch/kernel/=
unaligned.c
> > index 85fae3d2d71a..3abf163dda05 100644
> > --- a/arch/loongarch/kernel/unaligned.c
> > +++ b/arch/loongarch/kernel/unaligned.c
> > @@ -485,8 +485,6 @@ static int __init debugfs_unaligned(void)
> >       struct dentry *d;
> >
> >       d =3D debugfs_create_dir("loongarch", NULL);
> > -     if (IS_ERR_OR_NULL(d))
> > -             return -ENOMEM;
> >
> >       debugfs_create_u32("unaligned_instructions_user",
> >                               S_IRUGO, d, &unaligned_instructions_user)=
;
>
> Trivial enough, thanks!
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
>
> --
> WANG "xen0n" Xuerui
>
> Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/
>
>
