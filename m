Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1027F69B569
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBQWUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:20:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjBQWUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:20:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFE86664F;
        Fri, 17 Feb 2023 14:20:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r11so2423598wru.1;
        Fri, 17 Feb 2023 14:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1i9LuC5d4vZMEjYcLaTDdxYBMP8JELhgLW32Lccsw8U=;
        b=dE3LmgLpmjeY+DmAATb3i1XnQ1jyDGNp4fRaFnX2YVVZFjjNdGsEDtmGrxMtfVM7a1
         +8W1YzKvMdQUMaYYW7ZGhQUGrePfoOTVnajA7C8s4i5ZkbewOE0qXQz/0ZMXh+avqepZ
         IN7tU/4rTisczW5751ZNVVsgVnK06QP9fmPqiuOuDiNHgtVq/aXNzi8hkyGjXSr9UykV
         g6R1XE0q2l7aGhd8TJMSbGKefUDCI/IeubTdmsxDqUdfvYS4rwUEgbYyPXvLEGvosUp0
         wESXlRQDOX2gDy2g1kcSzwRAGZ5I+wDffIDDKfRZQ0OuFKBJFgvgPalMN+A8PX4W2y/g
         /wNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1i9LuC5d4vZMEjYcLaTDdxYBMP8JELhgLW32Lccsw8U=;
        b=0w/rp8JqjkONQh8LJTmM24mDOT1rEqH4Uuj3KdJG/nUMhmxG6hgWs2l0HpYYiLsNQI
         5bf5cCUR1vkAxbOTCizMLfWNIE4bTEMK+c3xp7WLzn59KCh1Qq+8JS+UKXvxvk4BFAn1
         l/Zo7xXnwwPiwIWzQ9MEM0QEt6yXrZ5wbvLLyqvI6pn8iKqp139NYR2gw45SGUqZCXQa
         B+NzuUY7o6YiPYFOeJCVh0NVIuUfh9BaOzXD+GOWwtVWcVOtmu3BVklXpHK5KUfOvedj
         nxljmwZhZgXZ2++8BspWs8sYxbO/0Y+VfYkIvWiiUPJAWHiIH4frR02Osys018+dYZGB
         7yvw==
X-Gm-Message-State: AO0yUKVWeD042jWc6ERGwC/ti+U5AzyhK+xvn1IcnkQznG4g7R4Ynv8X
        Lk2BjOGk0vb272JUMJeo6gc=
X-Google-Smtp-Source: AK7set+uHhngYpSmVrvC/pgYx28HXmftNTpLC75+bTJkM9v8lzwviIbSj4gtCTGaM4J8T/kkosKgsA==
X-Received: by 2002:a5d:48d0:0:b0:2c4:503:7afc with SMTP id p16-20020a5d48d0000000b002c405037afcmr1104857wrs.7.1676672429782;
        Fri, 17 Feb 2023 14:20:29 -0800 (PST)
Received: from Ansuel-xps. (93-34-91-73.ip49.fastwebnet.it. [93.34.91.73])
        by smtp.gmail.com with ESMTPSA id j28-20020a5d453c000000b002c6eaf53bcdsm1141798wra.28.2023.02.17.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 14:20:29 -0800 (PST)
Message-ID: <63effdad.5d0a0220.28f2a.4738@mx.google.com>
X-Google-Original-Message-ID: <Y+8MEMI/BLy46EmQ@Ansuel-xps.>
Date:   Fri, 17 Feb 2023 06:09:36 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Russell King <linux@armlinux.org.uk>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] clk: Fix wrong clock returned in parent_data with .name
 and no .index
References: <20230215232712.17072-1-ansuelsmth@gmail.com>
 <6dcb55104d5065d30a9dab4bca878922.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dcb55104d5065d30a9dab4bca878922.sboyd@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_12_24,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:11:20PM -0800, Stephen Boyd wrote:
> Quoting Christian Marangi (2023-02-15 15:27:12)
> > Commit 601b6e93304a ("clk: Allow parents to be specified via clkspec index")
> > introduced a regression due to a "fragile" implementation present in some very
> > corner case.
> > 
> > Such commit introduced the support for parents to be specified using
> > clkspec index. The index is an int and should be -1 if the feature
> > should not be used. This is the case with parent_hws or legacy
> > parent_names used and the index value is set to -1 by default.
> > With parent_data the situation is different, since it's a struct that
> > can have multiple value (.index, .name, .fw_name), it's init to all 0 by
> > default. This cause the index value to be set to 0 everytime even if not
> 
> It's only initialized to all 0 because that's what you've decided to do.
> It could be on the stack and have random stack junk values.
>

Yes and that itself is problematic on his own. The index value may be
set to an unintended value and we really can't update each parent_data
to -1. And as you can see in the example index is used as an alternative
source to search the parent.

Hope it's clear what is the problem here.

> > intended to be defined and used.
> > 
> > This simple "fragile" implementation cause side-effect and unintended
> > behaviour.
> > 
> > Assuming the following scenario (to repro the corner case and doesn't
> > reflect real code):
> > 
> > In dt we have a node like this:
> >                 acc1: clock-controller@2098000 {
> >                         compatible = "qcom,kpss-acc-v1";
> >                         reg = <0x02098000 0x1000>, <0x02008000 0x1000>;
> >                         clock-output-names = "acpu1_aux";
> >                         clocks = <&pxo_board>;
> >                         clock-names = "pxo";
> >                         #clock-cells = <0>;
> >                 };
> > 
> > And on the relevant driver we have the parent data defined as such:
> >                 static const struct clk_parent_data aux_parents[] = {
> >                         { .name = "pll8_vote" },
> >                         { .fw_name = "pxo", .name = "pxo_board" },
> >                 };
> > 
> > Someone would expect the first parent to be globally searched and set to
> > point to the clock named "pll8_vote".
> > But this is not the case and instead under the hood, the parent point to
> > the pxo clock. This happen without any warning and was discovered on
> > another platform while the gcc driver was converted to parent_data and
> > only .name was defined.
> 
> You didn't set .index explicitly to zero, but it is zero because of the
> use of static struct initializers here. If the struct was on the stack
> nobody knows what the value would be. Set -1 if you don't want to use
> the index lookup path.

There is at least one driver that use .name for global searching and
it's clear that he didn't intend to use index lookup.

Are you totally against this or you are suggesting I should use a
different word for this?

To me this looks very sensible and something we should take care since
sounds a bit fragile to me. (I know 99% of the time it would be a dev
error but we could have case where things works by luck and for example
someone starts adding an additional parent in later changes and regression
happens.)

-- 
	Ansuel
