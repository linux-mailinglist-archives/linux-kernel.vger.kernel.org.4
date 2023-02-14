Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609A5696935
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjBNQVO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Feb 2023 11:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBNQVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:21:13 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A954C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:21:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9D494642ECB2;
        Tue, 14 Feb 2023 17:21:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oBhXB59KN0Js; Tue, 14 Feb 2023 17:21:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4AC93642ECD2;
        Tue, 14 Feb 2023 17:21:08 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id g0ffR7oKKqVt; Tue, 14 Feb 2023 17:21:08 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2C24A642ECB2;
        Tue, 14 Feb 2023 17:21:08 +0100 (CET)
Date:   Tue, 14 Feb 2023 17:21:07 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Message-ID: <290910672.129444.1676391667993.JavaMail.zimbra@nod.at>
In-Reply-To: <Y+uztjxDdtFy6MJ4@makrotopia.org>
References: <cover.1671737443.git.daniel@makrotopia.org> <Y+uztjxDdtFy6MJ4@makrotopia.org>
Subject: Re: [PATCH 0/2] ubi: wire up parent device
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: wire up parent device
Thread-Index: gBfXjFgR7YDPiBgMRLukfCC3XAUgvw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> I've only recently noticed that this series is marked as 'Accepted' in
> patchwork. However, I fail to find the commits in any public linux
> tree, nor has patchwork sent the usual notification email informing me
> about it being accepted.
> 
> Can it be that it has slipped under the table (or even the carpet)
> somehow?
> 
> Please let me know if there is anything wrong with this series and/or
> if I should re-submit it, or if I shall just wait for it to surface in
> linux-mtd or linux-next.

The patches are in linux-ubifs #next and in linux-next itself.
See:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=05b8773ca33253ea562be145cf3145b05ef19f86

So, all good. :-)
 
Thanks,
//richard
