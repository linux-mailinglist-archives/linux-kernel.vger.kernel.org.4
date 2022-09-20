Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6BA5BDFBD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiITIUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:20:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiITITm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:42 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4EC65552;
        Tue, 20 Sep 2022 01:16:03 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2440C1C0015;
        Tue, 20 Sep 2022 08:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=irYS8rB2BM2PxXgnGQ/bb//+3yKCxrRzr5QdV9zBcVw=;
        b=KsomwEOTSWXQXQglkRXNCnyQ+Prt2w37XfRkvwipz8XgK0g+uTPSACMbHiJFljASYg8kDQ
        Pc3AGWN9WW95iDwFafIoOeRqq50XLrI02rMC0mfL0xh1LjLbcUriDeC61Svdbz1oP73pUm
        WZk4xEeXaec39Xlb4gvl/ca3t8opEK+VYWRj70N0vpu0iO9oheiJPN5B7kSs3Kn0bjeb8M
        9mQJS7FEGrxzw6sH0tlYfqktNpl/G5824sP/89OvxQTrXEyUYP2Eq/rFh001wDRdUqAkx5
        K2cp5Q73XGcAaG3yLi3HB4cH57j6q0onCxVUceONhOGcMuJkl8GrVvBI7Cqksg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v3 8/8] mtd: rawnand: intel: Use devm_platform_ioremap_resource_byname()
Date:   Tue, 20 Sep 2022 10:15:54 +0200
Message-Id: <20220920081554.598124-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220702231227.1579176-9-martin.blumenstingl@googlemail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'7471a53ddce54cee9b7a340dc930eb35b02c9eed'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-02 at 23:12:27 UTC, Martin Blumenstingl wrote:
> Switch from open-coded platform_get_resource_byname() and
> devm_ioremap_resource() to devm_platform_ioremap_resource_byname() where
> possible to simplify the code.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
