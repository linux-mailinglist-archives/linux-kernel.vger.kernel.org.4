Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6641C6028DC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJRJ4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiJRJ4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:56:32 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627ECB1DC0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:56:22 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9411510000E;
        Tue, 18 Oct 2022 09:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666086981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SU/eFAg8+KBTIRwD4dYWBBPE3YjTp5i/6+7PETgyslE=;
        b=HW2acJ8p39bUFqqRVZTj6RQpIC4AhxwqpQVzjIEbA4s/KkvvL64e1kPzOW63O7dL1pCpyR
        qQsjmHQxgNg7kH5jm6Mf1AuvJcTx8CElFAhIHVKLxDBHYMtwd6qVLR+RAkw8mWGfseGBqW
        Pguw612VqlqMclp26aqNyfSpI7NRqxxsAAB4mWYd8W+En/u/3IX3TJ3jyj2SFs+6C1wSJr
        vHUJs7IRL4n7J2w0jB8mrqw3IY59stGAYB00LXm91Ukp24uaaQ578h4Wd1lyAfVfx0jAXj
        Vg+pAeRpm4vEe2bFJcnUouuXt3NMnAGXzD2CGf/I2U/3nqx3Pb4XDypy/qraAA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ray Zhang <sgzhang@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] mtd: mtdoops: add mtdoops_erase function and move mtdoops_inc_counter to after it
Date:   Tue, 18 Oct 2022 11:56:18 +0200
Message-Id: <20221018095618.543259-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010045549.2221965-3-sgzhang@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'76306951cf7314e3176099756453b055dc34a298'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-10 at 04:55:48 UTC, Ray Zhang wrote:
> Preparing for next patch with minimal code difference, add mtdoops_erase
> function and move mtdoops_inc_counter to after it, with no functional
> change.
> 
> Signed-off-by: Ray Zhang <sgzhang@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
