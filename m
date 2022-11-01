Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0D36144BB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 07:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiKAGjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 02:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKAGjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 02:39:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967FD2BF1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:39:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso17948067pjg.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 23:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zjm6vkcUHHt/WlCFKXrmJ5qjIVeFNMZWxZFTowcFZnw=;
        b=Egvel5cPdV6oz5Ybxr6963sDu5ZkoxKeSJm0ReR2X/XVaTY8jceFi04dAllG4kv7m4
         CVoYpqNQTe8oXfblGC3c+scOhoA2YV2dz6LxfTLBShIBueoHF6yruO9Co3g7VeyYWbp6
         Vdb6iTyU67ewnSWAuEwRo5HzvraT9lajPyc1z3u+7lWTAz7KbrEkK8jfThkVV66UWWLo
         hBPxc0yPJozwfPzbLYbZtj4cB957sQ9BpLKfKBlg3mIB26gB6oc9XIISoCpe8Qwy0JZs
         eUWhBUINZzeRUj//JjBA0PSSP+jeznHUQU02W6y7+sxIs5GmJbsY29p8Y+5rm8qQy7T5
         v48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zjm6vkcUHHt/WlCFKXrmJ5qjIVeFNMZWxZFTowcFZnw=;
        b=o5JzM3/O+R9NDtP/pNRogSx74R91sqAEAKWOXAaZbdcu+GphvYczAbHPRJwnJ8H1iY
         ijsc5dP/vVwln5JTnl6VG4uL8GEynk/6Qxgfq9rBoUCor6VyauvsGkEF22BBnazmPHpt
         HVtBQ+LUMc4obi+qmm8giHeGHzFTHIZV9gLDTkD1/eSYeVPugDwjKU9iVYDk9K/kbcZK
         h6/MAdDxjJk6V1hNgKnwFUhVvTmlSjsbOUqy4VD0sMxAnlyVxWSxJA6o/tCp9N5G8b3M
         UZlSUpRIve4axZ4T7ipYf7OvLDfMmTovWmNjBnaSq/7eqBvep1OqO282qYSZ7VL0t4s2
         /sdA==
X-Gm-Message-State: ACrzQf3xRdgDNkZ+YH+ZhaJefKI/WBVU7up4OX+YGMX2b2kYmi0knrsJ
        tuEiDmFj24ieAOLimgYbsKX3/TwqUmg+dVyD8RFRQQ==
X-Google-Smtp-Source: AMsMyM6Pb3FdPIBUFMBKkraNZxzDYfIcCtv3ngoLrPVf1pM9fGiKb9V9JmB8px+XaD3qqN/P+WmIeH/HrKP8l+lsyKo=
X-Received: by 2002:a17:902:f686:b0:187:16a0:fd2b with SMTP id
 l6-20020a170902f68600b0018716a0fd2bmr12326009plg.91.1667284788108; Mon, 31
 Oct 2022 23:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221016121406.co3qixzcbfke4ye7@proprietary-killer.gsrm.network> <CAD6h2NSahYuqg1T2oW7tHmAeAfqircfeokYhvJYNRVi5TXEDAA@mail.gmail.com>
In-Reply-To: <CAD6h2NSahYuqg1T2oW7tHmAeAfqircfeokYhvJYNRVi5TXEDAA@mail.gmail.com>
From:   Haojian Zhuang <haojian.zhuang@linaro.org>
Date:   Tue, 1 Nov 2022 14:39:35 +0800
Message-ID: <CAD6h2NT84eLERrx8T_=4qK7d9jum7Lc9QEMnNvd65cptZRTuoA@mail.gmail.com>
Subject: Re: pinconf-single: pinctrl-single,bias-pull{up,down} bits help/explanation
To:     "Marty E. Plummer" <hanetzer@startmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, tony@atomide.com,
        linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 at 14:20, Haojian Zhuang <haojian.zhuang@linaro.org> wrote:
>
> On Sun, 16 Oct 2022 at 20:14, Marty E. Plummer <hanetzer@startmail.com> wrote:
> >
> > Greetings.
> >
> > What I'm having issue with is the pinctrl-single,bias-pull values. From
> > commit abe4e4675dfc62b7f2328e2c4bce8b5bdcdff7c0 I get a bit of it, and I
> > think I have it mostly figured out:
> >
> > // <[input] [enabled] [disabled] [mask]>;
> > pinctrl-single,bias-pullup = <? 1 0 0x100>;
> > pinctrl-single,bias-pulldown = <? 1 0 0x200>;
> >
> > using mask 0x100 to single out bit 8 and mask 0x200 to single out bit 9,
> > enable values being simple binary on/off. What I don't get is how the
> > input value is determined/calculated.
> >
> > Aside from the above mentioned commit for the am335x-pocketbeagle.dts,
> > which uses a differing pullup control scheme, the only users I can find
> > in the tree are a handful of hisi socs which I don't have a datasheet
> > for to map their usage to register definitions and puzzle this out.
> >
> Excuse me for just noticing the email.
>
> #define  PULL_DIS     0
> #define  PULL_UP        0x100
> #define  PULL_DOWN  0x200
>
> // <[input] [enabled] [disabled] [mask]>
>
> // If you want to pull-up, configure the pin as below.
> pinctrl-single,bias-pullup = <PULL_UP  PULL_UP  0  PULL_UP>
> // If you want to disable pull-up, configure the pin as below.
> pinctrl-single,bias-pullup = <0  PULL_UP  0  PULL_UP>
>
> It seems that the pin configuration in am335x-pocketbeagle.dts is wrong.
> But I don't have the board to verify it.
>

Sorry. I didn't check the comments in the commit carefully.

Obviously, the pinctrl definition is totally different in am335x chip.

bit4 is used to select pull-up or pull-down.
bit3 is used to enable the pull-up/pull-down.

In Hisilicon chip, bit9 is used to enable pull-down and bit8 is used
to enable pull-up.

They're totally different. I suggest you to enable the value in DTS
file and dump the register
value  to check for your own silicon.

Best Regards
Haojian
