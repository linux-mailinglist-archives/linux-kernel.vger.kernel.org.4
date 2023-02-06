Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2DC68BC21
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 12:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBFLzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 06:55:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjBFLz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 06:55:29 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CC9E22DD0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:55:25 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D8273240005;
        Mon,  6 Feb 2023 11:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675684523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jilgdZMYBDG0g0b3kjgZTGVaf8ZHW1xW/txAPD3ybGU=;
        b=Uv6s0gf1wUs5U8zAu6tPeMur8xwv3BQqk32wbHvq0/Zd6vEXt4EJ8s0JLwTj9fqQLDNX3Y
        2j+FItCYJtOvtiCSQS9BTiweSu8bKimCQOoIQq1HmnqSsaaUqsKND7CfbyWKLFUisHCvXM
        Cv+tKfqcbAXv7LNLQvwpAq4cLgq4yq6fvaBZU6u4UOCyWBIy+iqSvtPQFBtR7dR3iq8iNQ
        MXqh4pEBN30IyeqLlrSQhml2lYlgnrtiBYPG1/lSIltfczCG9pfbYVmqhqRBT3wO1guUl3
        XI8LHtv+eDcypuG6ATgsRmf38C9pDIVVOn/Z6EIa6oNns9xSoGs6KjjG+DwvVQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Samuel Holland <samuel@sholland.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 2/3] mtd: rawnand: sunxi: Embed sunxi_nand_hw_ecc by value
Date:   Mon,  6 Feb 2023 12:55:20 +0100
Message-Id: <20230206115520.560842-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230204143520.9682-3-samuel@sholland.org>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ac1c7072e38e492b27353a6e7b144e64cbbf9495'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2023-02-04 at 14:35:19 UTC, Samuel Holland wrote:
> The sunxi_nand_hw_ecc object is not shared, and it has the same lifetime
> as the sunxi_nand_chip which points to it, so we can embed it in the
> outer structure instead of using a pointer. This removes an unnecessary
> memory allocation and simplifies the error handling code.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
