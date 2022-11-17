Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964D962E6D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240965AbiKQVTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240919AbiKQVSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:18:11 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4697885EDE;
        Thu, 17 Nov 2022 13:16:25 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1E0A7240008;
        Thu, 17 Nov 2022 21:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nRtYi3vYAjLpXY8WOHa/2dwKQFZjvZN8mIZraBpZzEk=;
        b=BLShnR/1Af40KpIte5jrwnELaBV6DiP1fBs5XVWINc3DailaLKAIJwzLp6bCkDWA1Fe0+z
        V7hD+c7sIVDW48Hbh0TCVB4CwBGBitBXqmEuCDLfpsuBpK8CIX9+lj3WCnAlik4XzSCQkD
        2sw3XSFH8BEL6NtEl+uWhQsIreAQRcgmEXAMPIL6w9IJvr1ikcNYkuAG4F6rH9h27Ijnep
        m/FurlYs+MkzD4aEis+SBMe3h7usNMpLHbU1vMN0U6jG5/HeYoXD/gWqiEiqMJG5NNiUSg
        nvadVGzPD7PHrbsGxIadmYi/lLyPPCEODjCu43mj2p3/9bHv2J876D7REeoexg==
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
Subject: Re: [PATCH v3 02/17] dt-bindings: mtd: Remove useless file about partitions
Date:   Thu, 17 Nov 2022 22:16:21 +0100
Message-Id: <20221117211621.1273636-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-3-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'f902baa917b6c1f2d70d008b2ebbe5acf79ba392'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 09:03:00 UTC, Miquel Raynal wrote:
> There is already a real partitions.yaml file, so assuming everybody
> knows hot to read yaml schema now, this text file is no longer needed,
> so drop it.
> 
> Depending on the situation, the lines referring to this file are either
> dropped or edited to point to mtd.yaml which includes partition{,s}.yaml.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
