Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16A26278C6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbiKNJLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236192AbiKNJLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:11:48 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54165DA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 01:11:45 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E39A920005;
        Mon, 14 Nov 2022 09:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668417104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oefpXQZ78GLAz1anvLhttjOAXOHcfMpJNoz4KuWwVco=;
        b=FrU2LK/9bUSuSobXoWO5LUBNUAQgXIVHXvVe9LmiuYaQMk56k39iKg5NYqyroJXGPeyQDT
        UNVDH+z+P1BtPpD++MnFW8LvzB2bTIMCQWQm6qqj5yFmTvE+Su4ZRgN8MdK6/3sOVUQH3M
        4xkvCx8sAV8K/MAGX1gJguMYsiuT9pSFJWTek3xjK66EW1YK8J41Wt2FLbxR+N0E9/8vCl
        BdMcgcR1MhBSysrAkcZIlKg8AUBrmZjba5D/m1hkrbR1uG+F+zlXdLCMYOg6R1ARRKiFcD
        OhfhmNBYYYzdrmJyZ9s91m92bh5GxY9TvRK/uvxjA3KYudQrJ+OmZr4nbpsIyw==
Date:   Mon, 14 Nov 2022 10:11:40 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <pratyush@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] mtd: Fixes for v6.1-rc6
Message-ID: <20221114101140.339e0d2e@xps-13>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is another small fixes PR for the next 6.1-rc cycle.

Thanks,
Miqu=C3=A8l

The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:

  Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixe=
s-for-6.1-rc6

for you to fetch changes up to c717b9b7d6de9e024e47f7cd5bbff49f581d3db9:

  mtd: onenand: omap2: add dependency on GPMC (2022-11-07 16:53:04 +0100)

----------------------------------------------------------------
Raw NAND fixes:
* Placate "$VARIABLE is used uninitialized" warnings
* omap2: Add missing dependency on GPMC
* qcom: Handle ret from parse with codeword_fixup

----------------------------------------------------------------
Adam Borowski (1):
      mtd: rawnand: placate "$VARIABLE is used uninitialized" warnings

Christian Marangi (1):
      mtd: rawnand: qcom: handle ret from parse with codeword_fixup

Krzysztof Kozlowski (1):
      mtd: onenand: omap2: add dependency on GPMC

 drivers/mtd/nand/onenand/Kconfig  |  1 +
 drivers/mtd/nand/raw/nand_base.c  |  4 ++--
 drivers/mtd/nand/raw/qcom_nandc.c | 12 +++++++-----
 3 files changed, 10 insertions(+), 7 deletions(-)
