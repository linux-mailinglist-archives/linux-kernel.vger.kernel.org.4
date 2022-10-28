Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FAFD61123E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbiJ1NF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiJ1NFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:05:10 -0400
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDCA31F89
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:04:57 -0700 (PDT)
Received: by mail-qt1-f182.google.com with SMTP id f22so3388379qto.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TVUWwaHw02W9cOy0F44SflIYoXa5sfjHCnsNHHyNsmM=;
        b=uLwyTjieD2aQGDmbRWc2qDIjTxvkLbf5DIONHZCutNo1715k8bb3ya9h/2H4/QBB0d
         SjtBZAMTdmQzTOEK4da741s3P+vSXWyLLyAzERWCghod+S3zXv7eyOP4QIF31a3qCn1Z
         d6aWy9UHBWajsHN0ZSV3k0Za/v2Q+VvGoPP/sayqMY+/0poBAF+VcxrdPPJM1OLbRheS
         CXNt/uCfKE2T3qWRfbjm5nb/NpyvuGhMjQ2lNSQC1jwT9XAzCum7IHCHy5mNC7A4nXM2
         GttwDhJ9nJEheMWtEktuZ/jIuV00PivpKigL8kAgeCC4+xh1pBdAhqnY/KbJ9xG31Tkn
         eTGw==
X-Gm-Message-State: ACrzQf3/u3nW2W9q41gkyHh3NmOY9DnHpR46qWTdNePWHLsqVvQy+Wmu
        GL76LEBEz6j638m3FX+/T4+OVhXmQqVpGQ==
X-Google-Smtp-Source: AMsMyM7k2H5RI2yTM5cjfRlUieumyCt7oqQlSab2uEIHJnHo9jIhaHUxMTqbryOybPyv6Ekau/6r1A==
X-Received: by 2002:a05:622a:410:b0:39d:8ed:33e with SMTP id n16-20020a05622a041000b0039d08ed033emr38772524qtx.43.1666962296296;
        Fri, 28 Oct 2022 06:04:56 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id j66-20020a37b945000000b006f87d28ea3asm2836718qkf.54.2022.10.28.06.04.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 06:04:55 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id j130so6027983ybj.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 06:04:55 -0700 (PDT)
X-Received: by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr46623716ybb.604.1666962295225; Fri, 28
 Oct 2022 06:04:55 -0700 (PDT)
MIME-Version: 1.0
References: <0229879ee3e2d8828707d291cddbb89ac18a10c2.1666945731.git.geert@linux-m68k.org>
 <Y1vSjQfkDfPINUBo@debian.me>
In-Reply-To: <Y1vSjQfkDfPINUBo@debian.me>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 28 Oct 2022 15:04:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV2WAnhFWJFEGOqch4h8mQ31w459ejOmn=39KWj1wAXsQ@mail.gmail.com>
Message-ID: <CAMuHMdV2WAnhFWJFEGOqch4h8mQ31w459ejOmn=39KWj1wAXsQ@mail.gmail.com>
Subject: Re: [PATCH] m68k: mac: Reword comment using double "in"
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Michael Schmitz <schmitzmic@gmail.com>
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

Hi Bagas,

On Fri, Oct 28, 2022 at 3:01 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On Fri, Oct 28, 2022 at 10:30:26AM +0200, Geert Uytterhoeven wrote:
> > People keep on sending (incorrect) patches to remove the second
> > occurrence of the word "in".  Reword the comment to stop the inflood.
>
> Ah! People who aren't fluent in English think that duplicated "in" below
> isn't OK, which after stripping that become nonsense without reading the
> actual code.
>
> > Suggested-by: Michael Schmitz <schmitzmic@gmail.com>
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > To be queued in the m68k branch for v6.2.
>
> Should this patch be Cc: stable'ed so that no more trivial patches as
> you mentioned?

People should not be sending patches against stable in the first place.
Once this makes it upstream, the inflow should stop (hopefully ;-)

> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
