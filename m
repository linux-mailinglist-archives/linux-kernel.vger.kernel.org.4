Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CB26AF5FD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjCGTnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjCGTnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:43:32 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141FEAF74B;
        Tue,  7 Mar 2023 11:31:50 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B1CD3100004;
        Tue,  7 Mar 2023 19:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678217509;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jh2svqgNjDxTRpo66M435sQVNOl7qUZwvbg09/0bJLc=;
        b=ZdkyyeEtKQUSUE1ikWg6Y+kG87BSOskMwP7A+TthSU+D+TQYzi/jjmv3CF0On7yN9wt8ni
        HNDIN8wGj8pj+9TRBKSfxeQ+HcpLuqZLscxwux4a1ytO+Lp6ZYoTdxHgXFR+WQcVtzpwtx
        dY+uPxE5qmL8MkElQxeijV6lUAZ9MkL9Ms5PwkFCFZ111t2IXpLCl+nbrerPl+uUSm20Nw
        bTk8/g/CaPVl8DstVJJIVkVCTdzMiW1zPrjSLRcLnniQ4eQn/QKMNlc6+TAfMH8n34z0VH
        mT1hgPH8DuCJwVa/QhMbZgd7gYpMgPoRR+tN4XGA2jGjKZih2jgpTxbeEKNH3g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: parsers: remove reference to config MTD_NAND_TMIO
Date:   Tue,  7 Mar 2023 20:31:47 +0100
Message-Id: <20230307193147.513133-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230307074038.17391-1-lukas.bulwahn@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'4080d536241652af43996d9ceee2b79aeca57267'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-07 at 07:40:38 UTC, Lukas Bulwahn wrote:
> Commit 568494db6809 ("mtd: remove tmio_nand driver") removes the config
> MTD_NAND_TMIO and its corresponding driver.
> 
> Remove the reference in MTD_SHARPSL_PARTS to that removed config.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
