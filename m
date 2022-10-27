Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569B160EF3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 06:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbiJ0EyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 00:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiJ0EyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 00:54:15 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3BA157F62
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:54:14 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id bb5so368763qtb.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 21:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teHo8Dveo4UNQHuN42GgHwf/dMoC0jWvMuyqCiD0B2U=;
        b=ikKEZd/YB9OMCw6ZjGi8MoKe0Mm11AM7mrfRvKuAKjUmBIEaqPYkiQfcQlsOEwI+Fs
         ZVwFtAVNbM8TpJVL8FckyGf74Xn48EeHIsBZ8PfP4v8RJXDnhwKmjUTmgQ0LCknl/Ofw
         6YzEcUBjGPZdZVTXj9Gd96nkRdAcYS7eiYhLu3V6xSH/PAa0UtsScs6z9BoD+7QC7oM6
         xWIIUBlW99XOhdmHsrU2rC/gV9j+ey7p9WoW0Sgmkx2bLIO3PvMaKoD3D/9gMwuEvG/G
         uvMStb8zJV1delpiHMe8bwsug5xVOp32/OnXBjYn9Mz/ijRLwBPlWbKTuGffD5L8dDwb
         JCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=teHo8Dveo4UNQHuN42GgHwf/dMoC0jWvMuyqCiD0B2U=;
        b=FrjhTEMb8Pe0ULX1d0A9YXx8NUST4wieGaljfe5AroQN/UtH05J3E6/oWxdlVDeuhy
         rXJsnBo3+n2+zRNpRITznf/xn41nmVt4RbA6S1JkRIr2Lmtou4mUAYfsK6HQFwCNjVUu
         /Q8rLt/QKxmaahO09hsTFd1V2mNtMR/07YE2UtpQSPUydj6s/4HPNhIx0wZcqHvp3W8N
         BQHlRCH0+sy35dUhlSpjayh7uSr6KVUey7wwRzJM2ZRLhcDDM2vfn6SGM0v5Xmji8qO8
         RIG2wtEx1ZK4zxnuvgUtHX7U1PNaQxyGu6GceIDqyGcrv7WkKkyWGndMKepByHZ6OZbw
         NhzQ==
X-Gm-Message-State: ACrzQf0EP7Tk3PtWj/VjQvYTlSJEbEePsoXm9ebWcNn5OoffpwHPofTA
        +O47jkulGcIAESBC3JNpRnz61q8L0up7dq7WGZ7vYsvskVcvOD8D
X-Google-Smtp-Source: AMsMyM6yjGTqiAUX/kRkIacEJ/vQvc6bVh/2NiSHqV+00snnlAjWJqwBwaqud0vTd5d07k/B4+YJk3LSRSYBT6iqv50=
X-Received: by 2002:ac8:7c46:0:b0:39c:fa92:a27a with SMTP id
 o6-20020ac87c46000000b0039cfa92a27amr37967751qtv.61.1666846453716; Wed, 26
 Oct 2022 21:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <051083d29e5812608deb034dfa86ae0c583fee44.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
In-Reply-To: <051083d29e5812608deb034dfa86ae0c583fee44.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Oct 2022 07:53:34 +0300
Message-ID: <CAHp75Vd6iWi98WxP6ex5Thvm4QPvYj4C343dogOY_ZqXTgKDGg@mail.gmail.com>
Subject: Re: [PATCH 04/15] pcmcia: synclink_cs: remove dead paranoia_check,
 warn for missing line
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org
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

On Thu, Oct 27, 2022 at 1:42 AM =D0=BD=D0=B0=D0=B1 <nabijaczleweli@nabijacz=
leweli.xyz> wrote:
>
> MGSLPC_PARANOIA_CHECK has never been defined automatically,
> and devices with null driver_info can't happen, since we reject the open
> in that case
>
> Move the log statement from dead code to the check,
> and log the state inconsistency like we do above for the line count
> ("invalid line #%d.")

Please, respect English grammar and punctuation, in particular don't
forget the trailing periods.

...

> +       if (!info) {
> +               printk(KERN_WARNING "%s(%d):mgslpc_open: "
> +                       "no device for line #%d.\n",
> +                       __FILE__, __LINE__, line);

Even though the old code uses this awkward style for messages, please
follow the modern one, i.e.

               pr_warn("mgslpc_open: no device for line #%d.\n", line);

>                 return -ENODEV;
> +       }

--=20
With Best Regards,
Andy Shevchenko
