Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F06CB750A82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjGLONK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbjGLONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:13:09 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E741987
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:13:08 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4EE3C60003;
        Wed, 12 Jul 2023 14:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZvoTpQokhfxDtKwxijGGRwv2ma6a+U5Syy0BYVUUzo=;
        b=CMAxGgaJTMD5faz+BirBc+qKDEqdZXxClErK7qVOCgjEMccFvmjBcKx034xtOc/LuNRC4D
        CV5KZXGwyN/0sT92rhBuPSI3qfk/l5+astqJozxNK33bLKaVEBIVoZLKId2dds76TU/NfJ
        f3BGd9D3I4vS0dyCJq9h/rzaVM/v8LTKWmynwDDB/tahyVw/tHDTFf8CXr065+ISPrf+VT
        r2Qm2tqFJ1Vc98LvmKNXJCs6Ds2tX8er5bYHDqL4FxMYiKNaSW2qDIShePKqKG3AzPbvIB
        1KNJ1VSartJPX/JVBo/ZPG4w/h4MYZBfJC5UfhyCJ8+l7lM18DumiM33cb2atg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] mtd: physmap-core: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 16:13:03 +0200
Message-Id: <20230712141303.354734-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-18-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e1666cfd78222ae145ac260368f29fa443d97b3f'
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

On Fri, 2023-07-07 at 04:06:22 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
