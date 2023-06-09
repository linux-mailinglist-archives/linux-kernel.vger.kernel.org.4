Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9F4729313
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbjFII1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241416AbjFIIZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:25:52 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53A8D3C14;
        Fri,  9 Jun 2023 01:24:52 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q7XQE-0004Jv-08; Fri, 09 Jun 2023 10:24:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id BF6ADC02EE; Fri,  9 Jun 2023 10:23:14 +0200 (CEST)
Date:   Fri, 9 Jun 2023 10:23:14 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Paul Burton <paulburton@kernel.org>,
        Siarhei Volkau <lis8215@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net
Subject: Re: [PATCH 3/4] mips: ingenic: Enable EXT/2 divider on JZ4750/55/60
 if EXT is 24 MHz
Message-ID: <20230609082314.GI8160@alpha.franken.de>
References: <20230604122655.69698-1-paul@crapouillou.net>
 <20230604122655.69698-3-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604122655.69698-3-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 02:26:54PM +0200, Paul Cercueil wrote:
> The JZ4750, JZ4755 and JZ4760 (non-B version) support using a 24 MHz
> external crystal oscillator instead of the typical 12 MHz one.
> 
> However, most of the SoC's IP blocks only work with a 12 MHz clock.
> Thanksfully, there is a /2 divider we can enable when a 24 MHz external
> crystal is present.
> 
> Force-enable this /2 divider when the oscillator is 24 MHz, so that the
> SoC always uses a 12 MHz clock internally.
> 
> It is done here, and not in the clocks driver, because we need the EXT
> clock to be 12 MHz for the early console to work, and the clocks driver
> probes way too late.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  arch/mips/generic/board-ingenic.c | 57 +++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
