Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 174D85F176E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 02:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiJAAkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 20:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbiJAAkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 20:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D636E6C762;
        Fri, 30 Sep 2022 17:40:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B3DE60EBD;
        Sat,  1 Oct 2022 00:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE720C433C1;
        Sat,  1 Oct 2022 00:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664584809;
        bh=HifGW6qGZv0PfXLRVe7/PypMC0m6829NgR01RsFRuME=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=MybcmEmJp3tnM/rZVZ3rVUCtp6bvQLbRSrxmk2AV0BcqTyIB6oQZLvZgxvCuOte75
         PvB5R5b9ltrgAyUimv1Ou3HjwzQtstsWqbB4AD4T2DX3GQU93Sflsp+TTf95q0QS7m
         QNqclO7cntwKRstCeYmv7M1UbvVTm9uv6B7VmbXF13uu7vwAhb0b2YG1dqjb5c96R4
         ubdc8YQy0B41WWAdY11nX9OSSg+ZYEgtCElUbT61Xzm5lvy+56qsgGWgfbf74UaAJi
         8UjaT/6ArsoIdXJBMANjl9jOmSCuXOGjsgQ3gVvKqYVdXQX03z70Pbq5qXJdQTs93b
         9OUEbYN2HeGZA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220602030838.52057-1-linmq006@gmail.com>
References: <20220602030838.52057-1-linmq006@gmail.com>
Subject: Re: [PATCH] clk: ti: dra7-atl: Fix reference leak in of_dra7_atl_clk_probe
From:   Stephen Boyd <sboyd@kernel.org>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Date:   Fri, 30 Sep 2022 17:40:07 -0700
User-Agent: alot/0.10
Message-Id: <20221001004009.BE720C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Miaoqian Lin (2022-06-01 20:08:36)
> pm_runtime_get_sync() will increment pm usage counter.
> Forgetting to putting operation will result in reference leak.
> Add missing pm_runtime_put_sync in some error paths.
>=20
> Fixes: 9ac33b0ce81f ("CLK: TI: Driver for DRA7 ATL (Audio Tracking Logic)=
")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Applied to clk-next
