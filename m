Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A9F6CC088
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 15:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjC1NV7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 28 Mar 2023 09:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1NV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 09:21:57 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915887285
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 06:21:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 86ABF64548A5;
        Tue, 28 Mar 2023 15:21:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xKZKaNllip0A; Tue, 28 Mar 2023 15:21:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 30EE864548B6;
        Tue, 28 Mar 2023 15:21:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NMSP10wv6tYQ; Tue, 28 Mar 2023 15:21:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1579B64548A5;
        Tue, 28 Mar 2023 15:21:51 +0200 (CEST)
Date:   Tue, 28 Mar 2023 15:21:50 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Bang Li <libang.linuxer@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1785377500.357636.1680009710991.JavaMail.zimbra@nod.at>
In-Reply-To: <20230328145848.5c7e4f14@xps-13>
References: <20230323140350.69908-1-libang.linuxer@gmail.com> <20230328145848.5c7e4f14@xps-13>
Subject: Re: [PATCH] mtdblock: tolerate corrected bit-flips
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: mtdblock: tolerate corrected bit-flips
Thread-Index: IScXBlLI190GBUfLWxK6EVGzIzw6pA==
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,T_SPF_PERMERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

----- Ursprüngliche Mail -----
> libang.linuxer@gmail.com wrote on Thu, 23 Mar 2023 22:03:50 +0800:
> 
>> mtd_read() may return -EUCLEAN in case of corrected bit-flips.This
>> particular condition should not be treated like an error.
> 
> I'm fine with the patch, Richard, are you okay as well?

Hm yes. I see the bug. I think it broke about 10 years ago
by e47f68587b82 ("mtd: check for max_bitflips in mtd_read_oob()").

In the early day I'd expect someone to hit this bug but I guess
on the last 10 years mtdblock had no real users.

Thanks,
//richard
