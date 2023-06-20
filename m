Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2C77374B3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjFTSz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjFTSzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C916C10FE;
        Tue, 20 Jun 2023 11:55:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 624F5613DC;
        Tue, 20 Jun 2023 18:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0E1C433C0;
        Tue, 20 Jun 2023 18:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687287309;
        bh=BeCIA0r73Z23vTxNBc+IRhxLfrH0TL74bXKV96Z7b4M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ALPKKpDG9i0OYWqAmIX9DoVLRPQ+I2fciBL/aCuooIvG+GSukq4Bn2jGfaC7qPhLx
         ijLasLzpKruRm78O1hYOt7/6o47NKUwxrmFqn8PHnZAYnSokeEJsRBgK2I/6Cq3pSg
         L7HWckvet0seafgezkNCFyoCvhrxWZ1Lk/UxarSqJvs1nr2LpTIGjQ71XDMoer0UgV
         Nx8zJev+oj5mVGwE74+BT/HzdRUPoiddSmzJywZheXR6fPrefEF+4AIsSvZf8KUjek
         JkNgMG87SUTRbYhtORt0RjA8/ib9dAj5jmGApvSmin08Xiqp6QUSnuDTcLx7ZKcczq
         DJ3L1ImvnTlOQ==
Message-ID: <37bb097111f6ae999f8fad5f8720d942.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230530093913.1656095-6-claudiu.beznea@microchip.com>
References: <20230530093913.1656095-1-claudiu.beznea@microchip.com> <20230530093913.1656095-6-claudiu.beznea@microchip.com>
Subject: Re: [PATCH 5/8] clk: si5341: free unused memory on probe failure
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     aford173@gmail.com, mike.looijmans@topic.nl,
        robert.hancock@calian.com, shawn.guo@linaro.org,
        fabio.estevam@freescale.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>, kristo@kernel.org,
        luca.ceresoli@bootlin.com, michal.simek@xilinx.com,
        mturquette@baylibre.com, nm@ti.com, ssantosh@kernel.org
Date:   Tue, 20 Jun 2023 11:55:06 -0700
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

Quoting Claudiu Beznea (2023-05-30 02:39:10)
> Pointers from synth_clock_names[] should be freed at the end of probe
> either on probe success or failure path.
>=20
> Fixes: b7bbf6ec4940 ("clk: si5341: Allow different output VDD_SEL values")
> Fixes: 9b13ff4340df ("clk: si5341: Add sysfs properties to allow checking=
/resetting device faults")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
