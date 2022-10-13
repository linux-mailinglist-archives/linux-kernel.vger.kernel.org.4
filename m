Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9635FE20A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 20:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbiJMSvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 14:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbiJMSvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 14:51:07 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC4463C4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:49:31 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id d13so1034668qko.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:49:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dqw3Xc1RI1aNzc3i+VnzEPkUPQWCL6Lh8uyt8Pd5dJw=;
        b=wqewJerCApNEmS0BeN+nyAGvQWS5FJUEVCZiIQsSqsoi7WbkJ5fs5ShbJyrEOia5Uu
         PU/HIS3Lf4vFJZ4H6yZkM/FD5QCLrwo1gko/wPdJyMoNzo7Dg5VdzASio1ndjysSJDQq
         LgRG6o1zrw5tbH8noT8qTWcSWMxYpLKT3FwIIvCEB+AnhUAa5JtKjfNNIWVCoxWE9oYW
         6OmtWUY6+5k2yslJYEaK7Yif92FIEVwy86eeKWZ2OppokNVBzTajlV3hqETGBtJX7yiw
         F5FcXWIFkwhnKJvUZp8uldEz3TRCrBboMvfG1TxY/EZA4NICpPj7eOURHE7PR8v2kxEw
         C4VQ==
X-Gm-Message-State: ACrzQf1G8A7Umn9K53LG+Vie0J9hjFqAJITqprfZ+fKK5ZnUsaqvxGs0
        J65yn26JUM5xS/+Tgm+NI3i5pOm0xN7U1w==
X-Google-Smtp-Source: AMsMyM7nUI9eC3RBBbZ+h/6RmCZJEoT4qJb4uM4NJTrOp1AEm1yuvkmA4m4wgrZB9PXcc3CspjqARA==
X-Received: by 2002:ae9:f205:0:b0:6bc:2d40:2f3d with SMTP id m5-20020ae9f205000000b006bc2d402f3dmr1047490qkg.448.1665686904401;
        Thu, 13 Oct 2022 11:48:24 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id y8-20020a37f608000000b006bb87c4833asm326181qkj.109.2022.10.13.11.48.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 11:48:24 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-35befab86a4so25934427b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 11:48:23 -0700 (PDT)
X-Received: by 2002:a0d:de43:0:b0:349:31bd:e8d5 with SMTP id
 h64-20020a0dde43000000b0034931bde8d5mr1243832ywe.283.1665686903595; Thu, 13
 Oct 2022 11:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
 <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
 <CAMuHMdU=TurB14tkAbqb9nWYvCOcr0UUScdga25h3-oWjYfzTg@mail.gmail.com> <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
In-Reply-To: <20221013182912.k4deh5v47rjbpnnl@meerkat.local>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Oct 2022 20:48:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
Message-ID: <CAMuHMdWb5HHuBi2BUKatdJ4e9y3Tz2pM-DG6mt18U60cD64fjQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

On Thu, Oct 13, 2022 at 8:29 PM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
> On Thu, Oct 13, 2022 at 02:57:18PM +0200, Geert Uytterhoeven wrote:
> > The first step is
> > https://korg.docs.kernel.org/lore.html#requesting-archival-of-an-existing-list
> >
> > It doesn't make much sense to start collecting archives if the lore
> > collector hasn't been activated yet.
>
> The archiver is now subscribed to the list. Once we have the archives, we can
> complete the setup.

Thank you, I have triggered the export from Gmail. After I have received
the export archive, I will merge it with my local pre-Gmail archives.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
