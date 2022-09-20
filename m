Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0E05BDF89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiITIN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiITIMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:12:52 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB0F63F27
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:11:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3847EE0006;
        Tue, 20 Sep 2022 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FYw776a8tiBkeyoGWt+RRk/t/WHYRfwOtyHykS/tkzo=;
        b=gOs5kzRTn1wMng7I6nEFJVmYTCVJ/tFQfTfrm6yznxfQzbyQfXgcMe4grn+JJT0nh5baft
        3axkTi/8KTWa2m6OxlU1me4r97PZtLGtAmfg0Xf37QHpXH4jAt2ffihGrHxaXWEQzyMAAq
        Wj+XfrDt4hSmVscS23Nvd9eGYi9YguUNvNKsJw+y/OIzjLF1WuloDIa36RBClkUUT4dmfn
        jxBeA+H/bz2v9XG6TrhrxZGgdzIIJVZcRH6PFC+gRKgTu69DHP4VheYMtZ9NyYTSAYaw47
        MHGAyjfexOlgPl0lIUxWAdqE04/ctGUI67MHyOMwWOA5knYTmCOiEeqHaEzrVw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Slark Xiao <slark_xiao@163.com>, han.xu@nxp.com,
        miquel.raynal@bootlin.com, vigneshr@ti.com, richard@nod.at
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: gpmi: Fix typo 'the the' in comment
Date:   Tue, 20 Sep 2022 10:11:07 +0200
Message-Id: <20220920081107.597391-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220722072850.72797-1-slark_xiao@163.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'12e971b21caf069e4cae9720cfc70e200b24992b'
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

On Fri, 2022-07-22 at 07:28:50 UTC, Slark Xiao wrote:
> Replace 'the the' with 'the' in the comment.
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
