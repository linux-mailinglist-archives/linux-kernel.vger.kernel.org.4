Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1354568EA4B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBHJAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 04:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjBHJAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 04:00:46 -0500
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADB0458A7;
        Wed,  8 Feb 2023 01:00:41 -0800 (PST)
Received: by mail-qt1-f174.google.com with SMTP id g7so19947588qto.11;
        Wed, 08 Feb 2023 01:00:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ulipj+ekr9BdqMabMZbjdhUjgKznvujfTjbF2mwVL4I=;
        b=ya/koxURVBVd3ekJIne1e2jCzVcm1ri/7uFC3QA4DfUtJ2EHBh2kWpJvwsqRURMzhi
         tCFFmplmiGhP/F3zlXKau663TwKiXKlpIq+/1PhKMnt9k0LR+guuoy6aBslvWDPUsarM
         j9Sd+4yy5upsBf6vZtRYxEKGds5t2c5Ldt72/3XxbXLsKxG/8/Nz5iiNMxlKV+blpIho
         XFFNbiLgdprGrZ4I+KrYUaHgrU/oOhjqJBJvW21DBx4qPdh4hS/vfBtUO1gObV2wnkgs
         jX5u6F9GPCh+vatO1Mz+aGQFy+FUUBhSIfoqYck9ldu7Kf4HtCjId3ixhbukc8bNq5+E
         m25w==
X-Gm-Message-State: AO0yUKU1aeAbGoUUkXyAkFjtSe89wZ4blo6knJIfokUJHvrdXgNwy25D
        ceFydzqSYqeEwK1Eiuo6IcQeGievebd5mw==
X-Google-Smtp-Source: AK7set9R3CdNsqj7Eh9w7Fz8rs0WU+fi/gST1ZIYYEhQ+gxf8wLtttOjJAQkQ9Hle7TrWAVVW7FSQw==
X-Received: by 2002:ac8:5955:0:b0:3b3:7d5:a752 with SMTP id 21-20020ac85955000000b003b307d5a752mr11741273qtz.50.1675846840080;
        Wed, 08 Feb 2023 01:00:40 -0800 (PST)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id s20-20020a05622a019400b003b860983973sm11011807qtw.60.2023.02.08.01.00.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 01:00:39 -0800 (PST)
Received: by mail-yb1-f169.google.com with SMTP id t1so12078272ybd.4;
        Wed, 08 Feb 2023 01:00:39 -0800 (PST)
X-Received: by 2002:a25:eb04:0:b0:7b4:6a33:d89f with SMTP id
 d4-20020a25eb04000000b007b46a33d89fmr504451ybs.543.1675846838981; Wed, 08 Feb
 2023 01:00:38 -0800 (PST)
MIME-Version: 1.0
References: <20230207165715.14617-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20230207165715.14617-1-glaubitz@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Feb 2023 10:00:26 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSuwu7LTpmUcOyTrZf0tOb4MfCAfHh7n7EL2JO2rtL9w@mail.gmail.com>
Message-ID: <CAMuHMdWSuwu7LTpmUcOyTrZf0tOb4MfCAfHh7n7EL2JO2rtL9w@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add myself as maintainer for arch/sh (SUPERH)
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-sh@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Feb 7, 2023 at 5:57 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> Both Rich Felker and Yoshinori Sato haven't done any work on arch/sh
> for a while. As I have been maintaining Debian's sh4 port since 2014,
> I am interested to keep the architecture alive.
>
> Signed-off-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Thanks for stepping up!

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
