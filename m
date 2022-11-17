Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD9162E6BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbiKQVQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240825AbiKQVPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:15:50 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CBB7A35F;
        Thu, 17 Nov 2022 13:15:27 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0EC73FF806;
        Thu, 17 Nov 2022 21:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VPHr+qDv2jvZw7yfWQ6ulK/MdmRbx+t8bsjqHho0yiI=;
        b=nAqlDnzrdHSTZf2HpQHlucabZ2Db2wD4jHANBXRfgnWXSBvnESeXgKR7CmU5laZgOkb2Zn
        x2PXiUTX5gWJHyHncuSAIsHG2E+KWx52GGAPeyhGPThHVChcF5YJsCTnZyxkqlrAKKeU1A
        f0KeVHrbfevi692vyE+VQeJY1AHc6omkO36/dliNuZjxXP/3agfSqJsOySg8iAJZucjwfq
        mzLoTUVZiV/fXeQiq+IjdxyfFagZa8mWBpSVrL0zRPfiFj8dH9gYaWDEShSW6QqHrook21
        cDKKh9ys7KSGG4li5LwQ96E9Hou7g8HRkOei8RY7DGITGBSSnOGvTh1SbM58Gw==
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/17] dt-bindings: mtd: nvmem-cells: Drop range property from example
Date:   Thu, 17 Nov 2022 22:15:23 +0100
Message-Id: <20221117211523.1273320-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-14-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'c0fc45f7d305688f727fb44a66554233b1624ab9'
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

On Mon, 2022-11-14 at 09:03:11 UTC, Miquel Raynal wrote:
> Memory mapped devices such as parallel NOR flash could make use of the
> 'ranges' property to translate a nvmem 'reg' cell address to a CPU
> address but in practice there is no upstream user nor any declaration of
> this property being valid in this case yet, leading to a warning when
> constraining a bit more the schema:
> 
> 	.../mtd/partitions/nvmem-cells.example.dtb: calibration@f00000:
> 	Unevaluated properties are not allowed ('ranges' was unexpected)
> 
> So let's drop the property from the example, knowing that someone might
> actually properly define it some day.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
