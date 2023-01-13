Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75EBB669E57
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjAMQj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjAMQjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:39:16 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4726A80AD3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:36:51 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 10CAA24000A;
        Fri, 13 Jan 2023 16:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673627809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kxSZeKeBriIYACw5fqkc+RWacxKu1wFr7laq9sROnMY=;
        b=EeDLDPZj6etJ1tCHdG9UAZ1Ez6DRGKDwrHQZRHiJcpCP+uKsWl6JpAAve2+dkVkpkPmSA/
        H43+gLqEVFRkQ58WBPUj7jS2dlRvymV6MMPqzFlwjics9rk45coZwMuPczEoehwjWRUl8A
        hV3SrhpGtTN8AkuuDqPPklfroaoQORjY9CRfrw8QObg6TRiOIBT0NA1hEneFm38RuTloxu
        hfmozaaBSxC+v5cJJttxZ2vlOsaJm/kN6ABjShcTIC5Et+YE959p4HzzUW/eBLJuQ9lx8/
        FklJ/xKgEzxuFdCZMwhQsKazp3MPwtilzJps7qAphwxU87Ycbnr4Dw4xz+U7TQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Stefan Agner <stefan@agner.ch>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: vf610_nfc: use regular comments for functions
Date:   Fri, 13 Jan 2023 17:36:47 +0100
Message-Id: <20230113163647.1295990-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230113064004.24391-1-rdunlap@infradead.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a2cfa6a24c61bf2178048397f6512ebb15e1ebfe'
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

On Fri, 2023-01-13 at 06:40:04 UTC, Randy Dunlap wrote:
> These comments are not quite in kernel-doc format and they don't need
> to be, so just use "/*" comment markers for them. This prevents these
> kernel-doc warnings:
> 
> drivers/mtd/nand/raw/vf610_nfc.c:210: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Read accessor for internal SRAM buffer
> drivers/mtd/nand/raw/vf610_nfc.c:245: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Write accessor for internal SRAM buffer
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: linux-mtd@lists.infradead.org

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
