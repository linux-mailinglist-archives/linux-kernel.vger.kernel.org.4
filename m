Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6F0474F530
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjGKQbC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjGKQbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:31:00 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9ABE60;
        Tue, 11 Jul 2023 09:30:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 30D7962F2910;
        Tue, 11 Jul 2023 18:30:52 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 8R4yn2ky6m_j; Tue, 11 Jul 2023 18:30:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9C74861A7038;
        Tue, 11 Jul 2023 18:30:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id u99T18Ks9BIc; Tue, 11 Jul 2023 18:30:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6400E61989ED;
        Tue, 11 Jul 2023 18:30:51 +0200 (CEST)
Date:   Tue, 11 Jul 2023 18:30:51 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Yang Rong <yangrong@vivo.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        opensource kernel <opensource.kernel@vivo.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lu Hongfei <luhongfei@vivo.com>
Message-ID: <2014273324.2321953.1689093051254.JavaMail.zimbra@nod.at>
In-Reply-To: <743f4445-31a6-0e51-f432-08033bdcaf20@web.de>
References: <20230711020752.2344-1-yangrong@vivo.com> <743f4445-31a6-0e51-f432-08033bdcaf20@web.de>
Subject: Re: [PATCH v3] mtd: core: Fix resource leak in a
 for_each_child_of_node() loop
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: core: Fix resource leak in a for_each_child_of_node() loop
Thread-Index: O0iikkkuA+X93639t1xDfOZiQ6wdMQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Markus Elfring" <Markus.Elfring@web.de>
>> v2: https://lore.kernel.org/all/20230710061412.2272-1-yangrong@vivo.com/
>> The modifications made copared to the previous version are as follows:
> 
> How do you think about the omission of a line here
> (so that a repeated typo can be avoided)?
> 
> Would the subsequent enumeration look a bit nicer if each text item
> will be delimited by a space character?

Markus, just stop it.

Thanks,
//richard
