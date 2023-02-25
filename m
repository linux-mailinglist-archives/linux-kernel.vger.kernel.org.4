Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B373F6A2A58
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 15:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBYOzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 09:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBYOzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 09:55:43 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB82125B6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 06:55:39 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id q2so648258qki.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 06:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Q8gsNHzpb5kSZtMtig8/+UueCt1zs6M93LoCCjgrGo=;
        b=NxXuAhBYmUdC2MrMV2EFL9Aen3jQKb3jYtB+q7Ty1zm82Fm2n0ZrgTpkYtAL7Jwkx0
         dP4P4erZ/Ht4J73pJS5KwCmpI8j1AWM+7h02RuL0+PfOrImuXj19XfzQq6ClTcQ5YSVL
         0tEubcNYqqLc2jzt5/tAtNMP/UGR7/Sy8HvV5hKbTdtANwlXk7hyhCMExuSzLTVCCSyn
         rzl762yf7jF9WkN2Ye9YeyGVfu6q74ZtViLLtR289BSHDIiuogSmznNWkIHHTX1Yd5DY
         zzQJTumXahViRWwFmYgRygiJBYgIxbsgh8ZigGsj06Qu98s8NZd4Q8Pl08WnL70iNmZ+
         fBMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Q8gsNHzpb5kSZtMtig8/+UueCt1zs6M93LoCCjgrGo=;
        b=MOpnuoUve6JsbfVhwpcHs8CodZUDLlXxVUNVwdysS4U0+POPpxwK2dscxersWi+OT6
         hGT5uSeGKr3eFoYcx79j2f2et3RpxTIGbxcOAXmGgte7m9Ykj8RkgidWnbG6aAzf6otl
         Iuaiad8kujfl2V9D5uzSaF07NDZNotAp0wYEaSW9bAO3JRySaW4hZgdeupcvu+84joRA
         bDVGpMzE6jpK6y7qlaC+N1Q6VwXAcAHM+E0C50gMpYQrhW+j5QFjiBkk6rUOn8WwcVMN
         eKyBgJBydcfSCGW67FA7WohUKhEXpPAoRKDaWr6efxq/hZCakekucrehf6u9uF2I5fDd
         eKZw==
X-Gm-Message-State: AO0yUKVyhFa0QgF1U0iTKrCsoM+oM3kxDnE/USMAQMSs/W2K2GBtEfZp
        laIMj5jQjOJqNe4j5nsc8wgJ5SZNlz+1ega7GXkmTwBIqBzeCcl9yfwXMw==
X-Google-Smtp-Source: AK7set8jA+1nFDnQkwfNDsgRkVHfQxRE0kvqoiPSKE7WECLY+Ny/1Ed0v/fPhmsJcfWj1yCPN4mroOYDfGrai4yml8k=
X-Received: by 2002:a05:620a:2589:b0:73b:7f8c:5571 with SMTP id
 x9-20020a05620a258900b0073b7f8c5571mr1261108qko.6.1677336937869; Sat, 25 Feb
 2023 06:55:37 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsO4=qKBF=2FRPVwW8FA4iLFh0Dt9n1BLMec3k10GUorpg@mail.gmail.com>
 <9f682c4d-e7b7-5e23-84f5-cea4fdac2085@leemhuis.info>
In-Reply-To: <9f682c4d-e7b7-5e23-84f5-cea4fdac2085@leemhuis.info>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 25 Feb 2023 19:55:27 +0500
Message-ID: <CABXGCsNruNKfx3d1dpneRUvn3dCqv_bM93TdJsCLeRYiP3qYaA@mail.gmail.com>
Subject: Re: [6.3][regression] after commit 7170b7ed6acbde523c5d362c8978c60df4c30f30
 my system stuck in initramfs forever
To:     Thorsten Leemhuis <linux@leemhuis.info>
Cc:     davidgow@google.com, rmoar@google.com, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
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

On Sat, Feb 25, 2023 at 7:22=E2=80=AFPM Thorsten Leemhuis <linux@leemhuis.i=
nfo> wrote:
>
> [CCing the regression list, as it should be in the loop for regressions:
> https://docs.kernel.org/admin-guide/reporting-regressions.html]
>
> On 25.02.23 14:51, Mikhail Gavrilov wrote:
> > new kernel release cycle returning with new bugs
> > Today my system got stuck in initramfs environment after updating to
> > commit d2980d8d826554fa6981d621e569a453787472f8.
> >
> > I still do not understand how to configure the network inside the
> > initramfs environment to grab the logs.
> > Since an attempt to rebuild the initramfs with all modules (dracut
> > --no-hostonly --force) leads to the stuck initramfs environment and
> > impossible entering into initramfs console.
>
> Do you see any error messages? I have problems since Friday morning as
> well (stuck in Fedora's initramfs) and see a lot of BPF warnings like
> "BPF: invalid name" and "failed to validate module". Was able to do a
> screenshot:
>
> https://www.leemhuis.info/files/misc/Screenshot_ktst-f36-x86-64_2023-02-2=
4_07:53:14.png
>

I also seen such messages
https://freeimage.host/i/img-1475.HMPL26l

And if initramfs is configured without --no-hostonly I even could
enter in emergency mode.

https://freeimage.host/i/img-1480.HMPsZ3N

But the module for my Keychrone K1 keyboard couldn't be loaded :(

P.S.: I also use Fedora Rawhide.

--=20
Best Regards,
Mike Gavrilov.
