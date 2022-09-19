Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB9F5BC1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 06:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiISEHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 00:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiISEG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 00:06:57 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA07FAE45
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:06:56 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t190so2598691pgd.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 21:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=SKc7ienc320bxaSqnsDwmqqYkrQ1W8qMLxdfUMOcQck=;
        b=DECwdbcvfv16bsFM6nQM3ZpFsiauW9Lcnmm7X25+4NjijLsN0W7qZnWHpH30YQd8+E
         jPfWmJthrHrMEIlMUM2Eci3dKz9BqZMkG1smGXBsb2WX0NWTjlKivSaVWwjeEZRzh4YR
         KZNYjOj/iyZ7hL8ehQ9Y2R+bETbPoJ8KgYhzeHtgKyBhKc6ufsu5pa1bCyK/Xqiu7KUI
         48K/om1UZh+qzvEA4J8Rouun5he6FIZkaY4YPy1V5epuH0VM23cq8tgfSvZ6NTeBBkeJ
         0QLfGLEOyX7HSZd4yzZ2Gg5t+JU+c0Mc635qpX8IkKvfBHuoqfBnYhUs4X+YpILo3JpM
         3OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=SKc7ienc320bxaSqnsDwmqqYkrQ1W8qMLxdfUMOcQck=;
        b=XMJ9XT4FE3Nu6mR4yyhHhAohQI9RLIaPPuo4YEm3WjCHE8iedVatWBrNhNonSSi3r3
         Jb65LPzXsYuX/GVhJa3GKjDKUsQfRFmzgPrwYgdySlgWY5O7lw8fpg9ZA1pnGSxRLfyq
         liEkZ44puQUjpPngB5c721CeIDgTvLUZZh/7YcoyUjxrrrShw+U8/Y1JqXtmA2LoRJNi
         Nq5EH7Yzh6PfofLkJkKit85zg+XK2QurqU8Lio1RB4apBr3WKZ/73zNMnmZgvNLJ4C7F
         1byjuu9wntmJZnr12Vq9XjeP/VkOS1axzD9l3MCV5TpNx1YlrsBd8guokKmBbcICpnJp
         16ZQ==
X-Gm-Message-State: ACrzQf0pRwn6anUXnQMptVixu94gAnkkC13NIjJwNspU9/Mao8hXo8yG
        BZxoBfSp59d6h7w1Do1US5c=
X-Google-Smtp-Source: AMsMyM607ldQAjae/oC+IOSLwU4EIw4Kh0YWOWFDmzUKOlIanKieGq3odU2ZiCYGog40IJ07068esg==
X-Received: by 2002:a63:1351:0:b0:439:14a8:87 with SMTP id 17-20020a631351000000b0043914a80087mr14233930pgt.66.1663560416330;
        Sun, 18 Sep 2022 21:06:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ce8400b0016dc6279ab7sm19388796plg.149.2022.09.18.21.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Sep 2022 21:06:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 18 Sep 2022 21:06:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: Linux 6.0-rc6
Message-ID: <20220919040653.GA1840059@roeck-us.net>
References: <CAHk-=wi=gtuSO8Yz8LDubkMk7TiMsZxpypt9S10jeZRkyaBFnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=gtuSO8Yz8LDubkMk7TiMsZxpypt9S10jeZRkyaBFnA@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 01:56:17PM -0700, Linus Torvalds wrote:
> So this is an artificially small -rc release, because this past week
> we had the Maintainers' Summit in Dublin (along with OSS EU and LPC
> 2022), so we've had a lot of maintainers traveling.
> 
> Or - putting my ridiculously optimistic hat on - maybe things are just
> so nice and stable that there just weren't all that many fixes?
> 
> Yeah, I know which scenario I'm betting on, but hope springs eternal.
> 
> Regardless, things look fine. I am expecting rc7 to be larger than
> usual due to pull requests having shifted one week later, and in the
> worst case that might mean that I might feel like we need an extra
> rc8, but for now I'm going to assume it's not going to be _that_
> noticeable and hope we'll just keep to the regular schedule.
> 
> But it would be lovely if everybody gave this some extra tender loving
> care in the form of extra testing...
> 

Build results:
	total: 149 pass: 149 fail: 0
Qemu test results:
	total: 490 pass: 489 fail: 1
Failed tests:
	mcf5208evb:m5208:m5208evb_defconfig:initrd

TL;DR: Patches / reverts needed to fix known regressions

Revert "net: fec: Use a spinlock to guard `fep->ptp_clk_on`"
Revert "fec: Restart PPS after link state change"
    revert b353b241f1eb
    revert f79959220fa5
    Rationale:
	The patches result in various tracebacks and crashes.
	https://lore.kernel.org/netdev/20220827160922.642zlcd5foopozru@pengutronix.de/

The need to revert those patches has been discussed repeatedly,
so going into details seems pointless.

Guenter
