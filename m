Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96A386727B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 20:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjARTCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 14:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjARTBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 14:01:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302B35B479;
        Wed, 18 Jan 2023 11:00:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6E8B619C6;
        Wed, 18 Jan 2023 19:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C59BC433EF;
        Wed, 18 Jan 2023 19:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674068439;
        bh=weTLZG8IsGIN+dW9FnU1+H8fULkXuUXBKDQBQ6V8wqU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SLzj9xO01/OI/eGBS3unEvefzng3fwo3+fycbHhn7MXd7g6HSBXi9e4KNPmgNjzMP
         MrPfPMbeTgq42EYUIeqjlQisKw/MmoNTmLqOUkrT9GUbF12AB/Niwca98J0RC7yhht
         HUH2SdHvw6PQLpu7NM0A8+moC0cgI+65AMwjDftVpUMQXn3HDERfjgPYJQvG9Zat9s
         vnyA919v0HhUa2qBgheQd3E6QYb0bkQ5oYAPn8xr+5gVgbgDF/dXNP1SIwLPpyGYVD
         6lAMtFJ51ZIeBYjrZKSJFuLl5B+3MPjQO9d1zXERgmPIgVwV+Jy7duZUur6rXMW0It
         RVil9O9e1naVQ==
Message-ID: <a1285cb87151130de782fc1941b13f34.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Y8VfEfnWwt8+QB1W@linaro.org>
References: <20230111101030.686885-1-Qing-wu.Li@leica-geosystems.com.cn> <20230111101030.686885-2-Qing-wu.Li@leica-geosystems.com.cn> <Y8VfEfnWwt8+QB1W@linaro.org>
Subject: Re: [PATCH V5 1/1] clk: imx8mp: Alias M7 SRC/DIV to M7 CORE
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        abelvesa@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        18701859600@163.com, bsp-development.geo@leica-geosystems.com,
        Marco Felsch <m.felsch@pengutronix.de>
To:     Abel Vesa <abel.vesa@linaro.org>
Date:   Wed, 18 Jan 2023 11:00:36 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2023-01-16 06:28:33)
> On 23-01-11 11:10:30, LI Qingwu wrote:
> > Defined IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV in imx8mp-clock.h
> > but never assigned. It will cause the system to hang if using them.
> > Alias IMX8MP_CLK_M7_SRC and IMX8MP_CLK_M7_DIV to IMX8MP_CLK_M7_CORE
> > for backward compatibility.
> >=20
> > Fixes: 8c83a8ff4dd9 (clk: imx8mp: use imx8m_clk_hw_composite_core to si=
mplify code)
> > Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> > Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
>=20
> Stephen, can you please pick this up yourself?
>=20

Is it needed for clk-fixes? When did the system start hanging?
