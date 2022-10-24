Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BAB5609BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiJXH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiJXH5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:57:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8BE5D0F9;
        Mon, 24 Oct 2022 00:57:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8CAF0B80EDF;
        Mon, 24 Oct 2022 07:57:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADEA7C433C1;
        Mon, 24 Oct 2022 07:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666598269;
        bh=hDxpDhMk666IjZLpS8egPr1W30wkhtST4o6l5/G/OKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rx0otZNOy7IbrQKLnW3PM2+b2cB1XZSZbp/HFiyMB/j7FLQFO88HxGa5vh8BaUwsH
         REbjpSe38TAZrunQZHNSbkSt/pHkSwPlnCM7lf+h6g4UDOB/0+IOUlalbRe3wRvPE8
         ZrFkpp3sKW+D3SxoAGUkhnwzjjNVbDsCDb6UmplYvNRXyqKegtfYeXPUbGEOepWRXm
         xkID7NQoeN/3l0rodyClEFMrIsNRF8L+NuNu8VDxpTHEQyqoupSbSwazU/Lt9o29w9
         v0TS1d2Inxp6ljbE/FoWWzrm6uFcsqReNW1dyLhRI5MyCwrhU33E7f3iZxWxA1h/Wd
         eFD2Ckzei22MQ==
Date:   Mon, 24 Oct 2022 08:57:41 +0100
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Joe Perches <joe@perches.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/21] power: remove s3c adc battery driver
Message-ID: <Y1ZFdblT4MaZ9ZS1@google.com>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-7-arnd@kernel.org>
 <Y1Y+o2aDz2Cd+ZG8@google.com>
 <697f1503-1289-45bf-acb0-57429c903665@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <697f1503-1289-45bf-acb0-57429c903665@app.fastmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022, Arnd Bergmann wrote:

> On Mon, Oct 24, 2022, at 09:28, Lee Jones wrote:
> > On Fri, 21 Oct 2022, Arnd Bergmann wrote:
> >
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> The s3c-adc driver is removed along with the s3c24xx platform,
> >> so the battery driver is no longer needed either.
> >> 
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> ---
> >>  MAINTAINERS                            |   7 -
> >>  drivers/power/supply/Kconfig           |   6 -
> >>  drivers/power/supply/Makefile          |   1 -
> >>  drivers/power/supply/s3c_adc_battery.c | 453 -------------------------
> >>  include/linux/s3c_adc_battery.h        |  39 ---
> >>  5 files changed, 506 deletions(-)
> >>  delete mode 100644 drivers/power/supply/s3c_adc_battery.c
> >>  delete mode 100644 include/linux/s3c_adc_battery.h
> >
> > Any idea why I was Cc'ed on this (and only this) patch?
> 
> Not sure. I use "get_maintainer.pl -i" to generate the list
> and try to prune it manually to avoid adding too many
> people to Cc. It appears that for this patch I accidentally
> included everyone who showed up in the git history for the
> maintainers file, rather than the people who touched the
> actual driver.

Understood.  Thanks for the explanation.

-- 
Lee Jones [李琼斯]
