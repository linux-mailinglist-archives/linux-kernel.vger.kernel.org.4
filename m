Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D2A6BEF2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjCQRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCQRGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:06:37 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBD6474F4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:06:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so5898003pjp.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 10:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679072782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5reig46CNQ6/X2/bvwfJ3zaFoMfC+ntfiSgkbPTgBZA=;
        b=IGC7asFwbazCZ+s5zhS2ojtWJIcb+m+rqslYW45+dbJY9euKmCbCp58M376x28chuy
         Br9sgNFdGL+lbgCWKD5mWn8K+edmhQDgJZbmN91jm5sv/fLIHxsONi3+OQ2O+aDUL/AD
         YTOt3FY0nASXbx2E0LGZCNOZP8z4wEaWGqvhTMW1L3Iz9FQpmd4RrH6vleZF37tRmv5S
         zpWKDoaT1Nnu/IVO5Po1SiZgi6Es28N4EINE+RI0RU/lFSB/iduykP/eACr+Fer2kSgz
         PMDvqB8jizwbPgsNstYfH1XPDAaOVIMyg0TuYpOk4kriGFc+mVkCjUc5PGLmuLZv7gBN
         Rp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679072782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5reig46CNQ6/X2/bvwfJ3zaFoMfC+ntfiSgkbPTgBZA=;
        b=Qfdin+nr/vI4+R1AGek2tUZ7Zpxd1nPUv9oMWFa/IoxZisWKK/SrIrXkcvI/SJtWE8
         4Zt8u+sHCkaOMmX3QaOIW3K1f9MfhJ3Gw9wLIVgJmGMYD+6HaPJB5EvRgO3FJ2HlS2Ps
         K+fk8cFRFsLsi8UmFSyTCjDyiPMSs5rWAmDZExnCogBdAGL5MlVUdFI4PbJl3qfXD64B
         9rHdTbdq60WCWRwUCKOzpyIDHIR8Us8IMy81CA8GzxQ3ckbQzNtaB8/2W33chINRXt0d
         2ALEIgXFYwhyQQG5oaH+UX8lwBU6o7UluRRbXg5RVJvI4Aia9WMwM70V+NAHDlAozor9
         ooqg==
X-Gm-Message-State: AO0yUKUsZGNo6aezm4+/iopi5Vm745tY80e+63mv87OaXA0QnOQH5dL3
        PoKdf8D7Nm6Wu4TAKve6yoYHPCC9xhmgf+TkyI4K1g==
X-Google-Smtp-Source: AK7set+/xImwEtemalZJBSvG1dfqmcq32GfKRhByAX7iyhIdrv/tGSRDZn0k0q/9sUcC5OydcOf7DvKgd0W214bjZ1c=
X-Received: by 2002:a17:902:d485:b0:1a1:b3bb:cd50 with SMTP id
 c5-20020a170902d48500b001a1b3bbcd50mr36558plg.10.1679072781616; Fri, 17 Mar
 2023 10:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230315010732.633992-1-saravanak@google.com> <ZBR1WHPpcrOMFwVe@kroah.com>
 <CAD=FV=XUe194BqM42QhZzxQ1M1uDmVbeya34p7shEGjTr2C1SQ@mail.gmail.com>
In-Reply-To: <CAD=FV=XUe194BqM42QhZzxQ1M1uDmVbeya34p7shEGjTr2C1SQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Mar 2023 10:05:45 -0700
Message-ID: <CAGETcx-GicLK1eLbLJktvsnYfH0RJCO4G47_Kxv8OrJrms9q=w@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Add CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 9:57=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Fri, Mar 17, 2023 at 7:12=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Tue, Mar 14, 2023 at 06:07:31PM -0700, Saravana Kannan wrote:
> > > Add a build time equivalent of fw_devlink.sync_state=3Dtimeout so tha=
t
> > > board specific kernels could enable it and not have to deal with sett=
ing
> > > or cluttering the kernel commandline.
> > >
> > > Cc: Doug Anderson <dianders@chromium.org>
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > ---
> > >  drivers/base/Kconfig | 12 ++++++++++++
> > >  drivers/base/core.c  |  5 +++++
> > >  2 files changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/base/Kconfig b/drivers/base/Kconfig
> > > index 6f04b831a5c0..aac247512d69 100644
> > > --- a/drivers/base/Kconfig
> > > +++ b/drivers/base/Kconfig
> > > @@ -230,4 +230,16 @@ config GENERIC_ARCH_NUMA
> > >         Enable support for generic NUMA implementation. Currently, RI=
SC-V
> > >         and ARM64 use it.
> > >
> > > +config FW_DEVLINK_SYNC_STATE_TIMEOUT
> > > +     bool
> > > +     help
> > > +       This is build time equivalent of adding kernel command line p=
arameter
> > > +       "fw_devlink.sync_state=3Dtimeout". Give up waiting on consume=
rs and
> > > +       call sync_state() on any devices that haven't yet received th=
eir
> > > +       sync_state() calls after deferred_probe_timeout has expired o=
r by
> > > +       late_initcall() if !CONFIG_MODULES. You should almost always =
want to
> > > +       select N here unless you have already successfully tested wit=
h the
> > > +       command line option on every system/board your kernel is expe=
cted to
> > > +       work on.
> >
> > As nothing can actually select this, it doesn't make sense to add this
> > now, right?  We need a user, otherwise the automated tools will come
> > along and remove this option when they figure out that it can't be ever
> > used.
>
> I think the hope was that it could be setup as a config that would
> show up as user selectable (like in menuconfig). Saravana: the problem
> is your bare "bool" above. That should be changed to a description
> shown to the user. Like maybe you'd want to change that to:
>
>   bool "sync_state behavior defaults to timeout instead of strict"

Ah, thanks. Will do this.

-Saravana
