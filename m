Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85796E3327
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 20:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDOSZV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 15 Apr 2023 14:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDOSZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 14:25:19 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028521FF7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 11:25:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A872F61989EA;
        Sat, 15 Apr 2023 20:25:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HXrk2pd79Qkr; Sat, 15 Apr 2023 20:25:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2977B622623A;
        Sat, 15 Apr 2023 20:25:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eyX8kgN0v4NL; Sat, 15 Apr 2023 20:25:16 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0433D61989EA;
        Sat, 15 Apr 2023 20:25:16 +0200 (CEST)
Date:   Sat, 15 Apr 2023 20:25:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        yi zhang <yi.zhang@huawei.com>
Message-ID: <779964919.69416.1681583115948.JavaMail.zimbra@nod.at>
In-Reply-To: <ZDnd7KmiRDhFuhhF@makrotopia.org>
References: <20230306013308.3884777-1-chengzhihao1@huawei.com> <20230324161923.1456371-1-nschichan@freebox.fr> <2c2c2ce9-795b-4f76-cde9-db4a4066dcc1@huawei.com> <20230329175421.3bd4906e@xps-13> <53992166.434647.1680125620704.JavaMail.zimbra@nod.at> <ZDnd7KmiRDhFuhhF@makrotopia.org>
Subject: Re: [PATCH -next v3] ubi: Fix failure attaching when vid_hdr offset
 equals to (sub)page size
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix failure attaching when vid_hdr offset equals to (sub)page size
Thread-Index: rtoansel+CM2fzJM4ah0aJIUiE8Hxg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
> As stable linux trees are affected I wonder when this will hit
> linux-stable, ie. will it be part of 5.15.108, for example?

Just sent out the PR to Linus.
As soon it is part of the next -rc, stable maintains can pick up the fix.

Thanks,
//richard
