Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0332772D34E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjFLVaN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjFLVaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:30:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F67A98;
        Mon, 12 Jun 2023 14:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF7062BC4;
        Mon, 12 Jun 2023 21:30:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F45FC433EF;
        Mon, 12 Jun 2023 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686605407;
        bh=6x3baeePMh0TYd5dpVjxp1lv4bF4Vajz8qGHiDNJgf0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nvHVfMnWlP3pLsZwF9M1F7kYd2GsWyLkMLdaJq+n5UqPfZIUnqTcY8q56EJ0iDBHT
         q8GRTbIIEnFwt49mBUWjeHtGQfkLfli+UEHLkEckQ+SQhxgHKSE7vm4XFWnzIa9U0b
         48jBxVk3p0sJdXzk7vDrsX7Oe4jXd7pzf0f9S1vc/rICCsvGcfcwgBHBYIH71J9RVJ
         3tbGHNZnBDOBu6vj7TuIBBTVUoRpmVy9dvVbeMJS361qo7GY7Nusgo/PZz8WeSX4R6
         FCbQiU8bNzS0DXzJcWTq5vw0hi6Mii9+DnADB37Cc6Nrg4mEakL5mTZZSbGoDT5Z1M
         xE6rwQxoEmUJw==
Message-ID: <ce0faea5556211465183c0bbabbb0e09.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230612182332.371003-1-sboyd@kernel.org>
References: <20230612182332.371003-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: meson: a1: Staticize rtc clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev, Jian Hu <jian.hu@amlogic.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 12 Jun 2023 14:30:04 -0700
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

Quoting Stephen Boyd (2023-06-12 11:23:32)
> Sparse rightly complains that this symbol is supposed to be static.
>=20
> Cc: Jian Hu <jian.hu@amlogic.com>
> Cc: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Fixes: 84af914404db ("clk: meson: a1: add Amlogic A1 Peripherals clock co=
ntroller driver")
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
