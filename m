Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C3662E6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240221AbiKQVRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:17:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240918AbiKQVRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:17:04 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B012D85EED;
        Thu, 17 Nov 2022 13:15:34 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4816C1BF204;
        Thu, 17 Nov 2022 21:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maEcsFKRmFPFcaTystw6MDV6AJk7t42kSZ4Dzy8Hr48=;
        b=DAilUKy4AF1x1959BQFMuZ8OsBA8O/jPkf+JFucmC30wIDtv3z7dUxX7d4h0XFnxxPfQpy
        aacYoBYizL+i2KyQmS2uQBbNX+vv0UO+qJdzYtN7VwoW8YPLf8BUrpIXkWS/apESf95i3w
        FloGIVgMFKhJRFlH5Bhp/yB26QeY56G/qQHJjm1gNFNCO4Ww8/UroViSDIkGP7FfvNwsif
        Icaiaf8E+fWmFywCv8riDMotEeqxGUqnAkWYqHFtfvDxH9mnNrrTA3K9vCfLjzYJckz4tr
        FBEz+S4Er1xglGEHxHBcLJHvQwBrISkYR8zSzNDmqV3N2tdwxoD3NyRsYqgtyw==
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
Subject: Re: [PATCH v3 12/17] dt-bindings: mtd: partitions: Change qcom,smem-part partition type
Date:   Thu, 17 Nov 2022 22:15:29 +0100
Message-Id: <20221117211529.1273348-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-13-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e141ee8234d02727b421058df56f5959b7dc0ed0'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 09:03:10 UTC, Miquel Raynal wrote:
> As described in dd638202dfb6 ("dt-bindings: mtd: partitions: add additional
> example for qcom,smem-part"), the aim of documenting the subnodes was to be
> able to declare nvmem cells. Hence, the partition property does not
> really apply directly here, let's instead reference nvmem-cells.yaml
> first.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
