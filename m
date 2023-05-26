Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07068712C1D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbjEZSC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEZSCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:02:24 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A37AD3
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 11:02:22 -0700 (PDT)
X-GND-Sasl: miquel.raynal@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685124141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JOmTTnUJ0QiDzTvM35S+su84JQ1WbaoWgG487kovL04=;
        b=UHAE0Fl+cmDWIlGMUpGuIDafwMBLn0sGS3msBfhyI5iw+NYSBtc46e/muYjNbJMevX3+Lw
        5zqbvPnRLvZuV6v5ObdpeZqrVzMgprEJImXXzN5dU8Ndk77tsnpAezJi3e1RnA4IQ/TBtV
        TSCZCntpscGbvBetLbCFwjDLAQXTGnRBSJKnh22pxtqeM2FyrU3ftVMylF9gI60Hw+YuBt
        pJcIfJI6M4xylW2xmG4IW6wDS/+SqyjNoK/VjQwPQj3hlFZOp2TLxWBqYPMk6kczEcR/dI
        hmw/v0kB726TFsF20FasCp5HmH7JHNUzI0m/OJlnS7UzbglsDRhJGCaXc0OxIw==
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
X-GND-Sasl: miquel.raynal@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E931C1C0006;
        Fri, 26 May 2023 18:02:20 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mtd: rawnand: marvell: ensure timing values are written
Date:   Fri, 26 May 2023 20:02:20 +0200
Message-Id: <20230526180220.924379-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230525003154.2303012-1-chris.packham@alliedtelesis.co.nz>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ce8a0b2602b221d564fee38847d15c1dbe05d382'
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

On Thu, 2023-05-25 at 00:31:52 UTC, Chris Packham wrote:
> When new timing values are calculated in marvell_nfc_setup_interface()
> ensure that they will be applied in marvell_nfc_select_target() by
> clearing the selected_chip pointer.
> 
> Fixes: b25251414f6e ("mtd: rawnand: marvell: Stop implementing ->select_chip()")
> Suggested-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
