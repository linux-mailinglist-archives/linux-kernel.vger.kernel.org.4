Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F96CD01C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjC2Chu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjC2Chp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:37:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24193598;
        Tue, 28 Mar 2023 19:37:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7494261A3F;
        Wed, 29 Mar 2023 02:37:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3F8C433D2;
        Wed, 29 Mar 2023 02:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057449;
        bh=GmjrNfc+m1lZ4syNJZ9a1ECJvMeoV+DS/ryEcHWjaL8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oZv/JOHOpnRCAhwNJI9nVR9Wp9wtKVPGMWqi2z9aFYOovMBLs1wU21niBmBD8SJq7
         2gLo/AeB0vYqrDjfWuQL5W4SzzhYnFk1cF2meJhn6K0rGRn4ME+wbVhuE5xMKS5rR3
         0Jbm8DWpKEu+K7OOEdl6pmuJZWrSHTopOVV64CTlbGQDTx0fvB4um/BYz9hPWsyHfT
         QqCtrBtwkKvTq/IrCyg5etyo7g1+iLReBxj/umCZv+U5/ldais33wvPWOxu+IaAX/3
         c1E5pV9U7gXj1qfBLPw5B0HLW9q74JohloS5H4FcVA3K5jCZgCzjCsQZhPoSmrvjh2
         AU51oKVH6qX7w==
Message-ID: <a2e0cd6b10e5bfcc4ba7d58070494ba5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-13-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-13-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 12/30] clk: palmas: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:37:27 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:14:54)
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
