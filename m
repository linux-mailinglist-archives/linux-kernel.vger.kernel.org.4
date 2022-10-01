Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D275F1DA9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiJAQgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 12:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJAQf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 12:35:58 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CFCD83386E;
        Sat,  1 Oct 2022 09:35:56 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oefT0-0003Pr-01; Sat, 01 Oct 2022 18:35:54 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id AAFEAC0D20; Sat,  1 Oct 2022 18:09:10 +0200 (CEST)
Date:   Sat, 1 Oct 2022 18:09:10 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: allow firmware to pass RNG seed to kernel
Message-ID: <20221001160910.GB13443@alpha.franken.de>
References: <20220930140138.575751-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220930140138.575751-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:01:38PM +0200, Jason A. Donenfeld wrote:
> Nearly all other firmware environments have some way of passing a RNG
> seed to initialize the RNG: DTB's rng-seed, EFI's RNG protocol, m68k's
> bootinfo block, x86's setup_data, and so forth. This adds something
> similar for MIPS, which will allow various firmware environments,
> bootloaders, and hypervisors to pass an RNG seed to initialize the
> kernel's RNG.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/mips/kernel/setup.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
