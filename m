Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7065BE04C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiITIfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbiITIec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:34:32 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149A642D8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:34:14 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id F1AEE4000C;
        Tue, 20 Sep 2022 08:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663662853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aY89X0PRSKW/Tm5MujcBMq9ADfJbIg8jUF4Tdi3x5F4=;
        b=XPOkmnRt0cMH1SHyb4KS986crfs9OMus+cgIXnstSuR/iqY2NoOI9+5AH7XNz+D03lnoXF
        PoR37rT2clMTZw1g2tqJPfg7tIo5ZpaoZO/gbnQ6pNyBMT/gfgu3It1067UeLfaI52pROT
        ghVIYXZlh+45o0PgQVQz5JqexciDN+AkPMhWDTZQ8tHQP0RHsHKkCEC6ZxZYxCdnRQGSdz
        2TqHKh5hR9G3MusFWLsjpVucalh/B95x3BzpVZQ70TMiWNsjs+zsMC40Uw5h/x6Yj8wl/z
        ehex2Ou8GX425To4Ah/qDHuTyTsx9PpA4yQdLzbFvXe2Hd30/2DcaLYgRGLjVw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>, miquel.raynal@bootlin.com,
        vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: remove misguided comment of nand_get_device()
Date:   Tue, 20 Sep 2022 10:34:12 +0200
Message-Id: <20220920083412.601208-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819021846.2924539-1-chenxiaosong2@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'35f88fc8c2a3224c66f59bd85055161a46b55dd9'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-08-19 at 02:18:46 UTC, ChenXiaoSong wrote:
> After commit 8cba323437a4 ("mtd: rawnand: protect access to rawnand devices
> while in suspend"), it will wait while in suspend rather than returning
> errors. So remove the misguided comment about return value.
> 
> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
