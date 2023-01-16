Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD50B66BCA6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjAPLR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjAPLRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:17:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8536F1DBBF;
        Mon, 16 Jan 2023 03:17:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23BEEB80D2D;
        Mon, 16 Jan 2023 11:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA72BC433EF;
        Mon, 16 Jan 2023 11:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673867832;
        bh=zbMX7mkZIWfvZgJ6Oh7/1vtp6h2UEaqSMHpRywuuzh8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bhHBOZrvQ2B1XMCEdtqezT4IpffQMEH5golIDHWIKHvU2tZnH0aIPp4y8HKmxrI/J
         SlO/A1K74h02Tu845QCqtmxSEWLLu04sl2AzDDoLwJf12jOcBC6lw6fTYHz3yJCMjq
         qGvxztnoymwuz0p9rdd9lJbDyj+wBOJ7hkJfFdi70c7NGAwq0nNXBzUF1fm9Udjlfe
         bAxsRo0hKPh6k8papqKJ+faaC4aVPROmAproAkyIzZmcOCFLJZXsQR2OZaSTFcnslw
         rz4iveCkHMhF46HW6kOjVoeShcHuo3LZA61+3o08bKgRc3Vy1PrNaxDbgZ55dDau0H
         tJ8zJrv6npClA==
Received: by mail-oi1-f171.google.com with SMTP id p133so7752177oig.8;
        Mon, 16 Jan 2023 03:17:12 -0800 (PST)
X-Gm-Message-State: AFqh2kpjtBEnjd0UxSxRs/gyT20/3tHe7V0eAOVzmTh6p1+sCY143mLj
        jSwvUuHx799tbNjx++yrZg8wDgS7kCUsXm8Ayec=
X-Google-Smtp-Source: AMrXdXtRXzlee0KS7fnimuPFxHCbpqAG1pojH2P2Cqzciuh2ZYZw6GhnL6P6RLYlIwLioxXO2hXfVRSWB+UHNgEvp20=
X-Received: by 2002:aca:3755:0:b0:35e:7c55:b015 with SMTP id
 e82-20020aca3755000000b0035e7c55b015mr5696848oia.287.1673867832025; Mon, 16
 Jan 2023 03:17:12 -0800 (PST)
MIME-Version: 1.0
References: <ed72aa98-151a-0f1b-062b-fbea08b38f6f@suse.cz>
In-Reply-To: <ed72aa98-151a-0f1b-062b-fbea08b38f6f@suse.cz>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 16 Jan 2023 20:16:35 +0900
X-Gmail-Original-Message-ID: <CAK7LNATYbwgv89_n1RfjCpNRv20HQkpB4MPfoh_48keLzS3rrQ@mail.gmail.com>
Message-ID: <CAK7LNATYbwgv89_n1RfjCpNRv20HQkpB4MPfoh_48keLzS3rrQ@mail.gmail.com>
Subject: Re: [PATCH] scripts: support GNU make 4.4 in jobserver-exec
To:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nicolas@fjasle.eu, axboe@kernel.dk, josef@toxicpanda.com,
        keescook@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 7:45 PM Martin Li=C5=A1ka <mliska@suse.cz> wrote:
>
> Starting with GNU make 4.4, --jobserver-auth newly uses named
> pipe (fifo) instead of part of opened file descriptors:
> https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html
>
> Support also the new format.
>
> Signed-off-by: Martin Liska <mliska@suse.cz>




Applied to linux-kbuild/fixes.
Thanks.


> ---
>  scripts/jobserver-exec | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
> index 4192855f5b8b..7eca035472d3 100755
> --- a/scripts/jobserver-exec
> +++ b/scripts/jobserver-exec
> @@ -26,11 +26,20 @@ try:
>         # If the MAKEFLAGS variable contains multiple instances of the
>         # --jobserver-auth=3D option, the last one is relevant.
>         fds =3D opts[-1].split("=3D", 1)[1]
> -       reader, writer =3D [int(x) for x in fds.split(",", 1)]
> -       # Open a private copy of reader to avoid setting nonblocking
> -       # on an unexpecting process with the same reader fd.
> -       reader =3D os.open("/proc/self/fd/%d" % (reader),
> -                        os.O_RDONLY | os.O_NONBLOCK)
> +
> +       # Starting with GNU Make 4.4, named pipes are used for reader and=
 writer.
> +       # Example argument: --jobserver-auth=3Dfifo:/tmp/GMfifo8134
> +       _, _, path =3D fds.partition('fifo:')
> +
> +       if path:
> +               reader =3D os.open(path, os.O_RDONLY | os.O_NONBLOCK)
> +               writer =3D os.open(path, os.O_WRONLY)
> +       else:
> +               reader, writer =3D [int(x) for x in fds.split(",", 1)]
> +               # Open a private copy of reader to avoid setting nonblock=
ing
> +               # on an unexpecting process with the same reader fd.
> +               reader =3D os.open("/proc/self/fd/%d" % (reader),
> +                                os.O_RDONLY | os.O_NONBLOCK)
>
>         # Read out as many jobserver slots as possible.
>         while True:
> --
> 2.39.0
>


--=20
Best Regards
Masahiro Yamada
