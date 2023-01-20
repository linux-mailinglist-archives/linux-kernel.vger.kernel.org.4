Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F287675DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjATTRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjATTRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:17:49 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E846E802;
        Fri, 20 Jan 2023 11:17:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id br9so9527096lfb.4;
        Fri, 20 Jan 2023 11:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H/cuYQVaURot8NIlqMJUqupZS5spnQh7yyTXLiHNfhU=;
        b=mUSBsA4ivUOd9hDrc/Q+1wcozutzyFiR/YmikIHJEUbbVDf8o0xN3+8Oov1DAVO+WG
         vmntJbVPVVbyRIDg8inIvphDQ0Lyj4KP3iMmUevByl5NkRf8aECxJN2V/jn4rrkwSudB
         XOuhp4uRFUPnBp0EeAfL4NoC0G4Kx85N04jt8wfZAc2kkQoeVC0DdceGjpHvKh/nQGku
         +e/hcNxoEVibYMAuA/ydE2x+XSr8MavunnOPuL+TAq4dbC4RbxkP2QXQKJ6oi8IVBfpj
         AkICQ22WBYy7ibkz7npNcqbAafnXvebT6i6kh0KT3PJdLHjhKVdmOZF+J5Wxlo6CuDiT
         7Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/cuYQVaURot8NIlqMJUqupZS5spnQh7yyTXLiHNfhU=;
        b=BQ9Q4yYVNnSTpoa2IY14Mm+8GMoKj4Qx3BpeFj37sH6hvS79eb+xjdetoBmwSYS5oH
         Kx6Lx5DNLC3ngdfFkW4nwVFmrMWdeChEwvxL8eSPYI+KfD9d0uDbyFtnNPDTPnIFle3/
         5N9ELv6dH7EAI2kt+XgME8niSJWEZNiOZ2GFuMqjdJ3BFF6Z39Gd6qXwb+kNduzuUujd
         WN4hr1IA5ymgM9wdYw++NCY5eb7srCFWUNi5OxPpuut668jsb+0eXIWSSNYfdjYUuooz
         F7EKeIIiJwQuZ9VZ6X9sJhuU7yUi7VwZtW0Q4h1vnMHQtOfwjkARD1jQyD71q+blBSmB
         2oFg==
X-Gm-Message-State: AFqh2krZPfduONwi9ySDBcm0I4HILIxGXeYgw6neuQ+VqqZr3NG6y18i
        o2Knuwu3zUCeoKp3SjF0tjTv4z9J54Jen/eN8PA=
X-Google-Smtp-Source: AMrXdXug4pUchE3u6YNTAw2d4BVLoA7vmgLoDUMjasMHua3CVAbiQmCJQ3cnUdMG/jAU+IFw62P/GfRs94HmhtWAbXQ=
X-Received: by 2002:a05:6512:3142:b0:4d5:7f50:d596 with SMTP id
 s2-20020a056512314200b004d57f50d596mr1493734lfi.536.1674242264561; Fri, 20
 Jan 2023 11:17:44 -0800 (PST)
MIME-Version: 1.0
References: <20230119111853.596560-1-arnd@kernel.org> <CANT5p=r+FB87Mx+Je6Xeo1-q=Cu01Mx++jR-=UegFYRtEtpBmA@mail.gmail.com>
In-Reply-To: <CANT5p=r+FB87Mx+Je6Xeo1-q=Cu01Mx++jR-=UegFYRtEtpBmA@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 20 Jan 2023 13:17:33 -0600
Message-ID: <CAH2r5mt430q49cGO=JvF88w_DMu7qua=x4KNER_5qN46=_jv8g@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix debug format string in cifs_debug_data_proc_show
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     Arnd Bergmann <arnd@kernel.org>, Tom Talpey <tom@talpey.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-cifs@vger.kernel.org,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Paulo Alcantara <pc@cjr.nz>, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <sfrench@samba.org>
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

merged into cifs-2.6.git for-next

On Thu, Jan 19, 2023 at 7:48 AM Shyam Prasad N via samba-technical
<samba-technical@lists.samba.org> wrote:
>
> On Thu, Jan 19, 2023 at 4:55 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > Printing a size_t as %lu causes a warning on some architectures:
> >
> > fs/cifs/cifs_debug.c: In function 'cifs_debug_data_proc_show':
> > fs/cifs/cifs_debug.c:478:75: error: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
> >   478 |                                 seq_printf(m, "\t\tWeight (cur,total): (%lu,%lu)"
> >
> > Use the correct %zu format string instead.
> >
> > Fixes: 962a0fd04791 ("cifs: distribute channels across interfaces based on speed")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  fs/cifs/cifs_debug.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
> > index f5f07019fc7e..2e644d926e62 100644
> > --- a/fs/cifs/cifs_debug.c
> > +++ b/fs/cifs/cifs_debug.c
> > @@ -475,7 +475,7 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
> >                                 cifs_dump_iface(m, iface);
> >
> >                                 iface_weight = iface->speed / iface_min_speed;
> > -                               seq_printf(m, "\t\tWeight (cur,total): (%lu,%lu)"
> > +                               seq_printf(m, "\t\tWeight (cur,total): (%zu,%zu)"
> >                                            "\n\t\tAllocated channels: %u\n",
> >                                            iface->weight_fulfilled,
> >                                            iface_weight,
> > --
> > 2.39.0
> >
>
> Hi Arnd,
>
> Thanks for pointing this out.
>
> --
> Regards,
> Shyam
>


-- 
Thanks,

Steve
