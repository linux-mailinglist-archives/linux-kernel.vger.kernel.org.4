Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB735EEDA6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiI2GNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiI2GNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:13:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5577121E54
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 23:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D996201E
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 06:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01035C433B5;
        Thu, 29 Sep 2022 06:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664431997;
        bh=mptkJW/0D7J67zG5IWOS5/3OR8nh/364Sw8qadvLw8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuMZGNsY9JNwxVqBTv2Qkn8muzAHYMKKbbxpK1IVApLWICoOXYzqZNm4IvozgdTug
         pWqaMbMVCqB956gdbXAqYJ5xuDwFc9/nDzXBfzriQi+Qt2bRXyHdbzAkwHdo3Ps76m
         aIY4CJ/t9wx5LQkmL3iWD0R25kp9eh1xAsAH1OFceaoGsuQWAKfXRE1BJ7p/7y5K9F
         SlxF/SAqPWofOss6e/plGhOb5klg1oSQMqXTYvSpGHHcskKX02J0SjV6SC5XGJjhbY
         VsQ2dWU94e7LKwUcuYU7xRyKhmTNzzp8s22T5BFwfnmFp5pwY2kwnQgLbW6151osFL
         93YmbAbu6Z4hw==
Date:   Thu, 29 Sep 2022 11:43:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Aurelien Jarno <aurelien@aurel32.net>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH] phy: rockchip-snps-pcie3: only look for
 rockchip,pipe-grf on rk3588
Message-ID: <YzU3eLRCMmogyypi@matsya>
References: <20220927051752.53089-1-aurelien@aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927051752.53089-1-aurelien@aurel32.net>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-09-22, 07:17, Aurelien Jarno wrote:
> The rockchip,pipe-grf property is only used on rk3588, but not on
> rk3568. Therefore this property is not present on rk3568 devices,
> leading to the following message:
> 
>   rockchip-snps-pcie3-phy fe8c0000.phy: failed to find rockchip,pipe_grf regmap
> 
> Fix that by only looking for this property on rk3588.

Applied, thanks

-- 
~Vinod
