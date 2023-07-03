Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7B4745C32
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGCM2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjGCM1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 08:27:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB011F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 05:27:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A85D60F14
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:27:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9CBC433C7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688387272;
        bh=2EVs3kXtnpDKdNK9AnLY5wZF5XzWUsZ/2zmOx02LYSE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=az4MYr7MKdkVdiJl9mNOIZmGAK/AevdEKU+MPp+qMQA74XX8Pwhyjnr+UDWj367s8
         XMOHC3orgnuJFPC6+VCf6PEZJ14pOvDH39DedpuzYBUXPyZO6wuZzPN5Lg1b2dgscZ
         jGUdSJXaROGGpCyB6bC/ehAuyEff5GndLAnoEfCvJXQ93GRIcMeW+uiNq188Mh4KUO
         m4a2W0liFVl7rpP73dh6XWwMDHVYNRWypF/OK9BWDKK7VubbODZRIV41G0M2ZyJQa2
         VO1Us1ppfNwI7xInklCRyx9N3MuveLazo/v70cIOh7MWYKKrX0Myxdm10Sk59QBxrj
         XYVmJ9xnZ3Vgw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-5728df0a7d9so55253087b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 05:27:52 -0700 (PDT)
X-Gm-Message-State: ABy/qLbNGGafJvQhPgnsJkz2nf9PqqtYbdFxShEtMZWBmNpv8tE6r8Hp
        99kVMjFYMGzlmYlZ4fjd3ia43gN4OJYFq5YWQA0=
X-Google-Smtp-Source: APBJJlHGkXOiyDljiw0WPQ1cdzbR+bOTDjupgspEK/of6mYU3V8vuOADTtRzC4cI8DvchQrkLfIr6EaRTZ1NFO100Vg=
X-Received: by 2002:a25:d216:0:b0:c21:caaf:bd47 with SMTP id
 j22-20020a25d216000000b00c21caafbd47mr10459923ybg.2.1688387271590; Mon, 03
 Jul 2023 05:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230620182528.669526-2-gregkh@linuxfoundation.org> <1caf16e9-f066-f889-278c-fe1c242930c3@habana.ai>
In-Reply-To: <1caf16e9-f066-f889-278c-fe1c242930c3@habana.ai>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 3 Jul 2023 15:27:25 +0300
X-Gmail-Original-Message-ID: <CAFCwf11fOZpzh5ZTizzW6ZnnvEbq4oG3upp9CNmstSZj5P4ofw@mail.gmail.com>
Message-ID: <CAFCwf11fOZpzh5ZTizzW6ZnnvEbq4oG3upp9CNmstSZj5P4ofw@mail.gmail.com>
Subject: Re: [PATCH] accel: make accel_class a static const structure
To:     Tomer Tayar <ttayar@habana.ai>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Ivan Orlov <ivan.orlov0322@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 3, 2023 at 3:09=E2=80=AFPM Tomer Tayar <ttayar@habana.ai> wrote=
:
>
> On 20/06/2023 21:25, Greg Kroah-Hartman wrote:
> > From: Ivan Orlov <ivan.orlov0322@gmail.com>
> >
> > Now that the driver core allows for struct class to be in read-only
> > memory, move the accel_class structure to be declared at build time
> > placing it into read-only memory, instead of having to be dynamically
> > allocated at boot time.
> >
> > Cc: Oded Gabbay <ogabbay@kernel.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Reviewed-by: Tomer Tayar <ttayar@habana.ai>
Thanks Tomer.
Applied to habanalabs-next for 6.6.
Oded
>
> Thanks,
> Tomer
>
> > ---
> >   drivers/accel/drm_accel.c | 21 ++++++++-------------
> >   1 file changed, 8 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/accel/drm_accel.c b/drivers/accel/drm_accel.c
> > index 4a9baf02439e..2dc187e1ee41 100644
> > --- a/drivers/accel/drm_accel.c
> > +++ b/drivers/accel/drm_accel.c
> > @@ -21,7 +21,6 @@ static DEFINE_SPINLOCK(accel_minor_lock);
> >   static struct idr accel_minors_idr;
> >
> >   static struct dentry *accel_debugfs_root;
> > -static struct class *accel_class;
> >
> >   static struct device_type accel_sysfs_device_minor =3D {
> >       .name =3D "accel_minor"
> > @@ -32,23 +31,19 @@ static char *accel_devnode(const struct device *dev=
, umode_t *mode)
> >       return kasprintf(GFP_KERNEL, "accel/%s", dev_name(dev));
> >   }
> >
> > +static const struct class accel_class =3D {
> > +     .name =3D "accel",
> > +     .devnode =3D accel_devnode,
> > +};
> > +
> >   static int accel_sysfs_init(void)
> >   {
> > -     accel_class =3D class_create("accel");
> > -     if (IS_ERR(accel_class))
> > -             return PTR_ERR(accel_class);
> > -
> > -     accel_class->devnode =3D accel_devnode;
> > -
> > -     return 0;
> > +     return class_register(&accel_class);
> >   }
> >
> >   static void accel_sysfs_destroy(void)
> >   {
> > -     if (IS_ERR_OR_NULL(accel_class))
> > -             return;
> > -     class_destroy(accel_class);
> > -     accel_class =3D NULL;
> > +     class_unregister(&accel_class);
> >   }
> >
> >   static int accel_name_info(struct seq_file *m, void *data)
> > @@ -116,7 +111,7 @@ void accel_debugfs_init(struct drm_minor *minor, in=
t minor_id)
> >   void accel_set_device_instance_params(struct device *kdev, int index)
> >   {
> >       kdev->devt =3D MKDEV(ACCEL_MAJOR, index);
> > -     kdev->class =3D accel_class;
> > +     kdev->class =3D &accel_class;
> >       kdev->type =3D &accel_sysfs_device_minor;
> >   }
> >
>
>
