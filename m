Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECED6876BF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjBBHuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 02:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBBHuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:50:22 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5904030FB;
        Wed,  1 Feb 2023 23:50:21 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg26so705313wmb.0;
        Wed, 01 Feb 2023 23:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhMp2mcNadfnherTAzCDojpxmUZhldJPGeGKk3DUDdw=;
        b=fzqTkx9BZu9JeeeRbdFqNm6cL4gmo3h3IUq9H3641OkHPcZTvxi8ONuIzME92axTGM
         0hjUkMxjkN89IRpMs6xqxD5uJYi9qKJclY1pARyp7INeghvjHYzZlBdBYN51531aVNwb
         Cq2hCMismhNGvIRj5HgBGTGC9B1QYC1eh+cXHNG86n/5Qj1IyfN9Npnpn0q95KpBIp2m
         dSeRN7gJh3XzCGWLNZe6eQzAp3/jRcBd8UmxbR4E/Zp4U29dnOG4Qlyf3fBCnGtJKve8
         G4xPgD8Hhf+ZzzYRv90SeHd8e1EgtZvKnFd69YRt4ySFcMXHgx5iOba2qo1nnp3fbg8Y
         glDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhMp2mcNadfnherTAzCDojpxmUZhldJPGeGKk3DUDdw=;
        b=XSGUZl+eAwOWZ2NJ/maKpAyU7j1M+VxfyHjUXYmGgTdwlwbh5w0vkXAIHi/6aCFqiE
         x3hgZEJdgQVsR35i/QBj6iAabMX7AFqzlJv0GfFNBFeufj6StY92Q0NWgJtZL5KnbA7u
         w9wkM9uzoR1phpNiWTOKtEGA7hcmQ/HWefh+R7ZVgawW77uOLRBjYNKTGeB9RfEzcUu5
         ZY6Vd8rvOXnb8Z+LeIos6FqixSnnXDOMwO0KtVMZwhxrBq7NBymw05AcoeCHUP/1pdiL
         mpPdWA4tRppBGJA8Va5tmP7teEEwit5S6SvwYX38YSelVMxJ0SyZ3Ot/WFnXO3Z3VYGo
         hYzg==
X-Gm-Message-State: AO0yUKUXBbEnKi4DiicgXO9/w4Rhp91/fiey7oW1haBTdJgkUxF/T2n/
        TeP3IuHrjZy25ue10wb+u33suzS56pssHDOA
X-Google-Smtp-Source: AK7set+pJNBXPE4ov9v78QQVzztj0g5UU0VBXX6eom9QcypZ1csfbm9oTo4oH1gIei9EzqAfesDjFg==
X-Received: by 2002:a05:600c:4446:b0:3dc:98a4:787d with SMTP id v6-20020a05600c444600b003dc98a4787dmr4828997wmn.3.1675324219691;
        Wed, 01 Feb 2023 23:50:19 -0800 (PST)
Received: from localhost.localdomain (staticline-31-182-169-137.toya.net.pl. [31.182.169.137])
        by smtp.gmail.com with ESMTPSA id j25-20020a05600c1c1900b003daf6e3bc2fsm6188212wms.1.2023.02.01.23.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 23:50:19 -0800 (PST)
Date:   Thu, 2 Feb 2023 08:49:53 +0100
From:   Sebastian Grzywna <swiftgeek@gmail.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Pedro Falcato <pedro.falcato@gmail.com>,
        linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Hang Zhang <zh.nvgt@gmail.com>
Subject: Re: [PATCH] ACPI: Make custom_method use per-open state
Message-ID: <20230202084953.3035c6e3@gmail.com>
In-Reply-To: <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
References: <20230131233755.58942-1-pedro.falcato@gmail.com>
        <CAJZ5v0iXcRFamA+mE837=zHReBT-+8WmMeRDR7L9R+FVpLr25A@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia 2023-02-01, o godz. 19:34:48
"Rafael J. Wysocki" <rafael@kernel.org> napisa=C5=82(a):

> On Wed, Feb 1, 2023 at 12:38 AM Pedro Falcato
> <pedro.falcato@gmail.com> wrote:
> >
> > Make custom_method keep its own per-file-open state instead of
> > global state in order to avoid race conditions[1] and other
> > possible conflicts with other concurrent users.
> >
> > Link:
> > https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail=
.com/
> > # [1] Reported-by: Hang Zhang <zh.nvgt@gmail.com> Cc: Swift Geek
> > <swiftgeek@gmail.com> Signed-off-by: Pedro Falcato
> > <pedro.falcato@gmail.com> ---
> >  This patch addresses Hang's problems plus the ones raised by
> > Rafael in his review (see link above).
> > https://lore.kernel.org/lkml/2667007.mvXUDI8C0e@kreacher/ was
> > submitted but since there were still people that wanted this
> > feature, I took my time to write up a patch that should fix the
> > issues. Hopefully the linux-acpi maintainers have not decided to
> > remove custom_method just yet. =20
>=20
> Well, thanks for the patch, but yes, they have.  Sorry.
=20
Hi Rafael,
Can you please explain why you don't want to keep it, given there's a
patch? I find it really useful in my day-to-day as a firmware engineer.
I don't see much happening in git history of
drivers/acpi/custom_method.c , and I don't see anything that was
specifically changed in it in past 10 years to keep it being
functional. Without your more detailed explanation I have hard time
understanding your decision to remove it, since I'm not a kernel
developer myself.
Thanks,
Sebastian Grzywna

> >  drivers/acpi/custom_method.c | 119
> > +++++++++++++++++++++++++++-------- 1 file changed, 92
> > insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/acpi/custom_method.c
> > b/drivers/acpi/custom_method.c index d39a9b47472..034fb14f118 100644
> > --- a/drivers/acpi/custom_method.c
> > +++ b/drivers/acpi/custom_method.c
> > @@ -17,73 +17,138 @@ MODULE_LICENSE("GPL");
> >
> >  static struct dentry *cm_dentry;
> >
> > +struct custom_method_state {
> > +       char *buf;
> > +       u32 max_size;
> > +       u32 uncopied_bytes;
> > +       struct mutex lock;
> > +};
> > +
> > +static int cm_open(struct inode *inode, struct file *file)
> > +{
> > +       struct custom_method_state *state;
> > +
> > +       state =3D kzalloc(sizeof(struct custom_method_state),
> > GFP_KERNEL); +
> > +       if (!state)
> > +               return -ENOMEM;
> > +
> > +       file->private_data =3D state;
> > +       mutex_init(&state->lock);
> > +
> > +       return 0;
> > +}
> > +
> > +static int cm_release(struct inode *inode, struct file *file)
> > +{
> > +       struct custom_method_state *state;
> > +
> > +       state =3D file->private_data;
> > +
> > +       mutex_destroy(&state->lock);
> > +
> > +       /* Make sure the buf gets freed */
> > +       kfree(state->buf);
> > +
> > +       kfree(state);
> > +       return 0;
> > +}
> > +
> >  /* /sys/kernel/debug/acpi/custom_method */
> >
> >  static ssize_t cm_write(struct file *file, const char __user
> > *user_buf, size_t count, loff_t *ppos)
> >  {
> > -       static char *buf;
> > -       static u32 max_size;
> > -       static u32 uncopied_bytes;
> > +       struct custom_method_state *state;
> > +       char *buf;
> >
> >         struct acpi_table_header table;
> >         acpi_status status;
> >         int ret;
> >
> > +       state =3D file->private_data;
> > +       buf =3D state->buf;
> > +
> >         ret =3D security_locked_down(LOCKDOWN_ACPI_TABLES);
> >         if (ret)
> >                 return ret;
> >
> > +       mutex_lock(&state->lock);
> > +
> >         if (!(*ppos)) {
> >                 /* parse the table header to get the table length */
> > -               if (count <=3D sizeof(struct acpi_table_header))
> > -                       return -EINVAL;
> > +               if (count <=3D sizeof(struct acpi_table_header)) {
> > +                       count =3D -EINVAL;
> > +                       goto out;
> > +               }
> > +
> >                 if (copy_from_user(&table, user_buf,
> > -                                  sizeof(struct
> > acpi_table_header)))
> > -                       return -EFAULT;
> > -               uncopied_bytes =3D max_size =3D table.length;
> > +                                  sizeof(struct
> > acpi_table_header))) {
> > +                       count =3D -EFAULT;
> > +                       goto out;
> > +               }
> > +
> > +               state->uncopied_bytes =3D state->max_size =3D
> > table.length; /* make sure the buf is not allocated */
> >                 kfree(buf);
> > -               buf =3D kzalloc(max_size, GFP_KERNEL);
> > -               if (!buf)
> > -                       return -ENOMEM;
> > +               buf =3D state->buf =3D kzalloc(state->max_size,
> > GFP_KERNEL);
> > +               if (!buf) {
> > +                       count =3D -ENOMEM;
> > +                       goto out;
> > +               }
> >         }
> >
> > -       if (buf =3D=3D NULL)
> > -               return -EINVAL;
> > +       /* Check if someone seeked ahead or if we errored out
> > +        * (buf will be NULL)
> > +        */
> > +       if (buf =3D=3D NULL) {
> > +               count =3D -EINVAL;
> > +               goto out;
> > +       }
> >
> > -       if ((*ppos > max_size) ||
> > -           (*ppos + count > max_size) ||
> > +       if ((*ppos > state->max_size) ||
> > +           (*ppos + count > state->max_size) ||
> >             (*ppos + count < count) ||
> > -           (count > uncopied_bytes)) {
> > -               kfree(buf);
> > -               buf =3D NULL;
> > -               return -EINVAL;
> > +           (count > state->uncopied_bytes)) {
> > +               count =3D -EINVAL;
> > +               goto err_free;
> >         }
> >
> >         if (copy_from_user(buf + (*ppos), user_buf, count)) {
> > -               kfree(buf);
> > -               buf =3D NULL;
> > -               return -EFAULT;
> > +               count =3D -EFAULT;
> > +               goto err_free;
> >         }
> >
> > -       uncopied_bytes -=3D count;
> > +       state->uncopied_bytes -=3D count;
> >         *ppos +=3D count;
> >
> > -       if (!uncopied_bytes) {
> > +       if (!state->uncopied_bytes) {
> >                 status =3D acpi_install_method(buf);
> >                 kfree(buf);
> > -               buf =3D NULL;
> > -               if (ACPI_FAILURE(status))
> > -                       return -EINVAL;
> > +               state->buf =3D NULL;
> > +
> > +               if (ACPI_FAILURE(status)) {
> > +                       count =3D -EINVAL;
> > +                       goto out;
> > +               }
> > +
> >                 add_taint(TAINT_OVERRIDDEN_ACPI_TABLE,
> > LOCKDEP_NOW_UNRELIABLE); }
> >
> > +out:
> > +       mutex_unlock(&state->lock);
> > +       return count;
> > +err_free:
> > +       mutex_unlock(&state->lock);
> > +       kfree(buf);
> > +       state->buf =3D NULL;
> >         return count;
> >  }
> >
> >  static const struct file_operations cm_fops =3D {
> >         .write =3D cm_write,
> > +       .open =3D cm_open,
> > +       .release =3D cm_release,
> >         .llseek =3D default_llseek,
> >  };
> >
> > --
> > 2.39.0
> > =20

