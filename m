Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C165B070
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbjABLUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:20:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjABLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:20:15 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87E25FD3
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:20:14 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5E606100008;
        Mon,  2 Jan 2023 11:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672658412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N7TQ4TvrTvrJPMfHspAvP+gisAsh/2xMjTMPVTSfd7U=;
        b=IdbGqCCJh4+VvT6tHQLRj9e/YC+ZXKojvE2Hei/lKu7Wakc7tNGPzaWamWIyp+Ym2WX5yu
        7wWAUS+cnZOf4POflsF6JRcBV0t9jAuBbbf5DR5kXKOrq/GtxFe0wVfvoVmlBVSWi833wk
        A3IAvO+40CR7fpb+qxnC8/YpRNjqKPrahR2wNB2Xnv7BXDDoIAbjkQn53H4GRVt2tT4Rz6
        MU93kYJbD2xd71FBWM81CpCX/x9qn8YG1sAu2fy+IH4nzReNORyvOHcwG9irWhUcEm2hBR
        VeGgNAs5a3IGMyZmtNPl6pvjiJBFOpldZVS0p0RNCy54jcODnhJ/W4C9CbsbKQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Brian Norris <computersforpeace@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 5/7] mtd: rawnand: sunxi: Fix the size of the last OOB region
Date:   Mon,  2 Jan 2023 12:20:08 +0100
Message-Id: <20230102112008.250724-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229181526.53766-6-samuel@sholland.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'34569d869532b54d6e360d224a0254dcdd6a1785'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-29 at 18:15:24 UTC, Samuel Holland wrote:
> The previous code assigned to the wrong structure member.
> 
> Fixes: c66811e6d350 ("mtd: nand: sunxi: switch to mtd_ooblayout_ops")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Acked-By: Dhruva Gole <d-gole@ti.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
