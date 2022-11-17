Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE22862E6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240922AbiKQVSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiKQVRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:17:34 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9BA28C0AC;
        Thu, 17 Nov 2022 13:15:58 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 32FECE0004;
        Thu, 17 Nov 2022 21:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CmSG2ryhcdFT7d9uwU/rqC+y30C+C5ULy8i7jDFK438=;
        b=Blo/mK3hVR5g08POlDipvzelsxbWFIgGwguM/1SiUFoHybQyaOuwljcVp7A1Kk817KhBrG
        v5a7sgXX4UjwBMI8c5GHxMchg+NT0W5jtX0FM1iC9SWeJis9LQrTpi9+mCztrLd+9J3Hoj
        Z+1ERqswsSDyj6pjQdoHhxPckzuWcRJvtmuAd/C5zlQQOnBBHjKTrvTnU46oKZtJz1pyFn
        mIjz26qRKE8FQiBrYeArCTeaalsCGMbUmH7Nsv/DelFVePpPrT9B2ElYQFxVmTHAs0nWQT
        LjQreLYFDUaI34JiNkSBaf8KGBzMweOIGuU5dX+zPwVBB/7k1fxq3xPEHIsPxg==
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
Subject: Re: [PATCH v3 07/17] dt-bindings: mtd: onenand: Mention the expected node name
Date:   Thu, 17 Nov 2022 22:15:55 +0100
Message-Id: <20221117211555.1273492-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-8-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'eb6fa33657da9526a9e5f43088d80b99a5c0315e'
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

On Mon, 2022-11-14 at 09:03:05 UTC, Miquel Raynal wrote:
> The chip node name in this driver is expected to be different and should
> be prefixed with onenand instead of the regular "flash" string, so
> mention it.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
