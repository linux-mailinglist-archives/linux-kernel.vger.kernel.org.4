Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7103A65B072
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjABLVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjABLU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:20:29 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F566360
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:20:28 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 00283100008;
        Mon,  2 Jan 2023 11:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672658426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYSHMB3px/jIzZ5HFen7sFam2xnxq7pikzKYVodSq3I=;
        b=arMLhacMCERN07gJ4h8Jn5h+tcPOuaa42Z5egJCgu6quaZjj0eCSo+R41K9GO8dNjRdmA5
        64GjjjbRnK+MMNs/+1PpFzTZA4Wdw9M7KiIxOop7LXlQVzRQdvnrweeu6Iq8lCyMTY0QYx
        OfT6LtFt7D9BtOvqXK63VVrnzwjBeqf4N1J+fMGvb3DdYjgUDrGu61EZ/raHERXv711C4l
        j2Y9ivSMFXbmbvJ0gOgCjmLk9jrvutwaV/bKNOulRONkyxntqNaQimAU7M9cYqoDYquJGw
        0e0bdmShLnRUpB1oTxXinNfhlW65902JWaAIlTq1XbmJGpuDgY1ryBWadgGs7w==
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
Subject: Re: [PATCH 1/7] mtd: rawnand: sunxi: Clean up chips after failed init
Date:   Mon,  2 Jan 2023 12:20:24 +0100
Message-Id: <20230102112024.250862-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229181526.53766-2-samuel@sholland.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6d7fea226b238b95d69faba49b8faf73d6e8c469'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-29 at 18:15:20 UTC, Samuel Holland wrote:
> If a chip fails to initialize, we need to clean up any chips that were
> already initialized/registered.
> 
> Fixes: 1fef62c1423b ("mtd: nand: add sunxi NAND flash controller support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
