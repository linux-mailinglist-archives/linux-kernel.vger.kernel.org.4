Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14BBC6027E4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiJRJFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiJRJEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:04:45 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9E91E717;
        Tue, 18 Oct 2022 02:04:29 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0DA6660004;
        Tue, 18 Oct 2022 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666083868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RL6Pm1PtqnVst262VMQ9ziU0/oxy9Za+p2F3nlrAD18=;
        b=STdvyZIjCcaUjwvKJjxQS/ON3ZGJa05Wco8/7zUFV8AbdhWUDDLBh3VZJCOeNrVSTnHPF7
        iTiQrLlEsNN62pcD2oiRd9HPZXN9k/B6LfSRRFJ3Ov102WDXSAlF2agjan0Q7ZLLZhWsns
        paM6bxGLTKtLP7Rah7Edt0KEfsytxyv+9MmdyNIRIXB+DOy0IEMJ8rMuZWudNWdsZ9gM1Z
        dyTTedX2AJW5ZaVVoCyQJobKCsIXUTPMz5In/taKHI1S/gcJfUlnsvYiAVbx4/lECRRTc2
        X2+34cB5bMoI+ibMWGkwi3QjJQRPu7ScJbjwm2KPpRQ0suRfOgQTZCOwPZr6PA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify entry for MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
Date:   Tue, 18 Oct 2022 11:04:26 +0200
Message-Id: <20221018090426.466380-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220929123431.23180-1-lukas.bulwahn@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd4353decd4fdec71b9f9d1ba8fa85b7e595e8924'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-29 at 12:34:31 UTC, Lukas Bulwahn wrote:
> Commit fbc00b5e746f ("dt-bindings: nand: meson: convert txt to yaml")
> converts amlogic,meson-nand.txt to yaml, but misses to adjust its reference
> in MAINTAINERS.
> 
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about a
> broken reference.
> 
> Repair this file reference in MESON NAND CONTROLLER DRIVER FOR AMLOGIC
> SOCS.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
