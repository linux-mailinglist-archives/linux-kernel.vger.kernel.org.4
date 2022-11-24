Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B18D6377C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 12:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiKXLgQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 06:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiKXLgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 06:36:12 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [217.70.178.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DF976DF
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 03:36:09 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7400C100002;
        Thu, 24 Nov 2022 11:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669289768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vr8bKLhT8q0qJhXyoRNU+MZCNNRnvBRG3Flc0FO22Po=;
        b=lIYedw9PzsJwyvr2iLyIsekayL8TQ9T7L8ilsyaYrh1OsGq8eO54sQ1lBO+Jp1ZMt/T7jV
        gLH9o4goJJUBju+rZX1LeewHujdewqrR47jXQgE0HDn4NW4gxmMn50RkVp/ma3I+Vw0VjF
        4iV1w8xkpmoD3RrCjI9X2HvCxQWoTljEP8y/NiV3m6oQkvIggCc9SnN7GF1ssm5O6jUQ6u
        nbjO8/6C7LLf9enTjYFIDeyPW4O0QhnRnNm/xTH3UEssY0+oglMkXU/DuNgPegZM2tESVV
        cXAIDFJOuGuwfOQMlZvEa5VfPSVUjdTDLFLleeA8ygsI8AOOzUogEN/yDhF0yw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: fix memory leak in pxa2xx_flash_probe()
Date:   Thu, 24 Nov 2022 12:36:06 +0100
Message-Id: <20221124113606.266257-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221119073307.22929-1-zhengyongjun3@huawei.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2399401feee27c639addc5b7e6ba519d3ca341bf'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-11-19 at 07:33:07 UTC, Zheng Yongjun wrote:
> If '!info->map.virt' or '!info->mtd' success, 'info' should be
> freed before return. Otherwise there is a memory leak.
> 
> Fixes: e644f7d62894 ("[MTD] MAPS: Merge Lubbock and Mainstone drivers into common PXA2xx driver")
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
