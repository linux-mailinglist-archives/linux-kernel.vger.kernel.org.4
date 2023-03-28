Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5193B6CC11A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjC1Ng2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 09:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbjC1NgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:36:25 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6843BDDB;
        Tue, 28 Mar 2023 06:36:08 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1ph9UO-0000sL-00; Tue, 28 Mar 2023 15:35:52 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 923B3C1D30; Tue, 28 Mar 2023 15:17:35 +0200 (CEST)
Date:   Tue, 28 Mar 2023 15:17:35 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] MIPS: Loongson32: Remove deprecated PWM timer
 clocksource
Message-ID: <20230328131735.GA11532@alpha.franken.de>
References: <20230328120506.375864-1-keguang.zhang@gmail.com>
 <20230328120506.375864-2-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328120506.375864-2-keguang.zhang@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:05:04PM +0800, Keguang Zhang wrote:
> The Loongson1 PWM timer will be moved to clocksource framework.
> Then, the old driver is no longer needed.
> Remove the deprecated code and update the Kconfig accordingly.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  arch/mips/loongson32/Kconfig       |  37 -----
>  arch/mips/loongson32/common/time.c | 210 -----------------------------
>  2 files changed, 247 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
