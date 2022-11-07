Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE661F92D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiKGQUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:20:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiKGQUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:20:07 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F0B81BEA4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:20:03 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A701EC000E;
        Mon,  7 Nov 2022 16:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667838002;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z9VS+8wTvm1EAgDjHkp8dY9nCf0BXzR44170Yq78V7I=;
        b=OoQKxL+Nxg4H0xMlvJYVSj/GRevW4SiV6s72TmBBFQefM1nLDfbY80/qqTTN4wDxlBcOUX
        dv6Fgb20ikAGj1ugmnHGYX//qx4SDIHpMHIgN0DQ349rnau1qHzkAdgjDfHvRvsd2S3gnm
        UFHL2CZQrOdp+rlOMKf2nK0u70Kea9CFMmKj63EziKF07I09Y8YX/L33UnCWJsGdqnp9rx
        FBnXQG9I88TwWLgADvmvDFhirFT5V0ym/0B3zDf8fDQ0NQSs6pqa7Qi5UHe6w7VNnrvoka
        gFY3IRCeeCfjXCLsr/detX8hHNsjKAsjaEpTmmtkxq7GhmE6gBTsDBCCa5nNiA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] mtd: onenand: omap2: add dependency on GPMC
Date:   Mon,  7 Nov 2022 17:19:58 +0100
Message-Id: <20221107161958.44056-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221107091520.127053-1-krzysztof.kozlowski@linaro.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c717b9b7d6de9e024e47f7cd5bbff49f581d3db9'
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

On Mon, 2022-11-07 at 09:15:20 UTC, Krzysztof Kozlowski wrote:
> OMAP2 OneNAND driver uses gpmc_omap_onenand_set_timings() provided by
> OMAP_GPMC driver, so the latter cannot be module if OneNAND driver is
> built-in:
> 
>   /usr/bin/arm-linux-gnueabi-ld: drivers/mtd/nand/onenand/onenand_omap2.o: in function `omap2_onenand_probe':
>   onenand_omap2.c:(.text+0x520): undefined reference to `gpmc_omap_onenand_set_timings'
> 
> The OMAP_GPMC is also a runtime dependency.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 854fd9209b20 ("memory: omap-gpmc: Allow building as a module")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Roger Quadros <rogerq@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes, thanks.

Miquel
