Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94C066028DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJRJ47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiJRJ4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:56:51 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC75B1BBC;
        Tue, 18 Oct 2022 02:56:48 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D505BFF80D;
        Tue, 18 Oct 2022 09:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666087007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=baIcB6Pr29o1KI2n+bO1ThO9ZZAOux+kI/uBwWzJ69I=;
        b=aT7Na8zc8GWyIMtBx5Yxssctdt4XQlaLsmB5d+kECgX/Q0dZ0Zt+tSGmOpAWKFBwKA7eyw
        B9jnFop+PoRaWtIm28f1sRV5EGV+q1v+sj/5DsZe8Bsi8wLh6WPaJVnb9xKfaOm9j+/dz0
        UM6MZ0Yq6dc2u8QJPgRGX65q5XJW8q1odJ+Rd0U+mIKjvs62SGt/KNTP1HApRaJfhslJeR
        FkAkCS3UA4HCqZESRu47bWYS34JzB9xopzbR4odJeOkyiS3gGOXnNmCZCDXx2lnqoBcig5
        XCdXe/l9udnPeba/mNfncOLUtArNayypH87XtzItLzskj8g2isszuHHY7w9C0g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     ansuelsmth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?b?UmFm?= =?utf-8?b?YcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 2/2] mtd: core: try to find OF node for every MTD partition
Date:   Tue, 18 Oct 2022 11:56:45 +0200
Message-Id: <20221018095645.543315-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004083710.27704-2-zajec5@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ddb8cefb7af288950447ca6eeeafb09977dab56f'
Content-Type: text/plain; charset=UTF-8
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

On Tue, 2022-10-04 at 08:37:10 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> So far this feature was limited to the top-level "nvmem-cells" node.
> There are multiple parsers creating partitions and subpartitions
> dynamically. Extend that code to handle them too.
> 
> This allows finding partition-* node for every MTD (sub)partition.
> 
> Random example:
> 
> partitions {
> 	compatible = "brcm,bcm947xx-cfe-partitions";
> 
> 	partition-firmware {
> 		compatible = "brcm,trx";
> 
> 		partition-loader {
> 		};
> 	};
> };
> 
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
