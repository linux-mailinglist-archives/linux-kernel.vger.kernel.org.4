Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD4763C29D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 15:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235385AbiK2OdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 09:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiK2Oc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 09:32:59 -0500
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4052419C3B;
        Tue, 29 Nov 2022 06:32:58 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id w4so9012257qts.0;
        Tue, 29 Nov 2022 06:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cUpgiPOMkAgUjLgo0dg2Z726lxhPTeHnNlTeQA4SUTQ=;
        b=GeteOidpvqYjKCz/jyhd2M7AQAehzFktxBnw/6hlPGyth7PykRE01/YENAJ+S6d9TY
         rbEcC3ZG9q1ymcLQ01HVmGAY6hwND+CytEDII1nIo4ZXNm+VFySX71gv37iXjWSJ8PEn
         pxrOG7fHJtqPSTLgSu14EmM2K5OKVxK33EKRk6Z73cpQlk4mV5qVY+mvjhbyVlHmQ10r
         cugBDmKqZrdzZ50f+na6Yo2RloG9vM3pOnJWso83eW+kKr28fSDmESpLGMlYe4ng0b64
         HI9RuenmvkVJKQHOK/hY9P2gTbDCVMXDenssT6E22PBVP5KM5g8t0CLRspsMGZRwR7Zx
         ZvYA==
X-Gm-Message-State: ANoB5pkUGd/yfaaOQ10nTgvVs0MVJG6HUFwufGvbjhFCYLPxFQO1JHB8
        RxDmK+JG9fCv6XW+2h4L2LH10xFsdePs4Q==
X-Google-Smtp-Source: AA0mqf4D5XmrS2oPQ6h8AtbAoUUS0mgrIReyRagSbdTx0cKABISHDY0FjSwJl4ySFv64sNYam8MqNQ==
X-Received: by 2002:a05:622a:4017:b0:3a5:4f7e:bab2 with SMTP id cf23-20020a05622a401700b003a54f7ebab2mr37871622qtb.527.1669732377131;
        Tue, 29 Nov 2022 06:32:57 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id bl38-20020a05620a1aa600b006fbb4b98a25sm10545595qkb.109.2022.11.29.06.32.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 06:32:56 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-3bfd998fa53so87507957b3.5;
        Tue, 29 Nov 2022 06:32:55 -0800 (PST)
X-Received: by 2002:a0d:dc87:0:b0:370:61f5:b19e with SMTP id
 f129-20020a0ddc87000000b0037061f5b19emr51696728ywe.316.1669732374847; Tue, 29
 Nov 2022 06:32:54 -0800 (PST)
MIME-Version: 1.0
References: <20221117122904.6759427e@canb.auug.org.au> <20221128102212.39f90b0c@canb.auug.org.au>
 <1a60d0b2-c020-4fce-d7f2-3534c9e14c84@intel.com> <9ac3a182-fc30-0834-8555-a4ec334531ae@linaro.org>
 <Y4S8H/hn1EJzw8fL@debian.me> <70ee6a63-de17-100f-d4fd-8b23ab92bfee@linaro.org>
In-Reply-To: <70ee6a63-de17-100f-d4fd-8b23ab92bfee@linaro.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Nov 2022 15:32:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUc1xt+J6a-vfQ3uJiRYiU4Sda3XRjy89RqKSAv_zQBKQ@mail.gmail.com>
Message-ID: <CAMuHMdUc1xt+J6a-vfQ3uJiRYiU4Sda3XRjy89RqKSAv_zQBKQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rafael@kernel.org
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

Hi Daniel,

On Mon, Nov 28, 2022 at 3:08 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 28/11/2022 14:48, Bagas Sanjaya wrote:
> > On Mon, Nov 28, 2022 at 02:22:27PM +0100, Daniel Lezcano wrote:
> >> On 28/11/2022 13:51, Rafael J. Wysocki wrote:
> >>> Sorry about this, but I cannot fix it myself and Daniel is on an
> >>> extended leave.
> >>>
> >>> Can you just drop it permanently from linux-next and we'll sort this out
> >>> when Daniel is back?
> >>
> >> Yes sorry for that, I'll go back in a couple of days and sort this out
> >
> > What about the upcoming merge window? At worst Linus has to figure
> > out how to solve this complex conflict when pulling either tree...
> >
> > Linus has already said that there's likely -rc8 of current cycle [1],
> > so we have about two weeks to try sorting out the conflict and be ready
> > for PR to him.
>
> Thanks for the pointer.
>
> I've been quickly through the changes for the thermal tree and I think I
> should be able to sort out most of the patches before the end of this
> week, hopefully. If there are any changes which sound too complex, I'll
> post pone them to the next release

I gave it a try for today's renesas-drivers release.
Does the conflict] resolution in [1] look good to you?

Thanks!

[1] https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git/commit/?h=renesas-drivers-2022-11-29-v6.1-rc7&id=9b249c2e655ef25473afbcdae85453c66eb288be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
