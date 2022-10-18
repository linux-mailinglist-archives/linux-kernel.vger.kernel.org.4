Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70406027DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiJRJER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbiJRJEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:04:13 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DB9A8CF9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:04:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E8DB11C0014;
        Tue, 18 Oct 2022 09:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666083850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P6KtNeMpTG5EYxhj2LWodlcM8U9peuLBtoyu5uXj7jU=;
        b=RsdaifbddHmoxiXbEkbM1J3/PJZ2OWY3AxSze2GoctWni2jB/Qpl9cmG3HvE6rPQiOeI9M
        xVUaLcv3oSGFvzJtNhYZe44Q3qgOIq1psRoxUDiaE1INfH2bcmCAtkEi9v/UjkkvLlIF8g
        4HQx21daVSAkbF1SxyL4JTHsBIlOtmsxsJa5w2TPL/i1vm+p4S4tXHpoF6HbN1YJpDECcj
        8Ju83ZZlpngSijZh13pqw42SA6rc73MxZVNY857yxyMoppRxa8uc4dLoSJWAZ9g6d8xMbi
        1AjS8O6bmQYI38Ai7oMvAsSg4TKuUBTmmtvcCVlJFziSOKK/eOEKLGgUDYhWZg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     mikhail.kshevetskiy@iopsys.eu, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v3 1/2] mtd: spinand: winbond: fix flash identification
Date:   Tue, 18 Oct 2022 11:04:08 +0200
Message-Id: <20221018090408.466267-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010105110.446674-1-mikhail.kshevetskiy@iopsys.eu>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'dbf70fc204d2fbb0d8ad8f42038a60846502efda'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-10-10 at 10:51:09 UTC, mikhail.kshevetskiy@iopsys.eu wrote:
> From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> 
> Winbond uses 3 bytes to identify flash: vendor_id, dev_id_0, dev_id_1,
> but current driver uses only first 2 bytes of it for devices
> identification. As result Winbond W25N02KV flash (id_bytes: EF, AA, 22)
> is identified as W25N01GV (id_bytes: EF, AA, 21).
> 
> Fix this by adding missed identification bytes.
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
