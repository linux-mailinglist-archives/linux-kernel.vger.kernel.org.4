Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9EC634BEB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiKWBC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbiKWBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:02:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349A11471;
        Tue, 22 Nov 2022 17:02:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7823EB81E4E;
        Wed, 23 Nov 2022 01:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B70C433B5;
        Wed, 23 Nov 2022 01:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669165361;
        bh=8CrXVtbNPoRo6//6sdp2xYtaIgxcfsZN5ECNv53aqmc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gBolhn3oocOYRM4P94Bd49gBwKoBeVm6tTJX4FT2D1jecyqJ4NLYERIzwObI2zVRd
         4mpOvl7h116+vWNPq2FmcxoNIBZUsWTw31dKma8Z8f6KHDcxoQPKbWVG1m9I10BW6k
         Ep6RiTc86Bs4eJJajwZkiQRM8xi1Cyc7ICd34+ZW1nuTHogUwcNGe2gd9vFARSThSH
         JxILKStnl7xPamf9k3l6XA5YjRVwXGhNjwYw8s0V8GcSPGtpADumPPRBOcQ3hcb0gj
         FSP63rA2bqpr6FbBu5Q6xOFgH1kH/OxYgknFZYXi39PZYSOYitAY0gZTR5kmraX/f7
         0KUjFzMrDhaBw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221113181147.1626585-2-dario.binacchi@amarulasolutions.com>
References: <20221113181147.1626585-1-dario.binacchi@amarulasolutions.com> <20221113181147.1626585-2-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH v4 2/2] clk: ti: dra7-atl: don't allocate `parent_names' variable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        kernel test robot <lkp@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Miaoqian Lin <linmq006@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 17:02:39 -0800
User-Agent: alot/0.10
Message-Id: <20221123010241.14B70C433B5@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2022-11-13 10:11:47)
> The `parent_names' variable was freed also in case of kzalloc() error.
> Instead of modifying the code to perform a proper memory release, I
> decided to fix the bug by not allocating memory.
> Since only one parent name is referenced, it is not necessary to
> allocate this variable at runtime and therefore you can avoid calling
> the kzalloc() function. This simplifies the code (even calls to kfree
> can be removed) and improves the performance of the routine.
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> ---

Applied to clk-next
