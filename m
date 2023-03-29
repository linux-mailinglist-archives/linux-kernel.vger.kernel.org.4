Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A656CD03E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjC2ClA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjC2Ck6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:40:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A06E35A8;
        Tue, 28 Mar 2023 19:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D1D8B81F88;
        Wed, 29 Mar 2023 02:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3238FC433D2;
        Wed, 29 Mar 2023 02:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057624;
        bh=CaMQ35XV8yS1qRP6pCVhCK5Q0eSKnfCwitxVdmBVpaM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=n3jjCU1CzUs8+R2hX05V74EN/qbvqSzdk1x/8/YLL09CI2m8zvjirDoIVaqxFbP4g
         wPeiRI6jebabWbS2C7Fe+u9wkqK4/qLXU0N5p7kG3RJ4/woB0CKc1tSzjMIWo/jdmp
         vxdgWurQPO5abPEKHqKilrBmLbnSyvIZQ0cu2ZYxFO1a+h8CZtQmQK4j+X/RLgxsVF
         NeLEDdTPB2fAJ78/0yAQwMefu5ZLgnlg15h/KfRTT1rReC9OMCDPPkezRe8NLdD+sJ
         iXvRaQ+nIOSTkIsGNfZg6H42GSPHr/OW6fCydd+d0xKDuvFcTa1Ug94sN2zDXQzNWe
         A4EeBLIbWqVkQ==
Message-ID: <21136043a4c745abca60afb206b980f6.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-27-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-27-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 26/30] clk: tegra: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:40:22 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:15:08)
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
