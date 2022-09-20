Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C95BDFD2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiITIUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiITITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:50 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC1F65569;
        Tue, 20 Sep 2022 01:16:21 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C05C820008;
        Tue, 20 Sep 2022 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661778;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mH4eJDdPeIqnWGX47G1oaR2YkiazldZdxhkY5UwFwf4=;
        b=cRH0E2cqS51/jK4yOvuWNKN5e6gDq6SAA+3shEKWWsol51puOB0hotgRClGRvjh08MHJNb
        TemEqsUMVccqjn++FwFQQl1Gtby5VOVAq9ojGoDwFmmLuiq/DVRMS/1vTUPTUbZ+NElRfR
        zmWDEoM9wseY+mbV+/B01AnnwtolStQEEnQwLJ0y66gcZkY7qUJ5Kce5hEBl/lkI/V8q/j
        bqhhbP83rD9Z5+CBPY7q04iHFPl5qrS26C6PJ+zUIDQmm4GHzTCV+KX6dcMoGuJl5yqUtj
        jXozZNUuvawje5j9nMGC5xXByqVHpdM1+xt+8s8/4Or33LNmqr8abS13SxWWpg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, richard@nod.at, vigneshr@ti.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/8] dt-bindings: mtd: intel: lgm-nand: Fix maximum chip select value
Date:   Tue, 20 Sep 2022 10:16:15 +0200
Message-Id: <20220920081615.598292-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220702231227.1579176-3-martin.blumenstingl@googlemail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9fac2a193e4553d6ce093a626ef5920c362d0753'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-02 at 23:12:21 UTC, Martin Blumenstingl wrote:
> The Intel LGM NAND IP only supports two chip selects: There's only two
> CS and ADDR_SEL register sets. Fix the maximum allowed chip select value
> according to the dt-bindings.
> 
> Fixes: 2f9cea8eae44f5 ("dt-bindings: mtd: Add Nand Flash Controller support for Intel LGM SoC")
> Acked-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
