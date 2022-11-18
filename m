Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B28162F036
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241108AbiKRI4f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Nov 2022 03:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233055AbiKRI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:56:33 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F4E40905
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:56:31 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 48A0261989E3;
        Fri, 18 Nov 2022 09:56:29 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id GwV-ib3UAR4e; Fri, 18 Nov 2022 09:56:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C02E461989E9;
        Fri, 18 Nov 2022 09:56:28 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Zw0FgYgv4uWV; Fri, 18 Nov 2022 09:56:28 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id A1BCB61989E3;
        Fri, 18 Nov 2022 09:56:28 +0100 (CET)
Date:   Fri, 18 Nov 2022 09:56:28 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>
Message-ID: <16338722.252938.1668761788563.JavaMail.zimbra@nod.at>
In-Reply-To: <8207d8f9-8b30-cfbb-9a5f-56294cb35601@huawei.com>
References: <20221011034732.45605-1-chengzhihao1@huawei.com> <8207d8f9-8b30-cfbb-9a5f-56294cb35601@huawei.com>
Subject: Re: [PATCH 0/6] ubifs: Fix wrong space calculation while doing
 budget
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubifs: Fix wrong space calculation while doing budget
Thread-Index: uy1pHj0we5aN/s0rXTydNGW/V+d95Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
> An: "richard" <richard@nod.at>, "Sascha Hauer" <s.hauer@pengutronix.de>, "Miquel Raynal" <miquel.raynal@bootlin.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "yi zhang"
> <yi.zhang@huawei.com>
> Gesendet: Freitag, 18. November 2022 09:53:38
> Betreff: Re: [PATCH 0/6] ubifs: Fix wrong space calculation while doing budget

> 在 2022/10/11 11:47, Zhihao Cheng 写道:
> 
> Hi. Richard
> Just a reminding. Could you please look through following series(Some of
> them is sent several months ago), I wish these can be merged in 6.1,
> thanks a lot:
> 
> ubi infinite loop:
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=304485
> ubi uaf in sysfs:
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=311956
> ubi fastmap:
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=313063
> ubifs assertion failed about writepage:
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=302776
> ubifs space budget:
> https://patchwork.ozlabs.org/project/linux-mtd/list/?series=322220

Sure. Let me check what happened to them.

Thanks,
//richard
