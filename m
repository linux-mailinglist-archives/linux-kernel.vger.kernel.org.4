Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B1896FE555
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjEJUnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjEJUnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:43:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C565672AA;
        Wed, 10 May 2023 13:43:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC0D56402F;
        Wed, 10 May 2023 20:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB84C433D2;
        Wed, 10 May 2023 20:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683751415;
        bh=tndkleIjyMNiQ8/7vt/ybi9DdjZVS+pTPWE39SqAuQ4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rfrtV3xrj0Cw+JJr+SLnl2LDMXdIUr5OlUQvzoQ6CE2+9YjYxQadHapbYsI47bJa3
         ErHXCz1BIdWYEFUkIXJFZggD50wGDAV33mRDdtCWrWUTNFfRcaJueAehUtexCPYFvZ
         mCXO5YCF5s4hw5zbcbK7JUD50lovGRza3M5o52mWKQmkyBtyvdYOM+m0aZ2UvxTeIL
         DZ4Nt3t03SY/5ZCDbhgus+doxhxrHVaWUosYYrOz4Qx6f4Yl8B1V2GXz9rNdgZfr+W
         vi9vYZavWCaTDmDldGsjIyAko0eRA5B6S7+mj2sh+PYJCg0Xd4SGt79ajCTTr5uZ6C
         5EVRp8mhi3W7Q==
Message-ID: <5e0438103c4ec0a2fadb34d7a66b82fc.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230430190233.878921-4-u.kleine-koenig@pengutronix.de>
References: <20230430190233.878921-1-u.kleine-koenig@pengutronix.de> <20230430190233.878921-4-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 3/3] clk: mediatek: Convert all remaining drivers to platform_driver's .remove_new()
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
Date:   Wed, 10 May 2023 13:43:33 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-04-30 12:02:33)
> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is (mostly) ignored
> and this typically results in resource leaks. To improve here there is a
> quest to make the remove callback return void. In the first step of this
> quest all drivers are converted to .remove_new() which already returns
> void.
>=20
> Trivially convert all mediatek clk drivers from always returning zero in
> the remove callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-next
