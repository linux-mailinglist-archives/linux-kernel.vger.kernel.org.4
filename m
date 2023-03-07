Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975066AF5DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCGTi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjCGThk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:37:40 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C9C95BF2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 11:25:00 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 809A740004;
        Tue,  7 Mar 2023 19:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678217099;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VrU8J9YB7fQPHk5/ael0OMDOC13vkm1stDSoSG3PYew=;
        b=ZpDIXDsfovyMckKIWaKBUOnFtR/7vWXdgr6OdQ058XmHA7uNsqGkqtubipCkZX/PivtPZs
        uA1NMga70CTjP3Bbg6VmBSJheiJ4KVpoYZYUCEwkq6UqDC67SgwL296JN9oSJfMegJpHVc
        UsV8Jew5yC8Qfif2UggmT1OnCUo3GnHQmI27B2LQ/vt6rvpGywbhphJLdCS0ndmwar57pB
        a96pmLITt1uUGdi6zW71mhqVLq7HJr5JpJHab1LahtjDzsHE2vTtUsi5R54ykwDOYRmJNy
        n6dPoP+0fsClzN4mwxeO34mk413Js5N1/6fhKi0qh6aL826oS8r77I4r2pl5ww==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     ye.xingchen@zte.com.cn, miquel.raynal@bootlin.com
Cc:     richard@nod.at, vigneshr@ti.com, christophe.jaillet@wanadoo.fr,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: =?utf-8?q?=5BPATCH_v2=5D_mtd=3A_rawnand=3A_orion=3A_use_devm=5Fplat?=      =?utf-8?q?form=5Fioremap=5Fresource=28=29?=
Date:   Tue,  7 Mar 2023 20:24:56 +0100
Message-Id: <20230307192456.433031-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <202302101723563685569@zte.com.cn>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'434b8356df416678fb29d21b02bb5755c5f778f0'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-02-10 at 09:23:56 UTC,  wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource(), as this is exactly what this
> function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
