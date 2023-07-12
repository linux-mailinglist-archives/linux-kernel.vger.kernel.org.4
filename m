Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2C0750A8E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjGLOO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjGLOO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:14:26 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1051BEA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:14:16 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A36060016;
        Wed, 12 Jul 2023 14:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689171255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wrX5+Xt3jD73MWezAMWISqvmWFhWEE1LiE9fY/yhD8A=;
        b=DsmhjPNxwlxrzvnl0fQ/M/idjtnbpdM9HhDp9KacOexRe6OJWef2G1kNP9zj8X/fmRw8j4
        KbNXOTykVLax5b7BbaHJ0wLGqtezXorbeAFu2wOtM3tRgZ7XFkn2eidBMbB5X/oF+gaf38
        otHCYzFzp7b8kqLHTwJ0P9/1aBY5792bvTyQGu4bWrnjlt93dIvi8aRBRZvlWOPGzcqb0Q
        LZKSRnlt+sL+ZcXHp4owp662oSPxJyX3iOaEwWlkpYt4yujMjt45YgYbAPLmnsqohKeEDz
        0fNzdkXW1cBT5GD7kfKisPj+ySbENorxMXSm4YWj/cBRr444HvvWMmchumMXQQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] mtd: use refcount to prevent corruption
Date:   Wed, 12 Jul 2023 16:14:01 +0200
Message-Id: <20230712141401.354961-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230620131905.648089-2-alexander.usyskin@intel.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'19bfa9ebebb5ec0695def57eb1d80de7e9cab369'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-06-20 at 13:19:04 UTC, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
> 
> When underlying device is removed mtd core will crash
> in case user space is holding open handle.
> Need to use proper refcounting so device is release
> only when has no users.
> 
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
