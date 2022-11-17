Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D62862E6D0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbiKQVSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:18:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240943AbiKQVSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:18:04 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE785EC6;
        Thu, 17 Nov 2022 13:16:15 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6231F10000A;
        Thu, 17 Nov 2022 21:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668719774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qw+ifOlJtc4kQJj7dswRvNQCovTkxmadZAaIJDyO/sY=;
        b=ISodbx/LUIWnXMaG6fZ9XXN9mjvydlLpNVyO+Q2VVpfIBVlyiA1pfsO66T/3XjX1B5ep/M
        IDYYahpYgRvTB0FUXclcrte9BkwK+XPcQ1MGPFz+3aRohz5o2vanupgEDKGy7TeWUKvVtP
        fiQlUEunEpGlqgcJaLCeslTX2VsRH3vVJU+HBK1U6eBQGUjJVGnyQ8DJ5j1Bh/qiuI9n4y
        /L1S7BG1+QtTp1bkUhIQgRfM4dMbuHPJPm66Y+M2KbIzX9W4uIIuGH8VvZ3mzeSJrNPr4l
        7pSt6PXhLZIuSoeEKIrC5Q2SEUUszzPXNzBimeIfS6DO5N3J+jTYUsVe1OIXuA==
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
Subject: Re: [PATCH v3 04/17] dt-bindings: mtd: nand: Drop common properties already defined in generic files
Date:   Thu, 17 Nov 2022 22:16:11 +0100
Message-Id: <20221117211611.1273578-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221114090315.848208-5-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'e598511b0bfe7d9fd5165d53f1afb94e1a9be62d'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-11-14 at 09:03:02 UTC, Miquel Raynal wrote:
> generic files, so let's drop these properties from the individual NAND
> controller bindings when no additional information is provided rather
> than the possible presence of the property.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next.

Miquel
