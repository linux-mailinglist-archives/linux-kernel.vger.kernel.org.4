Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B560A61F991
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbiKGQ0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbiKGQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:25:57 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1D927CF2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:22:25 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 592CC20014;
        Mon,  7 Nov 2022 16:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667838141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1voTN4LOSxnG5Yjl7R7hFiznO+MJNTPM5HgV+HO9Oc=;
        b=SglMUE/Y6qtcDNFpdlirWQm77GeroELPQgBDBkzaJRJTEIZ6ZH2G9lbmTE6XchNstJvMAV
        CtaD4o8VRma5ZaMZ1WDRhDMGCHf7+tn2M9CjEDt34d8EZfvBxG6kncFHPqKOx0dZP010Y0
        2TzksIXCiJsxPGu34hwtwA4O3LfoO3qr8A7AX29F2cGSGr34bp7Y7HYSf/U6SFh4cFAtL/
        HA+J5TKjzqFxXyhNBVjuwfdosWWJ3l/7zjiuWBUiL2g4RgKsCAYTyCGjTYChH8ST0btQq7
        QPqlcVkZQcCm4Qb0s/XpOFtkt0w11/CNyHegNBmgOz4nRM/UdfB+I2uafRBUNA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 06/11] mtd: remove lart flash driver
Date:   Mon,  7 Nov 2022 17:22:19 +0100
Message-Id: <20221107162219.49208-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221021155000.4108406-7-arnd@kernel.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a6c5f12b0df22574f8eb02b0159bc71ac66c1a64'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-10-21 at 15:49:36 UTC, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The sa1100 lart platform was removed, so its flash driver is
> no longer useful.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
