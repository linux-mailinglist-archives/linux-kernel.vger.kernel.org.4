Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342A5693A43
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 22:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBLV2p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Feb 2023 16:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjBLV2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 16:28:44 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8D8A254;
        Sun, 12 Feb 2023 13:28:42 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 63352642ECB8;
        Sun, 12 Feb 2023 22:28:39 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9lwZAuZA28ha; Sun, 12 Feb 2023 22:28:38 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 19F03642ECBB;
        Sun, 12 Feb 2023 22:28:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id sO_gfzSpzsUe; Sun, 12 Feb 2023 22:28:38 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id F1FE8642ECB8;
        Sun, 12 Feb 2023 22:28:37 +0100 (CET)
Date:   Sun, 12 Feb 2023 22:28:37 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Peter Foley <pefoley2@pefoley.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Message-ID: <317345605.121578.1676237317911.JavaMail.zimbra@nod.at>
In-Reply-To: <20230213081128.0659dd4d@canb.auug.org.au>
References: <20230213081128.0659dd4d@canb.auug.org.au>
Subject: Re: linux-next: Signed-off-by missing for commit in the uml tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: linux-next: Signed-off-by missing for commit in the uml tree
Thread-Index: KMMVSRObpfJoRJPN3cSeuADuqtVX8Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Stephen Rothwell" <sfr@canb.auug.org.au>
> Hi all,
> 
> Commits
> 
>  46d4f4457984 ("um: Use CFLAGS_vmlinux")
>  f348208e5daa ("um: Prevent building modules incompatible with MODVERSIONS")
>  76d23d6f4a8c ("um: Avoid pcap multiple definition errors")
> 
> are missing a Signed-off-by from their author.

Peter, am I allowed to add "Signed-off-by: Peter Foley <pefoley2@pefoley.com>"
to these patches?

Thanks,
//richard
