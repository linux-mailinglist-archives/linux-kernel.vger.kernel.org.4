Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299F768EA7C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjBHJHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBHJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:07:02 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492376A47;
        Wed,  8 Feb 2023 01:07:02 -0800 (PST)
Received: by mail-qt1-f179.google.com with SMTP id g18so17661674qtb.6;
        Wed, 08 Feb 2023 01:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdYqGAJyRa8qIJ+NrQDA6JinRoUIu5AZ1ShXzwXorPU=;
        b=g56U72kM6wX+4U3wpigDdOeEQf12flOAkAcJCTovpKa971mriW0AxjksT/cubNQhDp
         nK/qLHJBclSABNGTTIKwrsny4PsOr6Ar2qqvZ7R6vnd5Qbuh4I7fp3CLELovVPczZaKc
         gXfIdSeSKv3s6pzW1dYVOUu54o4nDtDV/lRGBsYfYnYzNh0mpfyYn87yEbMURSSFP0Cw
         dMyJzlBE/lqNr0YYlfPkkfoNQpFppQ1UL3wWv/nCCuvL27rNblVBFdokSuYUjCS1sUDr
         anxg+trIEIWBuhnDn7qmb5QHyh4Wo+6YwrEQnBVyV+pgrrjbABvHPSNCwfEmhQ/ZfaGG
         HX2w==
X-Gm-Message-State: AO0yUKVoZ7xMiCY4kqTxCGt41Zgzw/q3ClaLvJmG7vv7XqInYzHdDiPX
        U8y4Jv/0ASkcC5vF6yFA5dS6lT2W9+0sYA==
X-Google-Smtp-Source: AK7set/w8WBFBdHszyxDzfte+DwElncOzTbNRqYjyxHVEf7FCNT89S/zRED/jsva8EayF9Um+PhuUQ==
X-Received: by 2002:a05:622a:118d:b0:3b8:2ce4:3e9 with SMTP id m13-20020a05622a118d00b003b82ce403e9mr11850313qtk.32.1675847221263;
        Wed, 08 Feb 2023 01:07:01 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id h26-20020ac8515a000000b003b82cb8748dsm10941442qtn.96.2023.02.08.01.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:07:00 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id d189so13312317ybc.0;
        Wed, 08 Feb 2023 01:07:00 -0800 (PST)
X-Received: by 2002:a5b:508:0:b0:8a3:59a4:340e with SMTP id
 o8-20020a5b0508000000b008a359a4340emr727677ybp.604.1675847220466; Wed, 08 Feb
 2023 01:07:00 -0800 (PST)
MIME-Version: 1.0
References: <202302081659401393135@zte.com.cn>
In-Reply-To: <202302081659401393135@zte.com.cn>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Feb 2023 10:06:48 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULPv3qLCPSzcWrgdbq6MNnx1NjxXC+6kUGhQOqasGRLg@mail.gmail.com>
Message-ID: <CAMuHMdULPv3qLCPSzcWrgdbq6MNnx1NjxXC+6kUGhQOqasGRLg@mail.gmail.com>
Subject: Re: [PATCH] media: platform: renesas: use devm_platform_get_and_ioremap_resource()
To:     ye.xingchen@zte.com.cn
Cc:     niklas.soderlund@ragnatech.se, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 10:02 AM <ye.xingchen@zte.com.cn> wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
>
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
>
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
