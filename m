Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF89370C38D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjEVQfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjEVQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A43CF;
        Mon, 22 May 2023 09:35:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4EDA61EAB;
        Mon, 22 May 2023 16:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80579C433EF;
        Mon, 22 May 2023 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684773342;
        bh=Mfqycb99KKOtWcsvOSNVQnX/iL5IooyCsD0WOoMPhnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mHWexFxDhwjtYlvMalofMjG4xtj0oI04Ewm5kSATYYq/TS8D4Xz1spiBtUa6N7GrI
         BoVFCguCwfzuV89nb0uFLHyV1xb3KNaMqdo3xDNO5WRb0N6VQ33z1UO5kC4gih0qNe
         o98pPgsZTnJfX9iKG1W+1mmdWvzkqO+W8ggT5RV2Fqw6T2DgIArkXnptAH2xEDWjtf
         WgtEdIp3pMZn69FOqSANIlEkz/C6LDRcZAhlEmay5YH6BajnqUBUkj/Q4VU/EGygPR
         VkUeNCnulBcpGoD6amgY2/4huHU/34Y0Vrx1u0XKd94l3giQCFE3l3CfBmIdCQZdUI
         aMMNIEWt/k8Gw==
Date:   Mon, 22 May 2023 17:35:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@sberdevices.ru
Subject: Re: [PATCH v4 2/2] leds: add aw20xx driver
Message-ID: <20230522163537.GR404509@google.com>
References: <20230517195238.34069-1-mmkurbanov@sberdevices.ru>
 <20230517195238.34069-3-mmkurbanov@sberdevices.ru>
 <CAHp75VdEc9x=v-NU4wqrg-S0vEjqc27JPqZAK0TJsNUc37ZTmg@mail.gmail.com>
 <20230522071426.GP404509@google.com>
 <CAHp75VdG6nSHgzmp9yA2aAwvzWuaYf2Q71tz2ruDPnwb=h=hiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VdG6nSHgzmp9yA2aAwvzWuaYf2Q71tz2ruDPnwb=h=hiQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023, Andy Shevchenko wrote:

> On Mon, May 22, 2023 at 10:14 AM Lee Jones <lee@kernel.org> wrote:
> > On Thu, 18 May 2023, Andy Shevchenko wrote:
> > > On Wed, May 17, 2023 at 10:52 PM Martin Kurbanov
> > > <mmkurbanov@sberdevices.ru> wrote:
> 
> ...
> 
> > > I would do
> > >
> > >   i = 0;
> > >
> > > here and drop the assignment in the definition block to be more robust
> >
> > "here" where?
> 
> > You've removed all context.
> 
> That's not true. The below line exclusively defines the location in
> the code that I'm talking about. Note, Martin understood that AFAICT
> and addressed in the new version.

I'd expect the author to have a solid understanding of the code.  I
found this difficult to read as-was and had to go look at the patch to
understand it.

No biggy.  Just something to bear in mind.

> > > against sudden reuse of i in between.
> > >
> > > > +       device_for_each_child_node(dev, child) {
> > >
> > > > +               i++;
> > > > +       }
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenk

-- 
Lee Jones [李琼斯]
