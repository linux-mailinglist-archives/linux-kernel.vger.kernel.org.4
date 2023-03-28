Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458236CB60E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjC1F2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjC1F2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:28:02 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080D71BC0;
        Mon, 27 Mar 2023 22:28:01 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id B401C3200931;
        Tue, 28 Mar 2023 01:27:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 28 Mar 2023 01:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679981278; x=1680067678; bh=RO
        u11UKD4YShKQV4V0qAyCPu1Enmp2EQm/tBMlKx01w=; b=NGoiH/5CFTUfOnl6NR
        qqnbNvBAsHVrL7pQYT5MXTULeeubAavlkhScSdAcNl3r6clTQJCTpB4BJTyZW8wC
        8Z/ygPmh/SIAdpFa/P35QyixHoBQmzVXDNgPGj/1F6QkPnMsZzNKH+ZSD/pRsXc5
        FgyRl2Z3bcPLGsj295FQh4uPKyA2KeGAVwOkGciJIjthINHV4YqecMEQ8T1MD99W
        mqGZ9ZvuCpl9PeM4kFLsCnNfv28tZfBKdcv3tv6x9yGVMKsLfHWdWEFhQXTwOoek
        9iyW41KMek7Y3bLao81S2+rXRr6Lw08R/kcuhs4HSW1B8yq8T00KlLL8HN6qjFXP
        nM4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679981278; x=1680067678; bh=ROu11UKD4YShK
        QV4V0qAyCPu1Enmp2EQm/tBMlKx01w=; b=NIZgQgxfx/H0QHMdMAPRzthK4IQLN
        oUhXiCpybakwGk3mXeQqMsF+dE1orsvXT0l81eKHjghAgNZbD/O3AxLWT9dLBb4B
        11+lLIc0GubnRG/ugkkaaZbJFoBhgO2HoAp4ae7zeOlY36P9cicqVw4fJ4RhUWUt
        13a4v2J08DBLECPPn2La9y02ZjTjy9Oi5jWi61tTNqyjm0tTp/qKfW/UTMjR5oLV
        mQ9aN5nlJch4Jr8oE5Jwmg6lqRarROc58na+g/p5J5bTvCxYU4MTL9w1dXvj/F4D
        5VWi4LBkbt10/eJN+kcuWcA9w8IrrapMc5dTZNJI5b3cUzY3xZlnJgMzg==
X-ME-Sender: <xms:3XoiZBVaFPc5ODsq80nZFClztW2zi1z1hRbv4g4AHUkXSU0zzXwPDA>
    <xme:3XoiZBlV6wUXLdZpfMaDJiv2BNpQoaL0uiJxNOxpX8ETxzMVeMZQ1NzvPhFO_qFlZ
    jF-cecC8jyFIg>
X-ME-Received: <xmr:3XoiZNYJFAy8rGt4SxqRkIwTQ_ryJvLixemlsSQ0OT6SXqbt-U9fDvCe_PAh8WXdAFBDM5wQ0aUoGtqrKAcq8-uQEDxfhTHGLckVUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehfedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:3XoiZEXgiQ-hsSW004-_KV4sT3uKrWDClc5SKDszaoL6058qsTFx7A>
    <xmx:3XoiZLk_Ek9ZyFkPoNxOg0uVfVGKgZpjCCVlc66yO0688s-Mfjm7Dw>
    <xmx:3XoiZBf0d724vWNOiJWL3yeBAWhMPSHGS4gnxVMhBWcMCcmNU9JOzg>
    <xmx:3noiZN4T0SVFpXnXasKL1tL4RUAVFKlWdNHiWe8QJc6ZRI6BRkzGQw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Mar 2023 01:27:57 -0400 (EDT)
Date:   Tue, 28 Mar 2023 07:27:54 +0200
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Shawn Guo <shawnguo@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the usb tree
Message-ID: <ZCJ62nDO3PocFPeP@kroah.com>
References: <20230328131110.6049c4ce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328131110.6049c4ce@canb.auug.org.au>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:11:10PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the imx-mxs tree as a different commit
> (but the same patch):
> 
>   fcd3f50845be ("arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb")
> 
> This is commit
> 
>   989e2ee399cd ("arm64: dts: imx8mq: drop usb3-resume-missing-cas from usb")
> 
> in the imx-mxs tree.

Thanks, I can revert this in the imx-mxs tree, but it should be fine
when Linus merges so I doubt that is needed.

thanks,

greg k-h
