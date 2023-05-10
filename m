Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3466FE551
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236101AbjEJUnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbjEJUnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:43:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C8BD7;
        Wed, 10 May 2023 13:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3706401A;
        Wed, 10 May 2023 20:43:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DFC2C433D2;
        Wed, 10 May 2023 20:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751392;
        bh=x7JoMvq12GkBDAMpw0bQAgdVpKquBbUYn0pK97yJaOQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZVp3Fh//rOZOI2KmFeakDBJXz14hmUm4L5JHlBzzzf056YNFNzroLjIX1zw2DU6YR
         Cpb5ltYNlm9fwjaX3/Dw5a2lJwwIoznyyUI3K/PYSlAnX7jV2k6DUjMHeW9WIn7wIA
         jVbkAjsVGILIyvAvpz3BZ9cOlghyBQoStxHGlXgictIFQ7jPZTD8iaQtyAxMgUpovA
         ciIKUD+jCM5dvGAwkSG15u3S73r8Bq9GawfmQDrXJQjj8Kwk+RFY1ztkQlE5Ci0v/r
         SHhdgVpH6ME0aoML9QFfHxTgLGpPYLya97LQsjFjRkwMDfZKhAcCPBCHmWUperndjk
         XDk6wW8cDCEoQ==
Message-ID: <f1d5d02d31e6237087c81705907ed861.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230430190233.878921-2-u.kleine-koenig@pengutronix.de>
References: <20230430190233.878921-1-u.kleine-koenig@pengutronix.de> <20230430190233.878921-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 1/3] clk: mediatek: Make mtk_clk_simple_remove() return void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Wed, 10 May 2023 13:43:10 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-04-30 12:02:31)
> __mtk_clk_simple_remove() and so also mtk_clk_simple_remove() return
> zero unconditionally. Make them return no value instead and convert the
> drivers making use of it to platform_driver's .remove_new().
>=20
> This makes the semantics in the callers of mtk_clk_simple_remove() clearer
> and prepares for the quest to make platform driver's remove function retu=
rn
> void. There is no semantic change.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-next
