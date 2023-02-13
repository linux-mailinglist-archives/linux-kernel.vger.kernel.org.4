Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9906694236
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:04:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBMKEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBMKEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:04:50 -0500
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A96C86AE;
        Mon, 13 Feb 2023 02:04:49 -0800 (PST)
Received: by mail-qv1-f52.google.com with SMTP id l7so3085162qvw.7;
        Mon, 13 Feb 2023 02:04:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nX9NKNfoarkgYYQ3M6UNMv7h9iSvCd5dVBdxKjMrY3Q=;
        b=j+f5owTa3rwHCoMql9N2U4gK9B3AMwJ9RfBRsgaVJ+XybLxT5OUAut2BbpZIPpIR6M
         nMza2Z+UtMHoYssX+okk5WTKlQBiL9FqjH0f17Y32NdMxv1Us4I4M3rRLP9+qJsJ2Ejo
         0IQlOGCyagHLCWxAVhlXyy5wd6bfa0O07mO4LYOfNsWTiCnpmFBgSgDY5OxDHfItR+zy
         LFEMW9yNNS0+YsDWNQL+HU4Y4KnMWUdXce7OntVkrD/SjW7svdT584a0ZsU1S81BDnR5
         PwEVijxrw+vyQ4SpeCZea9jI6AzKCkTe9Z/LoINtf7vH+iERsPFgna1WLE4f43eEPUli
         wqEA==
X-Gm-Message-State: AO0yUKVNuruw2QsFKOBoXv3xDEVecmpx+6rXAlLrZL2An6dmnnJQ5JPb
        0UdDeZu3m4sVSneYCT7ag8KsCiqPD7xjzg==
X-Google-Smtp-Source: AK7set8wAwKLXTlXtEWO+f9FJTrx1gnd1dbpWTybPVRVp4dmmWBDPEnqqhHLe3mW1khyfu90iUbq9A==
X-Received: by 2002:a05:6214:2b07:b0:56c:20c:f2f4 with SMTP id jx7-20020a0562142b0700b0056c020cf2f4mr45829535qvb.45.1676282687883;
        Mon, 13 Feb 2023 02:04:47 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id d186-20020a3768c3000000b006fa7b5ea2d1sm9396224qkc.125.2023.02.13.02.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:04:47 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id x4so13769427ybp.1;
        Mon, 13 Feb 2023 02:04:47 -0800 (PST)
X-Received: by 2002:a25:9e86:0:b0:8c2:240e:bd05 with SMTP id
 p6-20020a259e86000000b008c2240ebd05mr1033451ybq.359.1676282687081; Mon, 13
 Feb 2023 02:04:47 -0800 (PST)
MIME-Version: 1.0
References: <20230213080620.62f7eeb6@canb.auug.org.au> <CACRpkdY-n+3pOKSVhxOxo9+cO+pRE0rOxs=zCdJOQ3iV9Ussyw@mail.gmail.com>
In-Reply-To: <CACRpkdY-n+3pOKSVhxOxo9+cO+pRE0rOxs=zCdJOQ3iV9Ussyw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 13 Feb 2023 11:04:34 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWVq+jaEV=7BMB=+fO0EZyGpjBcm=bu3Mm-QvRqm1NNZQ@mail.gmail.com>
Message-ID: <CAMuHMdWVq+jaEV=7BMB=+fO0EZyGpjBcm=bu3Mm-QvRqm1NNZQ@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the pinctrl-intel-fixes tree
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

Hi Linus,

On Mon, Feb 13, 2023 at 10:57 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Sun, Feb 12, 2023 at 10:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > The following commit is also in Linus Torvalds' tree as a different commit
> > (but the same patch):
> >
> >   a13bbd841bf8 ("pinctrl: intel: Restore the pins that used to be in Direct IRQ mode")
> >
> > This is commit
> >
> >   a8520be3ffef ("pinctrl: intel: Restore the pins that used to be in Direct IRQ mode")
> >
> > in Linus' tree.
>
> This is really weird because my only copy of that patch was on the fixes branch
> and that is what I sent to Torvalds.
>
> When I check my tag pinctrl-v6.2-3 it's like this:
>
> commit a8520be3ffef3d25b53bf171a7ebe17ee0154175 (HEAD, tag: pinctrl-v6.2-3)
> Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date:   Mon Feb 6 16:15:59 2023 +0200
>
>     pinctrl: intel: Restore the pins that used to be in Direct IRQ mode
>
> So that is what went to Torvalds' tree. It's also the only thing I
> ever published to
> the for-next branch, as it turns out after some git reflog in my working tree:
>
> a8520be3ffef (HEAD, tag: pinctrl-v6.2-3) HEAD@{31}: reset: moving to fixes
> a8520be3ffef (HEAD, tag: pinctrl-v6.2-3) HEAD@{39}: reset: moving to fixes
> a8520be3ffef (HEAD, tag: pinctrl-v6.2-3) HEAD@{52}: reset: moving to fixes
> a8520be3ffef (HEAD, tag: pinctrl-v6.2-3) HEAD@{55}: am: pinctrl:
> intel: Restore the pins that used to be in Direct IRQ mode
>
> So what is this a13bbd841bf8 patch coming from?

"git show --pretty=fuller" says:

    Commit:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
    CommitDate: Mon Feb 6 17:03:06 2023 +0200

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
