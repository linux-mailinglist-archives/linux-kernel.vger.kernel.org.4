Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0E715C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 13:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjE3LE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 07:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjE3LE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 07:04:28 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEDECD;
        Tue, 30 May 2023 04:04:26 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f7f73e90f9so21969531cf.2;
        Tue, 30 May 2023 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685444666; x=1688036666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uI+O1xTwh4jwUq+i1K6qEtlOwjj7Ph0QVRwIlRcZhvg=;
        b=j5pJ4gBmMSadxNn3fiqFsfN8sFNLYWVtcuhfaLjrfqyeB8++IRtVIaYnQHxOE711BL
         mQo0rIyR2zl573lA0Rv/+hpQZOBKTXYlBSc86f5vn3IaiQFstfWT6NqXJ3T47shlaHx2
         EpmHET2rc820Z/fq5hLlHtDkcSoRP1gkXi8meRdQeSPD+n5dm9jVtcugJdry2VOG6dYC
         l/06Zb+0OrZ2QGEM+GiIpex5uHt7DVBCmj0kFeI72Xv1wXzxeunH4k0iuDwL2PnR9Qs6
         anzmTfbm3/sZcQN86104/ZqAoKE52btIFvyCzQueQiRM1AvYbcNF1ubH3no0uLdICfnf
         z13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685444666; x=1688036666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uI+O1xTwh4jwUq+i1K6qEtlOwjj7Ph0QVRwIlRcZhvg=;
        b=dlbr0E4G7g8TqwoeVhQXo8GYL294tVzJkENLZ0bUvR5AdLk14m+sDCi6VjqGCvOL8t
         6EIakHDbccpsSqyqR3oHy4YPqa5jILkC7Kc4+G5WLNHyYjqcPdvNuIuWk2mLgv/Mgsfa
         8h/8hset9UVAQP5wZ/ErwJChi0q7IHOJs5mebx2CTS5e1Rt8T/GIo45NinjHyxZUKvhj
         hgG0AdTCAVBEq/bNR4si/5RKa+bxcdp2sDw2BUy0+KSxfqgjlL2Rwwog12oDwHYLy8NT
         UgVaOYanVwFme1fOrefNTgzFZJ1lTpasp2/lb7NQULBNvOHAt30joZyuh4maiqU8rubV
         JrgA==
X-Gm-Message-State: AC+VfDwqIQ+d8dER6NWO3CfcDviOvuhMjx4kbezrHsSlMGnWfEwuaWjh
        H1OfVYIq1LwC1HnmdeXXCrScKsISmXGucoizyfc74hPojnU=
X-Google-Smtp-Source: ACHHUZ5UWpJm8+OdMIjp+SRrvey2QPLFEGl/qHNKhECWdnc5nY9ipYx0BQtrAFLxfbpZgX5LbH76yy+dUx7iQk3yrIM=
X-Received: by 2002:ad4:5ce1:0:b0:621:7d4:e068 with SMTP id
 iv1-20020ad45ce1000000b0062107d4e068mr1940379qvb.52.1685444665459; Tue, 30
 May 2023 04:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230523171240.12930-1-osmtendev@gmail.com> <CADyDSO7Lchnraz8pZJkgDBg=YiEG51kcSd+_yg55GpJOuHk6wg@mail.gmail.com>
In-Reply-To: <CADyDSO7Lchnraz8pZJkgDBg=YiEG51kcSd+_yg55GpJOuHk6wg@mail.gmail.com>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Tue, 30 May 2023 16:04:14 +0500
Message-ID: <CAK6rUAOXShUhmdyKv6EM+moeBKiruoQgbqHxQNm9_20WcOW7=w@mail.gmail.com>
Subject: Re: [PATCH] hid-wiimote-debug.c: Fix error checking for debugfs_create_file
To:     David Rheinsberg <david.rheinsberg@gmail.com>
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I will adjust it by sending the revision of the patch by removing NULL-check.

Thanks,
Osmten

On Tue, 30 May 2023 at 15:48, David Rheinsberg
<david.rheinsberg@gmail.com> wrote:
>
> Hi
>
> On Tue, 23 May 2023 at 19:13, Osama Muhammad <osmtendev@gmail.com> wrote:
> >
> > This patch fixes the error checking in hid-wiimote-debug.c in
> > debugfs_create_file. The correct way to check if an error occurred
> > is 'IS_ERR' inline function.
>
> Please have a look at fs/debugfs/inode.c, especiall the docs of
> debugfs_create_file():
>
> 477  * NOTE: it's expected that most callers should _ignore_ the errors returned
> 478  * by this function. Other debugfs functions handle the fact that
> the "dentry"
> 479  * passed to them could be an error and they don't crash in that case.
> 480  * Drivers should generally work fine even if debugfs fails to init anyway.
>
> I think the current code is fine. If you feel like adjusting it, I
> would rather just remove the NULL-check.
>
> Thanks
> David
>
> > Signed-off-by: Osama Muhammad <osmtendev@gmail.com>
> > ---
> >  drivers/hid/hid-wiimote-debug.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hid/hid-wiimote-debug.c b/drivers/hid/hid-wiimote-debug.c
> > index a99dcca2e099..eddd981fee1a 100644
> > --- a/drivers/hid/hid-wiimote-debug.c
> > +++ b/drivers/hid/hid-wiimote-debug.c
> > @@ -183,12 +183,12 @@ int wiidebug_init(struct wiimote_data *wdata)
> >
> >         dbg->eeprom = debugfs_create_file("eeprom", S_IRUSR,
> >                 dbg->wdata->hdev->debug_dir, dbg, &wiidebug_eeprom_fops);
> > -       if (!dbg->eeprom)
> > +       if (IS_ERR(dbg->eeprom))
> >                 goto err;
> >
> >         dbg->drm = debugfs_create_file("drm", S_IRUSR,
> >                         dbg->wdata->hdev->debug_dir, dbg, &wiidebug_drm_fops);
> > -       if (!dbg->drm)
> > +       if (IS_ERR(dbg->drm))
> >                 goto err_drm;
> >
> >         spin_lock_irqsave(&wdata->state.lock, flags);
> > --
> > 2.34.1
> >
