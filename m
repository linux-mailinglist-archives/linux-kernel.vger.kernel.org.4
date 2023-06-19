Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCD735937
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232128AbjFSOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFSOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:11:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C57B9C;
        Mon, 19 Jun 2023 07:11:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8A7160C8D;
        Mon, 19 Jun 2023 14:11:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD43C433C8;
        Mon, 19 Jun 2023 14:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687183892;
        bh=O0Uj7fMgPrN+j5YxvlsA2mSniLpIngmwSddrJandsYo=;
        h=Date:From:To:Cc:Subject:From;
        b=byFiBifJ39naxW5ErpCIfoEcP+Js1nUGxV20vo/hgYFe3aDygTjfR0Zc6pQr/7tQ/
         NQ4zriQyoQnRCSXbxOBCGYRQB/cAXxWFCT1Y54qB6u8yO+GMrXw2B38fdCt8SDiIg5
         r8uciCu0DJ8xKeOsHkGmx84f42MCzLSYxR3NSgc5IDoBszd5vIu4HuUm0CHLhMVppw
         Iz+pcSh0CGjJNqu5+bWlKofgSu0MPv9QfCG9sz74mrFk6lZg0Dqu/PxEAFuIke6HcI
         gJRhO/24fGBOqPVU+wgqaoAaBWTa4bYgPw70opv21oSMnzPhdGyJAH9j3jo2JB7Tj6
         +wRndIgGh37RQ==
Message-ID: <73ad37e4-1689-ed01-f5de-a92dfdaa25c2@kernel.org>
Date:   Mon, 19 Jun 2023 23:11:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Chanwoo Choi <chanwoo@kernel.org>
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Chanwoo Choi <chanwoo@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>
Subject: [GIT PULL] devfreq next for 6.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael,

This is devfreq-next pull request for v6.5. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-6.5

for you to fetch changes up to a83bfdca8b2098999e3edfb87e98925e019eb818:

  PM / devfreq: mtk-cci: Fix variable deferencing before NULL check (2023-05-29 23:25:31 +0900)

----------------------------------------------------------------
Update devfreq next for v6.5

Detailed description for this pull request:
1. Reorder fieldls in 'struct devfreq_dev_status' in order to shrinks the size
of 'struct devfreqw_dev_status' without any behavior changes.

2. Add exynos-ppmu.c driver as a soft module dependency in order to prevent
the freeze issue between exynos-bus.c devfreq driver and exynos-ppmu.c devfreq
event driver.

3. Fix variable deferencing before NULL check on mtk-cci-devfreq.c
----------------------------------------------------------------

Christophe JAILLET (1):
      PM / devfreq: Reorder fields in 'struct devfreq_dev_status'

Marek Szyprowski (1):
      PM / devfreq: exynos: add Exynos PPMU as a soft module dependency

Sukrut Bellary (1):
      PM / devfreq: mtk-cci: Fix variable deferencing before NULL check

 drivers/devfreq/exynos-bus.c      | 1 +
 drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
 include/linux/devfreq.h           | 3 ++-
 3 files changed, 5 insertions(+), 2 deletions(-)
