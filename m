Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC99D6C501B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjCVQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjCVQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:08:53 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139365BCBE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:08:42 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CF9061BF20D;
        Wed, 22 Mar 2023 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679501320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+PSmnxBcZaUN7gsWHWZ45hdp2vXlK1DT4al4TDhvtl0=;
        b=Vcy9+zDUUhG2rn8iTHsAKvO4V15dpsX94dRn8OkrHPjFyLXe6ywWgPbEPvusnyMYH83Q97
        tCQOmTrZ1QcXbh3HZjJ4zYRu4tyyvNoZL2WRA95hzgT+EaIOdLuxFDbjOS+TMApsc79d1E
        Jw0delv/2t3kli1J9Z18PCMXo2myl74EE/QERYaiKu2MWG3XEM9lSOy/Bc4PpynWLKSECi
        UC7w0ZxbhROnrZGgnMiOlnxjBn/Ub8+UbKPPNq3V+tyw4q/M4Z+W7vbR3UVmY4DN2gdKCl
        515mFRhlCtFGdgLnoHWcwXtvJGgMnYLVbVO9KbQ/z+wJMGPZFfg3Y8Gu/ZcwZw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Tom Rix <trix@redhat.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] mtd: rawnand: remove unused is_imx51_nfc and imx53_nfc functions
Date:   Wed, 22 Mar 2023 17:08:38 +0100
Message-Id: <20230322160838.2232894-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321114638.1782086-1-trix@redhat.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'cb70cf99abae487941bbb5d3661653c02a5103cc'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-03-21 at 11:46:38 UTC, Tom Rix wrote:
> clang with W=1 reports
> drivers/mtd/nand/raw/mxc_nand.c:1602:19: error: unused function
>   'is_imx51_nfc' [-Werror,-Wunused-function]
> static inline int is_imx51_nfc(struct mxc_nand_host *host)
>                   ^
> drivers/mtd/nand/raw/mxc_nand.c:1607:19: error: unused function
>   'is_imx53_nfc' [-Werror,-Wunused-function]
> static inline int is_imx53_nfc(struct mxc_nand_host *host)
>                   ^
> These functions are not used, so remove them.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
