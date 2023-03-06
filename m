Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E76246ACF2C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjCFUaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjCFUaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:30:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCE43866F;
        Mon,  6 Mar 2023 12:30:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC14D6116D;
        Mon,  6 Mar 2023 20:30:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13931C433EF;
        Mon,  6 Mar 2023 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678134611;
        bh=xbWf+sdjztIPDwttPs5NUEVzUHAhlaetVoydXRsoWpk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Pp88JpMjVB+iwrWrstHSl0LUAYaSdVc0jce1pHNI0Dw/TaOldVLqeiqbPnzmVNxo3
         sP8Sg77OzORyIW0mHMCZdB4EByoYatBUOhPRjBoM+sv1X1mbarR61M6TtndfgtjNSo
         L/N2Gd6KoK7stkSv99bgIpTQVlB454f4lJAyDMIqHhqY3ShtmbyX4l+aTtwjZmsAr8
         XGDPT81Bkov7AmneoapMI/Su+yh8OmqJ4vCJjvy7tnEznU0mm+UEP9ZY6jwpcxxZ9p
         OpLOyNKk+xaHBKQ+9QBNW4Am+u0SGreQKvbCDYeobn4n/OmkGj6sOSXsRO6TfegNau
         5YRKf/1eCdBbg==
Message-ID: <47b6ba881b16b6f11824eb52c153b5b5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230227105931.2812412-1-claudiu.beznea@microchip.com>
References: <20230227105931.2812412-1-claudiu.beznea@microchip.com>
Subject: Re: [PATCH] clk: at91: clk-sam9x60-pll: fix return value check
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Dan Carpenter <error27@gmail.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, mturquette@baylibre.com,
        nicolas.ferre@microchip.com
Date:   Mon, 06 Mar 2023 12:30:07 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2023-02-27 02:59:31)
> sam9x60_frac_pll_compute_mul_frac() can't return zero. Remove the check
> against zero to reflect this.
>=20
> Fixes: 43b1bb4a9b3e ("clk: at91: clk-sam9x60-pll: re-factor to support pl=
ls with multiple outputs")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
