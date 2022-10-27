Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA460ED3D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 03:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiJ0BFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 21:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbiJ0BFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 21:05:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED9838694;
        Wed, 26 Oct 2022 18:05:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21EBC620F8;
        Thu, 27 Oct 2022 01:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB29C433C1;
        Thu, 27 Oct 2022 01:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666832707;
        bh=+Ez6WYsZqAn0lFGyPn93VnnIIVFNJD0XEuX7LXud3cE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iFrmBz3httCqrIx0lE6e101vtRv16cTLD8oEUDv0F952mlDhMZPYF99WlOJpwb6x1
         lJMj36WoRTdb1pZIEF6r1N7UJyOQ5a4gQN7nsQfypK4/8dVGCUBg4t1xVgLc6kCVEv
         XVYHFyzvs4aW3THyOsF19NOWchIS9efHqSnJGfHdm34rcQsOMEBm4arGDjkimXrKqE
         nMxMMnnU4bpIyYmrmNLLAv0Scgl8vdN3Sb3ZYg1Pw4JGJW4v3kjTRvLVWA07r5qvht
         shNDxt5vIZ6TXq/QjWhNrlNaDseGfQcu7J8XjE+I/9D2TBqoa3em4CBWwjXAjVjIkF
         GRHRGXGMue+pw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <49e339d4739e4ae4c92b00c1b2918af0755d4122.1666695221.git.rtanwar@maxlinear.com>
References: <cover.1666695221.git.rtanwar@maxlinear.com> <49e339d4739e4ae4c92b00c1b2918af0755d4122.1666695221.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH 1/1] clk: mxl: Fix smatch static checker warning
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, dan.carpenter@oracle.com,
        linux-clk@vger.kernel.org, yzhu@maxlinear.com
Date:   Wed, 26 Oct 2022 18:05:05 -0700
User-Agent: alot/0.10
Message-Id: <20221027010507.6DB29C433C1@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-10-25 04:03:57)
> Commit 036177310bac: ("clk: mxl: Switch from direct readl/writel based IO=
 to
> regmap based IO") introduced code resulting in below warning issued by the
> smatch static checker.
>=20
>         drivers/clk/x86/clk-lgm.c:441 lgm_cgu_probe()
>         warn: passing zero to 'PTR_ERR'
>=20
> Fix the warning by replacing incorrect IS_ERR_OR_NULL() with IS_ERR().
>=20
> Fixes: 036177310bac: ("clk: mxl: Switch from direct readl/writel based IO=
 to
> regmap based IO")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---

Applied to clk-next

BTW, please don't send a cover letter for single patches.
