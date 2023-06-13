Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B935C72D6C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjFMBNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjFMBNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:13:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DA2A0;
        Mon, 12 Jun 2023 18:13:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97D406301F;
        Tue, 13 Jun 2023 01:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC162C4339B;
        Tue, 13 Jun 2023 01:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686618793;
        bh=gmymbzHrclsljsrpfO7Q/CbjPvQelDe6/g5madNgpDw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=lOgMuJIJDpYz8zYDUwBofEtANK4cUJ5n3jyErIPXP24XiN+DMPUFEfLhRPQL8SvRe
         WvNGnjsBzfQEKOuFwXbGiNE2X6NtX/gU9gdhajeXDAHQVLxUhSDhBI6fO/V1rANCNB
         9vyxzn05pioC9DSFPDC0dFfiZTAzcTM+mC8EnfwltkjbxCmOnNszmDjjYku6X1lsNq
         AZfmDQvIQhOvFO3o0d7ItiMHQaVXrXKEAVfVscAeZMUgqY/ifS143i27ZWfxyqTa1p
         /JAioEaGqcdoxSBxQ/81vqZDIQVujBtHH8e/grmPivWPbjLxk7j97W6i3eHxvUqT3I
         yH6L2SOIG1pWQ==
Message-ID: <4e4327afb0c71ae299e6aaaa3dffd4f9.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230511133226.913600-1-msp@baylibre.com>
References: <20230511133226.913600-1-msp@baylibre.com>
Subject: Re: [PATCH] clk: mediatek: mt8365: Fix inverted topclk operations
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 12 Jun 2023 18:13:10 -0700
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

Quoting Markus Schneider-Pargmann (2023-05-11 06:32:26)
> The given operations are inverted for the wrong registers which makes
> multiple of the mt8365 hardware units unusable. In my setup at least usb
> did not work.
>=20
> Fixed by swapping the operations with the inverted ones.
>=20
> Reported-by: Alexandre Mergnat <amergnat@baylibre.com>

Checkpatch complains now that there isn't a Closes: tag here.

> Fixes: 905b7430d3cc ("clk: mediatek: mt8365: Convert simple_gate to mtk_g=
ate clocks")
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Applied to clk-fixes
