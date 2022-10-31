Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2476139E3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiJaPTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiJaPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:18:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA30DE02F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 911AFB8188F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B5DC433C1;
        Mon, 31 Oct 2022 15:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667229528;
        bh=AtOM7D9gLdA+Hslq3f03XFKM+cnAeVcXitVLVp3zwkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hdnCJcXS0CbO1bW7EPFEfQ4lKVqday5GPVTO8ZWlgjVJ+HeGfejCPUg4cfi/Ka7D8
         2gkDloI8/3RRhHM0zNT8dRNTWYdgob3AfuUXYvL+7LPfEYq1A0/EbRBbprp5M5m4y1
         tOWZR69QS+5g7wj92W6/6ag8dgPxBUwVwlAzHBnZE377lvuOXa3io9Z75MOJhSN/+2
         aKkiGRHkYgFMoHI8R9bytWXLPjogrV6nRlwX/Xp1UM5nwtvnRvFXC57c0IWGey+0xo
         6EliHdfuKzi3kX2JTqHp2iz7RES7GyM3NjltycSQTbDol4JgWJSmZUN/XsMR6/45ME
         veiMCwFnZrTog==
Date:   Mon, 31 Oct 2022 15:18:43 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH 17/17] mfd: remove htc-i2cpld driver
Message-ID: <Y1/nUwjDFyIKQ/dT@google.com>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
 <20221019150410.3851944-17-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019150410.3851944-17-arnd@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Oct 2022, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The HTC Herald machine was removed, so this driver is no
> longer used anywhere.
> 
> Cc: Cory Maccarrone <darkstar6262@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig      |   9 -
>  drivers/mfd/Makefile     |   1 -
>  drivers/mfd/htc-i2cpld.c | 627 ---------------------------------------
>  include/linux/htcpld.h   |  23 --
>  4 files changed, 660 deletions(-)
>  delete mode 100644 drivers/mfd/htc-i2cpld.c
>  delete mode 100644 include/linux/htcpld.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
