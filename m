Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130E45E9DC5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbiIZJgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbiIZJgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:36:13 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7394222A9;
        Mon, 26 Sep 2022 02:36:11 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1ockX4-0007UJ-00; Mon, 26 Sep 2022 11:36:10 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 85C44C0643; Mon, 26 Sep 2022 11:08:40 +0200 (CEST)
Date:   Mon, 26 Sep 2022 11:08:40 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Aleksander Jan Bajkowski <olek2@wp.pl>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: dts: lantiq: rename dts files with soc name being
 the prefix
Message-ID: <20220926090840.GA6352@alpha.franken.de>
References: <20220829183717.4394-1-olek2@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829183717.4394-1-olek2@wp.pl>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 08:37:17PM +0200, Aleksander Jan Bajkowski wrote:
> Rename lantiq dts files with soc name being the prefix, so that the
> board dts file can be located easily by soc name, and we also gain
> the consistency of naming.
> 
> This patch is a preparation for the addition of dts for newer SoCs
> (Lantiq ARX100, VRX200 and xRX330).
> 
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  arch/mips/boot/dts/lantiq/Makefile                              | 2 +-
>  .../boot/dts/lantiq/{easy50712.dts => danube_easy50712.dts}     | 0
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename arch/mips/boot/dts/lantiq/{easy50712.dts => danube_easy50712.dts} (100%)
> 
> diff --git a/arch/mips/boot/dts/lantiq/Makefile b/arch/mips/boot/dts/lantiq/Makefile
> index f5dfc06242b9..ae6e3e21ebeb 100644
> --- a/arch/mips/boot/dts/lantiq/Makefile
> +++ b/arch/mips/boot/dts/lantiq/Makefile
> @@ -1,4 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
> -dtb-$(CONFIG_DT_EASY50712)	+= easy50712.dtb
> +dtb-$(CONFIG_DT_EASY50712)	+= danube_easy50712.dtb
>  
>  obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
> diff --git a/arch/mips/boot/dts/lantiq/easy50712.dts b/arch/mips/boot/dts/lantiq/danube_easy50712.dts
> similarity index 100%
> rename from arch/mips/boot/dts/lantiq/easy50712.dts
> rename to arch/mips/boot/dts/lantiq/danube_easy50712.dts
> -- 
> 2.30.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
