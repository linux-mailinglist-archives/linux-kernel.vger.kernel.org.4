Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F15E696906
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBNQP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjBNQP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:15:57 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F390EB6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:15:56 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pRxyE-0005lS-0D;
        Tue, 14 Feb 2023 17:15:54 +0100
Date:   Tue, 14 Feb 2023 16:15:50 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 0/2] ubi: wire up parent device
Message-ID: <Y+uztjxDdtFy6MJ4@makrotopia.org>
References: <cover.1671737443.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1671737443.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've only recently noticed that this series is marked as 'Accepted' in
patchwork. However, I fail to find the commits in any public linux
tree, nor has patchwork sent the usual notification email informing me
about it being accepted.

Can it be that it has slipped under the table (or even the carpet)
somehow?

Please let me know if there is anything wrong with this series and/or
if I should re-submit it, or if I shall just wait for it to surface in
linux-mtd or linux-next.


Thank you!


Best regards


Daniel


On Thu, Dec 22, 2022 at 07:32:46PM +0000, Daniel Golle wrote:
> Wire up device parents of UBI devices and ubiblock devices (UBI volume
> devices are already correctly wired to their parent UBI device). This
> makes more sense than having UBI devices free-standing in
> /sys/devices/virtual/ubi/ without any connection to their parent MTD
> device, and ubiblock devices in /sys/devices/virtual/block/ which would
> be better hosted by the UBI volume device they belong to.
> 
> The purpose of these changes is to allow downstream tools to more
> easily identify UBI<->hardware relationship, and potentially also
> improve power management and scheduling performance in future.
> 
> Daniel Golle (2):
>   mtd: ubi: wire-up parent MTD device
>   mtd: ubi: block: wire-up device parent
> 
>  drivers/mtd/ubi/block.c | 2 +-
>  drivers/mtd/ubi/build.c | 1 +
>  drivers/mtd/ubi/kapi.c  | 1 +
>  include/linux/mtd/ubi.h | 1 +
>  4 files changed, 4 insertions(+), 1 deletion(-)
> 
> 
> base-commit: e45fb347b630ee76482fe938ba76cf8eab811290
> -- 
> 2.39.0
> 
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
