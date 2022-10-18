Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCAF6027DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiJRJEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJRJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:04:08 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214D0A8CF9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:04:06 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C8D7EFF80B;
        Tue, 18 Oct 2022 09:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666083845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ov1McskxA2EWvBoLZC6l6I9qjfPSqehFWh4VIGcBMFQ=;
        b=RNBBhaVijb0w14KfkC4xHsEcaqv6Rkvinf3zl0ohRJnjuZlMhMfyQkr1dRKWnRdT9UWocM
        HmI4u08QXqzXsTQN7KI0Wcp2fs7NhyZACxte3ZW/fGG+OrOv7QVh9b7dnWnpyknBUDEvKe
        bMeZfkJBK7KsgLGNbLWHcyhJ/W4UAN7jIC0N2dXrR0xtbQ/bhIvOKGtpAEqtG7BmiJNOrq
        kLy0NNUH9oWjPqBmMahhm4W5yK8sp+YD3OQaEUrRqlyAhJhj0vm0mmVizD4Vn2Pz9/ZOe8
        hnlHjh2Myxax5xvrKbrOECmlLfvKB0409qem8w1DkMgN5NrsVShZqGFhBVQbXg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mikhail.kshevetskiy@iopsys.eu, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3 2/2] mtd: spinand: winbond: add Winbond W25N02KV flash support
Date:   Tue, 18 Oct 2022 11:04:03 +0200
Message-Id: <20221018090403.466239-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010105110.446674-2-mikhail.kshevetskiy@iopsys.eu>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'6154c7a583483d7b69f53bea868efdc369edd563'
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

On Mon, 2022-10-10 at 10:51:10 UTC, mikhail.kshevetskiy@iopsys.eu wrote:
> From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> 
> Add support of Winbond W25N02KV flash
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
