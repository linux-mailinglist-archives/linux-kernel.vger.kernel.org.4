Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2235BD1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiISQQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiISQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:16:06 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB24530F57;
        Mon, 19 Sep 2022 09:16:02 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 621D71BF20A;
        Mon, 19 Sep 2022 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663604160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELi8T3Bhx5dSgWmHSngNXxOBCBGwDJCNnx9M4Rl2f9Q=;
        b=O1rc2hGHDRLJrmRNwetsfc7aOSS6r4gVAKXAW28Qkx4K77Lse+n7plCIyITsQIBSomKM+j
        isttim8nbNqBPH2FtsMQD3e4sf5Js6nThNYqIAboqNhxOYAd6PVtgEdOOVciqK4kFenQpQ
        LwCXN6cFXR2JLKV9iaIu/5eoeraqcGZ2YkLDDhZVq85F7uFMDEzLTV6Gh/S+DboBBmuV73
        XMO+daKFPfY1A2PI9JFvaiZP6hHxKPSwdI/aWFw5C8oxHDqBJ3jx4X2xyIk3SEnQsmKvm5
        KarMLFyiayGJ8F462SyLGPAbTjdPTy8qw3w4dgf4vKat+OseOumeLaFe6VNY3g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Colin Ian King <colin.i.king@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: devices: docg3: Use correct function names in comment blocks
Date:   Mon, 19 Sep 2022 18:15:58 +0200
Message-Id: <20220919161558.226540-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220805175423.2374939-1-colin.i.king@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f535ca406f5400be33b9498ea8a07ffa9e744133'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-05 at 17:54:23 UTC, Colin Ian King wrote:
> The incorrect function name is being used in the comment for functions
> doc_set_reliable_mode, doc_read_seek and docg3_probe. Correct these
> comments.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
