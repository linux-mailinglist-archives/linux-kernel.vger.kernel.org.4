Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A990F738647
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 16:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjFUOJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 10:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjFUOIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 10:08:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6139218C;
        Wed, 21 Jun 2023 07:08:52 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qByVq-0004Ap-00; Wed, 21 Jun 2023 16:08:46 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id F1A4EC0346; Wed, 21 Jun 2023 16:08:22 +0200 (CEST)
Date:   Wed, 21 Jun 2023 16:08:22 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Shiji Yang <yangshiji66@outlook.com>
Cc:     linux-mips@vger.kernel.org, john@phrozen.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mips: ralink: introduce commonly used remap node function
Message-ID: <20230621140822.GC7206@alpha.franken.de>
References: <OSYP286MB03120BABB25900E113ED42B7BC5CA@OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OSYP286MB03120BABB25900E113ED42B7BC5CA@OSYP286MB0312.JPNP286.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:44:32PM +0800, Shiji Yang wrote:
> The ralink_of_remap() function is repeated several times on SoC specific
> source files. They have the same structure, but just differ in compatible
> strings. In order to make commonly use of these codes, this patch
> introduces a newly designed mtmips_of_remap_node() function to match and
> remap all supported system controller and memory controller nodes.
> 
> Build and run tested on MT7620 and MT7628.
> 
> Signed-off-by: Shiji Yang <yangshiji66@outlook.com>
> ---
>  arch/mips/ralink/common.h |  2 --
>  arch/mips/ralink/mt7620.c |  9 ---------
>  arch/mips/ralink/mt7621.c |  9 ---------
>  arch/mips/ralink/of.c     | 42 ++++++++++++++++++++++++++++++++-------
>  arch/mips/ralink/rt288x.c |  9 ---------
>  arch/mips/ralink/rt305x.c |  9 ---------
>  arch/mips/ralink/rt3883.c |  9 ---------
>  7 files changed, 35 insertions(+), 54 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
