Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DABFC6C03B1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 19:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjCSSFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 14:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCSSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 14:05:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A121352B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 11:05:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 749CCB80B47
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 18:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FFEC433EF;
        Sun, 19 Mar 2023 18:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679249116;
        bh=PeFqLP+biZrkpnE1Qe8JXbY5jUnij+eEGjz8aLdF/J4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YBDBlyU5L7qwIR3OJeB3v7yK1CsJO+pi4yVtAJ0lzOciPHz1M2ZGBOV8xlIQenQ8v
         7kqXFKpqJJmL/7DHHgRD26rm7foMDL5sEijAc72W25WLdHREzSrwrfEm3Vj+N2Az6t
         ++lFqMNchHe9P8ttmdqWzOoc++hVLrSLUJ/ifQGsUcQgMvHAw7eI0K1BejCwIeiNUZ
         V2C7UEsNmO9OztIB9m9Geu63xZLY0tT/CLgaGiyhedkYcKNzlXYgiAVsVAZ1FxQwaV
         H+tddkcAChlUYuH4EH/phENYqzBkJ05CivcAGWwjVU/bxk4VAqUBorAhipiemB6fSU
         VGIu8GxlWMHZg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BA9EB1540381; Sun, 19 Mar 2023 11:05:15 -0700 (PDT)
Date:   Sun, 19 Mar 2023 11:05:15 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     linux@weissschuh.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] tools/nolibc: always disable stack protector for
 tests
Message-ID: <5c2fdd86-4e6a-4f48-ab57-95a223f39e94@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230319135100.31952-1-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230319135100.31952-1-w@1wt.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 02:50:59PM +0100, Willy Tarreau wrote:
> Hello Paul,
> 
> Thomas noticed that nolibc-test fails to build on compilers that enable
> stack protectors by default. Passing -fno-stack-protector when supported
> addresses the problem.
> 
> I verified that all supported archs continue to work after his patch is
> applied, and that it applies without conflict (and works) both on top of
> your latest dev tree and on top of Linus' master branch. Thus I think it
> can make sense to queue it with your next series of fixes and have it for
> 6.3 given that it addresses build issues for some developers.

Queued and pushed, thank you both!

Just to make sure I understand, you would like me to add this to the
serieses from Vincent, yourself, and Feiyang that are set up to go into
the next merge window, correct?

If you instead would like me to push it to Linus directly into the v6.3
release as a regression fix late this coming week, please let me know.

							Thanx, Paul

> Thanks!
> Willy
> ---
> Thomas Weißschuh (1):
>   tools/nolibc: always disable stack protector for tests
> 
>  tools/testing/selftests/nolibc/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
> 
> -- 
> 2.17.5
> 
