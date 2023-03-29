Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BE46CD01A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 04:37:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjC2Chl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 22:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjC2Che (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 22:37:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C56030F2;
        Tue, 28 Mar 2023 19:37:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 144E6B81F88;
        Wed, 29 Mar 2023 02:37:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E9CC433D2;
        Wed, 29 Mar 2023 02:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680057438;
        bh=bqM3lkt40SglHamR4Qw9WHyCts4GxGWaeZnuP+utrbs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oh/lgd6IHRiianHd16bDs+XriC9qwCxE6QdZPA/PJGwHxJGv82/U/0Ta7w0fIbxtF
         DTg/z7RUW9kp/vwj4hGfGYhdt05sWAlOrDe/Ko1rhHvRM0PXSTzCY06Kb5Y4zUZrr8
         JInCaHhKwRFeN297IlmqS0iwgvupzXKQQDsJCJcsmOieYcHpfP9m9fMg39Az/hi61A
         rEgBlM59Z+yRBS6Y95h3MaYfbUHfTCawmLpCEKwBYdpYHkjnWrX2ikxOF9NrRYaz+g
         IJhlCHxPabgU4Bq9mqnRCEaoh8qdrRhaaYb8x5jRZo3rEzgnMUrzE0JGsGnyJISu0u
         K1xjcD2mjIwpw==
Message-ID: <02d04a128295182f17d8d43a1139aeb0.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230312161512.2715500-12-u.kleine-koenig@pengutronix.de>
References: <20230312161512.2715500-1-u.kleine-koenig@pengutronix.de> <20230312161512.2715500-12-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 11/30] clk: hsdk-pll: Convert to platform remove callback returning void
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Date:   Tue, 28 Mar 2023 19:37:16 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Uwe Kleine-K=C3=B6nig (2023-03-12 09:14:53)
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
