Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C49A85F49AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 21:24:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiJDTYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 15:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiJDTYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 15:24:13 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A8D65815
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 12:24:12 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g23so8760335qtu.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 12:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=UGv+4Ut0HLLEjpaUAPUVZXaZ900gJu9AykveplMCL1U=;
        b=URvG7DwIubm3/EQ91sUr7I/IZcR0Fhyn+9ZTW+dQQr9NpmeWjM6ahJZObGsJ3U0SiB
         g3p7kThvV4Jq3HV0K0aeEhaDa8gR+gQyU11rYMjBUkgDwmi1+V6eS0hoVnb5xn4/RmNq
         oCN7gfhRM46mNb7BZR8+tN7a9LRWayvP8oW3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UGv+4Ut0HLLEjpaUAPUVZXaZ900gJu9AykveplMCL1U=;
        b=DfQfjAzkLoKsDxphjxbQYnaT4Xyk40Rs2LZTt6+OOOMQN1a9AZD3LAxUyyAa4uv6Sb
         AOj8gRABllggz0UwEtbxTAe5RdRsYYf4Rfihf/GJRsuGA2viGUSyLyRxcG2DaWd2RBu4
         NPyu+Zpm8hVmpEbjd6dk6IOMc6x6HNuDi5enrdA7Eu1TBlQfOl4KZpyJw4QMCp/YBBpA
         e6Z/JCswRWvrDASat4Lv1rIJBlT9Ovz/Hn7nPiAIUJPn1RctOIsfzAYsO2KfT6XxMg2y
         +QdOglXsNPnqW0YBThO7Fr8DJuCcU0GwN/j3VJGtXQqK0ZDaIosShAeKCBxErTHwemR4
         2wRw==
X-Gm-Message-State: ACrzQf2Kk6aBL1lK3KmUU6WbOhNi5BN+3CcpS4229aX692TvEuJXmAzl
        x/strsMxO4m2pM0FBEoMA9Mq8g==
X-Google-Smtp-Source: AMsMyM7F6US4MHrT1SRGsB2cYTu7Yy8NeSol1EU/9LJMbcPgPun/zAiBU19d8ou6TvWTXeuJMMX5Gg==
X-Received: by 2002:a05:622a:180d:b0:35b:d283:7e65 with SMTP id t13-20020a05622a180d00b0035bd2837e65mr21012590qtc.106.1664911451349;
        Tue, 04 Oct 2022 12:24:11 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-33-142-113-79-147.dsl.bell.ca. [142.113.79.147])
        by smtp.gmail.com with ESMTPSA id d10-20020ac851ca000000b0038c60a3fa8bsm1075495qtn.85.2022.10.04.12.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 12:24:10 -0700 (PDT)
Date:   Tue, 4 Oct 2022 15:24:08 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>,
        "Artem S. Tashkinov" <aros@gmx.com>,
        ksummit <ksummit@lists.linux.dev>, workflows@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla
 blues"
Message-ID: <20221004192408.z6gxc7unclm7vbdg@meerkat.local>
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <20221004175354.bfvg3vhfqch35ib5@meerkat.local>
 <87fsg3s8co.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87fsg3s8co.fsf@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:21:27PM +0300, Jani Nikula wrote:
> As to bots, one idea would be to go through old & unchanged bugs after
> every kernel release or so, ask to reproduce on the new kernel, and auto
> close if there's no response within some time frame. This could be very
> relaxed for starters, but would start closing all the stale and
> neglected bugs that have crept up that are of no use to anyone.

This is what Fedora does, and I've always felt it creates more annoyance than
good, but if that's the consensus, I'll be happy to implement this.

-K
