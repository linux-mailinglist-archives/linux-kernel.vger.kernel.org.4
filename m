Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEC7609B58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJXHcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXHcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:32:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9814057E;
        Mon, 24 Oct 2022 00:32:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5D92B80E23;
        Mon, 24 Oct 2022 07:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9436FC433D6;
        Mon, 24 Oct 2022 07:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666596758;
        bh=LNfOmd5fjQMNDmFl34cnDjiEjUDBRW5BfBCBVQ1IiRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFgjZ9VYu0O/YdKXe3xMsLgHaGxqUiUOtE2PLSBESBm2S1buGPyM09i2CLXtoCN0j
         lQHj/exwWn0Vs1ISnKzhKI9Uxb5KQjJj2ynk3n4WOBEyCpRmwG+/i7dGU+HDk/fWFj
         SzdFW9jcaxTTIoa7518X8huS55KF5L6wEade0DBCiRMWX3QMF7T+N6Izl/vo8EnZGd
         HJwe2vgju3MjYMckMWjH5BypFAh5lDMRkombuITKUiZThoNFRAYeC5EBZy9xLEhuLA
         J1PuiBYjx+/4Kkgzi2i+Ivw1CffpyIKgRh4ctsi6sg+ZlqQ47XBqAmSVbg7J9xhprd
         SYk+Yn5io7ypw==
Date:   Mon, 24 Oct 2022 08:32:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/5] mfd: mc13xxx: stop including of_gpio.h
Message-ID: <Y1Y/kZxPTGrWH5wH@google.com>
References: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926054421.1546436-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Sep 2022, Dmitry Torokhov wrote:

> Neither SPI nor I2C variant uses any APIs from of_gpio.h so let's stop
> including it.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/mfd/mc13xxx-i2c.c | 1 -
>  drivers/mfd/mc13xxx-spi.c | 1 -
>  2 files changed, 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
