Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B621750A83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjGLONP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjGLONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:13:13 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B968810C2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:13:12 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 38E3C2001B;
        Wed, 12 Jul 2023 14:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ta5ioCd7GqG6UJ1XPBF1f9YtfZ8DyGYbABEPInFPsyI=;
        b=oQj4RBnyoApVGd/PZk7cbPv8mPiYQ0gvuG+yz6MrEdKwFO7VQHpEsGx5geNMsxbw7/JR9+
        bRYQwxPHYnNbABsrbNj2rqy82lCqBGrnMiHHB9j8tvh9eHDCpw2C2gCbYAxEyeDUlAvkFd
        OutWTbcb5+5moWa19KIh2bouDsOFfWQvXmh6mjh43nuEXMiSTLz9o1gdTKFxlO32+KgRVL
        zde74yg0iIATnhOmX9MQth0dAtfLG1g/kcXgrGinBjXDr3jioWCNvp5tO2CUGfHbXtLtAe
        xcNi4UK1ftGwhivwcSAHFhEENMF3MyMarw9BfRCXcV7UQcNF2vv3jSxGZvbjLA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] mtd: spear_smi: Convert to devm_platform_ioremap_resource()
Date:   Wed, 12 Jul 2023 16:13:09 +0200
Message-Id: <20230712141309.354763-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-17-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'badd019b4a2a44815e976a0108dd8e52a1a24a83'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 04:06:21 UTC, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
