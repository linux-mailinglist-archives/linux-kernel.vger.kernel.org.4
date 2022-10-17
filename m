Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90469601C6B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 00:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiJQWaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 18:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiJQW3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 18:29:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13FDF29;
        Mon, 17 Oct 2022 15:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C9F3B81B36;
        Mon, 17 Oct 2022 22:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D51C433D7;
        Mon, 17 Oct 2022 22:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666045749;
        bh=k7MLUjceCFWiLok658ldq37/tAw0aML4ER0Pm1Q0SNg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZIv+zDO258AM0sK3Ogqd/emWlIJ9ZHxWfWfUAy4IDvPQZFzAI5tsmxWsPS/Rhz8lj
         HMu3oxZaic5Z/2g6tpoLKw7ou+2DafNTHkODlZSZgDRe3b75OkPiMyRwmbybq7TKA5
         NM8yZfhqZX3R7v/XCaFRQBxd51U0xVX734abys+wAVccL2ic1Q0wVs6t7Ebe3oMFKc
         ilqIPLtbBY8Lxl6c8vH66NnmB2ac67WVBsgNeoNE2YMoOjznNawIgGZNcgE2UDvNZT
         2Gz/nFsTe3+AvGjpPNwt0EFh64Ks/ue3BsQAE0K2XexkF4Ai574IM40UXEM/aeqto2
         Lj3Kvq3DU1Csw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a4770e7225f8a0c03c8ab2ba80434a4e8e9afb17.1665642720.git.rtanwar@maxlinear.com>
References: <cover.1665642720.git.rtanwar@maxlinear.com> <a4770e7225f8a0c03c8ab2ba80434a4e8e9afb17.1665642720.git.rtanwar@maxlinear.com>
Subject: Re: [PATCH v4 4/4] clk: mxl: Fix a clk entry by adding relevant flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-lgm-soc@maxlinear.com,
        Rahul Tanwar <rtanwar@maxlinear.com>
To:     Rahul Tanwar <rtanwar@maxlinear.com>, linux-clk@vger.kernel.org,
        mturquette@baylibre.com, yzhu@maxlinear.com
Date:   Mon, 17 Oct 2022 15:29:07 -0700
User-Agent: alot/0.10
Message-Id: <20221017222909.A1D51C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rahul Tanwar (2022-10-12 23:48:33)
> One of the clock entry "dcl" clk has some HW limitations. One is that
> its rate can only by changed by changing its parent clk's rate & two
> is that HW does not support enable/disable for this clk.
>=20
> Handle above two limitations by adding relevant flags. Add standard
> flag CLK_SET_RATE_PARENT to handle rate change and add driver internal
> flag DIV_CLK_NO_MASK to handle enable/disable.
>=20
> Fixes: d058fd9e8984c ("clk: intel: Add CGU clock driver for a new SoC")
> Reviewed-by: Yi xin Zhu <yzhu@maxlinear.com>
> Signed-off-by: Rahul Tanwar <rtanwar@maxlinear.com>
> ---

Applied to clk-next
