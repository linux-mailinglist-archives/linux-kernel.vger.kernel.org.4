Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3AAD66641E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235423AbjAKTw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238445AbjAKTwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:52:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0064318C;
        Wed, 11 Jan 2023 11:50:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E8EE461E06;
        Wed, 11 Jan 2023 19:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54557C433EF;
        Wed, 11 Jan 2023 19:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673466627;
        bh=1rnb9bDgHwGMTz5A20UrPy/V5pD9T4YnbPxjYPkWHAI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i5ZNYw3Ebh8thAcUTckqN52yigjE+h6oq6/G88H0UhzaOGUKGN5vdA+EF5g5rL7pj
         loRFg/dW095QC7jUpNadqR8MmrXJolYcycA8Kx//51alA7FoceRUaBrRzh5GlseZlX
         lMOqovMN7GdRjCpbHrKPJfnsP5FMmKGEpQQVDn72iVhpk2sE3zK1Y74CHA59zHZhuH
         ovS+jC6zQ+K9TgQid6EsDsPw1xUojE9k9Hk1yJzSij/KfyTnCDKhQJ4GbjqHLVl/RH
         5qBP1zMIfMmf+rTAE7gCglvlgDCy0L7q8bf/1dmfoN2eDSTqZtS4U+QJkVGBLtGIpr
         Ika4JJdwRndUw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 011FB5C0920; Wed, 11 Jan 2023 11:50:26 -0800 (PST)
Date:   Wed, 11 Jan 2023 11:50:26 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH rcu 09/27] drivers/clk: Remove "select SRCU"
Message-ID: <20230111195026.GY4028633@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230105003813.1770367-9-paulmck@kernel.org>
 <c59b64de02161ceeed11b43230cd46d0.sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c59b64de02161ceeed11b43230cd46d0.sboyd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 11:37:15AM -0800, Stephen Boyd wrote:
> Quoting Paul E. McKenney (2023-01-04 16:37:55)
> > Now that the SRCU Kconfig option is unconditionally selected, there is
> > no longer any point in selecting it.  Therefore, remove the "select SRCU"
> > Kconfig statements.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: <linux-clk@vger.kernel.org>
> > ---
> 
> Applied to clk-next

Thank you!  I will drop it from my tree on my next rebase.

							Thanx, Paul
