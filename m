Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57C5712C1C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbjEZSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEZSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:02:20 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35F2D3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:02:19 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685124137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D2WoWOQXtKlpe3ao06i3Mft9mNFnFGHReEa4645KcNU=;
        b=RpibYJkcEKorvueyaca/oyFDtBa00jdSCdOf0UB9oNcHSbjCu1SsdlVqpTVjZV0wRf84uy
        fNZyvD7onJYGEz8ydtDfv1l9xMfvmDBb3YKRLj+7cIgZ93XtjhpEuxfD94RcFae5UFJNFw
        Y+ZydEqKXALC5gzlEHsD3xaqTztfqgf2DiWTQ39rzQla45jnHpIxZysGFk1wyO0kfuLhMC
        eA0KIoRRDV7ISLcSy771TqS0JlgYniKI0Qp+qjiOcVFoFL4LdQ4OZdBUGRprtOxCyeHYd2
        PEdjTCNoFLIcK1+wIgQnsJUyFYFZDQkSK/44HjjjvqXqyG1bxV2JgJZVc3kaLA==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C6031C0003;
        Fri, 26 May 2023 18:02:15 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mtd: rawnand: marvell: don't set the NAND frequency select
Date:   Fri, 26 May 2023 20:02:15 +0200
Message-Id: <20230526180215.924342-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525003154.2303012-2-chris.packham@alliedtelesis.co.nz>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'87dee04f3c828dec34e94f1bd90ed423c3f9813f'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-05-25 at 00:31:53 UTC, Chris Packham wrote:
> marvell_nfc_setup_interface() uses the frequency retrieved from the
> clock associated with the nand interface to determine the timings that
> will be used. By changing the NAND frequency select without reflecting
> this in the clock configuration this means that the timings calculated
> don't correctly meet the requirements of the NAND chip. This hasn't been
> an issue up to now because of a different bug that was stopping the
> timings being updated after they were initially set.
> 
> Fixes: b25251414f6e ("mtd: rawnand: marvell: Stop implementing ->select_chip()")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
