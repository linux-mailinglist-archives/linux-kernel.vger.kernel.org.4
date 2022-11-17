Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2365462E6C1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240680AbiKQVSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240856AbiKQVRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:17:16 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88DA8C09B;
        Thu, 17 Nov 2022 13:15:44 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id BD16A60002;
        Thu, 17 Nov 2022 21:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VBW8P64uZ+Zle2ji1+nCtWJBZ/3uNumEr3WsRPfM5tI=;
        b=f1Y0OLS1JKCv9alo/8NgEa9uo480zXj9+AnN+RFXbqr8EEoBym2Ok0Y+CZnd+tufa3FpJp
        IEHdE2EVv++EiZ2Y8IZRHeOAXKrbZ2iLrwaYFZj4K5CDIMosj7MISlCyb6Qbmqoy9KldWm
        HR91TYRZktBtxyU3nCKZ3abyjISj+HWalom0p/YDESqy4xZPufypQw/aCIyzOQN2jlPfzL
        GKVycOMRsHuAeWXGh5ai3GfGUUQM7S7QmjcWWZR4wEdkhfFHPaXotXOHVTeMysrvENx//h
        pShZdLmIagMBmDYX0OY+z9DHfy+MCPmkKtBN4Hxhyoc1YdrmiVSqvBXtCpOPJw==
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
Subject: Re: [PATCH v3 10/17] dt-bindings: mtd: physmap: Reuse the generic definitions
Date:   Thu, 17 Nov 2022 22:15:41 +0100
Message-Id: <20221117211541.1273405-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-11-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'7bdc671822e9099dd5328431867e4cf718b107f5'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 09:03:08 UTC, Miquel Raynal wrote:
> The memory mapped MTD devices also share a lot with all the other MTD
> devices, so let's share the properties by referencing mtd.yaml. We can
> then drop mentioning the properties, to the cost of mentioning the
> possible "sram" node name prefix.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
