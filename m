Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32216C14C4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbjCTOa7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Mar 2023 10:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjCTOax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:30:53 -0400
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8765588;
        Mon, 20 Mar 2023 07:30:52 -0700 (PDT)
Received: by mail-vs1-f51.google.com with SMTP id s1so10651674vsk.5;
        Mon, 20 Mar 2023 07:30:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679322651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=00l8z9oqCvhZjLEVBuQ8DT4Wwg7fPUKvNuCrA1BQAAo=;
        b=6KoaDDm5VtMfO8OxtEQjF3SnmBPjhJ3L4zCP2K5YNI3wprsSACCyHHBa7oyiURVISv
         E7L6TzBkMJM5aoT7vE6NvSaNr+IUNBB1eSGQeLMKZw4nTed/8cQZ6HM6KGOKvDZ/otPR
         uS8vmpzhCY5U5FiyZOElMaaw6heAtzNadFqhIL0eRj+oGhMBbFwKAXMQFxPZpFwsiJAo
         Zo5dY0Q+igbh3ZCF0jhiX0R273QSpLC5vjBao0gGV1usLtvu2486Px/di55QejdVji0z
         kp8nMUkxG8h0eLJCgAkJdZwJ+CkhKInDK9CS4KX2zpRjgH/160fn5PoZO6WdatOhxMrb
         92dg==
X-Gm-Message-State: AO0yUKXUx+W85pjoPT4GFGWnzPQpDPsY2bjUUbWkV5dJIr+xw2IZXubu
        ntQweRvMwUPZGAjrhlRP1K02sWw8RSIv5g==
X-Google-Smtp-Source: AK7set9bAqHMlltsd43E+DDzGNQsKLNMNS/7FDbwzojJ5iJogJKAJ8ukG1sY+G96VMd6CGMe9hY+DQ==
X-Received: by 2002:a67:b308:0:b0:425:d658:5861 with SMTP id a8-20020a67b308000000b00425d6585861mr2295650vsm.10.1679322651195;
        Mon, 20 Mar 2023 07:30:51 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id 68-20020a370747000000b007426e664cdcsm7294402qkh.133.2023.03.20.07.30.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 07:30:50 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id n125so13282275ybg.7;
        Mon, 20 Mar 2023 07:30:50 -0700 (PDT)
X-Received: by 2002:a25:3249:0:b0:a02:a3a6:78fa with SMTP id
 y70-20020a253249000000b00a02a3a678famr4214330yby.12.1679322650227; Mon, 20
 Mar 2023 07:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230320135418.2055-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20230320135418.2055-1-lukas.bulwahn@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 20 Mar 2023 15:30:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWpYZr=v-pm4c2nCoHGv3ygdKiV+TKQ8jLkJOGQcYtreQ@mail.gmail.com>
Message-ID: <CAMuHMdWpYZr=v-pm4c2nCoHGv3ygdKiV+TKQ8jLkJOGQcYtreQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: Kconfig.machine: remove obsolete configs ROMBASE
 and ROMSIZE
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Greg Ungerer <gerg@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC Greg

On Mon, Mar 20, 2023 at 2:54 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> The configs ROMBASE and ROMSIZE were used in arch/m68k/68360/head-ram.S,
> which was removed with commit a3595962d824 ("m68knommu: remove obsolete
> 68360 support").
>
> Remove the obsolete configs ROMBASE and ROMSIZE.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Fixes: a3595962d82495f5 ("m68knommu: remove obsolete 68360 support")
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

> --- a/arch/m68k/Kconfig.machine
> +++ b/arch/m68k/Kconfig.machine
> @@ -439,15 +439,6 @@ config ROM
>           that can be stored in flash, with possibly the text, and data
>           regions being copied out to RAM at startup.
>
> -config ROMBASE
> -       hex "Address of the base of ROM device"
> -       default "0"
> -       depends on ROM
> -       help
> -         Define the address that the ROM region starts at. Some platforms
> -         use this to set their chip select region accordingly for the boot
> -         device.
> -
>  config ROMVEC
>         hex "Address of the base of the ROM vectors"
>         default "0"
> @@ -465,14 +456,6 @@ config ROMSTART
>           Define the start address of the system image in ROM. Commonly this
>           is strait after the ROM vectors.
>
> -config ROMSIZE
> -       hex "Size of the ROM device"
> -       default "0x100000"
> -       depends on ROM
> -       help
> -         Size of the ROM device. On some platforms this is used to setup
> -         the chip select that controls the boot ROM device.
> -
>  choice
>         prompt "Kernel executes from"
>         help

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
