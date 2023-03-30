Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A016D0343
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjC3LdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbjC3LdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:33:12 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D8F9B9ECB;
        Thu, 30 Mar 2023 04:33:03 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1phqWX-0002LY-00; Thu, 30 Mar 2023 13:32:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 60EEFC1D41; Thu, 30 Mar 2023 13:30:03 +0200 (CEST)
Date:   Thu, 30 Mar 2023 13:30:03 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v2 1/3] MIPS: Loongson32: Remove deprecated PWM timer
 clocksource
Message-ID: <20230330113003.GA9674@alpha.franken.de>
References: <20230330101506.545040-1-keguang.zhang@gmail.com>
 <20230330101506.545040-2-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330101506.545040-2-keguang.zhang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:15:04PM +0800, Keguang Zhang wrote:
> The Loongson1 PWM timer will be moved to clocksource framework.
> Then, the old driver is no longer needed.
> Remove the deprecated code and update the Kconfig.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
> V1 -> V2: Delete the obsolete header file regs-pwm.h
> ---
>  .../include/asm/mach-loongson32/regs-pwm.h    |  25 ---
>  arch/mips/loongson32/Kconfig                  |  37 ---
>  arch/mips/loongson32/common/time.c            | 210 ------------------
>  3 files changed, 272 deletions(-)
>  delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-pwm.h

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
