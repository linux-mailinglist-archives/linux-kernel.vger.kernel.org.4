Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69765BCFA9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiISOv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiISOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:51:08 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E348E32EE4;
        Mon, 19 Sep 2022 07:51:07 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oaI6u-0005ft-01; Mon, 19 Sep 2022 16:51:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 23F18C12F2; Mon, 19 Sep 2022 16:47:47 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:47:47 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Kelvin Cheung <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Subject: Re: [PATCH v2] MIPS: Loongson32: Fix PHY-mode being left unspecified
Message-ID: <20220919144747.GA7674@alpha.franken.de>
References: <20220911161009.34453-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220911161009.34453-1-keguang.zhang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:10:09AM +0800, Kelvin Cheung wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> commit 0060c8783330 ("net: stmmac: implement support for passive mode
> converters via dt") has changed the plat->interface field semantics from
> containing the PHY-mode to specifying the MAC-PCS interface mode. Due to
> that the loongson32 platform code will leave the phylink interface
> uninitialized with the PHY-mode intended by the means of the actual
> platform setup. The commit-author most likely has just missed the
> arch-specific code to fix. Let's mend the Loongson32 platform code then by
> assigning the PHY-mode to the phy_interface field of the STMMAC platform
> data.
> 
> Fixes: 0060c8783330 ("net: stmmac: implement support for passive mode converters via dt")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> Tested-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V1 -> V2: Add my SoB tag
> ---
>  arch/mips/loongson32/common/platform.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
