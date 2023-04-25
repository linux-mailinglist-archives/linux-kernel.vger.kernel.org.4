Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978AC6EDCA5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjDYHbC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 25 Apr 2023 03:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjDYHa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 03:30:27 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B6CC20;
        Tue, 25 Apr 2023 00:29:40 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-b980ec2a95cso7303620276.2;
        Tue, 25 Apr 2023 00:29:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682407685; x=1684999685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uGl5U27dIAVcoPRAhAw7M++MtUvlNkzHHP3i/+uz8BM=;
        b=JYKizE66VSNqk5+1rs6sGyGTMjtlTOaCyB+c1fpagSzmf9+tqopSPJJQI5Li9X+jNX
         nFQHurC6+/HAxlVm6eyyqcyNLgyP5bZRDFTWi/5IzHFeyianD5FsL7gZdVFN+dNPbWeU
         4b8758BGfTGRX0rXGSto7sUGIArTlq0Ka21NjhK/PKfe2uHgo94HINjAh36NjfVDFApH
         LSHzL7Zv7ZgwCRzIqVzJWOsWXKK3tukiKGbABeJb+Psk2luRKl616zX6Y4lbmu6/zeAR
         YaKgK1i246LiqfNABF02XKzwoXpz6/mp3pOEE4sKt7zxhXIMHb/3j/0vL7QvRktIs43g
         /VnQ==
X-Gm-Message-State: AC+VfDwgPMnDM9RPL9pZR1XSlacG+YFn2RdRTYM2wpbpuVE1w8XFutFU
        isHYrBhkbqfbU6ROfyFAQ8iiJLkNokolwg==
X-Google-Smtp-Source: ACHHUZ76kZCkvJroi+i+A+za1T8isl2CHK+/By1hCHAeElXKKBjgyrIjfTUFOfJHMklv8rTU3JI+kg==
X-Received: by 2002:a25:d750:0:b0:b99:f35f:9086 with SMTP id o77-20020a25d750000000b00b99f35f9086mr828369ybg.33.1682407685655;
        Tue, 25 Apr 2023 00:28:05 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id 194-20020a2502cb000000b00b95b616caf2sm3370718ybc.6.2023.04.25.00.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 00:28:04 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-54f8f459b34so63728427b3.0;
        Tue, 25 Apr 2023 00:28:04 -0700 (PDT)
X-Received: by 2002:a81:4e4a:0:b0:54c:9c2:d1be with SMTP id
 c71-20020a814e4a000000b0054c09c2d1bemr10102189ywb.13.1682407684508; Tue, 25
 Apr 2023 00:28:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220328000915.15041-1-ansuelsmth@gmail.com> <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain> <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 25 Apr 2023 09:27:51 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
Message-ID: <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-omap@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        linux-oxnas@groups.io, linux-arm-msm@vger.kernel.org,
        linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
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

Hi Rob,

On Tue, Apr 25, 2023 at 12:16 AM Rob Herring <robh+dt@kernel.org> wrote:
> I have a script[1] that does the conversion written the last time this
> came up. Just have to agree on directory names. I think the easiest
> would be for Arnd/Olof to run it at the end of a merge window before
> rc1.

"emev2" and "sh7" are missing for renesas.

Does your script also cater for .dts files not matching any pattern,
but including a .dtsi file that does match a pattern?

> I'm very much in favor of this happening especially before *any*
> overlays are added to add to the mess (it's probably already
> happened).

;-)

> [1] https://lore.kernel.org/all/20181204183649.GA5716@bogus/

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
