Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C296A5FD99F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiJMMxG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Oct 2022 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiJMMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:53:04 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAEC12790B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:53:03 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id bb5so878347qtb.11
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:53:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdvJ1Rh5b+NEMidgBT/38v5acoxFTItHtJsRGjoiEKA=;
        b=kYhdGdbTUw3biKdIeY3NCtD9VOggy8wwq5DIoKTLoTicYeZ/2vDRRAcF0o9QWWqwZ2
         76igoxFPnVLpTwpsoCDtm5Uf19cl4MLMjusVe3tSCbYLvxwNctfKxH8DYpacOPHY4Dj6
         mDMApEQNoOgdYKGwDuRGQnCw8kUEX1RlMNMXNropNKHn+jIhc67rIm4e9MQHQAgGFoHG
         YArA/PD3oIrRlcPA4BI8e0qX0bkq08qj36+AvScPAZkCzNJUP8eTjF3rs/CekS3CSnoh
         Wn7fTcNx3xkHB4jVokjrir3oEElygZq1cR0jyMEyPeJC5752xhFvd+Ale8UzRnsbuBTa
         lVOw==
X-Gm-Message-State: ACrzQf3888mCA/lnrpnHC5oy2NEbiWh8MNsxouqhova4bkQZPg+gtSbn
        7oI5R78qI/nmf9Qic3RshG0T0memCMOm6g==
X-Google-Smtp-Source: AMsMyM5K5uR7QtEC/GN1U8YAf1feB2pc9nCTVx1tp9ryPFqXUTm1JfkBJmqe1x5D0lFzpiQUTYjW/A==
X-Received: by 2002:a05:622a:58e:b0:398:23db:964 with SMTP id c14-20020a05622a058e00b0039823db0964mr21287477qtb.664.1665665582337;
        Thu, 13 Oct 2022 05:53:02 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id k15-20020a05620a414f00b006e6a7c2a269sm18275854qko.22.2022.10.13.05.53.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 05:53:02 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id 203so1891552ybc.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:53:01 -0700 (PDT)
X-Received: by 2002:a05:6902:563:b0:6be:5f26:b9b7 with SMTP id
 a3-20020a056902056300b006be5f26b9b7mr33449769ybt.36.1665665581616; Thu, 13
 Oct 2022 05:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221012191142.GA3109265@bhelgaas> <885a98b927a5244ad5a5ec8727b67b2135d5a8ad.camel@sipsolutions.net>
 <f57d954a-b565-9bfa-b8eb-ce608e168f1a@cambridgegreys.com> <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
In-Reply-To: <2135037685.24273.1665665172126.JavaMail.zimbra@nod.at>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 13 Oct 2022 14:52:49 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
Message-ID: <CAMuHMdVWWbonfT7-RRV4U9UUudUobpeAGOXpO9Y0Cyuqzy=DeQ@mail.gmail.com>
Subject: Re: Add linux-um archives to lore.kernel.org?
To:     Richard Weinberger <richard@nod.at>
Cc:     anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        helpdesk <helpdesk@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Thu, Oct 13, 2022 at 2:46 PM Richard Weinberger <richard@nod.at> wrote:
> ----- Ursprüngliche Mail -----
> > Von: "anton ivanov" <anton.ivanov@cambridgegreys.com>
> > On 12/10/2022 20:15, Johannes Berg wrote:
> >> On Wed, 2022-10-12 at 14:11 -0500, Bjorn Helgaas wrote:
> >>> The linux-um@lists.infradead.org mailing list is listed in MAINTAINERS
> >>> and is quite active [1].  Once in a while a commit links to the
> >>> infradead pipermail archive [2] (the link in that commit appears
> >>> broken).
> >>>
> >>> I propose that we add linux-um to the lore.kernel.org archives so
> >>> future commits can use lore.kernel.org links that don't depend on
> >>> infradead.
> >>>
> >>> https://korg.docs.kernel.org/lore.html says pipermail archives like
> >>> infradead has are not ideal, but I don't have any archives at all, and
> >>> I don't know how to get even pipermail archives out of infradead.
> >>
> >> I think we talked about this before, but I also don't have any archives
> >> worth talking about (only since mid 2019 with a small gap in mid 2020).
> >>
> >> If anyone wants to collect the archives from all people, I'm sure it
> >> could be done. I can contribute what I have ...
> >>
> >
> > I am not keeping any (only some of the discussion on my own patches) - I relied
> > on the mailing list archive.
> >
> >> The tooling makes that pretty simple, actually.
> >>
> >> I think lists.infradead.org mostly got lost though, right dwmw2? So that
> >> way I don't think we'll find much (old) archives either.
>
> Geert, IIRC you have excellent archives. Maybe you can help us?

/me wondered how long he could keep on ignoring this thread ;-)

Mine date back to 2003 (at sourceforge.net).
I'll increase the priority of that task...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
