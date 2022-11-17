Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4852762D5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 09:58:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239345AbiKQI6u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 03:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239246AbiKQI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 03:58:46 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EC613D41
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:58:43 -0800 (PST)
Received: by mail-qk1-f175.google.com with SMTP id g10so727747qkl.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:58:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PsHL7FL7Xul8Q7EqXyeDP++KJ21Dqj5Fc5nxhWT+XH8=;
        b=D+RrDUxI8usqb5XGaN3Ef2AjiIBvv8a0+lg3a5QrAjVv5FvR7tCBB/AZJ67vJ0kzVY
         bMjmLnzKnd5UaenU8vlb5GsQ93wROaZnRCGIqBqhCagEbjiBaN0H26dCw2M7r23zHqbS
         Vp51gYBF7YcvG6QriqCJdXg/yMqythJpgzX9UvFVHgK2RGaclPkZR73/zpHUYrHMR9vV
         UjcGUiIoQchfWhT83HA14Dp6YEt37dalfPLE/6oB2Rro5U4OjtL78/TWkAw80shB1CQ3
         PKCoKb4urXqhe0vpuTe4NMGMrcDBMKgsQLI0jhXBhS3GBzxT7eiqtH5eCApXCWBFDaDF
         AnFA==
X-Gm-Message-State: ANoB5pkJCmk0EPdFdbTRikZ9e8UJ0TPwQ84FD9AvCvClg3HzvpXUMmo3
        +h47KsKN8fefdpEukwgzpi/FPFz3U8gnJA==
X-Google-Smtp-Source: AA0mqf42McCTTomJI5GQKbvf5/IUhHZM/ZyO0UBdRxRZcMTGExYTYwHWBcH33cALwUXFDqI3XR/7ww==
X-Received: by 2002:a05:620a:2853:b0:6f7:fbbc:eb56 with SMTP id h19-20020a05620a285300b006f7fbbceb56mr809567qkp.719.1668675522818;
        Thu, 17 Nov 2022 00:58:42 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a415200b006e54251993esm77549qko.97.2022.11.17.00.58.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 00:58:42 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id k84so1115950ybk.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 00:58:42 -0800 (PST)
X-Received: by 2002:a25:4289:0:b0:6ca:e43:d9ff with SMTP id
 p131-20020a254289000000b006ca0e43d9ffmr1156718yba.543.1668675522199; Thu, 17
 Nov 2022 00:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com>
 <20221013182912.k4deh5v47rjbpnnl@meerkat.local> <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
 <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
In-Reply-To: <CAMuHMdV5i3JGtg8e=STuP7SENVOKHAEtZ+WdUw8GPt7j9gH65A@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 09:58:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
Message-ID: <CAMuHMdV5pbH-=8z0Qg2_t8ekzTQjZUopPrZeJHWs+z0DzJAZYg@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Richard Weinberger <richard@nod.at>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
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

Hi Konstantin,

On Fri, Oct 14, 2022 at 8:06 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Thu, Oct 13, 2022 at 8:48 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Oct 13, 2022 at 8:29 PM Konstantin Ryabitsev
> > <konstantin@linuxfoundation.org> wrote:
> > > On Thu, Oct 13, 2022 at 02:57:18PM +0200, Geert Uytterhoeven wrote:
> > > > The first step is
> > > > https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list
> > > >
> > > > It doesn't make much sense to start collecting archives if the lore
> > > > collector hasn't been activated yet.
> > >
> > > The archiver is now subscribed to the list. Once we have the archives, we can
> > > complete the setup.
> >
> > Thank you, I have triggered the export from Gmail. After I have received
> > the export archive, I will merge it with my local pre-Gmail archives.
>
> I have just sent my merged archive for linux-um.lists.infradead.org
> and the old user-mode-linux-devel.lists.sourceforge.net (starting
> from 2003-09-02) to Konstantin.

Is there anything from us you are still waiting for?
Thanks again!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
