Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9CB5BD1FA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiISQQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiISQQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:16:24 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236823AE5E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:16:16 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0E0F7240005;
        Mon, 19 Sep 2022 16:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663604174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2igv61d+yyXjIWPMPbUkwtzPP4hi7M6BgZTabOpDc88=;
        b=VkKbhl/59oKwtZv/rP75n83KA9m00eOMhteiylV0vS4t8mxs5tCfZTDTaA6z2bUnteyXjT
        ABN7+185TmxaHqGOglN8arrBlO6RJeerqtL4FwJuI2jKy+6XW/KeA8QjfgD2SuBJ4ciX7I
        EfpGwzg3rZ3C3ZWcpZ/9IbksUglBTnLvMTpKvUHYa+AO7HZfbwXAC7WM2GUaH83foyPKv8
        iZmtU/xDX+mx8zjuXS3Zkr0GvMEaPlkeHm0oGh/GjFo1XbGSXM+R3K0EbSh/gAyEOFQdmx
        uPV+pSwzgTuvNijrZHKOoh/sq7Y1c0SV/kvID6mwczY7IG/vaIODHLEDotE99A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     williamsukatube@163.com, robert.jarzmik@free.fr,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Subject: Re: [PATCH] mtd: check the return value of devm_ioremap() in docg3_probe()
Date:   Mon, 19 Sep 2022 18:16:12 +0200
Message-Id: <20220919161612.226599-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722091644.2937953-1-williamsukatube@163.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'26e784433e6c65735cd6d93a8db52531970d9a60'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-22 at 09:16:44 UTC, williamsukatube@163.com wrote:
> From: William Dean <williamsukatube@gmail.com>
> 
> The function devm_ioremap() in docg3_probe() can fail, so
> its return value should be checked.
> 
> Fixes: 82402aeb8c81e ("mtd: docg3: Use devm_*() functions")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
