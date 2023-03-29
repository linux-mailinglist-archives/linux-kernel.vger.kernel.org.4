Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A66216CD112
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 06:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjC2ENC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 00:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjC2EM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 00:12:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F9C3AB2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 21:12:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5A6C61A15
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2816EC433D2;
        Wed, 29 Mar 2023 04:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680063172;
        bh=mbMXPFEyi3ngtrwHaocHzfA+F1do5R7/Rt65wdFf0ss=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RI2cYj1JL2pKIcSknABeihKHiTycGFzIjKw5pFgxNjV022Xu0NECF7MBCFMjoglBW
         d/OfUq/PEPCnCnJYRs3XINTrgDGuO08hH3mYsPCcdC01N6yOutyt3FhET46K9FLTgI
         iJd4hZdqMl+1tp8giLlJJr4QxO49wNovesXm+8aDCwrIic7VOXjT2FuF0TOMC8bYcp
         aTtG1f3GmJHz/5JxYO3O1HXQV3skcw6Enw7uLw6+hNKrbrcVjfU2TH2VOYvg8UAqDV
         5VMnMYkld2r2favqNfGw3IBTh0EDvuK/aZMoDGxRZTPo1OjUw016IYhOmsuvuR45YO
         TVmAX8jD3WnDg==
Message-ID: <4fa881ea6b0eb18395e6b13c965466ef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230306073446.2194048-3-u.kleine-koenig@pengutronix.de>
References: <20230306073446.2194048-1-u.kleine-koenig@pengutronix.de> <20230306073446.2194048-3-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/3] spmi: mtk-pmif: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@pengutronix.de
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 21:12:50 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-05 23:34:45)
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

Applied to spmi-next
