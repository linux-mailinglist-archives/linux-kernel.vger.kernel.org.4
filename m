Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906426027D6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiJRJDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiJRJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:03:02 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8292DAA3DA
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:02:50 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CBABE240005;
        Tue, 18 Oct 2022 09:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666083768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GYCexmla+K3Yaqaosx/NDHgpwO3ew94UiEZ0KVBRK5g=;
        b=EAE7uLN01isiBu+/6PX0OqvTSaNJEDn90fbrxnvDLfacscBt4BU5yvuQU9lRnVO6IioDUY
        tPktBgX9HPiZ9k3ilRy7L2i0TDehucFXXx/1yEI0vkdXw2rV5J8iH/c1yVghpBFdeCdrxD
        ZL5ot1fgHCWIZKFac1CT2U0ytIiOnlFzNboCWCRr6QOgV+ElL3sb+UwCKp193u9FDyKnCa
        xR+EQYUdUXw0olDjE6fdsWOD2bYcmhjf9yfP7qReKBktr7+z8op8cadNcIpDQWm7vKUnb/
        5Fn8IPOwlpbQfvLFbiJgjupZzd3iMuPCd/XD7buYvMqlC5Evxk7SODXRSX0ePA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        bbrezillon@kernel.org
Cc:     Tony O'Brien <tony.obrien@alliedtelesis.co.nz>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: marvell: Use correct logic for nand-keep-config
Date:   Tue, 18 Oct 2022 11:02:45 +0200
Message-Id: <20221018090245.393831-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220927024728.28447-1-chris.packham@alliedtelesis.co.nz>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ce107713b722af57c4b7f2477594d445b496420e'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-27 at 02:47:28 UTC, Chris Packham wrote:
> From: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> 
> Originally the absence of the marvell,nand-keep-config property caused
> the setup_data_interface function to be provided. However when
> setup_data_interface was moved into nand_controller_ops the logic was
> unintentionally inverted. Update the logic so that only if the
> marvell,nand-keep-config property is present the bootloader NAND config
> kept.
> 
> Fixes: 7a08dbaedd36 ("mtd: rawnand: Move ->setup_data_interface() to nand_controller_ops")
> Signed-off-by: Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
