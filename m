Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093EB6EB380
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 23:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbjDUVSX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 21 Apr 2023 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjDUVSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 17:18:21 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F251B1FF0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 14:18:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7B69B63CC16F;
        Fri, 21 Apr 2023 23:18:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SnRLdqdW0iV1; Fri, 21 Apr 2023 23:18:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 17D266418F2B;
        Fri, 21 Apr 2023 23:18:16 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id auZ6_yP3xkVD; Fri, 21 Apr 2023 23:18:16 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EC79563CC16F;
        Fri, 21 Apr 2023 23:18:15 +0200 (CEST)
Date:   Fri, 21 Apr 2023 23:18:15 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>
Message-ID: <1751647898.236371.1682111895850.JavaMail.zimbra@nod.at>
In-Reply-To: <20230318015621.1408243-1-wangzhaolong1@huawei.com>
References: <20230318015621.1408243-1-wangzhaolong1@huawei.com>
Subject: Re: [PATCH 0/5] ubi: Enhanced fault injection capability for the
 UBI driver
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Enhanced fault injection capability for the UBI driver
Thread-Index: zOuMq5RgU5mOajBYreOdiSG1qqplFg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
> The existing fault injection capability of UBI is too simple.
> It uses hard-coded fault probability values and lacks other
> configurable options. As a result, these interfaces are difficult
> to use when digging defects in the abnormal path of code and
> reproducing some problems.
> 
> The kernel provides a powerful fault injection framework, which
> provides rich configurable fault injection attributes during runtime.
> So it can be used to improve the fault injection capability of the
> UBI driver.
> 
> This series of patches refactor the existing fault injection interface
> and add some fault injection types to help testers and developers
> find potential problems in the code.

In general I like having some new and advanced way to test UBI.
But your patches seem to remove the old interface from debugfs,
this will cause breakage of existing test scripts.

So please keep the old interface too.

Thanks,
//richard
