Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9423E6D71B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjDEAuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjDEAuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:50:21 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD1D10EB
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 17:50:19 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id ay14so24508486uab.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 17:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680655818;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ak7UXG4UZdCKSZRvuWDjbJRyNWdpFuarm6tImHqS+tw=;
        b=OMIpUT5GS1WJA1cd0vQ+yDW45uo967cPrQo1IK4SNc4XM7i2U4nksypSW7cCEjsWei
         yvKnocS8H44Yz/8uVAsYOa3dp3elKnqa+erEzQYklN1E+A7ELVYwF4s1Oc5qf0tC/QZZ
         KTdcixsuemTWEwJFNBG2RxPE32HcJqB2WH8ALNGbjRbyxcdi0WkGF70B+WOKXY5kbtWl
         3jL1Hw8rTUElosjDtCiW5uJ1e+gKtRHIxOBYObzJcV92gWqBnZkOoc6s8TrNx+ug4jBJ
         2E2Ib04IkXZ+hpBw9mqPJwFmyZPRb3uohKyw28qy4BZ9VO/D1uOcyiwbwQb7P+OH5bZd
         icSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680655818;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ak7UXG4UZdCKSZRvuWDjbJRyNWdpFuarm6tImHqS+tw=;
        b=EkO2eVj53wSnAPQt/QBrXnpWUxCLF8w8hcwzZjoUihdQl1DVCbnTgB9VTvHuHODO+R
         mMW5WIVSqyEAccYopO4rBFvluJG088W03ug6G5RaYuktOOK3eYV52A9DeIcEEFI3qHBA
         l+Y4ahyrJO46c3klmJU54TGUGf+uCz7uvE/wpEYoK/qQsgegq24fGWQH6N9F0wjXxnmZ
         peFi+17qm4qxexnvffVxDfHoHffa177yarUYdELy/YhNeIJ0k9OrzfRz2pdbvqJCJGLd
         jiDCzJ+8KsdW7StK21JA97Zq/G0YkiQetQUJ2LFyVn760DClzOrSTh22OpDeR3dJu5i2
         3COg==
X-Gm-Message-State: AAQBX9dY4QTECN3P7f1w9c/UJnpzrgpNiA8BlFj7OEP4m3OZ7EQ9GVDq
        tDhrnTy3HkCf7817LKzGNLsLJMqI9GCPPRkO2fI=
X-Google-Smtp-Source: AKy350a0K2xmeGb6mz8g69Vb5w5rMblGpVHWJMQBmt+Fo2pTG3v6JjII2AcZgJFgv8ViFObh6x9vTb3oZToI1AcP3po=
X-Received: by 2002:a9f:37cd:0:b0:764:64c1:9142 with SMTP id
 q71-20020a9f37cd000000b0076464c19142mr1076792uaq.0.1680655818366; Tue, 04 Apr
 2023 17:50:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230404002601.24136-1-yq882255@163.com> <CACvgo53mV7Aoe+omtSF0BNg+gVOWqDQ_QAmMkhikjQw-vF55Xw@mail.gmail.com>
 <ZCx6Q5y1dgAv2q/o@phenom.ffwll.local>
In-Reply-To: <ZCx6Q5y1dgAv2q/o@phenom.ffwll.local>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Wed, 5 Apr 2023 08:50:06 +0800
Message-ID: <CAKGbVbssdy3D8iCyUHr-kqr8spSDkTXfKzg4pQwoSZB+dv3i0A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Revert lima fdinfo patchset
To:     Emil Velikov <emil.l.velikov@gmail.com>, yq882255@163.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        lima@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Qiang Yu <yuq825@gmail.com>,
        Erico Nunes <nunes.erico@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next, sorry for the trouble.

Regards,
Qiang

On Wed, Apr 5, 2023 at 3:28=E2=80=AFAM Daniel Vetter <daniel@ffwll.ch> wrot=
e:
>
> On Tue, Apr 04, 2023 at 04:17:33PM +0100, Emil Velikov wrote:
> > On Tue, 4 Apr 2023 at 08:13, <yq882255@163.com> wrote:
> > >
> > > From: Qiang Yu <yuq825@gmail.com>
> > >
> > > Upstream has reverted the dependant commit
> > > df622729ddbf ("drm/scheduler: track GPU active time per entity""),
> > > but this patchset has been pushed to drm-misc-next which still
> > > has that commit. To avoid other branch build fail after merge
> > > drm-misc-next, just revert the lima patchset on drm-misc-next too.
> > >
> >
> > The bug/revert is unfortunate, although we better keep the build clean
> > or Linus will go bananas ^_^
> >
> > Fwiw for the series:
> > Acked-by: Emil Velikov <emil.l.velikov@gmail.com>
>
> Can you (eitehr of you really) please push asap and make sure this doesn'=
t
> miss the last drm-misc-next pull (-rc6 is this w/e)? Otherwise we'll have
> a bit a mess.
> -Daniel
>
> >
> > HTH
> > -Emil
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
