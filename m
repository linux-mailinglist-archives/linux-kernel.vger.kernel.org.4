Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA4D6B9B64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjCNQ1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbjCNQ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:27:09 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1EF862854;
        Tue, 14 Mar 2023 09:26:57 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pc7UG-00048S-03; Tue, 14 Mar 2023 17:26:56 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 97AB7C131B; Tue, 14 Mar 2023 17:21:18 +0100 (CET)
Date:   Tue, 14 Mar 2023 17:21:18 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     linux-mips@vger.kernel.org, john@phrozen.org,
        linux-kernel@vger.kernel.org, git@johnthomson.fastmail.com.au
Subject: Re: [PATCH 00/12] mips: ralink: introduce 'soc_device' initialization
Message-ID: <20230314162118.GD18446@alpha.franken.de>
References: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230227105806.2394101-1-sergio.paracuellos@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 11:57:54AM +0100, Sergio Paracuellos wrote:
> This series align old SoCs ralink code with current mt7621 code refactoring
> SoC related information into more readable functions as well as introducing
> 'soc_device' for all of them. This allows to be able to distinc SoC info
> from driver code without using architecture dependent includes. 
> 
> I am also planning to extract from ralink code current clock related stuff 
> into proper clk drivers at some time and be able to distinc SoC in this way
> let me to mark future drivers to be easily marked for COMPILE_TEST target.
> 
> Changes have been compile tested for:
> - RT2880
> - RT3883
> - MT7620
> 
> Changes have been properly tested in RT5350 SoC based board (ALL5003 board)
> resulting in a working platform.
> 
> Thanks in advance for your time.
> 
> Best regards,
>     Sergio Paracuellos
> 
> Sergio Paracuellos (12):
>   mips: ralink: rt305x: define RT305X_SYSC_BASE with __iomem
>   mips: ralink: rt305x: soc queries and tests as functions
>   mips: ralink: rt305x: introduce 'soc_device' initialization
>   mips: ralink: rt3883: define RT3883_SYSC_BASE with __iomem
>   mips: ralink: rt3883: soc queries and tests as functions
>   mips: ralink: rt3883: introduce 'soc_device' initialization
>   mips: ralink: rt288x: define RT2880_SYSC_BASE with __iomem
>   mips: ralink: rt288x: soc queries and tests as functions
>   mips: ralink: rt288x: introduce 'soc_device' initialization
>   mips: ralink: mt7620: define MT7620_SYSC_BASE with __iomem
>   mips: ralink: mt7620: soc queries and tests as functions
>   mips: ralink: mt7620: introduce 'soc_device' initialization
> 
>  arch/mips/include/asm/mach-ralink/mt7620.h |   3 +-
>  arch/mips/include/asm/mach-ralink/rt288x.h |   3 +-
>  arch/mips/include/asm/mach-ralink/rt305x.h |   3 +-
>  arch/mips/include/asm/mach-ralink/rt3883.h |   4 +-
>  arch/mips/ralink/Kconfig                   |   4 +
>  arch/mips/ralink/mt7620.c                  | 145 ++++++++++++++++----
>  arch/mips/ralink/rt288x.c                  |  94 ++++++++++---
>  arch/mips/ralink/rt305x.c                  | 147 +++++++++++++++++----
>  arch/mips/ralink/rt3883.c                  |  94 ++++++++++---
>  9 files changed, 410 insertions(+), 87 deletions(-)
> 
> -- 
> 2.25.1

series applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
