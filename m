Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED345BD1F7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiISQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiISQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:15:59 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1412983A;
        Mon, 19 Sep 2022 09:15:55 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 45FA924000B;
        Mon, 19 Sep 2022 16:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663604154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N53lFuTivYC5vBnMbOqNikz5xNoHZbhEvLvTfGv0G/w=;
        b=S9POnKx+YNyZpCByZ5G/S08K5baSM3a17yJEk/rkmg5LJqGCOWUE8kb5ZZDDSil9mA+Oj6
        YBU5SklxuvTR0KLDp274SvrYLV0n5FKPfdUPC/gvptwqlKBz5mdYaLgn9LGch77xaA7OIA
        8SroGnVhtyPYLgI1YDW3ddVb7Ovk4X/JkjkYEz6nVTZ8gm9/c+lxDhdNaAQRnl+nuCLHk4
        8VfSujnctuZiVMKKfvdJ+r7OtVMR+sQS0VMS8s9ffQ10QjE907p7+V5XWh/n8YBE12cxif
        R4ABVY5Z6A+HDXWnKRXtDQ1cQDUpDIc2ptlgJ39onBzkmK2FWiqOhArDpGFdjA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: Fix a typo in a comment
Date:   Mon, 19 Sep 2022 18:15:52 +0200
Message-Id: <20220919161552.226510-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <de1b1134f056ea7563bb0a9bb2f66ede1475728d.1659816434.git.christophe.jaillet@wanadoo.fr>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'8d704c4e1ead92b6185d6aedeb08ac6a85c4a42a'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-08-06 at 20:07:22 UTC, Christophe JAILLET wrote:
> o and t are swapped.
> s/mtdpsotre/mtdpstore/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
