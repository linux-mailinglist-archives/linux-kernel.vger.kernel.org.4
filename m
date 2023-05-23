Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A5B70D897
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbjEWJNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236090AbjEWJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:13:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50E3012B;
        Tue, 23 May 2023 02:13:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q1O5L-0007MY-01; Tue, 23 May 2023 11:13:39 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 83A17C02E6; Tue, 23 May 2023 11:09:13 +0200 (CEST)
Date:   Tue, 23 May 2023 11:09:13 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: Loongson32: Remove reset.c
Message-ID: <20230523090913.GF9484@alpha.franken.de>
References: <20230511120648.463221-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511120648.463221-1-keguang.zhang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 08:06:48PM +0800, Keguang Zhang wrote:
> Commit 2a31bf20808a ("watchdog: loongson1_wdt: Implement restart handler")
> implmented .restart ops, Then, _machine_restart is no longer needed.
> The _machine_halt and pm_power_off are also unnecessary,
> which contain no hardware operations.
> 
> Therefore, remove the entire reset.c and related header file.
> Update the Makefile accordingly.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V2 -> V3: Update the commit message
> V1 -> V2: Remove the reference to regs-wdt.h
> ---
>  .../include/asm/mach-loongson32/loongson1.h   |  1 -
>  .../include/asm/mach-loongson32/regs-wdt.h    | 15 ------
>  arch/mips/loongson32/common/Makefile          |  2 +-
>  arch/mips/loongson32/common/reset.c           | 51 -------------------
>  4 files changed, 1 insertion(+), 68 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
>  delete mode 100644 arch/mips/loongson32/common/reset.c

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
