Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE47B6AF5CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjCGTgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjCGTgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:36:15 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3820D5DEC6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:23:12 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 15D40FF802;
        Tue,  7 Mar 2023 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678216991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BXOAdv3ZY1yqGvfT92jz/aIBRhNnHINlK7UC1NP5j4=;
        b=A8HDzBU4gWP65Mhb6DRDKH2HbXtHuinWkc/yI0gGFkZtjK/TDfkBWremqkgHUPrhr5Imvd
        YsEniQwg98YBSVZPLXOunq9dACVbWGLhsrsxIfuzz02AOakxTEXggwhtF8JG8gIOtT2ViY
        gxaElNaqxxGafaqpqohdl1sypnDqmaMdnkPIRPSAfAq76hdN3moBPum7azZrTQJMWUCDV4
        mBmcS5igjZv/wCcNgAwKAtnXb8KkL4FP8TG5KGi2wTAdWU0Xrjk0GypdFqpqnRv+RSFXT8
        6aQ26t8pxl3S3R1OO7GxZY69Sv7ay6CFIfYNUh7axwEG2CxuqyaeNplPl33sdg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mtd: core: prepare mtd_otp_nvmem_add() to handle -EPROBE_DEFER
Date:   Tue,  7 Mar 2023 20:23:07 +0100
Message-Id: <20230307192307.353572-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230306125805.678668-4-michael@walle.cc>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2e9d68641030c280f2132036d0fb089255e3862f'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-03-06 at 12:58:05 UTC, Michael Walle wrote:
> NVMEM soon will get the ability for nvmem layouts and these might
> not be ready when nvmem_register() is called and thus it might
> return -EPROBE_DEFER. Don't print the error message in this case.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
