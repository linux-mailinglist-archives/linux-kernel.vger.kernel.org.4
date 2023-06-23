Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F115573B4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232193AbjFWKNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjFWKNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:13:15 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74FE296F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:11:58 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4007b5bafceso148681cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687515077; x=1690107077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2/sNgVy2wy/AQIGP29IPL+bw5EB92RRs3POON8RyTxs=;
        b=3WIrSQ4rslL2VP4Z0UrJuxFgh0abFJQVr2imPlp5iVV7GfN2A4G28PcsYs1pLHA2sQ
         L6QSNdGJ3ox6rcP3+GS/BWHJ+ofecY+s+AMEwMS/Zf3EZhChJGkpDrgRaq65ZUZc2EZZ
         He9ggKnX2ph0fPUY4mlULwtjFEfq7usk8mn47Xe0yE0NJYMusawZXXeAtUKG28T9FJ8E
         HLIHONLCMnBudjQ1OlWCyvXiL0O85H18vy9JIAVmkWq0/HIlPshl8y44udqpyzzzUoOd
         6oH6Mt4MSRCzEDDOwdfcejDKeZRs7Cob5zoEckx9FCOdUAIAEB2XaHD5cwQudlrzz8mA
         lLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687515077; x=1690107077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/sNgVy2wy/AQIGP29IPL+bw5EB92RRs3POON8RyTxs=;
        b=DNQNjn41cwWidrTjgKToDRnyWgY+Am0jgauqENjr/Fl7opIPyDd9YAekWiRTkin4M1
         vj9ggYH5UxxGc1FT++2g6HDbnRi1OAOnbYMlKaf+KPDOfHMJ/vPZQMBSd97XeJEX922k
         85vaMD7Ppt3Lv7XEnSMUAHa25sWmsO59B1rBKE3BcRgAuORbMc+yGFxhf51POTmDfRn5
         LUJooujAOQfKZo8UCEW7ojJZ0lTOyHbo7Fv2Yllcj5xpqgVym8FzJ2X0Am4H3kHNywcT
         lvgQctIH6TTJp9Ws2ggd9hWJnKQTxOg+lq8MY5SFZVcCtUm82Fx/vLqAfnPZIwJ4yNpo
         JYQw==
X-Gm-Message-State: AC+VfDyZuFEBxl25Q2sWY+LJVvY29wgiiPvbux7WyKuASEGmTpfkB4dx
        hNLpOJrynM6npBF/UXi1tiO+tnxHWAjH05+ya1+vXw==
X-Google-Smtp-Source: ACHHUZ6tVLBt13enRILwjsIxq3vLgt7VmkhjwNQ4UocKn450gMH4dgZYU/U8DZmHg7j8i5vpAfybk8DBuBQ/nj6hQis=
X-Received: by 2002:a05:622a:95:b0:3f8:5b2:aeec with SMTP id
 o21-20020a05622a009500b003f805b2aeecmr79645qtw.20.1687515076644; Fri, 23 Jun
 2023 03:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230622150423.3726894-1-kyletso@google.com> <20230622150423.3726894-4-kyletso@google.com>
 <2023062345-hassle-septic-b8b4@gregkh> <CAGZ6i=3BP4ssx31roJoGL_VT=o3mq9Lj_VfZ_HSywzPOEt3v7g@mail.gmail.com>
In-Reply-To: <CAGZ6i=3BP4ssx31roJoGL_VT=o3mq9Lj_VfZ_HSywzPOEt3v7g@mail.gmail.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Fri, 23 Jun 2023 18:11:00 +0800
Message-ID: <CAGZ6i=1uD-baR+Tht4+D1oC7O04K4L-RDBdDLSo6gZhNqN=2rg@mail.gmail.com>
Subject: Re: [PATCH 3/3] usb: typec: Use sysfs_emit_at when concatenating the string
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     heikki.krogerus@linux.intel.com, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 6:06=E2=80=AFPM Kyle Tso <kyletso@google.com> wrote=
:
>
> On Fri, Jun 23, 2023 at 3:51=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Thu, Jun 22, 2023 at 11:04:23PM +0800, Kyle Tso wrote:
> > > The buffer address used in sysfs_emit should be aligned to PAGE_SIZE.
> >
> > Why?  Are you getting warnings about this?
> >
> > thanks,
> >
> > greg k-h
>
> Yes, here is the warning.
>
> [  223.243123] invalid sysfs_emit: buf:00000000eda2d647
> [  223.243197] WARNING: CPU: 4 PID: 8860 at fs/sysfs/file.c:735
> sysfs_emit+0xb0/0xc0
> [  223.244335] CPU: 4 PID: 8860 Comm: cat
> [  223.244363] pstate: 62400005 (nZCv daif +PAN -UAO +TCO -DIT -SSBS BTYP=
E=3D--)
> [  223.244378] pc : sysfs_emit+0xb0/0xc0
> [  223.244394] lr : sysfs_emit+0xac/0xc0
> ...
> [  223.244560] Call trace:
> [  223.244568] sysfs_emit+0xb0/0xc0
> [  223.244582] select_usb_power_delivery_show+0x134/0x18c
> [  223.244626] dev_attr_show+0x38/0x74
> [  223.244654] sysfs_kf_seq_show+0xb4/0x130
> [  223.244668] kernfs_seq_show+0x44/0x54
> [  223.244683] seq_read_iter+0x158/0x4ec
> [  223.244727] kernfs_fop_read_iter+0x68/0x1b0
> [  223.244739] vfs_read+0x1d8/0x2b0
> [  223.244775] ksys_read+0x78/0xe8
>
> The warning comes from
> https://elixir.bootlin.com/linux/v6.3.9/source/fs/sysfs/file.c#L734
>
> if (WARN(!buf || offset_in_page(buf), "invalid sysfs_emit: buf:%p\n", buf=
))
>         return 0;
>
> Kyle

BTW, to print the buf address, it should use %pK ...

Kyle
