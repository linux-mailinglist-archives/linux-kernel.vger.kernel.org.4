Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A255F0EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiI3PQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiI3PQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:16:20 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFFE312CC9D;
        Fri, 30 Sep 2022 08:16:17 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oeHkM-0003TJ-00; Fri, 30 Sep 2022 17:16:14 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 3E2D4C0D0C; Fri, 30 Sep 2022 16:46:40 +0200 (CEST)
Date:   Fri, 30 Sep 2022 16:46:40 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH] mips: update config files
Message-ID: <20220930144640.GA12989@alpha.franken.de>
References: <20220929101451.32267-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929101451.32267-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 12:14:51PM +0200, Lukas Bulwahn wrote:
> Clean up config files by:
>   - removing configs that were deleted in the past
>   - removing configs not in tree and without recently pending patches
>   - adding new configs that are replacements for old configs in the file
> 
> For some detailed information, see Link.
> 
> Link: https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
>  arch/mips/configs/ar7_defconfig               |  4 ----
>  arch/mips/configs/ath25_defconfig             |  4 ----
>  arch/mips/configs/ath79_defconfig             | 10 --------
>  arch/mips/configs/bcm63xx_defconfig           |  3 ---
>  arch/mips/configs/bigsur_defconfig            |  9 --------
>  arch/mips/configs/bmips_be_defconfig          |  3 ---
>  arch/mips/configs/bmips_stb_defconfig         | 23 ++-----------------
>  arch/mips/configs/cavium_octeon_defconfig     |  1 -
>  arch/mips/configs/db1xxx_defconfig            |  1 -
>  arch/mips/configs/decstation_64_defconfig     | 10 --------
>  arch/mips/configs/decstation_defconfig        | 10 --------
>  arch/mips/configs/decstation_r4k_defconfig    | 10 --------
>  arch/mips/configs/fuloong2e_defconfig         |  9 --------
>  arch/mips/configs/generic/board-ocelot.config |  1 -
>  arch/mips/configs/gpr_defconfig               |  8 -------
>  arch/mips/configs/ip22_defconfig              | 10 --------
>  arch/mips/configs/ip27_defconfig              | 19 ---------------
>  arch/mips/configs/ip28_defconfig              |  3 ---
>  arch/mips/configs/ip32_defconfig              |  2 --
>  arch/mips/configs/jazz_defconfig              |  1 -
>  arch/mips/configs/lemote2f_defconfig          |  9 --------
>  arch/mips/configs/loongson1b_defconfig        |  4 ----
>  arch/mips/configs/loongson1c_defconfig        |  4 ----
>  arch/mips/configs/loongson2k_defconfig        |  3 ---
>  arch/mips/configs/loongson3_defconfig         |  2 --
>  arch/mips/configs/malta_defconfig             |  5 ----
>  arch/mips/configs/malta_kvm_defconfig         |  5 ----
>  arch/mips/configs/malta_qemu_32r6_defconfig   |  3 ---
>  arch/mips/configs/maltaaprp_defconfig         |  3 ---
>  arch/mips/configs/maltasmvp_defconfig         |  3 ---
>  arch/mips/configs/maltasmvp_eva_defconfig     |  3 ---
>  arch/mips/configs/maltaup_defconfig           |  3 ---
>  arch/mips/configs/maltaup_xpa_defconfig       |  5 ----
>  arch/mips/configs/mtx1_defconfig              | 10 --------
>  arch/mips/configs/omega2p_defconfig           |  3 ---
>  arch/mips/configs/pic32mzda_defconfig         |  1 -
>  arch/mips/configs/rb532_defconfig             |  4 ----
>  arch/mips/configs/rbtx49xx_defconfig          |  7 ------
>  arch/mips/configs/rm200_defconfig             |  7 ------
>  arch/mips/configs/rt305x_defconfig            |  4 ----
>  arch/mips/configs/sb1250_swarm_defconfig      |  2 --
>  arch/mips/configs/vocore2_defconfig           |  3 ---
>  arch/mips/configs/xway_defconfig              |  4 ----
>  43 files changed, 2 insertions(+), 236 deletions(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
