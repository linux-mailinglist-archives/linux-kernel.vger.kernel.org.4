Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32D4613991
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 16:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbiJaPBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 11:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiJaPBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 11:01:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFFF11144;
        Mon, 31 Oct 2022 08:01:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F90DB816D9;
        Mon, 31 Oct 2022 15:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C79C433D6;
        Mon, 31 Oct 2022 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667228468;
        bh=BULsYzioOvNI0VWQL6Gy4RFiFJVJG/1pz1rnZm68F1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j4LTJWzgkHrNHCmG/CW/Sec38zDcOSuTDJu1FMuaGM6SOvq02f7KK4bdhkIKq70/n
         oXJShIN99AmRK7C/tCy98VGy27ju/m/5F5cnbnPFUyK1ugBZCBzi9pMLxbaA9T7CYP
         4oxTjZWhUnADBvB2NLo9QA99da4qZbqvQPsGw/L5KMxgfszXlzvhSGDTF+TQiYtNkA
         rpPF2dtpP8UI4j10GqUIy84rADmLumi6EiWUzkVPC/J9UklnwS85HtPTKW1WCoPA9q
         l2e9INDhNlVcy8Ga6JnArlYhh25/wplevXqK0Dk9e0qcYE6/9PwAhHVQxeFJrMaXID
         D5smSrNmjvgvA==
Date:   Mon, 31 Oct 2022 15:01:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-input@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 06/14] mfd: remove dm355evm_msp driver
Message-ID: <Y1/jLvg5AYCk1CkD@google.com>
References: <20221019152947.3857217-1-arnd@kernel.org>
 <20221019152947.3857217-7-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221019152947.3857217-7-arnd@kernel.org>
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
> The DaVinci DM355EVM platform is gone after the removal of all
> unused board files, so the MTD device along with its sub-devices
> can be removed as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/input/misc/Kconfig         |  11 -
>  drivers/input/misc/Makefile        |   1 -
>  drivers/input/misc/dm355evm_keys.c | 238 ---------------
>  drivers/mfd/Kconfig                |   8 -
>  drivers/mfd/Makefile               |   1 -
>  drivers/mfd/dm355evm_msp.c         | 454 -----------------------------
>  drivers/rtc/Kconfig                |   6 -
>  drivers/rtc/Makefile               |   1 -
>  drivers/rtc/rtc-dm355evm.c         | 151 ----------
>  include/linux/mfd/dm355evm_msp.h   |  79 -----
>  10 files changed, 950 deletions(-)
>  delete mode 100644 drivers/input/misc/dm355evm_keys.c
>  delete mode 100644 drivers/mfd/dm355evm_msp.c
>  delete mode 100644 drivers/rtc/rtc-dm355evm.c
>  delete mode 100644 include/linux/mfd/dm355evm_msp.h

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
