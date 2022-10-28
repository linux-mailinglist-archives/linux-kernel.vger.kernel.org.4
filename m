Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4096106AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiJ1AJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiJ1AJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:09:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C6EF67;
        Thu, 27 Oct 2022 17:09:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62B46B82684;
        Fri, 28 Oct 2022 00:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE9DC43470;
        Fri, 28 Oct 2022 00:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666915768;
        bh=XLQs904fdLuqTQ68Yo4g7RagsFSqgRNILY6SoA9KvfA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=oHiq36PBzdSWncGUnxCg5XxCotWSYhks7FQy3YP4CEVOeTaRqY7TEjFS3ec99Gsid
         jo73Mmp3L/PYWTynvA9wPunKEy/ojUZiaizj8Tjhd0vHEHX0JNbN/ow3/0vvf1pWif
         69QhFm/L/bWCr+Rt0dcnk1It6O2ZUUDZYoO55mt1It3GdqYDFCzNkSKW28hc8OGb3o
         F4UFibOOMwrq6HwbFUyRE3tr49vOsY1jvOiCHw2g6wvW4ZGqUBcmhYDj2+DHzTidg2
         eeqQG1uVUZ5gFshbRp8n8GY4AsR5NMr/pClRegdcwlNiOs++747VzEbNrgENoCgc1G
         r8QWxEi/8G/jA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221018-clk-range-checks-fixes-v1-3-f3ef80518140@cerno.tech>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech> <20221018-clk-range-checks-fixes-v1-3-f3ef80518140@cerno.tech>
Subject: Re: [PATCH 3/4] clk: Initialize max_rate in struct clk_rate_request
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Thu, 27 Oct 2022 17:09:25 -0700
User-Agent: alot/0.10
Message-Id: <20221028000928.0AE9DC43470@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maxime Ripard (2022-10-18 06:52:58)
> Since commit b46fd8dbe8ad ("clk: Zero the clk_rate_request structure"),
> the clk_core_init_rate_req() function clears the struct clk_rate_request
> passed as argument.
>=20
> However, the default value for max_rate isn't 0 but ULONG_MAX, and we
> end up creating a clk_rate_request instance where the maximum rate is 0.
>=20
> Let's initialize max_rate to ULONG_MAX properly.
>=20
> Fixes: b46fd8dbe8ad ("clk: Zero the clk_rate_request structure")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-fixes
