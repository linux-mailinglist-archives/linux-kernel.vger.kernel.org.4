Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F355C5ECF28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiI0VNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiI0VNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:13:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3221E0C5D;
        Tue, 27 Sep 2022 14:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=ujgWHXehstGOeCKBukPXgFHS1ehsMRilhypdHD9Miec=; b=yiEPAiSOUlNOY62tMjYeEH4MRC
        E717YZ/3zNj1VaDuoTxR0pDbCMtZGkPYbYxehhQcr9D9/jMaBmH36+Uu3BFvAyQn3z+Aj7fAKKybb
        E30OvqxWY7wwYnjf+lGqHVg2SE/V8HM8EbJd6kpkNhsELzB5rl2prYYgIs34FMALJlPKm7bST9OYb
        Zig4q0mJVoRGYPrkR8961C4tT2+3D4grTskMfKUSC/4jPSAQfPKpXX5/owYKB88dKOLUTArgXV9Tq
        d39KkRqpaRDpZ29ufSN5BkR4Z9i6daupQjlZ+PiwdDTJIBD642GiZasOV+pUCzk2zlcqR+UAywJg6
        eqEatkgA==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odHtR-00Cfzl-Uw; Tue, 27 Sep 2022 21:13:30 +0000
Message-ID: <f1b22431-074d-32f1-b67a-34c51e4d072a@infradead.org>
Date:   Tue, 27 Sep 2022 14:13:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: Tree for Sep 27 (uml 64-bit or 32-bit: tinyconfig)
Content-Language: en-US
To:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-um <linux-um@lists.infradead.org>
References: <20220927201053.518736-1-broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220927201053.518736-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/22 13:10, broonie@kernel.org wrote:
> Hi all,
> 
> Changes since 20220923:
> 

In file included from ../include/linux/notifier.h:16,
                 from ../include/linux/memory_hotplug.h:7,
                 from ../include/linux/mmzone.h:1244,
                 from ../include/linux/gfp.h:7,
                 from ../include/linux/slab.h:15,
                 from ../include/linux/crypto.h:20,
                 from ../arch/x86/um/shared/sysdep/kernel-offsets.h:5,
                 from ../arch/um/kernel/asm-offsets.c:1:
../include/linux/srcu.h: In function ‘srcu_read_lock_nmisafe’:
../include/linux/srcu.h:181:26: error: implicit declaration of function ‘__srcu_read_lock_nmisafe’; did you mean ‘srcu_read_lock_nmisafe’? [-Werror=implicit-function-declaration]
  181 |                 retval = __srcu_read_lock_nmisafe(ssp, true);
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~
      |                          srcu_read_lock_nmisafe
../include/linux/srcu.h: In function ‘srcu_read_unlock_nmisafe’:
../include/linux/srcu.h:226:17: error: implicit declaration of function ‘__srcu_read_unlock_nmisafe’; did you mean ‘srcu_read_unlock_nmisafe’? [-Werror=implicit-function-declaration]
  226 |                 __srcu_read_unlock_nmisafe(ssp, idx, true);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
      |                 srcu_read_unlock_nmisafe

-- 
~Randy
