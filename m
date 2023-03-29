Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219E16CD025
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjC2Ciy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjC2Ciw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:38:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5710E3A9A;
        Tue, 28 Mar 2023 19:38:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2192B81F88;
        Wed, 29 Mar 2023 02:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD2C9C433D2;
        Wed, 29 Mar 2023 02:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057500;
        bh=exqBtxzee2hlIHiMZ9XiKNfGw2LlCdgJ60cLlhN9og0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Lr5cULdXMU9/B8BWs+QJ86K9oM+PKLI3RIutR9IyBNMXvXgEC83mNrfTrq8ypHDgd
         fKzyd0LvX3Yq/sLnnAVWgMOsjrT0kZf9xJeMn8vbnIVbu/e4Numgd/U1Pvf/qpmreD
         NvQyK0QUaQuCbNc99v2dAY4Zqa7m3htrIKmeYTuThz6Kf9djjSGl+pB4x8PBlbrS+O
         l3sPyHVxuUrK65KGCA5cfBC/MdB8FN/VrI41tH8e/vDiDfRwmUL54c8qI5voBsgN0D
         JzRWmVJoZTT3aIX1lS63QwYsF+Bcpdag4FW6Ds6Pc4LvPkrcWGOT9FpqQKyv6p+xdF
         LQJQyAejrq30w==
Message-ID: <f796c0691d4796ec1d7656de55a25d39.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-16-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-16-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 15/30] clk: scpi: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:38:18 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:14:57)
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-next
