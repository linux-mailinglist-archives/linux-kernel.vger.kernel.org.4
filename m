Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530EC62E6C3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbiKQVSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240800AbiKQVRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:17:24 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EFA8C0A1;
        Thu, 17 Nov 2022 13:15:49 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 80EB760008;
        Thu, 17 Nov 2022 21:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/e3JQKNJWHzX7z3b8NbCC3L33QHhdsa7QAgvCkJ+88=;
        b=BdT8BPaV9hRMnDPu3CpF3oH0ezN+o+m+tLbnN6ABrcP8FhQQMs4ywJr73+QM2gBgqJ4DBk
        k7zF0xuFHw+/DvB5dD8COXbc3L5btzdLzdjrGswAOpRn41TCvehwIqsSAF7dEmHpAqjwJV
        P/RC9DEzcDVQF1sbacuPvykOWt2ELpaUW2XqNdBNRTbrbzLxYI7qLRy6WZDwU7VgJj8Tkn
        byWuvugL6q12eQ2xJpK/Oha1Cbr1Q+6TLgNM3UBbe40IYPX1rhRarzBLegZOpLLQ1JryV4
        n9eMvLelxRcxOrO1cpAO+VC3EQty7c24lfHzBlWAVbQOt2IJbh4mYpwSHLz8EA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        linux-mtd@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 09/17] dt-bindings: mtd: spi-nor: Drop common properties
Date:   Thu, 17 Nov 2022 22:15:45 +0100
Message-Id: <20221117211546.1273433-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-10-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e9a399caf0314a69593b653ddf0efadbb11ffb9a'
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

On Mon, 2022-11-14 at 09:03:07 UTC, Miquel Raynal wrote:
> When redefining common properties does not bring any additional
> information, just drop them from the SPI-NOR bindings because these
> properties already are definied in mtd.yaml.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
