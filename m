Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5E85BDF98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiITINc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbiITIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:12:53 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465A16554D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 01:11:23 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 64E2820003;
        Tue, 20 Sep 2022 08:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7AhZ/ZDIP3Pwi2ndC3tMWwpbduc1obZ/BRprK8FhIGA=;
        b=LRu6OI9HCs+P6a22iY4gLw38L1MOte9MHBOlsXlJXXwIJOXAfErSSYJHeCmAVV5QBwVN8T
        fntEcYgduBsXCdPYVhe6X1f2DKo3CRAGrXZP/uZaeh/53ltHZanm8kWi2l7zFMHjBKa7Ud
        Sj4Jib92IvWw5J3A/onZNt5G8b6ssP/tJUk/rXLdj8ltFLt8r7dgikW9zoMuvzznzixJq7
        Xe+vgCPC9BymRp3nbEqMi86uo2Fj6wBDFdHwZGSU5CTCKPqbRtF6rsyBcd6LXopoLbXFou
        dV5ej8IWTjCygpYCTfRFaCFmI9srKsMgQCCvCHABxGdemBSmP/wIiAQd9+4Oxg==
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
Subject: Re: [PATCH 1/2] mtd: rawnand: brcmnand: Move Kconfig to driver folder
Date:   Tue, 20 Sep 2022 10:11:18 +0200
Message-Id: <20220920081118.597448-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220711222323.4048197-2-f.fainelli@gmail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'bcd80bcc5d0f288ba33c69ea034b57a7b0adc63e'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-07-11 at 22:23:22 UTC, Florian Fainelli wrote:
> In preparation for allowing each of the brcmnand stub to be built
> separately, move the Kconfig entry to the driver folder.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
