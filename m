Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9565B071
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjABLVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjABLUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:20:24 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DEFF634D
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:20:23 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8B57040003;
        Mon,  2 Jan 2023 11:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672658421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MIRjjM9BazxN62f1abUsHSvG9e7+Ah1eYy4khCLuHOg=;
        b=KzhEF7BmXRUeMlpa6FFiqhgXvb/e4/K3nKxns1522ql8Lm9/GUejSgz55GJfcoaVsywjUy
        BhJ4J2RfrLH7nzXAqPPrthOoYTibPtPffArZlSWeh9GsD5duXdSQTOClHpeubY91j6NJx+
        ohFG6ulXgj2TQ3cXY/EqmwWf1CyjPbsBcS0W07lja8j174LjHYUvBad3KC2Ga8ReJmpvg9
        bm/FqErp6NL6XtUOkDsBDFkL/VronM0EbYrxQVRWEqIHv0Jlbf90ARFCvrEh9wPQlGIWyS
        Q1K2iMypPXihNYJ4Nqf4yOGtQ75SKcgW8XfIRyP6NitLvt7kfPwteSPueBPkDQ==
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
Subject: Re: [PATCH 2/7] mtd: rawnand: sunxi: Remove an unnecessary check
Date:   Mon,  2 Jan 2023 12:20:20 +0100
Message-Id: <20230102112020.250809-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229181526.53766-3-samuel@sholland.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'59186a402ab07d205428ee9f62ff0e95ecb06b63'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-12-29 at 18:15:21 UTC, Samuel Holland wrote:
> sunxi_nand->nsels cannot be zero, so the second check implies the first.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
