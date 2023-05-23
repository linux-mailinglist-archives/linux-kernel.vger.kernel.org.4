Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4F270D89A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236268AbjEWJOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 05:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236201AbjEWJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 05:13:53 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9AEC138;
        Tue, 23 May 2023 02:13:45 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1q1O5K-0007MY-02; Tue, 23 May 2023 11:13:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 8C0AEC02E6; Tue, 23 May 2023 11:07:06 +0200 (CEST)
Date:   Tue, 23 May 2023 11:07:06 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     paul@crapouillou.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mips: dts: ingenic: Remove unnecessary AIC clocks
Message-ID: <20230523090706.GC9484@alpha.franken.de>
References: <20230505142400.1270848-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505142400.1270848-1-aidanmacdonald.0x0@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 03:24:00PM +0100, Aidan MacDonald wrote:
> The "ext" and "pll half" clocks don't belong in the DT. They are
> not consumed directly by the AIC and are only used as the parent
> clocks of the "i2s" clock. An operating system should be able to
> figure out that information itself because it presumably knows the
> layout of the clock tree.
> 
> Removing these from the DT should be safe from a compatibility
> point of view because the jz4740-i2s driver in Linux does not, and
> never did depend on them.
> 
> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> Link: https://lore.kernel.org/all/20221028103418.17578-1-aidanmacdonald.0x0@gmail.com/
> ---
> This is a resend of patch 2/3 from a previous submission which is linked above.
> 
> v1->v2: updated commit message
> 
>  arch/mips/boot/dts/ingenic/jz4725b.dtsi | 7 ++-----
>  arch/mips/boot/dts/ingenic/jz4740.dtsi  | 7 ++-----
>  arch/mips/boot/dts/ingenic/jz4770.dtsi  | 5 ++---
>  3 files changed, 6 insertions(+), 13 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
