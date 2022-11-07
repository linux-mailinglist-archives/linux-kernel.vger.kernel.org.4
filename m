Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C3B61EA42
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 05:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiKGEvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 23:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiKGEvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 23:51:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A75E5F7B;
        Sun,  6 Nov 2022 20:51:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC33960EC4;
        Mon,  7 Nov 2022 04:51:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D9DC433D6;
        Mon,  7 Nov 2022 04:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667796701;
        bh=x1ar0oW6kUam3xH8IpOfjT09cYROhu1iQnuFPwJp7Aw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wi3gfsP2fC9+SZ/CWsQZFsygVKMwPGydRaELXh5RxFbMniJ9d1LGtmjd6eOHOMHRw
         /Z15UudO3Dy0gA/bQmjHu+VBX/Jvm/9ovICYB707OXl+Ij2n0rh3A3yY2qXPfOAF/q
         0ovnGJZQ7+AT5oKSwwUUKWbBJP/halmYoKUDOKaUKRplhnTRZ3p9ABLq0GuvJ9gox/
         Xt6o6lri1H3NdWHTF4jt4gUauTvUzaGRSOFYCMft2ZodtyzhfIf5iR8BMTr2CU7ikb
         rUj4wPVLRs96fz43OlgIY3r+h5E6tJA0Kg9QbdIQ5lCVyHc3ZRvMG8ebRUR0TwpjqR
         W7Itns6ObcCLA==
Date:   Mon, 7 Nov 2022 10:21:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Justin Chen <justinpopo6@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the phy-next tree
Message-ID: <Y2iO2XbUPmewsrfH@matsya>
References: <20221107081159.7ba208fd@canb.auug.org.au>
 <CAJx26kX_fb6RMyVWQO7TntVTn9i3z2SzR0uXjUf4_zQczsmEeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJx26kX_fb6RMyVWQO7TntVTn9i3z2SzR0uXjUf4_zQczsmEeQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-11-22, 17:10, Justin Chen wrote:
> On Sun, Nov 6, 2022 at 1:12 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > In commits
> >
> >   5b679072af07 ("phy: usb: Fix clock imbalance for suspend/resume")
> >   219ec4e8f7b2 ("phy: usb: Use slow clock for wake enabled suspend")
> >
> > Fixes tag
> >
> >   Fixes: ae532b2b7aa5 ("usb: Add "wake on" functionality for newer Synopsis XHCI controllers")
> >
> > has these problem(s):
> >
> >   - Subject does not match target commit subject

Fixed now

> >     Just use
> >         git log -1 --format='Fixes: %h ("%s")'
> >
> Apologies, I missed the "phy:" in the beginning. Should be this.
> Fixes: ae532b2b7aa5 ("phy: usb: Add "wake on" functionality for newer
> Synopsis XHCI controllers")

Use the script above to generate this and not manually
> 
> How should I fix this? Can this be fixed in place?

I have fixed it up

-- 
~Vinod
