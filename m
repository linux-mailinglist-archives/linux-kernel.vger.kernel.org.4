Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFE7610099
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 20:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiJ0Sr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 14:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiJ0Sr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 14:47:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F85913E8B;
        Thu, 27 Oct 2022 11:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1DB162431;
        Thu, 27 Oct 2022 18:47:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065D9C433D6;
        Thu, 27 Oct 2022 18:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666896445;
        bh=GoCrn4imY1/B5eRyBLMzQqslmtbDVWoBPDbA+k1mJWU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AYTPDGyKf9/snaSrzOtDocU06QwBTPXxfQ9q0Y1Cg6p0U/c41cA1ve1cZxhOC+Z6b
         sdMjBOfCQZq51Z1CuNpvDef2drfCUHnlcnt01TDMQ7E6iAZ4KygHZ+J9XC/pNfyi2d
         QEuH0B+To/PqP3gxPAsic5l8tWWecwLAGUP8DBaSKLIx/Ck4P11msSZnk8VtI0WsGe
         c8pLxGwKpncUDHezO+yu0kOGsEctVkYktT4JE6fWZ60/Bx0IxoCSj00nvT78XpAzMx
         D5OrQd6JLA8lbGsSZHQIG6CQrEh6YxPu0AVcNvEAQp/yO8HSssUSmDw5u22Iw3U8Hq
         9+vWu57nz3jKw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221022133404.3832-2-romain.perier@gmail.com>
References: <20221022133404.3832-1-romain.perier@gmail.com> <20221022133404.3832-2-romain.perier@gmail.com>
Subject: Re: [PATCH v7 1/1] clk: mstar: msc313 cpupll clk driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Willy Tarreau <w@1wt.eu>
To:     Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Romain Perier <romain.perier@gmail.com>,
        linux-clk@vger.kernel.org
Date:   Thu, 27 Oct 2022 11:47:21 -0700
User-Agent: alot/0.10
Message-Id: <20221027184725.065D9C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Romain Perier (2022-10-22 06:34:04)
> From: Daniel Palmer <daniel@0x0f.com>
>=20
> Add a driver for the CPU pll/ARM pll/MIPS pll that is present
> in MStar SoCs.
>=20
> Currently there is no documentation for this block so it's possible
> this driver isn't entirely correct.
>=20
> Only tested on the version of this IP in the MStar/SigmaStar
> ARMv7 SoCs.
>=20
> Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> Co-developed-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> Signed-off-by: Romain Perier <romain.perier@gmail.com>
> ---

Applied to clk-next
