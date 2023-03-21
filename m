Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD85F6C3ED2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjCUXxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjCUXxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:53:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E455983A;
        Tue, 21 Mar 2023 16:53:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7462161EE8;
        Tue, 21 Mar 2023 23:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBAFC433D2;
        Tue, 21 Mar 2023 23:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679442817;
        bh=rTkIDlZDYR/2kX3f6rymIvV6hfQapwWQG2X/uBm7rxk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vLWZz7w3/mYCVMG0q/Wred8e0NiZIwk/PgPk6c+uZa83S4wYRY90azgR72ruNOHEj
         fkHegHO6J5/K4atkdDKSmQGFV3UnFsgKKk7HF1TO/jwVTTo/AEfgCP5xRyZugAbICf
         DbSBsCjGidwe/6Xm4vYqfzWA/SJWHI1y0UzrETxKTd8hXMzSiUmTxRSU/HJ1vTDh2b
         jvcHcmSWUyWI/zF/Qhzg1MvZD6uZHNVM6Qo9DNK9zgZMbmzKRBccWMZe4sQfl0Wk99
         tNyOOM7K9xNrbTmysBFhaWODk7+qjo8g3ooCcheeopZTbWnAbCoABOSGtDziianEw2
         t0oiCwni4Wl2A==
Message-ID: <4c6fe977531b069d11554a252589a2a3.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221209152913.1335068-5-marpagan@redhat.com>
References: <20221209152913.1335068-1-marpagan@redhat.com> <20221209152913.1335068-5-marpagan@redhat.com>
Subject: Re: [PATCH 4/6] clk: socfpga: arria10: use of_clk_add_hw_provider and improve error handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Marco Pagani <marpagan@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Tue, 21 Mar 2023 16:53:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Marco Pagani (2022-12-09 07:29:11)
> The function of_clk_add_provider() has been deprecated, so use its
> suggested replacement of_clk_add_hw_provider() instead.
>=20
> Since of_clk_add_hw_provider() can fail, like of_clk_add_provider(),
> check its return value and do the error handling.
>=20
> The indentation of the init function parameters has been aligned
> to match open parenthesis as suggested by checkpatch.
>=20
> Signed-off-by: Marco Pagani <marpagan@redhat.com>
> ---

Applied to clk-next
