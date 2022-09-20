Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB055BDF79
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiITINX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiITIMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:12:51 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249865551
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:11:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6037B20000C;
        Tue, 20 Sep 2022 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6HIvGTQ94NzYXeOw7DginZZyHpaS9ym0PLAPepQcbQ=;
        b=VA6kz+d5kqpPydi/8WrQ3OrEqTTrEXyqrumjXaNOfgZe8/uDXIpFUI/v7YvWtSNe8RvNRj
        lc5e2NCftFUp3GVSna/zmAbKGex3UjKgaJA4qLjhAQeDHsSY35YlZp3zOWPdklSs2y317e
        902l0V1roEqt2N1z3fdzKLE/JF/uWSq04TDfQfM/3eQDbl7FdZwpyNNPCPeMJewNm2bfjb
        83dm2VLi60ZZbYOnY8yLNwBisBmcxsb9x1uQURrnZObABJ7IOHLgCgjmN9q91HUy0wAv3J
        FR7VduKJVusiXnAnXRDLzGJaoEaBNuxwddIVRsF+gp/fUT5gwe5AGGR/nUonQw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "GONG, Ruiqi" <gongruiqi1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Wang Weiyang" <wangweiyang2@huawei.com>
Subject: Re: [PATCH] mtd: rawnand: arasan: stop using 0 as NULL pointer
Date:   Tue, 20 Sep 2022 10:11:03 +0200
Message-Id: <20220920081103.597363-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220725112108.686347-1-gongruiqi1@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'dfa196253c57166b2182872e15dee75124066193'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-25 at 11:21:07 UTC, "GONG, Ruiqi" wrote:
> Fix the following sparse warnings:
> 
> drivers/mtd/nand/raw/arasan-nand-controller.c:918:70: warning: Using plain integer as NULL pointer
> drivers/mtd/nand/raw/arasan-nand-controller.c:918:73: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
