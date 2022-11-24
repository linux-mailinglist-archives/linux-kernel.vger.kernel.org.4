Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28966377C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiKXLgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiKXLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:36:29 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD798247
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:36:24 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B68B6240005;
        Thu, 24 Nov 2022 11:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669289783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dlPpfwv5MuQW45pcS0uu+R0L1quqqE+gBARVAIRWeM=;
        b=Lr+6i/ijdZTrRYPqSGANWslXGoVmbDeHdZJEHNuz9QCjdqJYg52gugPWQwOKzNggHDrq9d
        76lR//CUofJxzdCMy8OtP8SneGofkHJI7dneqQDR6Rxs1Oa4ytGgRaP6GUSEzX7rGUlpo1
        hJH4cG8vKmMXOdD3atGhkz+xUsvky6E68Vejx7Pj1ge3FIO2SNlsnvjTZNRHvAxWZisN81
        klOCoZoHg+4q/L5BPYT9XO5QNAhw3Qkkcj0sacOTkgVyNpoEKza2XQ/YCWKPCsh5Q355Az
        DsLJU8IOPEjU/qsdmiSq2BSUKVr1OF21b48FqkoKXrREZ5Oy7ErZ4rl0rumAtA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jean Delvare <jdelvare@suse.de>, linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: onenand: omap2: Drop obsolete dependency on COMPILE_TEST
Date:   Thu, 24 Nov 2022 12:36:20 +0100
Message-Id: <20221124113620.266344-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221122202957.5748c6ce@endymion.delvare>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'b46ff0780f1760a64b9dfdd2dc8f76bfe0c7c820'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-22 at 19:29:57 UTC, Jean Delvare wrote:
> Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> is possible to test-build any driver which depends on OF on any
> architecture by explicitly selecting OF. Therefore depending on
> COMPILE_TEST as an alternative is no longer needed.
> 
> It is actually better to always build such drivers with OF enabled,
> so that the test builds are closer to how each driver will actually be
> built on its intended target. Building them without OF may not test
> much as the compiler will optimize out potentially large parts of the
> code. In the worst case, this could even pop false positive warnings.
> Dropping COMPILE_TEST here improves the quality of our testing and
> avoids wasting time on non-existent issues.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
