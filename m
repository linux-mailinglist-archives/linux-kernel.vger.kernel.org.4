Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC9AF6028E1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiJRJ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiJRJ50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:57:26 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BACB2750;
        Tue, 18 Oct 2022 02:57:03 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D520E40005;
        Tue, 18 Oct 2022 09:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666087021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mN1nF865lcYvGYr15lBFejksJf9Opi3qv1C6xgzF7XQ=;
        b=WFsEmwGR/1G/8LsTF34HJ7HaWiGic2GjgChlx0ughwU4l3w80QbMyzR+ujdziXVF+fqKIV
        ksLwEPzIWeNYv4qYMA92gCyPFhfy0jVLAsHwqYs8VJ1rdwbHuPAWIBh3+P71Z5BQMsKhUk
        YURnw3qRB4BTrwxCgssLTL/wOqdpXPshLcjLdQke7UK4wEoJeIkACTE8Muxb9Vahz6tIyU
        KBRPW/vOp9Tt2KE3wy5Ozza68IgIcWCz7zk8hEtkXdPd2GAB1Md2uyEUdqIrSGFdFHGmTy
        Frjhr50khfPWLspHF6hYliBmpyMBWigPeKgw6DFWkF0NGLfX4FXulcNgxu+BLw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     ansuelsmth@gmail.com, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?b?UmFm?= =?utf-8?b?YcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V2 1/2] mtd: core: simplify (a bit) code find partition-matching dynamic OF node
Date:   Tue, 18 Oct 2022 11:56:59 +0200
Message-Id: <20221018095659.543383-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221004083710.27704-1-zajec5@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'63db0cb35e1cb3b3c134906d1062f65513fdda2d'
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

On Tue, 2022-10-04 at 08:37:09 UTC, =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Don't hardcode "partition-" string twice
> 2. Use simpler logic & use ->name to avoid of_property_read_string()
> 3. Use mtd_get_of_node() helper
> 
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
