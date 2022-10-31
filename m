Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581F56139D7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiJaPRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiJaPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:17:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E963011441
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 08:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84C64B818A2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 15:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6F3C433D6;
        Mon, 31 Oct 2022 15:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667229434;
        bh=IbPbETwQQHxe9D0KPXzTpk5mUhHXS33xTx+r4lhy4xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cV7p9xTUg1pA6N1MlV09vmEipDmY7XhAF5Vy4yS9jQhz8N7eNZ8r/1VBSA641IyqB
         cNuwSbW8TjX0HRNhu8DtD9pl1LKPsf/jCrD82zlhEVqCNoPICKI3xdO+6gS/WK8Ejw
         k3vhd/9co6q+sGQ53YeAuSmWH1ecthypxD5ODVfsRkt57HkVVNCzzkRPHuJWOFd7vg
         Qf+9x7+a+ZgHcaWYefglB/Ni5g6krWMIN0VkCa50PyWKLd4R3dBA+ga1tmnHNH49zn
         ELo/CUt2a0hlCjOlBAW6TbCOqNwKOJL0ObC5nd3SqXn+Kg8v+YgsyeVdbILV/vTmcj
         xPtzbANLgsLZQ==
Date:   Mon, 31 Oct 2022 15:17:08 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 10/14] mfd: remove davinci voicecodec driver
Message-ID: <Y1/m9DacBsbAerAC@google.com>
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-11-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019152947.3857217-11-arnd@kernel.org>
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
> The ASoC davinci voicecodec support is no longer used after
> the removal of the dm3xx SoC platform, so the MFD driver is never
> selected.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig              |   5 --
>  drivers/mfd/Makefile             |   2 -
>  drivers/mfd/davinci_voicecodec.c | 136 -------------------------------
>  3 files changed, 143 deletions(-)
>  delete mode 100644 drivers/mfd/davinci_voicecodec.c

Applied, thanks.

-- 
Lee Jones [李琼斯]
