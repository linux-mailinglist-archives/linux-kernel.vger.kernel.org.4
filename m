Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A946965B074
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232715AbjABLVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbjABLUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:20:35 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AAC6358
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 03:20:33 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0D069FF802;
        Mon,  2 Jan 2023 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1672658432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RMrkLl1cpHLTK+wPSAXDpqqVjmnjzWcaxPTe6/swFkQ=;
        b=pSUl1g3BBFSzHxhMfqAUhoei2ua3N2Dvze8+voGt8N06QMh/ihHOdLjFlvja04vUnr0omt
        s0ubKoQGOR9MB3acxFTBE+yWb+mDNpiNzm87staDQ/SynyUyJFICvUqqbTPK0P7LpTtHNM
        8hkJaRoDEdyyHRt3nc0MQQuM1NO8Q4AlQgmzBIvUUicMaZ9PWN04XnWhOpBBLIOLZNgeGU
        ci1aCq0xiqj0RJ+5Elu5hWgvSxRWmJEfLm/ZKKNRVelBFmeO0XBX++N7XAgxQNQsc752LQ
        ElglzPrSIttc1xXmZKSIchxTX3BzZNaN0Fe8XgBRU/lxrL21997WwOPF5Aaf2Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Aviram Dali <aviramd@marvell.com>
Subject: Re: [PATCH v2] mtd: rawnand: marvell: add missing layouts
Date:   Mon,  2 Jan 2023 12:20:29 +0100
Message-Id: <20230102112029.250891-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221216162715.3230766-1-vadym.kochan@plvision.eu>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'68c18dae68881054ed5426c00f0ed351b1db9bc0'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-12-16 at 16:27:15 UTC, Vadym Kochan wrote:
> From: Aviram Dali <aviramd@marvell.com>
> 
> A missing layouts were added to the driver to support NAND flashes
> with ECC layouts of 12 or 16 with page sized of 2048, 4096 or 8192.
> 
> Usually theses are rare layouts, but in Marvell AC5 driver, the ECC
> level is set according to the spare area, so we may use these layouts
> more frequently.
> 
> Signed-off-by: Aviram Dali <aviramd@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
