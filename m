Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740A36377E5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKXLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:48:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKXLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:48:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D65BB5FF6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:48:11 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id n20so3721166ejh.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=blCcvC6QKKIaKtyUJS3ccU8VGbnmgGS7051EVyZp8hM=;
        b=WDYRSI7qFtGIukM5Ljw7LGTfH8GC5RrIPnE4mzgRvjCWsCMgn396uKu9fC7+Gx0q+I
         MDEfUxIaLkWMPufNnHRdevpxQJM6mjR6TSs+Ml3+DHdXn5N2LLBV0PSJgl7XdoqRbyZy
         KY5psZtIUaxI+oAqQwKgb+SpQu/Z+oiGzQpY5YTpRfu1KgBWM0+2CNNMok9yoDztjG7G
         JVB38Fl6dIqwwYLWxp5VrZvzysHL2kmkzSQRlqmwyzH2d5sAJo/6i1Uxhnz9SZmypm9K
         J6GltXA1vi53MDw5pUhIOxmw3/jiAYJfIBEamkVO7nmzSI+BTnUfH94AJeBg0XyvsVek
         0XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=blCcvC6QKKIaKtyUJS3ccU8VGbnmgGS7051EVyZp8hM=;
        b=O23eeme9Le72du7sNbDcUaofypNRmXIGJU/VrgupskFAr5nGr27nDqvEqoEiD5OXfl
         1fjk60lwJJMN0hQLfHdc7cLttU7IKxq3Ss+0eZr6lm5loz9PvV6BijqdyAOtqfp+x67W
         RAYkoMUT9KNYCNq2rOayyEhneAVH+agXs5X/3PRTwHiY3eaDJmN2lzC+eGxXGQYyi5KU
         AhUciUhI3dvie2/ee7m5y+SrMz6qnuobtTi+GaGQz8t7m5JolSeY6/2g3X91Mp5gag+6
         RobmJQWNMDL2S+xOcPaDdNtmFX6rpM1hZ06tH+8fZaAhJOi/c6qUm3KUyyE1IzN158tS
         XiDw==
X-Gm-Message-State: ANoB5pkURzaKUXg9Si1J06y4mefgxB2koGdOT1T3+SD2BDoKMRM7Yk5s
        gKLno23t1dhLBnUd8AVOeSGLBrAQ1bMSmOgsF2voJa/x
X-Google-Smtp-Source: AA0mqf6Gm+V7GlZo2znlxXosInF8w9q5Ch/o2fFXsP5+OX6fxQPIdOZiQ/Lmi8Y9QMY6+DLJLcEQKRddawkNeUBf568=
X-Received: by 2002:a17:906:c052:b0:79a:101a:7e57 with SMTP id
 bm18-20020a170906c05200b0079a101a7e57mr27132572ejb.368.1669290490329; Thu, 24
 Nov 2022 03:48:10 -0800 (PST)
MIME-Version: 1.0
References: <20221124114356.2187901-1-me@iskren.info>
In-Reply-To: <20221124114356.2187901-1-me@iskren.info>
From:   Iskren Chernev <iskren.chernev@gmail.com>
Date:   Thu, 24 Nov 2022 13:47:58 +0200
Message-ID: <CAL7jhiedQ7eP0V2LRE-BgAuVbm51uU=LwEATzuMwP-XxRE_GxA@mail.gmail.com>
Subject: Re: [PATCH] mailmap: update email for Iskren Chernev
To:     Iskren Chernev <me@iskren.info>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 1:44 PM Iskren Chernev <me@iskren.info> wrote:
>
> I'm sunsetting my gmail account and moving to personal domain.
>
> Signed-off-by: Iskren Chernev <me@iskren.info>

Acked-by: Iskren Chernev <iskren.chernev@gmail.com>

> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index 4a14ece4cdb7..ab20bdb07656 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -228,6 +228,7 @@ Juha Yrjola <at solidboot.com>
>  Juha Yrjola <juha.yrjola@nokia.com>
>  Juha Yrjola <juha.yrjola@solidboot.com>
>  Julien Thierry <julien.thierry.kdev@gmail.com> <julien.thierry@arm.com>
> +Iskren Chernev <me@iskren.info> <iskren.chernev@gmail.com>
>  Kalle Valo <kvalo@kernel.org> <kvalo@codeaurora.org>
>  Kalyan Thota <quic_kalyant@quicinc.com> <kalyan_t@codeaurora.org>
>  Kay Sievers <kay.sievers@vrfy.org>
> --
> 2.38.1
>
