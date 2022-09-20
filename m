Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04BB5BDFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiITIUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 04:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbiITITt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 04:19:49 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE7462AAD;
        Tue, 20 Sep 2022 01:16:09 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 4490B1C0008;
        Tue, 20 Sep 2022 08:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663661767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=434CYzGHoeQ4qHxNxhE6pXALGn7X7EKGl1rtwJm3bK4=;
        b=ZPGjlAit17atuof15FaXUrBLyKVdGNftJ8FLQs+COWDU0y/lgWv/ibmq6nm0TeASzV0aXM
        Q3KVv1J+pOW+UYdDkb2LwQwiJVPm3i3XqLame+6ZyS7iq85pAd71y0e/H7u+gK2tTQVGFw
        T/4Ksu4zdPtYTMxkPxWzbI6rPrJwzdS7IYyRW+MTvdNnAL3jCWs6WQkEudwL94kMeNkscA
        9mdl0JwkoJY4oj1muVJGI8LLSaL44FcmqIYtdMXJjHp8bV/aGJXvqyGVtoAqtA8KTXmCd6
        stK/3Kmt+6JZSIy6ZJb9xFL9IdyuEFbmFQiqnJ0jxBW6Dzyo4K6LH827kyBg3A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, tlanger@maxlinear.com,
        rtanwar@maxlinear.com, richard@nod.at, vigneshr@ti.com
Subject: Re: [PATCH v3 5/8] mtd: rawnand: intel: Don't re-define NAND_DATA_IFACE_CHECK_ONLY
Date:   Tue, 20 Sep 2022 10:16:04 +0200
Message-Id: <20220920081605.598208-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220702231227.1579176-6-martin.blumenstingl@googlemail.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'ebe0cd60fcffd499f8020fde9b3b74acba9c22af'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-07-02 at 23:12:24 UTC, Martin Blumenstingl wrote:
> NAND_DATA_IFACE_CHECK_ONLY is already defined in
> include/linux/mtd/rawnand.h which is also included by the driver. Drop
> the re-definition from the intel-nand-controller driver.
> 
> Fixes: 0b1039f016e8a3 ("mtd: rawnand: Add NAND controller support on Intel LGM SoC")
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
