Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E5634C01
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 02:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235414AbiKWBEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 20:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbiKWBEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 20:04:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07378DAD03;
        Tue, 22 Nov 2022 17:04:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92F3161962;
        Wed, 23 Nov 2022 01:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2919C433B5;
        Wed, 23 Nov 2022 01:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669165469;
        bh=zKr0vysxg9hT9r8cIAZlZ3wtj9YOLwV9ca4LqEGGFHA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SXzHzOsCR/cM1pbBcol3RCpiqp9uk9FeeGlJ7XFQMELri/UY2ZCMV3Ysc5B1Docol
         JmeAGMllk1a+vWlIlsBsaQXFfCYEaOFlW8yPPP4EiTUKB1eRJ6YDF9DcxfEHbnqvVl
         IBJkwtZpKztNBpoubYm7gLLG5UBu1TH5oJ2cyLq/dTwMc9VxHX8XNGWXcOJOjK5e3g
         /8dVcWyQAhNh2XvmOKJU3Q2YMQGU7VCa1zOCAHUzVm3P1p0C2cAxsbQ0NAvnnPH5GL
         XRQoYG3g89bbgD0p7f22TBiz3zO3dRAHIyNSqhBG3HxTV2ev1PMgJaqW5qJEYSRksV
         HVgENrpjztW2A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221106155625.3476564-1-dario.binacchi@amarulasolutions.com>
References: <20221106155625.3476564-1-dario.binacchi@amarulasolutions.com>
Subject: Re: [PATCH] clk: ti: fix typo in ti_clk_retry_init() code comment
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liang He <windhl@126.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <kristo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Nov 2022 17:04:26 -0800
User-Agent: alot/0.10
Message-Id: <20221123010428.E2919C433B5@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dario Binacchi (2022-11-06 07:56:25)
> Replace "not" with "node".
>=20
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---

Applied to clk-next
