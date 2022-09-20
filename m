Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F65BDF97
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiITINn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiITIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:12:53 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B47065566
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:11:18 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 72B18E0014;
        Tue, 20 Sep 2022 08:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661476;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/aDi97q7WLzJZ7h57IhprMRU3z7CPClkMT5+WoehnE=;
        b=BKt84ZhgIyptoGTwgRSWm2bKqo0HXbKqTq7/RcDdR5K+NENd2kN3L3iYrY28xyD02CurNI
        VUkSzPB6sFh/125yORNzYJSh2Yf0q5nlsaFHBe/hs2wDjifRTZ2R9P0L4tbWLZMay9QDo2
        lC3Qy8Oxv+9+/gPwbB3cnAnvtIT/yjleAvolyK5mzEWCNqR6wj/Y4lTo1rrgkAA6mwLKH2
        32Zp7aBUGGbH07AMC7nbaEa8VfTiIJ5PuM/Rr0BkoqhwzyZlEWRCMTRI8MxNxbd9tAD+yb
        Jh+mR9CHqAqHeCACuR35P87R3FLa4+EcJu5+pRsag/Vou5lL5oB8a7+pYjiQYg==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-mtd@lists.infradead.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Roger Quadros <rogerq@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Colin Ian King <colin.king@intel.com>,
        linux-kernel@vger.kernel.org (open list),
        William Zhang <william.zhang@broadcom.com>
Subject: Re: [PATCH 2/2] mtd: rawnand: brcmnand: Add individual glue driver selection
Date:   Tue, 20 Sep 2022 10:11:13 +0200
Message-Id: <20220920081113.597419-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711222323.4048197-3-f.fainelli@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'58fac217aeef7cfbffd24bb8be5b2db0ba52d161'
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

On Mon, 2022-07-11 at 22:23:23 UTC, Florian Fainelli wrote:
> Allow each platform to define a dedicated Kconfig entry for its glue
> driver such that we can decide on a per-platfomr basis whether to build
> it or not. This allows for a finer grained control over the resulting
> kernel image or set of modules.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
