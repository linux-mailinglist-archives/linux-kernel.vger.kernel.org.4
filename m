Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8826CF56F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjC2Vdr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Mar 2023 17:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC2Vdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:33:45 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA34211C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 14:33:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8E6B760719A6;
        Wed, 29 Mar 2023 23:33:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 2anPznKkB6Ly; Wed, 29 Mar 2023 23:33:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E19E8609D2FA;
        Wed, 29 Mar 2023 23:33:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Jhtf2j6S2kn1; Wed, 29 Mar 2023 23:33:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C3AE764548A7;
        Wed, 29 Mar 2023 23:33:40 +0200 (CEST)
Date:   Wed, 29 Mar 2023 23:33:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     chengzhihao1 <chengzhihao1@huawei.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        yi zhang <yi.zhang@huawei.com>
Message-ID: <53992166.434647.1680125620704.JavaMail.zimbra@nod.at>
In-Reply-To: <20230329175421.3bd4906e@xps-13>
References: <20230306013308.3884777-1-chengzhihao1@huawei.com> <20230324161923.1456371-1-nschichan@freebox.fr> <2c2c2ce9-795b-4f76-cde9-db4a4066dcc1@huawei.com> <20230329175421.3bd4906e@xps-13>
Subject: Re: [PATCH -next v3] ubi: Fix failure attaching when vid_hdr offset
 equals to (sub)page size
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix failure attaching when vid_hdr offset equals to (sub)page size
Thread-Index: XAujqRaYgCyfoBWH7qHDWkn/zHQjaw==
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
>> Thanks for testing.
>> 
>> > Tested-by: Nicolas Schichan <nschichan@freebox.fr>
> 
> Same here.
> 
> Tested-by: Miquel Raynal <miquel.raynal@bootlin.com> # v5.10, v4.19

Applied to next, PR will follow soon.

Thanks everyone!
//richard
