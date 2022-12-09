Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AC44647B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 02:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLIBMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 20:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLIBMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 20:12:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A9B80A0E;
        Thu,  8 Dec 2022 17:12:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A8D406203F;
        Fri,  9 Dec 2022 01:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F9FC433F2;
        Fri,  9 Dec 2022 01:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670548342;
        bh=Q37W1vLJUGba/GKJcAqRPtnLC0ooux4QhJ6D99IJvhs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZI661ixsVRMEo2OEh2JptvfA43/sySTL9PIV5OGjqqz8AXWluQyKtbzcL7VzvqpA6
         tDzRF+77RWwnHY1u2wgaGEAze1zzKKeVs/I+dPCp6t8UU/uEUnkuCMVEE6aRwU6YnQ
         mLnNQxauxZhpj817bP0+qn9KlAzxQRNWqW95ZkGuKPiUVpuqoE0jxJqsz7hxxDxKFg
         DhGyx1E5dviHdq1EW9Ct5XCg/6U0sHJ5sOQhksFy9Y98gAa0m1/QhibqTW5q6E5oGG
         YwgUuAMVlJ171/Y8Bf925ON8M1wRd3QC/eyUBtWXiXdgMIzisI8pIR04JBNF8Ho0xP
         gQgjYVhBy15tQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221123161921.81195-1-conor@kernel.org>
References: <20221123161921.81195-1-conor@kernel.org>
Subject: Re: [PATCH] clk: microchip: enable the MPFS clk driver by default if SOC_MICROCHIP_POLARFIRE
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        Conor Dooley <conor@kernel.org>
Date:   Thu, 08 Dec 2022 17:12:19 -0800
User-Agent: alot/0.10
Message-Id: <20221209011222.04F9FC433F2@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Conor Dooley (2022-11-23 08:19:22)
> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> With the intent of removing driver selects from Kconfig.socs in
> arch/riscv, essential drivers that were being selected there could
> instead by enabled by defaulting them to the value of the SoC's Kconfig
> symbol.
>=20
> Do so here & drop the depend on RISC-V - the SOC_ symbols are only
> defined there anyway.
>=20
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---

Applied to clk-next
