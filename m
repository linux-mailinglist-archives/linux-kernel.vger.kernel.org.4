Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4CD56A2A1A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjBYNv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBYNv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:51:26 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05A413DFB;
        Sat, 25 Feb 2023 05:51:25 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id z6so2371750qtv.0;
        Sat, 25 Feb 2023 05:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0SRlfWig3tEGxTbW3x+e5tDuKYCknmRIInoXInN6npI=;
        b=q6tSzQ0/6ZxtWNIs3WZQXuiMiZ1L53WV2mdvblUW/QRzQi/z1VGMuK/ReAaamAvkb8
         OQVm6KSzcP+pzEyBs07CcM9aR/67z+HQlmR/qRC3HjLuu4nOgjH3VwyipAmOsTvL31+m
         S52TRMr2goVKPpLeJMStYeqn45uhVneMSVOP82efQTDCUa5yb/tlCdrNkfvSea/hqHUl
         8+xGXNBg/taZVn/WhoAvgXHItqS+8kuAFMWOiaw2geMRC/hcZiUDpyVldCqWyY/gP45K
         wEwBfJ6sfc9MXJlNLAH1NB2/yxgTVYACj4eYYrd2cuIB8NjwMfd7KCiBUiaiIlCgPBCD
         JHNQ==
X-Gm-Message-State: AO0yUKXXa/J+FXPSRnIlQt1E/0k4L96B7vD1u0bomdAxtFtiq87+Dd+9
        E9FVdN4mfbwvL3eLago33uo2GBGnud0WAg==
X-Google-Smtp-Source: AK7set/bIKgSocfoSJyqECVj6lSKGxb++KOG/KU8wUohZ252Uv8bjGIBhReOqqhifpKwoVWPe0Aj2Q==
X-Received: by 2002:ac8:4e89:0:b0:3bd:18c:4f7c with SMTP id 9-20020ac84e89000000b003bd018c4f7cmr20172262qtp.45.1677333084568;
        Sat, 25 Feb 2023 05:51:24 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id x2-20020ac86b42000000b003b635a5d56csm1360679qts.30.2023.02.25.05.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Feb 2023 05:51:24 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-536c02eea4dso55843847b3.4;
        Sat, 25 Feb 2023 05:51:24 -0800 (PST)
X-Received: by 2002:a05:690c:c8f:b0:52f:184a:da09 with SMTP id
 cm15-20020a05690c0c8f00b0052f184ada09mr2636587ywb.2.1677333083756; Sat, 25
 Feb 2023 05:51:23 -0800 (PST)
MIME-Version: 1.0
References: <20230225071230.11494-1-ufh8945@gmail.com> <20230225071230.11494-2-ufh8945@gmail.com>
In-Reply-To: <20230225071230.11494-2-ufh8945@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 25 Feb 2023 14:51:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUNn1Dxmfq+Y-B=CPDepFKZSxn=NTF2nG0BL=WBU-iG9g@mail.gmail.com>
Message-ID: <CAMuHMdUNn1Dxmfq+Y-B=CPDepFKZSxn=NTF2nG0BL=WBU-iG9g@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: video: logo: add SPDX comment, remove GPL
 notice in pnmtologo.c
To:     Nikita Romanyuk <ufh8945@gmail.com>
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kelvium@yahoo.com
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

On Sat, Feb 25, 2023 at 8:31 AM Nikita Romanyuk <ufh8945@gmail.com> wrote:
> Signed-off-by: Nikita Romanyuk <ufh8945@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
