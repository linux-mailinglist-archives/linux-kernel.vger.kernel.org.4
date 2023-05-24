Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D4D70FC18
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234637AbjEXRA1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 13:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbjEXRAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 13:00:24 -0400
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7F0BB;
        Wed, 24 May 2023 10:00:23 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-513debc49e8so351795a12.0;
        Wed, 24 May 2023 10:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684947621; x=1687539621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bnQ7iWZQ9Jgvf512BdDOCo0y+67JuQ0Mc0pXfe99S4=;
        b=bkb+29sADvojIJnB36/puHOiamt4HEBAzQdtaKdeD2frt8wl5eG44/Ih2Sey3afQnR
         5IDNFAmbMFs1HHi5joiwA8MR0xaAxAUeA4VpCOGiTa0JgSw3dygSNWb/ihjF/hl+DEDa
         YDY0D0DxesRxBbIixbEdNqrOVUM3Qx+aIuISxi6NF+jvhdeteEzja4rj4Vs8n6uixDxU
         oZmSwcOL5t44Zs+sWe0g1SXQQyBSSbeXQ6Oeu5wVJl159J2isQL7anb6t4fxzo2MqF5L
         9o2iow6XVi9WLQ4hixZa48eowDoyej8096ARg0gxEgZgJsDvvklyNifBujBpZ68chqyJ
         WnSQ==
X-Gm-Message-State: AC+VfDyCITap/7BBWNOBalwF7hkvbeK8LstywVFdeZyKBRz5XNR3vCi8
        sYRaQuTLslQZYxm8gkQf3HOCiHb33kAghV7t4UW91X7m
X-Google-Smtp-Source: ACHHUZ4zkXKoUIMbblySJMWLINU/pl5/h3yyKDdTQWWlkhCs93xq4sjxh/rMtUgwAzPHZ7HQS3AENyEL3Bjc8E9o9Tw=
X-Received: by 2002:a17:906:72d4:b0:96f:da08:d451 with SMTP id
 m20-20020a17090672d400b0096fda08d451mr9559930ejl.6.1684947621587; Wed, 24 May
 2023 10:00:21 -0700 (PDT)
MIME-Version: 1.0
References: <A393097506CB918E+ZFN4YOkubdwQvONz@TP-P15V>
In-Reply-To: <A393097506CB918E+ZFN4YOkubdwQvONz@TP-P15V>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 May 2023 19:00:10 +0200
Message-ID: <CAJZ5v0ja0FBakV7ERdVdB0bckaG9t+K6rz8qgPJDGG7bMNvaSQ@mail.gmail.com>
Subject: Re: [PATCH] strcut: Correct spelling mistakes in comments
To:     Wang Honghui <honghui.wang@ucas.com.cn>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 4, 2023 at 11:19 AM Wang Honghui <honghui.wang@ucas.com.cn> wrote:
>
> Signed-off-by: Wang Honghui <honghui.wang@ucas.com.cn>
>
> strcut: Correct spelling mistakes in comments.
>
> ---
>  kernel/power/snapshot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index cd8b7b35f1e8..b27affb7503f 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -398,7 +398,7 @@ struct mem_zone_bm_rtree {
>         unsigned int blocks;            /* Number of Bitmap Blocks     */
>  };
>
> -/* strcut bm_position is used for browsing memory bitmaps */
> +/* struct bm_position is used for browsing memory bitmaps */
>
>  struct bm_position {
>         struct mem_zone_bm_rtree *zone;
> --

Applied as 6.5 material under an edited subject and with a new
changelog, thanks!
