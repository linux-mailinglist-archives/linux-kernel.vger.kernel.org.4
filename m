Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A2F6F5F26
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjECTce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECTca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:32:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF70B7D98;
        Wed,  3 May 2023 12:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=tMLN9BtaXqxM5JJBBy/1HaXn2nyhid1vnoNwTsVZtoc=; b=gW2xBkf6qTqwn2xuiYWGZlLCsB
        qj8GQnMoSu12l1WPlrYtAf0vEJg7OD79TI6RCGGtWsCdDqC7sYtnyuWTQcw/bKJJQdptmo+MXnAB8
        +q0moNCswkFdh1+ZMT2eTfmOtSKDVwE89wbzoUTjZMV8yNQ+kPqaoQBtUIlrhSTJbp/I9FMmjCPCr
        Lvf8zMXssSMfLSMSGYW7OUnLkmZoFbtoeFeGgV3XylXPGY8BUk5zx74zZqtLZjY4z2cX29s48I4hb
        UhAYV5VCDO/SOzdaPQaExKEEmDSSfG/oeMT78ETjL4YrvX6M98RZ8ZkYnjEc2NLhAyeVEazSKb/9o
        TWfdFT2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1puID8-005bF2-0g;
        Wed, 03 May 2023 19:32:22 +0000
Date:   Wed, 3 May 2023 12:32:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     torvalds@linux-foundation.org, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        mcgrof@kernel.org
Subject: [GIT PULL] Modules changes for v6.4-rc4 second request
Message-ID: <ZFK2xmSgFCxtlMm+@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had sent the only patch in patch form but I gather you prefer a pull
request so sendign thsi instead.

I verified and indeed I had quite a bit of 0-day build successes with
this branch. The issue reported by 0-day came late with an sparc64 allyesconfig
build. The issue were not found earlier with 0-day allyes config on a few
other archs.

I'll see I can get more build converage on modules for modules-next so we can
catch random builds / gcc combos these earlier.

The following changes since commit 348551ddaf311c76b01cdcbaf61b6fef06a49144:

  Merge tag 'pinctrl-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2023-05-02 15:40:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/modules-6.4-rc1-v2

for you to fetch changes up to 0b891c83d8c54cb70e186456c2191adb5fd98c56:

  module: include internal.h in module/dups.c (2023-05-02 20:33:36 -0700)

----------------------------------------------------------------
modules-6.4-rc1 v2

There is only one fix by Arnd far for modules pending which came in after
the first pull request. The issue was found as part of some late compile
tests with 0-day. I take it 0-day does some secondary late builds with
after some initial ones.

----------------------------------------------------------------
Arnd Bergmann (1):
      module: include internal.h in module/dups.c

 kernel/module/dups.c | 2 ++
 1 file changed, 2 insertions(+)
