Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AA46A6BAE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjCAL2R convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 1 Mar 2023 06:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjCAL2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:28:15 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B76D72A4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:28:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 229AC6382EF7;
        Wed,  1 Mar 2023 12:28:10 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id VzUUj5x2PD0C; Wed,  1 Mar 2023 12:28:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7BDF86382F03;
        Wed,  1 Mar 2023 12:28:09 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id uELCjn1QVamu; Wed,  1 Mar 2023 12:28:09 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 565826382EF5;
        Wed,  1 Mar 2023 12:28:09 +0100 (CET)
Date:   Wed, 1 Mar 2023 12:28:09 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1637751218.187351.1677670089216.JavaMail.zimbra@nod.at>
In-Reply-To: <299a85b4-aea5-b8b8-394f-4b7093b6a754@huawei.com>
References: <20230215022507.2363193-1-chengzhihao1@huawei.com> <9121ae91-5b4f-4b10-46fc-6cc0683c949d@huawei.com> <34189394.187159.1677657964794.JavaMail.zimbra@nod.at> <299a85b4-aea5-b8b8-394f-4b7093b6a754@huawei.com>
Subject: Re: [PATCH v2] ubifs: dirty_cow_znode: Fix memleak in error
 handling path
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: dirty_cow_znode: Fix memleak in error handling path
Thread-Index: jI6dxxZj4vvQSlt0IvLuiHnakpyrZA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>
> CC: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Sascha Hauer" <s.hauer@pengutronix.de>, "linux-mtd"
> <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>
> Gesendet: Mittwoch, 1. März 2023 12:13:59
> Betreff: Re: [PATCH v2] ubifs: dirty_cow_znode: Fix memleak in error handling path

> 在 2023/3/1 16:06, Richard Weinberger 写道:
>> We cannot replace the patch in linux-next, the merge window is already open.
>> A follow up fix is possible after 6.3-rc1 is done. So, next week.
> 
> It's okay, thanks. I will send fix patch again after 6.3-rc1.

You can send it right now. But I have to wait a bit.

Thanks,
//richard
