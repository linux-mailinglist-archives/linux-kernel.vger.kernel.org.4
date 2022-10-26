Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC99660E14B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbiJZM5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbiJZM5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:57:19 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D8963B942
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:57:18 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id x3so2784954qtj.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:57:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GHPnwGcL07S/3HxkQcxmtCdbU4/35neUEzbYrWqymaQ=;
        b=ZcV7zNgTMc134DrKNNkrd4iGsU/OEhsPbSMi9c5OY7aWAMwbhrcPyQ9GiaBM+zPzLC
         c+Am17IOGHB7484nfsTWxoXboeCSEJAECiJXVswwPvnihTCgrKsjdLzKq0Ii+zp7OstR
         PXkW/28UBD3TTogGZZc9NT5sVB2wBgaAoCNMo0AzLOaBsBzpjV7+opeZgbKnIU9kPsnM
         OyN0WqYmVebsEH0AfgIb92GUV0PFHyIfBtfNRRLl/zmigQqfmI+gMvObA+Nree2/YJ8z
         22/S/FbeZbgIuMVq/CoBP/lvscBmP9L1393MSam/qReZe2X2QOdRKyKTQUf2XGnVrYue
         BehA==
X-Gm-Message-State: ACrzQf3p61Bq/AOiQrEjxw+2CKywkex9/4m3+4iOt7Yo5zhheQFjbM6r
        yQmuwFiqtoxg/+xMjUKRvdYy+gX4yCtPDg==
X-Google-Smtp-Source: AMsMyM7Hf+qLfGSD9nC+UL2Xe6QMH18tqC5tlODmHAdI0zzBzorjPZi6V009vu8t9q5UQIoxfpKUhQ==
X-Received: by 2002:a05:622a:392:b0:39c:e5a2:6d18 with SMTP id j18-20020a05622a039200b0039ce5a26d18mr37100719qtx.245.1666789037567;
        Wed, 26 Oct 2022 05:57:17 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id q8-20020a37f708000000b006ce0733caebsm3796634qkj.14.2022.10.26.05.57.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 05:57:17 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id o70so18696324yba.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 05:57:17 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr36837059ybb.604.1666789036883; Wed, 26
 Oct 2022 05:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221026124801.1576326-1-Jason@zx2c4.com>
In-Reply-To: <20221026124801.1576326-1-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 26 Oct 2022 14:57:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdR34JX3+=m8vuw=k_kOxT1jq3sGsW6yh_h9aFH+BP4A@mail.gmail.com>
Message-ID: <CAMuHMdXdR34JX3+=m8vuw=k_kOxT1jq3sGsW6yh_h9aFH+BP4A@mail.gmail.com>
Subject: Re: [PATCH] m68k: mac_via: use explicitly signed char
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, Oct 26, 2022 at 2:48 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> The `val` variable is set to -1 and compared against < 0, which means
> it's assumed to be signed. However, soon char is to become unsigned
> tree-wide. So explicitly mark `val` as signed to that it keeps working
> the same way.
>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> Geert - Linus asked me to consolidate all of the unsigned-char fixups in
> one tree. So, unless you plan on taking this for 6.1, I'll queue it up
> in that tree for 6.2, following your ack. -Jason

Thanks for your patch!

> --- a/arch/m68k/include/asm/mac_via.h
> +++ b/arch/m68k/include/asm/mac_via.h
> @@ -269,7 +269,7 @@ extern int via2_scsi_drq_pending(void);
>
>  static inline int rbv_set_video_bpp(int bpp)
>  {
> -       char val = (bpp==1)?0:(bpp==2)?1:(bpp==4)?2:(bpp==8)?3:-1;
> +       signed char val = (bpp==1)?0:(bpp==2)?1:(bpp==4)?2:(bpp==8)?3:-1;
>         if (!rbv_present || val<0) return -1;
>         via2[rMonP] = (via2[rMonP] & ~RBV_DEPTH) | val;
>         return 0;

LGTM, although this could just use "int" instead.

Upon closer look, this function is not used, and seems to have never
been used before.  Please just remove it instead.
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
