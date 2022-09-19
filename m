Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C26D5BD1F5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiISQQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiISQPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:15:52 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54608286C6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 09:15:50 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id ACD16C000C;
        Mon, 19 Sep 2022 16:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663604149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Dc/RlglN5rD6jeAjq6bz9fLtyemoPUuRw33vxFl6Yo=;
        b=N/DqyCnoZ+xMZrFCE4iiOhh4jKP7f/F7t3X+VHB/ob54vs0YF6fmJTgeHlksp28mY/sMDf
        yrXBWs2PCajxTQJOdp1kZ1/9/uv8oeGFyWrTzfDDLgLrr+fM5Nb3fKEpDHRbKh44VFyk19
        KcDrRVpVz7GveGNxE3m527KKKnsdlPFrsD/0FBcF3sqqi54bnBQflgQs+7EzB9aMVWSxQd
        gtyGzCs3FrfQMINODn8cJkZTxL/Edh+wC+jvP7RSoTKLlYSf4QcvW0NiXo5OduhT1iyZ3n
        ppe+s0ovLtsuJIvKj7H/oLF//DF/qglA1Vu2H5SksSGHqemUr4pm0QmZuYWVkg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Gaosheng Cui <cuigaosheng1@huawei.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        wangweiyang2@huawei.com
Subject: Re: [PATCH -next] mtd: ftl: use container_of() rather than cast
Date:   Mon, 19 Sep 2022 18:15:46 +0200
Message-Id: <20220919161546.226481-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220816135910.268016-1-cuigaosheng1@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bf3e6b8f837afdf01d31cdc86028660f3f342bbe'
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

On Tue, 2022-08-16 at 13:59:10 UTC, Gaosheng Cui wrote:
> The container_of() is much more readable and also safer.
> 
> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
