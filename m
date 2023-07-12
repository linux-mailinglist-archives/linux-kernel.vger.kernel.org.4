Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6643E750A85
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbjGLONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjGLONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:13:36 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2FA1BC6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:13:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B121E60009;
        Wed, 12 Jul 2023 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELmVEwfyQow51i4SwILFqMBHApGdkoRTmhhEzgBesiI=;
        b=ZvccUrp8Ez3RYDCvKj/4f4ZZ7QPMhUzMbPqdqLDtK2VKfRVtM5A2bmFvUVCW6E9PLgglTt
        JeXp7bkwz9a0IG+gXVbbQQ+y0QRbrFD1OMf3VaG8JmGNU7+V07EpJgsD7LSTKJsesz9mKx
        aBPjhFtQWxX+Y0U5OwmAsfJN1n9VqjRaVf9KV5flqaoG/GHIXQOkQ/ekaKUqWede0D/FUm
        khFoQk6dVSDm9E7SQ8ZHxzGbKsIs7w5SH6yYeDEGrOb9ZIGurnO1bN9mCW+PxGofkByROY
        sYGRUsheUR3nAdnkC0HtOMcMDYkzwTEw8XyLRCtB9uX+lUPR1dHQOdGuz8vjmg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/18] mtd: lpddr2_nvm: Convert to devm_platform_ioremap_resource()
Date:   Wed, 12 Jul 2023 16:13:19 +0200
Message-Id: <20230712141319.354823-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-15-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'a29f696aa96f94ced1655b183c9694920d8bbfe2'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 04:06:19 UTC, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
