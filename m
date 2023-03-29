Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592C66CD003
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjC2Cfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC2Cfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:35:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D232D4F;
        Tue, 28 Mar 2023 19:35:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BC1E61A3E;
        Wed, 29 Mar 2023 02:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B3AC433D2;
        Wed, 29 Mar 2023 02:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057326;
        bh=MyEuYDkf+StM1Q+SSNOS6qHcmlP6pXJ84tsG+a+VYtI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MpHaPOwjxk7af0XuvP347IXG2YhTqKdVHlpN3daFBHZs/FkFg6d3tkCtlbz4ylh9T
         /LcNRWdhXQJV2LbXfvQb25ihDzuvA6QDK7siWWdYFJTzg111MlMuptTQy0XJdSIEtY
         58hmVFqa/Hvr7P+kWRj1FA/OIHcTYo32NWTkaPEo4dY7WIL3j3V70dSNtrDurMOV6U
         yUyYxxdiBqyV/Iztxgx6r1FaLa0k72LIsM9Kq5nRh88XCE/oWYt74hW044ApRaFH2+
         ZeYyTo5JPyOPuWsNk3V2zXbaddwKPvCiXm3v1v0ihKWx7lI6+R7g3H0xAVjMKT/wDs
         daeCLDz6WPcPw==
Message-ID: <e351fdfac414f398fd0c2f6bfaba46be.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-4-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-4-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 03/30] clk: xilinx: Drop if block with always false condition
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:35:24 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:14:45)
> xvcu_remove() is only called for a device after after xvcu_probe()
> completed successfully. In that case dev_set_drvdata() was called for
> that device with a non-NULL parameter, so platform_get_drvdata() won't
> return NULL and the if condition is never true.
>=20
> Drop the if, preparing a conversion to make platform driver's remove
> callback return void.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-next
