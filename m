Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B756A688C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 09:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjCAIGM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Mar 2023 03:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjCAIGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 03:06:11 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2F830EA4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 00:06:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BA09E6382EFB;
        Wed,  1 Mar 2023 09:06:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zrNmv9WCWaJ6; Wed,  1 Mar 2023 09:06:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 28CD56382EFF;
        Wed,  1 Mar 2023 09:06:05 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id isM9H1l8qKaD; Wed,  1 Mar 2023 09:06:05 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 000806382EFB;
        Wed,  1 Mar 2023 09:06:04 +0100 (CET)
Date:   Wed, 1 Mar 2023 09:06:04 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <34189394.187159.1677657964794.JavaMail.zimbra@nod.at>
In-Reply-To: <9121ae91-5b4f-4b10-46fc-6cc0683c949d@huawei.com>
References: <20230215022507.2363193-1-chengzhihao1@huawei.com> <9121ae91-5b4f-4b10-46fc-6cc0683c949d@huawei.com>
Subject: Re: [PATCH v2] ubifs: dirty_cow_znode: Fix memleak in error
 handling path
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: dirty_cow_znode: Fix memleak in error handling path
Thread-Index: X90c9wAR7xc40YmoflX3D/iimRonEw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> Just a reminder to notify that this is a v2 fix to replace original
> solution (which is in next branch)
> https://patchwork.ozlabs.org/project/linux-mtd/patch/20221118090236.664244-3-chengzhihao1@huawei.com/.

We cannot replace the patch in linux-next, the merge window is already open.
A follow up fix is possible after 6.3-rc1 is done. So, next week.

Thanks,
//richard
