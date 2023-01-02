Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E2365B06F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjABLU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjABLUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:20:20 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6766359
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:20:18 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E4567240009;
        Mon,  2 Jan 2023 11:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672658417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cHX8Aqnc2BeWf4Socc5lhFPPs1ftUXPoV0NGTjWgg/A=;
        b=ogtyDxur2TztkFZttad/c6NxZB09n/9LG5EgyyOPdMjmVgu79W45Z+6y6d0Cgvrj2c2pJ1
        AB2DSxgTvo+CAxECBvc7b0GeioGAb6iDYjY/jdqjwhWaZ2grU6fxdrYHtBgClj04WsKDIW
        HFRd7vz/bm2HwhBWLx2shmvCak6ew50ZMfxrrY/2sezIFeGrOpH0eMjEJyhUlcwT0KtBl+
        4AwWLY72ta9nj6Kl04BsAMyLiQvmVkI98C+HWhOzozmdZloGq1YBJM0d88yh42nN9epEU2
        2vqUiTcBtFFWkncuX6jEUCh/R9QbUYZ2nc1B/JOzrLRNvVmOZu2Qf3noOfIVig==
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
Subject: Re: [PATCH 3/7] mtd: rawnand: sunxi: Remove an unnecessary check
Date:   Mon,  2 Jan 2023 12:20:15 +0100
Message-Id: <20230102112015.250755-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229181526.53766-4-samuel@sholland.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'85e8177e581964a727410c781410f626e1cb4c25'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-29 at 18:15:22 UTC, Samuel Holland wrote:
> Each chip is required to have a unique CS number ("reg" property) in the
> range 0-7, so there is no need to separately count the number of chips.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
