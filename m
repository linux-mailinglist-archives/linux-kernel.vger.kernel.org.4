Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE49615FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiKBJZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiKBJYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:24:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DD92A72C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:23:10 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id y14so43643065ejd.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAWuHkpwgFfj7hhvFV4HxiLR1FE5OMLKHNPDDaCEASU=;
        b=Gtu0Ihij+nBxhtfx6L2SIRCXBbEoh6Ml8CRcad4tGqp0bDLotvBdDokciS4kkebKf+
         c7JGqzXn/KB9jct4cDwpgKInbF2y/Jn6Aw0Ja72vQd5X7jQv3zfHK/SMClip4QvPLh0u
         5CJOgas3x0pDyfEsA/TKs7cAQZyJ7Jmc0qUrE397kgEUCIpjMvyul5oaEQxcgqWJAR5R
         fvdFGUCLmKgH/eIVIVrnoBKLoXH4zPdimLuNhKZubyR7LGpEgBWJFvwz0Ay10zC/In0D
         usUXQ0kII5JY0q+QTiTylaJX7guINEk/3sElROzw+akl6ZVOM09N5IhXCxEtOHxRF6aj
         DmvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAWuHkpwgFfj7hhvFV4HxiLR1FE5OMLKHNPDDaCEASU=;
        b=vkghQFbv520/0y0kujQiCq1yw+aJiaSPsbaZDj3dP0zyhyAra31iL7hqkiyefGzP5Z
         WIRuVc1ZZGh+3M9/N9/d0qz6uTQSapKAQfmC33pguNxlUaAtivRoHt6PHDycCWrzgatD
         /57DAzfTqWkeSDkPa8BoNuaHWRSJmxfCu6ZOlLke/CTSc7jzKom23SYOJyA+TJ4/h+cr
         IeUwQkGUFwKzBFpk3QDuDeJKKvmmjUCXxuH3NrP5568nE8sSUFyqVJrwLHAnDCV5uZhu
         hGUYOtoz7fzV9p/3s0Rd5nkbJqWKV2R9Aio4vFOmnrG3GVUZR0wPi1M9LrlDVHN+P4rw
         HztA==
X-Gm-Message-State: ACrzQf1NFI8G+LPb8NG33wtE7vyLJndVQLaI0jjmp02zKJg0/CKqXSQA
        FI9WmeUB18AvhmKGarb6U6LHfq+ubQxKQWbxbWdnRg==
X-Google-Smtp-Source: AMsMyM4Z+d3FlUYFTaTzsaq4IqvJzKWCQTziKaxgs3wXWXAnaLeMiKS9TGWC3euoNd0VWQleMtvHS7le7gJSoYKCCR4=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr23201600ejc.440.1667380988923; Wed, 02
 Nov 2022 02:23:08 -0700 (PDT)
MIME-Version: 1.0
References: <20221021084708.1109986-1-bchihi@baylibre.com> <7h5yg02bh7.fsf@baylibre.com>
In-Reply-To: <7h5yg02bh7.fsf@baylibre.com>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Wed, 2 Nov 2022 10:22:33 +0100
Message-ID: <CAGuA+oqWXy-WV3-VFN+Mm8cHnAbr83a4HjE=PuyH2CVV9soZVg@mail.gmail.com>
Subject: Re: [v2, 0/2] Fix broken SET/CLR mode of a certain number of pins for
 MediaTek MT8385 SoC
To:     Kevin Hilman <khilman@kernel.org>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 5:40 PM Kevin Hilman <khilman@kernel.org> wrote:
>
> Hi Balsam,
>
>
> bchihi@baylibre.com writes:
>
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > On MT8365, the SET/CLR of the mode is broken and some pins won't set or clear the modes correctly.
> > To fix this issue, we add a specific callback mt8365_set_clr_mode() for this specific SoC.
> > This callback uses the main R/W register to read/update/write the modes instead of using the SET/CLR register.
> >
> > This is the original patch series proposed by Fabien Parent <fparent@baylibre.com>.
> > "https://lore.kernel.org/linux-arm-kernel/20220530123425.689459-1-fparent@baylibre.com/"
> >
> > Changelog:
> > Changes in v2 :
> >         - Rebase on top of 6.1.0-rc1-next-20221020
> >         - Delete MTK_PINCTRL_MODE_SET_CLR_BROKEN quirk
> >         - Add mt8365_set_clr_mode() callback
>
> nit: subject of cover letter should also include "pinctrl: mediatek:"
> prefix.  Also note that you're missing the word "PATCH" in all of the
> subjects.
>
> Tip: If you use `git format-patch`, you can just pass `-v2` on the
> cmdline and it will create the prefixes for you automatically.
>

Hi Kevin,

Well received.
I will fix these issues in the next version/resend.
Thank you so much for the review!

Balsam.

> Kevin
