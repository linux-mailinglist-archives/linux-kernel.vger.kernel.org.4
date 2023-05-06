Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF36F9370
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjEFRvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:50:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DF31816D;
        Sat,  6 May 2023 10:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DEE3611EC;
        Sat,  6 May 2023 17:50:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1690C433EF;
        Sat,  6 May 2023 17:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1683395455;
        bh=eGMdLm10H5H7l0I55t9opbxFMKjKj+pCqF9EqqzXHOI=;
        h=Date:From:To:Cc:Subject:From;
        b=V7ZLj0wNH6IlriJ0Y5jUli6GjkVnxH7O99TbrKp7WD2Dv1iImzqR5AplN1U+Ka8Ia
         UvNMe6V/nFma3qXNWwrkeHvICyecglvpz8C2ktkee0XpKtBr1k3OXKi5IP2nri98hs
         P1yj90YnRzaR7WJQVTEKPsZYow7zidCIaFrQEKBU=
Date:   Sat, 6 May 2023 10:50:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Keith Busch <kbusch@kernel.org>
Subject: [GIT PULL] dmapool updates for 6.4-rc1
Message-Id: <20230506105054.0155139b3d3a7f249ead37be@linux-foundation.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please pull the dmapool updates for 6.4-rc1, thanks.


The following changes since commit 418d5c98319f67b9ae651babea031b5394425c18:

  Merge tag 'devicetree-fixes-for-6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux (2023-05-05 13:27:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-stable-2023-05-06-10-49

for you to fetch changes up to da9619a30e73b59605ed998bf7bc4359f5c0029a:

  dmapool: link blocks across pages (2023-05-06 10:33:38 -0700)

----------------------------------------------------------------
Reinstate the dmapool changes which were accidentally removed by
2d55c16c0c54 ("dmapool: create/destroy cleanup").

----------------------------------------------------------------
Keith Busch (6):
      dmapool: move debug code to own functions
      dmapool: rearrange page alloc failure handling
      dmapool: consolidate page initialization
      dmapool: simplify freeing
      dmapool: don't memset on free twice
      dmapool: link blocks across pages

Tony Battersby (4):
      dmapool: remove checks for dev == NULL
      dmapool: use sysfs_emit() instead of scnprintf()
      dmapool: cleanup integer types
      dmapool: speedup DMAPOOL_DEBUG with init_on_alloc

 mm/dmapool.c | 407 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 202 insertions(+), 205 deletions(-)

