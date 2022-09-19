Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB205BD218
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 18:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiISQUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 12:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbiISQUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 12:20:43 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E0C2FFD8;
        Mon, 19 Sep 2022 09:20:38 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DDB72240007;
        Mon, 19 Sep 2022 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663604437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5IUMqLbULQGbkIxRFBE/MsSYr16nbj1/byQGJmLuwso=;
        b=WVABEvgJBcNLslhplq1oL+SjAr23CTx3KssJggxY2hm/Y7i0I9yIBEblZPt2ig14/tvwG2
        uskvuK9GwOEs8xzwXsGANn+dKpPs6ads6KlPo0ZCeZcUvhm9RbDrcLq/k6jfxprFUWMEDK
        dqRjgIDmRE9VR8yh9RvAhBzjnUdAF2wXlXuUHYh6M4X+oC++2fsUS3mDWgH6XJLkvMTIqm
        h8xJj5ACiPAAf3QLhavm3qF6NK1GlAg4E39oipAr0rIVzsmZJfqMvYFtWU5VYm/Z15tVSv
        srhDiuzqcBWZt0kYn7n6W4n86hiyiJQjPFnn3jlnkECstMMX5SIOX7r39GIpUQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        bcm-kernel-feedback-list@broadcom.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH 1/2] dt-bindings: mtd: partitions: add binding for U-Boot bootloader
Date:   Mon, 19 Sep 2022 18:20:34 +0200
Message-Id: <20220919162034.226938-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711153041.6036-1-zajec5@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'27bfb201b2c03c8a033b60e5ad80cbf3aaa52b94'
Content-Type: text/plain; charset=UTF-8
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

On Mon, 2022-07-11 at 15:30:40 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Right now there is no (known) real reason for a custom binding for
> standard U-Boot partitions. Broadcom's U-Boot however requires extra
> handling - looking for environment variables subblocks. This commit adds
> Broadcom specific binding.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
