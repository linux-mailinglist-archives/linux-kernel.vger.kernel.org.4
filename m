Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECE366FD665
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 07:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbjEJFzH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 10 May 2023 01:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjEJFzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 01:55:05 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D299273D
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 22:55:00 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C00F061B8B4D;
        Wed, 10 May 2023 07:54:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id n_S4LQIz-Mly; Wed, 10 May 2023 07:54:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 35D8661CECF8;
        Wed, 10 May 2023 07:54:57 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vpLgkkUi-oWy; Wed, 10 May 2023 07:54:57 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0EF94615C9F5;
        Wed, 10 May 2023 07:54:57 +0200 (CEST)
Date:   Wed, 10 May 2023 07:54:56 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     kernel test robot <lkp@intel.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        oe-kbuild-all <oe-kbuild-all@lists.linux.dev>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <997268184.9271684.1683698096971.JavaMail.zimbra@nod.at>
In-Reply-To: <202305100640.HGwVAUIt-lkp@intel.com>
References: <202305100640.HGwVAUIt-lkp@intel.com>
Subject: Re: arch/um/drivers/harddog_user.c:6:10: fatal error: stdio.h: No
 such file or directory
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: arch/um/drivers/harddog_user.c:6:10: fatal error: stdio.h: No such file or directory
Thread-Index: /HP02hVwBMcXLMWFmev9z/iN8nuRpg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "kernel test robot" <lkp@intel.com>
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> head:   16a8829130ca22666ac6236178a6233208d425c3
> commit: fc54a4f15988e228cf88f888483e985c5f35031e um: prevent user code in
> modules
> date:   3 weeks ago
> config: um-allmodconfig
> (https://download.01.org/0day-ci/archive/20230510/202305100640.HGwVAUIt-lkp@intel.com/config)
> compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
> reproduce (this is a W=1 build):

The fix is already in linux-next. PR will follow shortly.

Thanks,
//richard
