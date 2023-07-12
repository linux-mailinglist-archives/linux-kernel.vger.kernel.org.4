Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07624750A84
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbjGLONW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbjGLONU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:13:20 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388A919A7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:13:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B26A0E000D;
        Wed, 12 Jul 2023 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RQo3IWxFrUNchxFsYrhNn0IWhqemGxFFnfeW2H+aYl8=;
        b=U8XjRlmLjynxknx8Z6r8TKB8NSc9duahwazIp9HP29+XB/7Un55MgqwSTpRF/a7+boHx5H
        ROzXne8bjrI+KnT/xSDyWA8jxJhZgEtZ2XbX4yELpRYoEZ6PtNF/l5dUQUhG8q4udFn2qD
        Cff0Et1MwNc2RYQaMUuWuZ3AVAVqGxd9rod4A309V1JoaELzPI8xOjVXFdX7mTGNJg+9md
        1p5t87S3gb4vZY9VV5ZGGSRgHckds8uyDKPvvkbZa2sp6ZZS7NyJCaILK1jw9DdU40eQKy
        ueh198ddYypV8huZ8xjoJ6ThIui6mP39e/jJlTxVgAsOKoaQOwBCp0Uxgvao5Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Yangtao Li <frank.li@vivo.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/18] mtd: st_spi_fsm: Convert to devm_platform_ioremap_resource()
Date:   Wed, 12 Jul 2023 16:13:13 +0200
Message-Id: <20230712141313.354793-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230707040622.78174-16-frank.li@vivo.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'1726813c2efff24a78836dd6333cd213b28cd5fa'
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

On Fri, 2023-07-07 at 04:06:20 UTC, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
