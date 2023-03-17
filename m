Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C696BE6A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCQKZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjCQKZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:25:49 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 59B3DE4C67;
        Fri, 17 Mar 2023 03:25:47 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pd7HN-0002Ik-00; Fri, 17 Mar 2023 11:25:45 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 85E9CC1AFC; Fri, 17 Mar 2023 11:22:32 +0100 (CET)
Date:   Fri, 17 Mar 2023 11:22:32 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath79: remove obsolete ATH79_DEV_* configs
Message-ID: <20230317102232.GA7054@alpha.franken.de>
References: <20230316114952.26253-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316114952.26253-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 12:49:52PM +0100, Lukas Bulwahn wrote:
> Commit 85b9686dae30 ("MIPS: ath79: drop platform device registration code")
> removes all files arch/mips/ath79/dev-*.[ch], adjusts the Makefile, but
> misses to adjust the Kconfig file. Hence, since then, the configs
> ATH79_DEV_* are really dead.
> 
> Commit 3a77e0d75eed ("MIPS: ath79: drop machfiles") already removes all
> configs that select ATH79_DEV_* config. So at that point, they was not a
> way to enable them with a kernel build configuration.
> 
> Remove these obsolete ATH79_DEV_* configs.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/ath79/Kconfig | 16 ----------------
>  1 file changed, 16 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
