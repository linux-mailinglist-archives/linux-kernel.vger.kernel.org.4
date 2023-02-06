Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3168BC1F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBFLzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjBFLzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:55:20 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260CBF76B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:55:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DFE9224000A;
        Mon,  6 Feb 2023 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675684517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H7t8Uwdr1dUJSd52cm7PrFoTbxTBWVyGF5I8T/aNAD8=;
        b=S0xt4XCCUU+Bl0tfBnzQdpC9rGWP4Bilb8BHVsQScGNlc00ICg3W2OQQGadNy4PML2JImG
        n+v7MeRBXObu3B7NCJy4Y2mvOQ81maYs7Kgnic3io6kcWTZ46YYQ/526vFUBTzNgAD0fUg
        JzCgYXUNywRG2SENlg6PV/8vOevm8d4FMzf0XiomOycFlkXGzMMLq3Qm2jxH64gb3OnO0Q
        Fi+XvMEddM0eroxdnfcwDPjmlKmIDbkHxwc3/l2zxopUdB4mhiIqyX6AUztQcxkaOuBjj2
        KlE7FfbnM3gGnYfmqmJwlIbn6jftDsdVbDgnqEAXT58My05+36O3bO8Zc7ze4g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 3/3] mtd: rawnand: sunxi: Precompute the ECC_CTL register value
Date:   Mon,  6 Feb 2023 12:55:14 +0100
Message-Id: <20230206115514.560804-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230204143520.9682-4-samuel@sholland.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ef3e6327ff04af8527b3558e023e99f1cc241bce'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-02-04 at 14:35:20 UTC, Samuel Holland wrote:
> The value computed by this function never changes for a given chip.
> Compute the whole register value once up front, instead of every time
> the ECC engine is enabled.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
