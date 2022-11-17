Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F8D62E6CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKQVSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240796AbiKQVSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:18:01 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A942A8CB97;
        Thu, 17 Nov 2022 13:16:10 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C9762C0002;
        Thu, 17 Nov 2022 21:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KzOL0egflZiwjfJaL2Ni+++jogbuy2iBQ5wpQrx7o78=;
        b=CnLULpy9G5+3fm1g0LqxgrUnQCzP7HanB1EzN1aopDXlygKQrRz/Qa8mVY11jYIFfiwjGF
        2zyENuCJdoDjRUVxP1E3b9qAkTf85w4D6URlj9KzlKXvjdQ0TWFporadim26b2QJB875ul
        LKD/GhfOMyStjXt5DQ+Uxl4PH2hvKkixULUcfYjZKB5YPsP6ktJEZQHCUFreaCAKainOCh
        gUJkbdbyrCwqjfOfTLH5irfQDkQINywwIBiLItXr+OMwG328K4EIme4k7LfeuP2ZVyRVNr
        bhfIz++xBdIDQUjNrA/+nMRE55vpZA+5RCjlc0GVezPy77xJTY/THAkCxICX/Q==
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
Subject: Re: [PATCH v3 05/17] dt-bindings: mtd: nand: Standardize the child node name
Date:   Thu, 17 Nov 2022 22:16:07 +0100
Message-Id: <20221117211607.1273550-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-6-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'488f19adf040329cbc0f9d3bea4829ccd0ebb57b'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 09:03:03 UTC, Miquel Raynal wrote:
> In almost all the schema mentioning a NAND chip child node, the name of
> the subnode contains a single index number.
> 
> In practice there are currently no controller supporting more than 8 cs
> so even the [a-f] numbers are not needed. But let's be safe and limit
> the number of touched files by just allow a single number everywhere, so
> in practice up to 16 CS at most. This value can anyway be limited in
> each schema.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
