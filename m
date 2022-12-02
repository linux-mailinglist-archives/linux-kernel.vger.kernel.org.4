Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03611640E53
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 20:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiLBTUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 14:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiLBTUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 14:20:01 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68D4E02C2;
        Fri,  2 Dec 2022 11:19:56 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id l15so6557165qtv.4;
        Fri, 02 Dec 2022 11:19:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Krq/qK4TL8BZ5IzDnHZVXKpdIUt0NJJ149BP500ozFw=;
        b=s2TXTQCokc95OBy4JG79aDEbpRITb9DGOAJBa+Ldd2fKsWRTWiQzQgoB81mGiNFme1
         EKAQdPGXAvqq1mhXED/DAihNmigQtc9UPJYfJOFTT/YsXSD8pOkwSdNtEM/59OVJUhrp
         uymy1FZceYmsJPQBDxcNDOsB6g5sbHSLm1ww1QfYGBzTuCnJFSzGf0lBub87kLvRu+kp
         jx/X8Zhoc0RPHoKKNRpeyRJ4IJp7rOc0hnt716cP+4YYyvH785h7LZ21+knLgMD87k+g
         JgEGANDNomP+2fW/bHa9UYrVaJFoMJvm9LyY+U877+xva7LtJLw48DFJjJ944br/OEvZ
         LlNQ==
X-Gm-Message-State: ANoB5pkC8UZ7IIy/byiZ9Qygi2NmoM7XIZun9acL2LC9vncluvOqkKbW
        mEoac5oVI9+fEXTIPaV81C43b2x284UMZsKmsnc=
X-Google-Smtp-Source: AA0mqf4MmCmoKIvOQtZdJS4YLefVb+zGnYo6cw2RCpk9a2GbKL7ogkSPYOaePmqo0EcoDYtf699TDfMfpyle+ADBy64=
X-Received: by 2002:ac8:4818:0:b0:3a6:a0d7:e1f7 with SMTP id
 g24-20020ac84818000000b003a6a0d7e1f7mr1696719qtq.153.1670008796014; Fri, 02
 Dec 2022 11:19:56 -0800 (PST)
MIME-Version: 1.0
References: <f619bc0b58a70e1cd1942b3db3716d6f9b261666.1669462247.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <f619bc0b58a70e1cd1942b3db3716d6f9b261666.1669462247.git.christophe.jaillet@wanadoo.fr>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 2 Dec 2022 20:19:45 +0100
Message-ID: <CAJZ5v0heDvc=tmn2bFBpUaq2w72R_E4HVtvSPuOuosyKDTHENw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: Remove a useless include
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, James Morse <james.morse@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-acpi@vger.kernel.org
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

On Sat, Nov 26, 2022 at 12:31 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> This file does not use rcu, so there is no point in including
> <linux/rculist.h>.
>
> So just remove it.
>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/acpi/apei/apei-base.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/acpi/apei/apei-base.c b/drivers/acpi/apei/apei-base.c
> index 02196a312dc5..c7c26872f4ce 100644
> --- a/drivers/acpi/apei/apei-base.c
> +++ b/drivers/acpi/apei/apei-base.c
> @@ -25,7 +25,6 @@
>  #include <linux/slab.h>
>  #include <linux/io.h>
>  #include <linux/kref.h>
> -#include <linux/rculist.h>
>  #include <linux/interrupt.h>
>  #include <linux/debugfs.h>
>  #include <acpi/apei.h>
> --

Applied as 6.2 material, thanks!
