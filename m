Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1F662269
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 11:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234123AbjAIKCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 05:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbjAIKBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 05:01:44 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D44B6F;
        Mon,  9 Jan 2023 02:01:37 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id z12so7390403qtv.5;
        Mon, 09 Jan 2023 02:01:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eshgBixf0oY5QW+geWBankTPG5WvD9jfZetbBO0Ldgo=;
        b=V+PXoU83OHHdY/GgD7/DiH8sew4jVppU65AFX/zq2BcGhx8uHUu4lkru/c/ZiVNHcd
         pkZugqcIzdvZdCD8GYJpe+qr4ErPWSiK2WWaXXS8oW4ASbc1L7SCSXZWOjbGhzqyUeHV
         ApeNni79ms4T4ZtkSduGqbTHNImRThoUlyMUqAge7QHHlMTqaNZY8f0ATST1XMEHfZW3
         1KcOVtVpf2WGNZ+uWB36mqBRZTWwYg+A4Btzeo+zT5I3CBnEb+vRRcxj9LCoq4LXVx+G
         ISJnM5w7cYPCXh0BTbEzP6aUJa5V2AfqpaPKPUcDey8omyaXSzPUgLNqIjsnVsbPHIcZ
         nJfA==
X-Gm-Message-State: AFqh2ko8ie01tFBmB9F1BuXuAvO/jOcy+O2tCjNQQAtMhswwVI1+Njn2
        2WYxkgPFV7IN57Ls6sQaTIOvHettyDvYTA==
X-Google-Smtp-Source: AMrXdXsb5h/is58LB+3UBFAMOeHyEY+glI/sIPy1xi+F8M8ClqXCGvO8ffUuA66ByNMTv9Ca0eTWrQ==
X-Received: by 2002:ac8:1487:0:b0:3ad:b9af:a507 with SMTP id l7-20020ac81487000000b003adb9afa507mr2371270qtj.52.1673258496676;
        Mon, 09 Jan 2023 02:01:36 -0800 (PST)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id t5-20020a05620a450500b006fa8299b4d5sm5160632qkp.100.2023.01.09.02.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 02:01:35 -0800 (PST)
Received: by mail-yb1-f180.google.com with SMTP id c124so7973202ybb.13;
        Mon, 09 Jan 2023 02:01:35 -0800 (PST)
X-Received: by 2002:a25:d103:0:b0:75d:3ecb:1967 with SMTP id
 i3-20020a25d103000000b0075d3ecb1967mr5480772ybg.604.1673258494966; Mon, 09
 Jan 2023 02:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20230105094039.1474255-1-xurui@kylinos.cn>
In-Reply-To: <20230105094039.1474255-1-xurui@kylinos.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 9 Jan 2023 11:01:22 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX174erGgrCUBv2WdX67H=mig-hi=SOdeMJ=0__thC_fw@mail.gmail.com>
Message-ID: <CAMuHMdX174erGgrCUBv2WdX67H=mig-hi=SOdeMJ=0__thC_fw@mail.gmail.com>
Subject: Re: [PATCH] fbdev/g364fb: Fix a compilation issue
To:     xurui <xurui@kylinos.cn>
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xurui,

On Thu, Jan 5, 2023 at 10:45 AM xurui <xurui@kylinos.cn> wrote:
> drivers/video/fbdev/g364fb.c:202:4: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
>
> Signed-off-by: xurui <xurui@kylinos.cn>

Thanks for your patch!

> --- a/drivers/video/fbdev/g364fb.c
> +++ b/drivers/video/fbdev/g364fb.c
> @@ -175,7 +175,8 @@ int __init g364fb_init(void)
>  {
>         volatile unsigned int *curs_pal_ptr =
>             (volatile unsigned int *) CURS_PAL_REG;
> -       int mem, i;
> +       int mem;
> +       uintptr_t i;

This doesn't look like the right fix to me.

The line the compiler[1] complains about is:

                *(unsigned short *) (CURS_PAT_REG + i * 8) = 0;

Interestingly, it doesn't complain about:

        *(unsigned short *) (CURS_PAT_REG + 14 * 64) = 0xffff;

This driver uses raw memory writes to write to hardware registers.
Probably it should use writel() instead.

[1] mips64-linux-gnuabi64-gcc version 10.3.0 (Ubuntu 10.3.0-1ubuntu1)
    jazz_defconfig + CONFIG_64BIT=y

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
