Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03369646378
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 22:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiLGVtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 16:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGVso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 16:48:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC6E813B1;
        Wed,  7 Dec 2022 13:48:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B7C061CC4;
        Wed,  7 Dec 2022 21:48:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC6AC433D6;
        Wed,  7 Dec 2022 21:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670449720;
        bh=ULWxfLSTv9BMiUOBQ4C3zaBn/OG4o+f8awG2LrQP/iw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Sgub788eUwwubMmUBOaC8aPZpb/BLj6Gsmj2A9kiUJ+O60CKsS0ddAe4geavuNCNj
         g3wHDzRjIoyWaAgaEOC5K7j4EG4qg1BE4dnhiIF8dZwLJCACCha6dGGBPk+HHbeUVk
         ATc3Rlw069XJ+8OLcB9cSQ7lH57SWRyYYrR5C/SSbsU3LlRTdy/vL3MNfqUQMRkt7i
         9ZDfjlyzM3YOdXIs4g0BN3CcZSD16NFUTuo07EzT9Mq1XNgiOza3N2h9TN8nVjj6H3
         b1q39zgBdTOzBVIUEB8GKEymvxu16P2a730JEOY31HwukpvQY7JQYzMtCJL8DXHPlf
         iW5ELQD8U9qWw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221018-clk-rate-request-tracing-v2-1-5170b363c413@cerno.tech>
References: <20221018-clk-rate-request-tracing-v2-0-5170b363c413@cerno.tech> <20221018-clk-rate-request-tracing-v2-1-5170b363c413@cerno.tech>
Subject: Re: [PATCH v2 1/2] clk: Store clk_core for clk_rate_request
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Maxime Ripard <maxime@cerno.tech>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Steven Rostedt <rostedt@goodmis.org>, maxime@cerno.tech
Date:   Wed, 07 Dec 2022 13:48:38 -0800
User-Agent: alot/0.10
Message-Id: <20221207214840.AFC6AC433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting maxime@cerno.tech (2022-10-26 06:46:58)
> The struct clk_rate_request is meant to store the context around a rate
> request such as the parent, boundaries, and so on.
>=20
> However, it doesn't store the clock the rate request is submitted to,
> which makes debugging difficult.
>=20
> Let's add a pointer to the relevant clk_core instance in order to
> improve the debugging of rate requests in a subsequent patch.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied to clk-next
