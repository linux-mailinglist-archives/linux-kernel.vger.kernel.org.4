Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECFA694198
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjBMJoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjBMJoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:44:06 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73E8C6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:44:04 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5258f66721bso155689897b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qt5BQPp6Kb7lMp2OsVEKiNMkmHxDtRccvggEDqy6BlI=;
        b=ks2PqeqcYpi9WJxRAieNKhn35XyNNz0j2Hzn9RQvYhhBrWMfkesz7UM5ZzeZZk4djR
         NOGNCTLGrqgXYZzqk66+27CNPgZvmC0AZX6Nk/KZ4lqP+ZwEkkFAwupMIrM+Pb2xWhke
         qBrQLXbcFf9TGQT3VLK+AVLgKnRm+4VzdOOGUGfBb5UYRI0CZsRt96F2P91vHmU/w6Of
         hHqOY5toUwKzwyEF9r3AoHLKVn7MHud0luZQLtub91GbZWiXzqDNGl1IoYhP1kMpeSy0
         zQYjC2iUDJTvzwvrOV9jS+Fe6CO7Jt2MTsJrPDoh8Nf1i78BFDODCdEs86iQ7NBDBOKY
         A4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt5BQPp6Kb7lMp2OsVEKiNMkmHxDtRccvggEDqy6BlI=;
        b=JrDpHi548opD2F0cr50ZPA3h7vqMd2p7I2bO/83hnvbVAdCQd/SJH5b258kgvvwfzU
         XXAQPjCfmdfyh+Vj8nKp/wooE1m15oCuZZ2XgdK6NoVgxieIj3k+SAZnoxNZFs+Xm254
         peP6W/veXbypsgpB5oifvsP6SsL1467/XgJ1MID6SfLJcs0Rrijwgg0fLlCWtzDb2nPz
         9Pf8UzWytCdD+xiKjPptqrpOxP06ismQwvP9VNtkvgjaR0tzrm5/gKoXZAu+Aqhye3ZA
         AnrhFETLZQ+Z16ttLbFJ8hPRUbh+JTaSXqAYFAIxeUsJ5JeVfiI2V7HVf7jaZcRbRL6d
         gwtg==
X-Gm-Message-State: AO0yUKVNHcHcwsOX+j/y0cgDvW9Z0MssSrOip5IZi+kWP7lrMnXf3OgD
        sk1tumvhXXWrlJIcPMlAnOwkIKKLL+X/VY8/WQfeDGc4NxHNWWtW
X-Google-Smtp-Source: AK7set/xgrzi3IYAjq9BKLt2f/EP2m9yUMF42UOsbN7NQWgxsdG69d1zgbd2rxWdA8ubLaH5/pc2Y8R8B4ZuWPIlSVo=
X-Received: by 2002:a81:8681:0:b0:506:c617:9e38 with SMTP id
 w123-20020a818681000000b00506c6179e38mr2846640ywf.54.1676281444061; Mon, 13
 Feb 2023 01:44:04 -0800 (PST)
MIME-Version: 1.0
References: <20230213080620.62f7eeb6@canb.auug.org.au>
In-Reply-To: <20230213080620.62f7eeb6@canb.auug.org.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 13 Feb 2023 10:43:52 +0100
Message-ID: <CACRpkdY-n+3pOKSVhxOxo9+cO+pRE0rOxs=zCdJOQ3iV9Ussyw@mail.gmail.com>
Subject: Re: linux-next: duplicate patch in the pinctrl-intel-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 10:06 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> The following commit is also in Linus Torvalds' tree as a different commit
> (but the same patch):
>
>   a13bbd841bf8 ("pinctrl: intel: Restore the pins that used to be in Direct IRQ mode")
>
> This is commit
>
>   a8520be3ffef ("pinctrl: intel: Restore the pins that used to be in Direct IRQ mode")
>
> in Linus' tree.

This is really weird because my only copy of that patch was on the fixes branch
and that is what I sent to Torvalds.

When I check my tag pinctrl-v6.2-3 it's like this:

commit a8520be3ffef3d25b53bf171a7ebe17ee0154175 (HEAD, tag: pinctrl-v6.2-3)
Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Mon Feb 6 16:15:59 2023 +0200

    pinctrl: intel: Restore the pins that used to be in Direct IRQ mode

So that is what went to Torvalds' tree. It's also the only thing I
ever published to
the for-next branch, as it turns out after some git reflog in my working tree:

a8520be3ffef (HEAD, tag: pinctrl-v6.2-3) HEAD@{31}: reset: moving to fixes
a8520be3ffef (HEAD, tag: pinctrl-v6.2-3) HEAD@{39}: reset: moving to fixes
a8520be3ffef (HEAD, tag: pinctrl-v6.2-3) HEAD@{52}: reset: moving to fixes
a8520be3ffef (HEAD, tag: pinctrl-v6.2-3) HEAD@{55}: am: pinctrl:
intel: Restore the pins that used to be in Direct IRQ mode

So what is this a13bbd841bf8 patch coming from?

Yours,
Linus Walleij
