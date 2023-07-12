Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D08750A8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjGLONw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbjGLONp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:13:45 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8654419A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:13:44 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB0471C0008;
        Wed, 12 Jul 2023 14:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IvVaaj10tLkFJrl+D8zsB29cOYsNisVZpzEQPRb2FZY=;
        b=Qzy7kga58/Yn+9D1+aogFnz9A6dBWk8uJ9O2NFwQl1BSheyMqU+hHcN7WdZHX/704Pojgk
        nW06dIxcP5ffeuJVDjMSlgRtJt9el2k+JLJGeTugd8EVKuuiq2PBmMd3OhmPPXzQ/p9RNH
        MCJ2KM49JgizOZdrbKhUZ08eH5gsH5DRP069JmFLOWM7/BLV8jNyeCLuHBKWurSom0IcOU
        RkDkh/6gEC5jxCXh+lHJGB//tEkDcxA2/KJhoK6nFsUtaMtTamUA4LuUZhvBDhF6/aoYje
        GKbyUZtpkCudVqYsx5ByBhGRVxJLZtLTB6Ru0eDRFvm9EDuz3orn102lYii1Cw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/18] mtd: plat-ram: Use devm_platform_get_and_ioremap_resource()
Date:   Wed, 12 Jul 2023 16:13:39 +0200
Message-Id: <20230712141339.354893-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-13-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'0e0d59f2f6ba8f26a16081fb76d301fc369cea36'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-07-07 at 04:06:17 UTC, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
