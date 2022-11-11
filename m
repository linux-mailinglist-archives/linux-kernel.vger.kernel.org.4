Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43895625346
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 06:58:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbiKKF6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 00:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbiKKF6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 00:58:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF1BEAB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:58:29 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w14so5111101wru.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 21:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dQTrN1j7D5Od0RfI0QG9Fx5v8zmQsi9NEHZ+3EDUSmk=;
        b=Udqr2R8V2vNlq/sUqkbHvF99eYazAH/Ki28lYHT/G1nHEvnKkXmEK2VuFCBklfjWkf
         3Bo4PmakcOB+8PWupzC2xT07UlatAy62NcnCjTseUoPltjv1JnLr7YMNIxEfWa0IvoIS
         Rsbs1oj0nKU6W1qF64Yh3P4Rb8YBiydAsqXPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQTrN1j7D5Od0RfI0QG9Fx5v8zmQsi9NEHZ+3EDUSmk=;
        b=M/h2dZmdyk/gr4Xc1DXsqi4E8Je+5Wqy7hWmZ4KcCgrejhw7neWZ+JGzk+6CAmQahf
         KDbMERAh5l4i7+eCoiewpKrK4lMxRlHJ0lE2zkJqB0c6EXztVnVSqLln0euoEvuiOP56
         CvwCchdPCD6MWE5IR/T99QiG6KMEwnZjgRy7d+BG/OYnsgxJK2a8kyDuyqsB1p2NE8Zg
         r8z4h/4eYoj6tw6cswhP/bkIy6QjLGZBfcztYNBHyVoE4Lzs1OX/y/4m0eh/1QkodcV6
         MhAy0+EafJy7AIO+cdCvtHYxIwb4spxkjV9NnHvtcjZAoJw8aqwFP/MP+np6Pizrww0/
         f+NA==
X-Gm-Message-State: ANoB5pkLc3kWZ/CKX74KoJf2CPpgO2/NTGtvsxDi+shi3pE5i3WqK3tH
        NfUrrz3U1tBNQqjaNV1/DVlnXYj4p8vFWOQ2EKJ5g6Fh
X-Google-Smtp-Source: AA0mqf7ddsHaE9m3bziST+k+8FnQ49rwnt7qQpt3yMJefxJD01k/U73boNvBT/FrsyenllusOjqxghFE6ABOF16G7Vg=
X-Received: by 2002:adf:f10b:0:b0:236:4983:285a with SMTP id
 r11-20020adff10b000000b002364983285amr235372wro.606.1668146308386; Thu, 10
 Nov 2022 21:58:28 -0800 (PST)
MIME-Version: 1.0
References: <20221110013438.16212-1-zev@bewilderbeest.net>
In-Reply-To: <20221110013438.16212-1-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Nov 2022 05:58:16 +0000
Message-ID: <CACPK8XdkXaVXzabFM-g6xQ1CBjZheiP9oFrYk5o1__QR7WBcdw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: aspeed: Update git tree URL
To:     Zev Weiss <zev@bewilderbeest.net>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-aspeed@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022 at 01:34, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> The description for joel/aspeed.git on git.kernel.org currently says:
>
>     Old Aspeed tree. Please see joel/bmc.git
>
> Let's update MAINTAINERS accordingly.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

Thanks!

Acked-by: Joel Stanley <joel@jms.id.au>

Arnd, does the soc team have a branch for these?

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cac5a4ad4eb8..1775e5fdaefd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1969,7 +1969,7 @@ L:        linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  L:     linux-aspeed@lists.ozlabs.org (moderated for non-subscribers)
>  S:     Supported
>  Q:     https://patchwork.ozlabs.org/project/linux-aspeed/list/
> -T:     git git://git.kernel.org/pub/scm/linux/kernel/git/joel/aspeed.git
> +T:     git git://git.kernel.org/pub/scm/linux/kernel/git/joel/bmc.git
>  F:     Documentation/devicetree/bindings/arm/aspeed/
>  F:     arch/arm/boot/dts/aspeed-*
>  F:     arch/arm/mach-aspeed/
> --
> 2.38.1
>
