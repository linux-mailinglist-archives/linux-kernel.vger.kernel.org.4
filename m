Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5720E6028DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiJRJ4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 05:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJRJ4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 05:56:34 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B40B1BB7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 02:56:28 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2770240014;
        Tue, 18 Oct 2022 09:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666086986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7sdgccbpHa+g3zogKwAbu/O/n6bb75oAZ7MRscSW22E=;
        b=JHLcgFzK6YP0A6jWc1XxIo4iH6XiZXHWhE9DbmL8sBS9TT6+zENJBif0SNVaOscqIKAk0d
        WKSPrVSceC7ukr6LCZxa60ATVVZN0y5y7oFCFSMrQybJlyIQNC4cOM+nLz54IYdlDPLSFN
        3zpdocxkCBm7axEvw4J89fbyH2abIIq1EcL8s//6h64xs6QoVuffXgTzQmpbFRekSFmn/k
        F4QxQ73xdTcRt+hNKXV/+NAMRedPuc3YiqZE7glDschYPRwLoTjctSuwmaU7Pcsi71vpUO
        Cgcc9cOdSQbw69CFxhW9/iYfGHyp/JmHc73CsyarVBrG+PYe5AY54igjWQmuSQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ray Zhang <sgzhang@google.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] mtd: mtdoops: change printk() to counterpart pr_ functions
Date:   Tue, 18 Oct 2022 11:56:24 +0200
Message-Id: <20221018095624.543287-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221010045549.2221965-2-sgzhang@google.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'de963c06fa578cb699505b26d7985fb2894372ab'
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

On Mon, 2022-10-10 at 04:55:47 UTC, Ray Zhang wrote:
> To comply with latest kernel code requirement, change printk() to
> counterpart pr_ functions in mtdoops driver:
> - change printk(INFO) to pr_info()
> - change printk(DEBUG) to pr_debug()
> - change printk(WARNING) to pr_warn()
> - change printk(ERR) to pr_err()
> 
> Note that only if dynamic debugging is enabled or DEBUG is defined,
> printk(KERN_DEBUG) and pr_debug() are equivalent; Otherwise pr_debug()
> is no-op, causing different behavior.
> 
> Signed-off-by: Ray Zhang <sgzhang@google.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
