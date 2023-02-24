Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 918D46A1D1B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjBXNtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBXNtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:49:12 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619E2B291
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:49:10 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id h16so14269444qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:49:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cdobsUNZXMqy4AZbmsjSHmQzJLyd1scZQQSBg1yiYIk=;
        b=YY7vvYRnd6r7wNVFgtWHfTHiHF96vK1wzpd/WxNzp8BTqrJi43LlMJC4OzE6RSRqt1
         qJPNNQbawSDuqeHUw24cR96a9o7gStLodo9db79XyihFhKNPiHF6NhEGOWMEGm2QIHYw
         TX0CtkcRsE9vktF7DzDEjEja5wwfEpicyqj9q5MKlMSL59HVTEoSGV9HhZ8UFZRrGvBZ
         SYW3oeMbdNlnTXQRpEbs4TxGhi8181BS4K4vInNA+sY/jB5Lr5/tEszDITQmxmGHGoLy
         9jlEuzdenTq27p1r7Wm9Kg7zA9M0tRF6dQIyXc2JBLCO/gB2d8LB6kt3BEwrJzMzoOi2
         jWoA==
X-Gm-Message-State: AO0yUKW/UxpoHabOu5zEkW2JwGH8FER/s9aJHbYjqOOChYZFMelA8gNu
        1UIaIUHUC9APJ582wEihWa1l4PnmH5kE7Q==
X-Google-Smtp-Source: AK7set93ap8PvX2LSJPIYQmp0q8Hx18OQI8w59UD9MkWB+cMcBweA4FJRbGx0lYIPz5jJb9BUnl4Hg==
X-Received: by 2002:ac8:4e41:0:b0:3b9:a777:3d9a with SMTP id e1-20020ac84e41000000b003b9a7773d9amr27114089qtw.44.1677246549879;
        Fri, 24 Feb 2023 05:49:09 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 13-20020a05620a040d00b0073b575f3603sm8462351qkp.101.2023.02.24.05.49.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 05:49:09 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-536c02c9dfbso274732127b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 05:49:09 -0800 (PST)
X-Received: by 2002:a81:af5f:0:b0:536:38b4:f51 with SMTP id
 x31-20020a81af5f000000b0053638b40f51mr4485469ywj.5.1677246548746; Fri, 24 Feb
 2023 05:49:08 -0800 (PST)
MIME-Version: 1.0
References: <Y/iy9+Kn0SgzngDC@kroah.com>
In-Reply-To: <Y/iy9+Kn0SgzngDC@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 24 Feb 2023 14:48:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXT-LqqfzLqUHpORbNz89F4eGJrJY2TJdoM5+MME_4fdw@mail.gmail.com>
Message-ID: <CAMuHMdXT-LqqfzLqUHpORbNz89F4eGJrJY2TJdoM5+MME_4fdw@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core updates for 6.3-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
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

Hi Greg,

On Fri, Feb 24, 2023 at 2:01 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> The following changes since commit 2241ab53cbb5cdb08a6b2d4688feb13971058f65:
>
>   Linux 6.2-rc5 (2023-01-21 16:27:01 -0800)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.3-rc1
>
> for you to fetch changes up to 88cd618dcc7b63baa1478730b02eaba3e3148467:
>
>   debugfs: drop inline constant formatting for ERR_PTR(-ERROR) (2023-02-20 14:14:56 +0100)
>
> ----------------------------------------------------------------
> Driver core changes for 6.3-rc1

Thanks for your PR!

> All of these have been in linux-next for a while with no reported
> problems.

I think you should drop this sentence from your boilerplate, to avoid
confusion among people who reported regressions and/or posted
fixes that you promised to queue up after your PR is sent to Linus.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
