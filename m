Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A65609BD1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiJXHwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJXHwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:52:23 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E242D54659
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:52:22 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id cr19so5245552qtb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2lDl36LG/JcyTlKxVA4dxBVzUz95+CXwb//i8WZcYZk=;
        b=an9OHIHO1pIh6zUhlv2uTUuLMIXGVi7zo7qgZo0I7/wyon3dVsOg3cLhHPbHEr0R46
         qah0WMeSKAj59w2EL9cOxjZVvOPbe+ObGvpfKVpFT59eDH8WAo44yqh8tQJWMPTC03j5
         lhppRWbs0jErQGif/c0xZ8fuP11Nn2em0HZTPzJWJp0U5Xv1frOATnG42/Hb+vcFX838
         ikxjHJzeztxWTBd6iZ5Yg1kU6OuXhXm5kjSud7oqk/zTCkcat9llXHxeEbAtjPI9ULYD
         PAhUOAVJ3G1EwFvoRTV2AhcKzzFInSPqKAdEFAYRmXvp9RuC6g61oDSip9irZhkoHVz2
         hYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2lDl36LG/JcyTlKxVA4dxBVzUz95+CXwb//i8WZcYZk=;
        b=LhQ10F81D1+PYJh8KgVKLgZ6g3Xkmy03bFWrzgl0tfl76bQQEx0bqpTd/xRFUnrg/H
         VYbLNqvjsAfCjRd9hKpy6VfD7TnZabZJ+0xW9jFfmdoW2e3k1TqKj3MV4aXBoEYXHGeO
         UW24qbDCs7rYgF4YROwi4iscJOUFcAt9CVZAfAEZZCgEgvwdaL6VLGlo68A0hjVwf89F
         9f/QT5Db17eyA8NWhglLhUmvHXV11RoI1p0qe9td179baXipth5gsogq7lxB6n9oqKHP
         CRt3SxAGE+f29DXO7axrUK+YNXcxrhkYdJOUC7O1o9x/rcruxhv1Qf/i99iokEK/iJFg
         +IZw==
X-Gm-Message-State: ACrzQf0u9dU6oYv35BVkrz5pBBWlII/NdOCVqkYA6eFc0lF1CHXyEKG2
        AJLP2MMRPBX60OgyMTcIBHC7K24jO+n9Y71CCzc=
X-Google-Smtp-Source: AMsMyM5Df+AsSzaUUX3TXS9vMO/D4cMyQYQ/2fH+UUetYbRRWoGPOO1KSyBSmnfzb+yi7VlDg4saudpO1R7/pAh1jyk=
X-Received: by 2002:ac8:5b81:0:b0:39c:b735:6b8b with SMTP id
 a1-20020ac85b81000000b0039cb7356b8bmr26122809qta.416.1666597941957; Mon, 24
 Oct 2022 00:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221022214622.18042-1-ogabbay@kernel.org> <20221022214622.18042-3-ogabbay@kernel.org>
 <Y1U2K+fAnGbYug/+@kroah.com> <CAFCwf11PxtcRZegVBxYfJQFpYO0AipobJXWWp4ch+7mMKRLuKg@mail.gmail.com>
In-Reply-To: <CAFCwf11PxtcRZegVBxYfJQFpYO0AipobJXWWp4ch+7mMKRLuKg@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Mon, 24 Oct 2022 17:52:10 +1000
Message-ID: <CAPM=9txP8N2kzeDHEbSbiO-oAy5cemJ_Ag4WqeCNzdx6b3quBA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] drm: define new accel major and register it
To:     Oded Gabbay <ogabbay@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel@ffwll.ch>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022 at 17:23, Oded Gabbay <ogabbay@kernel.org> wrote:
>
> On Sun, Oct 23, 2022 at 3:40 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sun, Oct 23, 2022 at 12:46:21AM +0300, Oded Gabbay wrote:
> > > The accelerator devices will be exposed to the user space with a new,
> > > dedicated major number - 261.
> > >
> > > The drm core registers the new major number as a char device and create
> > > corresponding sysfs and debugfs root entries, same as for the drm major.
> > >
> > > In case CONFIG_ACCEL is not selected, this code is not compiled in.
> > >
> > > Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
> > > ---
> > >  Documentation/admin-guide/devices.txt |  5 +++
> > >  drivers/gpu/drm/drm_drv.c             | 45 +++++++++++++++++++++++
> > >  drivers/gpu/drm/drm_internal.h        |  3 ++
> > >  drivers/gpu/drm/drm_sysfs.c           | 52 +++++++++++++++++++++++++++
> > >  include/drm/drm_ioctl.h               |  1 +
> > >  5 files changed, 106 insertions(+)
> > >
> > > diff --git a/Documentation/admin-guide/devices.txt b/Documentation/admin-guide/devices.txt
> > > index 9764d6edb189..06c525e01ea5 100644
> > > --- a/Documentation/admin-guide/devices.txt
> > > +++ b/Documentation/admin-guide/devices.txt
> > > @@ -3080,6 +3080,11 @@
> > >                 ...
> > >                 255 = /dev/osd255     256th OSD Device
> > >
> > > + 261 char    Compute Acceleration Devices
> > > +               0 = /dev/accel/accel0 First acceleration device
> > > +               1 = /dev/accel/accel1 Second acceleration device
> > > +                 ...
> > > +
> > >   384-511 char        RESERVED FOR DYNAMIC ASSIGNMENT
> > >               Character devices that request a dynamic allocation of major
> > >               number will take numbers starting from 511 and downward,
> > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > index 8214a0b1ab7f..b58ffb1433d6 100644
> > > --- a/drivers/gpu/drm/drm_drv.c
> > > +++ b/drivers/gpu/drm/drm_drv.c
> > > @@ -67,6 +67,10 @@ static bool drm_core_init_complete;
> > >
> > >  static struct dentry *drm_debugfs_root;
> > >
> > > +#ifdef CONFIG_ACCEL
> > > +static struct dentry *accel_debugfs_root;
> > > +#endif
> > > +
> > >  DEFINE_STATIC_SRCU(drm_unplug_srcu);
> > >
> > >  /*
> > > @@ -1031,9 +1035,19 @@ static const struct file_operations drm_stub_fops = {
> > >       .llseek = noop_llseek,
> > >  };
> > >
> > > +static void accel_core_exit(void)
> > > +{
> > > +#ifdef CONFIG_ACCEL
> > > +     unregister_chrdev(ACCEL_MAJOR, "accel");
> > > +     debugfs_remove(accel_debugfs_root);
> > > +     accel_sysfs_destroy();
> > > +#endif
> > > +}
> >
> > Why is all of this in drm_drv.c?
> >
> > Why not put it in drm/accel/accel.c or something like that?  Then put
> > the proper stuff into a .h file and then you have no #ifdef in the .c
> > files.
> I thought about that, adding an accel.c in drivers/accel/ and putting
> this code there.
> Eventually I thought that for two functions it's not worth it, but I
> guess that in addition to the reason you gave, one can argue that
> there will probably be more code in that file anyway, so why not open
> it now.
> I'll change this if no one else thinks otherwise.

Seems like a good idea to start doing it now, might make things easier
to keep separated.

Dave.
