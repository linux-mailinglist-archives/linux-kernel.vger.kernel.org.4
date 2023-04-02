Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30B2F6D384D
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjDBO10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDBO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:27:24 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A3B10264
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:27:23 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id cz11so23188105vsb.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 07:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680445642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAjdoltsGkUUCuNGdmSPqiLs+nEKH+6FFfXSQhZ99GY=;
        b=IhEla1/C0IvZeXoJK+i6AqkJEo8lszD7z2sIqDyF8osHdTKr20Z2Loq9Xyky1Zml/W
         vjjftt5ztQBhEvBIUq0FwoETobSHMJLwBGYW3ZcKpUYYtOqX21P9OEWM+wRu4nFzaph7
         NDLEMZXOMWpqSZXbACOoZWkAb+LRG44WH4jVvH4GDAOCts4YK4HGjx0Sc7nlEh+xQ8ok
         nXode2FTC9a4ntreUB7IxPFCg2vGnxGgkOcvoPRry+XFj29wPBtV0IGyb/SOEijv2CK4
         NQ42xlq+qUgDUsMWSez939xv0o8n5mh2sB15Osi1JPkuNeOFuiMGYMthZcDD44jiGx33
         nymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680445642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAjdoltsGkUUCuNGdmSPqiLs+nEKH+6FFfXSQhZ99GY=;
        b=z1/cFnZCfQ5q/Yz4GWf6bBNKd2ZUXWEHy3bZv1SyeURvSruGzSUbEb152ay6vODDh1
         8oNg6VbCYb0JGdGoCno8ULy5limPbVP7bLSx44x+GialkRu+UcoRoknYPH59d07vKi+k
         W2XTXoZKMXB8ncFw78dBztcQ0gD08NAX5yAXWbyldiJYYDfAZXGJivUwz3ETOePr9n7b
         Tn+o/RiHZscAhdccpwd2jv81tQ2UTe8Vtx+CUS9L55Ij4DUbslKNzV9fnMJhQdEHAJLa
         RzkgTG6CsjVnp0Pjshjx9Hjs1RaSIrc/yj4oWRj/haQ0o1bwdFcxsng3FmhdmJApgeBL
         TDzg==
X-Gm-Message-State: AAQBX9cQwh0x87EBkl93Pusk6WY/ww+dlyodmiKWavSVe4lXrUfVWExZ
        /y6+wRLvF24D09dJrwRZqYjTsOxOVbsaa11n7xrM6wXeEVhA6scD
X-Google-Smtp-Source: AKy350Yt4uzToQrAwa9Y0BJVN5Y2Tr15T43akRaPXmB6buytqrmKlyl7AEMV6WmfYnEf/eRc3ppGLu5vvgJKRI6MyBs=
X-Received: by 2002:a67:e04d:0:b0:425:e623:360a with SMTP id
 n13-20020a67e04d000000b00425e623360amr17728315vsl.1.1680445642565; Sun, 02
 Apr 2023 07:27:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230312233052.21095-1-nunes.erico@gmail.com> <CAKGbVbs2ZRGyYOy9yYUMJ+apQm=NaXXb58C-97CaoTe5KPNqgw@mail.gmail.com>
 <CAKGbVbtb-cKv2Fb1x91vZssZxayxciSp3RLJeVsn0z1JhvT6QQ@mail.gmail.com> <3c1d4d055df1b75c757956b47b77a23a9edcf842.camel@lynxeye.de>
In-Reply-To: <3c1d4d055df1b75c757956b47b77a23a9edcf842.camel@lynxeye.de>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Sun, 2 Apr 2023 22:27:11 +0800
Message-ID: <CAKGbVbvaHgJbuh4O8K1CXhYn_PFwBzrkdXzM4YhFAMnuQ0ncUw@mail.gmail.com>
Subject: Re: [PATCH 0/3] drm/lima: expose usage statistics via fdinfo
To:     dev@lynxeye.de
Cc:     Erico Nunes <nunes.erico@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org
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

> "df622729ddbf drm/scheduler: track GPU active time per entity" had to
> be reverted due to it introducing a use after free. I guess this
> patchset now conflicts with the revert.
>
I do get some build fail message on other branch. Do I need to revert this
patchset on drm-misc-next or left to branch maintainer to decide whether
to pick this patchset upstream?

Regards,
Qiang

>
> > On Mon, Mar 13, 2023 at 11:09=E2=80=AFAM Qiang Yu <yuq825@gmail.com> wr=
ote:
> > >
> > > Patch set is:
> > > Reviewed-by: Qiang Yu <yuq825@gmail.com>
> > >
> > > Looks like drm-misc-next does not contain "df622729ddbf drm/scheduler=
:
> > > track GPU active time per entity" yet.
> > > Will apply later.
> > >
> > > Regards,
> > > Qiang
> > >
> > > On Mon, Mar 13, 2023 at 7:31=E2=80=AFAM Erico Nunes <nunes.erico@gmai=
l.com> wrote:
> > > >
> > > > Expose lima gp and pp usage stats through fdinfo, following
> > > > Documentation/gpu/drm-usage-stats.rst.
> > > > Borrowed from these previous implementations:
> > > >
> > > > "df622729ddbf drm/scheduler: track GPU active time per entity" adde=
d
> > > > usage time accounting to drm scheduler, which is where the data use=
d
> > > > here comes from.
> > > >
> > > > Then the main implementation is based on these etnaviv commits:
> > > > "d306788b6e1b drm/etnaviv: allocate unique ID per drm_file" and
> > > > "97804a133c68 drm/etnaviv: export client GPU usage statistics via
> > > > fdinfo"
> > > >
> > > > Also "874442541133 drm/amdgpu: Add show_fdinfo() interface" since l=
ima
> > > > has a context manager very similar to amdgpu and all contexts creat=
ed
> > > > (and released) at the ctx_mgr level need to be accounted for.
> > > >
> > > > Tested with the generic "gputop" tool currently available as patche=
s to
> > > > igt, a sample run with this patchset looks like this:
> > > >
> > > > DRM minor 128
> > > >     PID               NAME             gp                        pp
> > > >     4322   glmark2-es2-way |=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=8A                  ||=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=
=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=
=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88=E2=96=88      |
> > > >     3561            weston |=E2=96=8E                       ||=E2=
=96=88=E2=96=88=E2=96=88=E2=96=8C                    |
> > > >     4159          Xwayland |=E2=96=8F                       ||=E2=
=96=89                       |
> > > >     4154          glxgears |=E2=96=8F                       ||=E2=
=96=8E                       |
> > > >     3661           firefox |=E2=96=8F                       ||=E2=
=96=8F                       |
> > > >
> > > >
> > > > Erico Nunes (3):
> > > >   drm/lima: add usage counting method to ctx_mgr
> > > >   drm/lima: allocate unique id per drm_file
> > > >   drm/lima: add show_fdinfo for drm usage stats
> > > >
> > > >  drivers/gpu/drm/lima/lima_ctx.c    | 30 ++++++++++++++++++++-
> > > >  drivers/gpu/drm/lima/lima_ctx.h    |  3 +++
> > > >  drivers/gpu/drm/lima/lima_device.h |  3 +++
> > > >  drivers/gpu/drm/lima/lima_drv.c    | 43 ++++++++++++++++++++++++++=
+++-
> > > >  drivers/gpu/drm/lima/lima_drv.h    |  1 +
> > > >  5 files changed, 78 insertions(+), 2 deletions(-)
> > > >
> > > > --
> > > > 2.39.2
> > > >
>
