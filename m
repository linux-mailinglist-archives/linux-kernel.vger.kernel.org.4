Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17326CD016
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjC2ChO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjC2ChC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:37:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4C3C20;
        Tue, 28 Mar 2023 19:36:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A3A3B81F90;
        Wed, 29 Mar 2023 02:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E5FC4339B;
        Wed, 29 Mar 2023 02:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057409;
        bh=XMuBj93qwqkhv6yg1fjCzviCrJmlzBLOId2XcYeaDlg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iYXNoyxclNHQoYQgmn+GSm0iDJzcyCYIxJ60eF/pvGwYpi5imFcdFAOrNIFlOKSi1
         L3/p4+jyGm/79ImvJ9tka988xJ1cCgxWKcMmiXsJdAWH0beimRvPYE2eLvMVCRJ8kb
         tB8DyaxcfnF+CwN04yP00B/mBrfQkI7cec8TMgJFf22bWnHOPIs2nkh7LATQkSQzPh
         EBPfEY+03hkoJEYu5HWGFDpwAGMT+3CRG9aQatwOuWj8PzyPmaZO9u5CEtL7ybORGT
         6FqnGrM2kDjs9oad9sKx6MDrDH67H2lHlNzwxm9JqjBp7Lz1HRVXCsWKVG35Exbhew
         z/0O920DO54Jg==
Message-ID: <71e058aa5e3e201ecad388437fcaeeb5.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-10-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-10-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 09/30] clk: fixed-mmio: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:36:46 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:14:51)
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
