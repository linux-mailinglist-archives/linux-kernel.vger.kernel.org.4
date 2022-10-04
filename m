Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55695F3F26
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJDJGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJDJGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:06:43 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5B2CC9E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 02:06:42 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id z97so17926100ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 02:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kawNVgdgBSHd0eDZf0GEPhYoTAGM50TKmYEVuPpOvXw=;
        b=pFedhuEmDarcm6UGf1nBESSgNy2qes/pdzkxnRts4t/i1EH1gAok0LH2QLL/qU/GKu
         trrF6s+eKOaIBra71g1cYXySDOyofwuKEEWQZEH2VvbSko7NjTXd7EC98pgReJj1NbI+
         dUpGl6yUgOVkD4G7mgWoPWRfyms0024ab8aWNcMppTlHWPyQvfwKY56jEXu1xTZyFkxI
         2tKi3yzs/r/P1LA/ushJ6x4/RA95O5Y7lKm+ouVTil4/LPK5h0nNJew0IZ87DOUYX2/I
         qn88+BxBx7btTe9Z/EB3u1OvZ41VxUZ2ntGHBsrQTmqJV3EjHjLPz1g1Q/mmKlWUlRmS
         rhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kawNVgdgBSHd0eDZf0GEPhYoTAGM50TKmYEVuPpOvXw=;
        b=jX8duKbzLrbWffnDctrnqeAYDDPS+JG1L6WbI9/h84btblM7wzabQsUSi/BDkSOiLs
         I+XqFTBLGEa5zOTfWSC3voy4cFz/KVg2iVG/iSPrOs6tI0OL1F1qmYM3jee/yvGIMxt+
         E0zaFj+asaOFnz8siqS54SNduXe4XtFm7f7TO+g3QWXRAv2lGSb4pYfF8v8aKTi6VfF4
         P6Ll5JeVAgYmFKypnSMLtbOBnOM4GCWUOsONIQ3vyr+Jgan7gyeilitwkpD8wnDL+blp
         7rvCWhGXjijTQfl/YUGRM1lsQjCCbzwN9Z1C7A1NtmbEpklYc+sui9+Qv+b9jF7/B+WE
         6VyQ==
X-Gm-Message-State: ACrzQf2YJlcFA/bz18rIsqXylrF5t9YKjxLQewZJDKPr4kuQTHEfzRxx
        eaF5Llwh0VfDE8o0Bq9LMWp8SN8ICu9DNlslu2RODg==
X-Google-Smtp-Source: AMsMyM4qfRDS9+wB85yEFq1mRkcFYkp7s9iue5GZNv/IIDTMC8BldHJka0t3IyYpPD4jVjJEviC57nGGcJxzTWyKpwU=
X-Received: by 2002:a05:6402:d0b:b0:458:a244:4e99 with SMTP id
 eb11-20020a0564020d0b00b00458a2444e99mr14584879edb.46.1664874400818; Tue, 04
 Oct 2022 02:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220920103108.23074-1-jay.xu@rock-chips.com> <20220920103108.23074-12-jay.xu@rock-chips.com>
 <CACRpkdZSCamhBD-M8CkZt6B3N9c2Jo_D3kwgOykj8+VJ_otYGQ@mail.gmail.com> <YzvvGValqxfIriGL@smile.fi.intel.com>
In-Reply-To: <YzvvGValqxfIriGL@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Oct 2022 11:06:29 +0200
Message-ID: <CACRpkdbA_h4m0cY98=0C2fCbTYEtowFRm9RF=tv=XSgjKxjcAQ@mail.gmail.com>
Subject: Re: [PATCH 11/20] gpio/rockchip: add of_node for gpiochip
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>, heiko@sntech.de, brgl@bgdev.pl,
        robert.moore@intel.com, robh@kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        lenb@kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 10:30 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Oct 04, 2022 at 09:14:38AM +0200, Linus Walleij wrote:
> > On Tue, Sep 20, 2022 at 12:31 PM Jianqun Xu <jay.xu@rock-chips.com> wrote:
> > > The Rockchip GPIO driver will probe before pinctrl and has no parent dt
> > > node, lack of the of_node will cause the driver probe failure.
> > >
> > > Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> >
> > > +#ifdef CONFIG_OF_GPIO
> > > +       gc->of_node = of_node_get(bank->dev->of_node);
> > > +#endif
> >
> > Any introduction of of_node_get() needs to be balanced with a
> > corresponding of_node_put().
>
> No, this code should not have been existed in the first place. We don't allow
> anymore any of of_node usage in the GPIO drivers. There is an fwnode and parent
> and logic to retrieve fwnode from parent in the GPIO library for the most of
> the cases.

Hm yeah given that the series want to introduce ACPI as well it makes
a lot of sense.

Yours,
Linus Walleij
