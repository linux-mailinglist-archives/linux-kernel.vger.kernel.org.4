Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DDC65A31A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 08:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiLaHjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 02:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLaHjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 02:39:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1C911175;
        Fri, 30 Dec 2022 23:39:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A82DEB80184;
        Sat, 31 Dec 2022 07:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAC8C433EF;
        Sat, 31 Dec 2022 07:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672472388;
        bh=TbG6cv/YLAHYJhLgQKAODUCdlCQYiEACzAqRj80DFKw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p015iKkPZ5dzdyZyK1whqrk+J6+zfuzz8GvGnLSWik4Y80g41rWrZ38PLqi1xQec/
         JaHYQ34I3O9Y2MO72udRpMm7hoi2ZEO9C+2UudHo85ZQYjTQQXYL38Uo/th79eXROG
         yFiEr4b3dbMHVADaKutmUjXIM6D4JaL+2trZAPnXCorpgBj97rtf9vhyLgcC9l/HMp
         OoOtHmcSJlrkWQAD0us3rm4/fhIhaezPU+6kv6EqmWO0UxkpmiFKbCJ5yOH7MagT/9
         2epSyvimqmIMkzxng6JNzC1XyJSWbrsGRE7s6gEd6QpsQNsVd9EP7MKLSTZb7wIHMY
         GfcdLrXD+r5dA==
Date:   Sat, 31 Dec 2022 15:39:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Unify USB Over Current Settings on Toradex Boards
Message-ID: <20221231073938.GL6112@T480>
References: <20221122155439.456142-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122155439.456142-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 04:54:33PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> 
> This patchset intends to disable the USB Over Current for Toradex i.MX
> boards using the USB chipidea driver.
> 
> We do this on the Carrier-Board device-trees due to the reason, that if
> a customer of us inheriting the module-level device-tree (named -.dtsi)
> does not inherit settings from us that may be incorrect for his
> use-case.
> 
> 
> Philippe Schenker (5):
>   ARM: dts: apalis-imx6: Disable usb over-current
>   ARM: dts: colibri-imx6: Disable usb over-current
>   ARM: dts: colibri-imx6ull: Disable usb over-current
>   ARM: dts: colibri-imx7: Disable usb over-current
>   arm64: dts: verdin-imx8mm: Disable usb over-current

Applied all, thanks!
