Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349D462E69A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240414AbiKQVPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:15:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234931AbiKQVOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:14:55 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7585679929;
        Thu, 17 Nov 2022 13:14:53 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C84FC2000A;
        Thu, 17 Nov 2022 21:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rjOO3HF8VOCT1YGIpGxFB5wFLfZ4kG/wIlQ/PZ/PcF8=;
        b=cNhO9dAyxWPayRx6Cf0hiFc292apajC3QttlCKG7KjYAhsq1gjvmnzUU3vnqNIYUZ0qoK5
        15bmJAFb/2ti7C22iW/ywJeybCLQ7cykGGM426BcFgb+oEDTdbyiRpX4CdcYP6Gp95hIrH
        wVb8BW21F08+9Q0+Js1bXY54FWDkjzcv+1sriMTi1GmmKy6J42niz9I/AQT5biOI+R5SjT
        PH1sm5qreL9j51hdlgeLdBMzcGmi96U59Y6b0mxcVGJ7EN+XsEzGEjOXf+LbsuTLes3w7u
        aACOvqJz4oW4WJ3bc3NRUQhsyPLTHL4IGOMP+vcesEQkRc+EpO4Z2Hw+/pCHiw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: refer to ARCH_BCMBCA instead of ARCH_BCM4908
Date:   Thu, 17 Nov 2022 22:14:49 +0100
Message-Id: <20221117211449.1273138-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116124932.4748-1-lukas.bulwahn@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'085679b15b5af65f9610f619afde41da0f966194'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-11-16 at 12:49:32 UTC, Lukas Bulwahn wrote:
> Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
> removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.
> 
> Probably due to concurrent development, commit 002181f5b150 ("mtd: parsers:
> add Broadcom's U-Boot parser") introduces 'Broadcom's U-Boot partition
> parser' that depends on ARCH_BCM4908, but this use was not visible during
> the config refactoring from the commit above. Hence, these two changes
> create a reference to a non-existing config symbol.
> 
> Adjust the MTD_BRCM_U_BOOT definition to refer to ARCH_BCMBCA instead of
> ARCH_BCM4908 to remove the reference to the non-existing config symbol
> ARCH_BCM4908.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
