Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7862E5BDFB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiITIUD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbiITITL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:11 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBA666105;
        Tue, 20 Sep 2022 01:15:54 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6623B1C000F;
        Tue, 20 Sep 2022 08:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0bZ/4ub62GqpgWbwegoDb5Vo3VrGav4tMuzZ44pe6tM=;
        b=BgB9C/LSPzzzishEokbHUGFSlXDbeh+mEAFBADS19MhM+0dG37H/D0RxGjbzShZQroPcFw
        MAZjU5+DVYmcGiXX4c3UCGtO6UgClhiCZ/2CyNL2rUygRPmGhQMcCk2hUi9YpaeuRmeXdv
        2D1xa0eTfPLE0oAJSEIw+z5kE8Njk5VyMdEXy5Jw+5utfdy7SI5QF/3xbeZuV/DGcSj5oO
        3uuJL2muhLARpDv+65r5+BKQm+KlZACUaJ0gjBMNKX/iGOggetYY46P2mqL82uFctqXvLB
        MtrGjtUO9S4DNu5qcS2Mu2EliEX32QJqSKu3VDFXEgRDRoFqgWMmdze988H3Vg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: nand: bbt: Use the bitmap API to allocate bitmaps
Date:   Tue, 20 Sep 2022 10:15:51 +0200
Message-Id: <20220920081551.598096-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To:  <b18c2b6711b8930f0dfb8318b5d19ef6e41f0f9a.1656864573.git.christophe.jaillet@wanadoo.fr>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'054c6b58fc6ca7321dc53d7b64f8422919355cd9'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-07-03 at 16:09:45 UTC, Christophe JAILLET wrote:
> Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.
> 
> It is less verbose and it improves the semantic.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
