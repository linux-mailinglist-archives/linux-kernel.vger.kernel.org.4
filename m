Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442DA72F2D4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242277AbjFNCwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242165AbjFNCv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958D92690;
        Tue, 13 Jun 2023 19:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 099A962F37;
        Wed, 14 Jun 2023 02:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0878AC433C0;
        Wed, 14 Jun 2023 02:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686711097;
        bh=N3q6ixAinHSWilzVMCv++DW3xSimSHnyP2PRlOaULYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aHS8GGlVpVMza8fUd10dHWgjcsEcnhYF6mtda1PEif73/gG8DJjgjRD496BZG2+IQ
         yZb0yLikA3pccFbH6043Pq5QZcqOroZdRH/n0aPMe6tt6rd6svMoQlkxrdOQGMmm5p
         gPTCRZNFuEphlrZWYkI0t495rTPGdcZJ6IzKlD2J5Zsf62F+leEV0MUgVETVEw0vup
         sMwdFgG4EQYtmZ9JqLK5OUrSJZXnIspVyWrfW0tKAsYBWwuyMLC6UVSY84A9XKx8KM
         hmEOCqZIbZ55Y5QXW5euBztlUDZTHbx6k9Q1KnD2gow6ubRUlJEXvAxIGp7m80p1TK
         vqIb4LmfdSHew==
Date:   Tue, 13 Jun 2023 19:51:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@kernel.org>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
Subject: Re: Closing down the wireless trees for a summer break?
Message-ID: <20230613195136.6815df9b@kernel.org>
In-Reply-To: <ba933d6e3d360298e400196371e37735aef3b1eb.camel@sipsolutions.net>
References: <87y1kncuh4.fsf@kernel.org>
        <871qifxm9b.fsf@toke.dk>
        <20230613112834.7df36e95@kernel.org>
        <ba933d6e3d360298e400196371e37735aef3b1eb.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023 22:00:35 +0200 Johannes Berg wrote:
> On Tue, 2023-06-13 at 11:28 -0700, Jakub Kicinski wrote:
> > On Tue, 13 Jun 2023 20:14:40 +0200 Toke H=C3=B8iland-J=C3=B8rgensen wro=
te: =20
> > > I think this sounds reasonable, and I applaud the effort to take some
> > > time off during the summer :)
> > >=20
> > > One question that comes to mind is how would this work for patchwork?
> > > Would we keep using the wireless patchwork instance for the patches
> > > going to -net in that period, or will there be some other process for
> > > this? I realise the setup we have for ath9k is a bit special in this
> > > regard with the ack-on-list+delegation, so I'm obviously mostly
> > > interested in what to do about that... :) =20
> >=20
> > Whatever's easiest :) It's probably a good idea for Kalle to write
> > down all the local rules and customs and share those with us.
>=20
> While that's probably a good idea regardless, I'd think that patchwork
> doesn't really matter that much - we'll have some catching up to do
> anyway after the vacations, so looking through patchwork etc. would be
> perfectly acceptable. Worst case we'd notice when a patch doesn't apply,
> right? :)

Right, I meant it more in terms of patch flow. Is looking at which
drivers have a tree specified in MAINTAINERS enough to know what
should be applied directly?

> Wrt. ath9k patches I guess "delegate in patchwork" won't work anymore,
> but "resend to netdev" or something perhaps?

We can watch PW state and apply from linux-wireless, I reckon.
That said I don't know how you use delegation :)
