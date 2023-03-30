Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02ADD6D0342
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjC3LdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjC3LdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:33:11 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D875D30D2;
        Thu, 30 Mar 2023 04:33:03 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1phqWX-0002LY-01; Thu, 30 Mar 2023 13:32:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id BF819C1DC7; Thu, 30 Mar 2023 13:30:53 +0200 (CEST)
Date:   Thu, 30 Mar 2023 13:30:53 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Yang Ling <gnaygnil@gmail.com>
Subject: Re: [PATCH 1/2] MIPS: Loongson32: Remove reset.c
Message-ID: <20230330113053.GB9674@alpha.franken.de>
References: <20230330102013.545588-1-keguang.zhang@gmail.com>
 <20230330102013.545588-2-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330102013.545588-2-keguang.zhang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:20:12PM +0800, Keguang Zhang wrote:
> The Loongson-1 restart handler will be moved to watchdog driver,
> then _machine_restart is no longer needed.
> The _machine_halt and pm_power_off are also unnecessary,
> which contain no hardware operations.
> 
> Therefore, remove the entire reset.c and related header file.
> Update the Makefile accordingly.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  .../include/asm/mach-loongson32/regs-wdt.h    | 15 ------
>  arch/mips/loongson32/common/Makefile          |  2 +-
>  arch/mips/loongson32/common/reset.c           | 51 -------------------
>  3 files changed, 1 insertion(+), 67 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
>  delete mode 100644 arch/mips/loongson32/common/reset.c

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
