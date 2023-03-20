Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057A76C256D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 00:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCTXHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 19:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCTXHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:07:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23E34034
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 16:06:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35937B810A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF80C433EF;
        Mon, 20 Mar 2023 23:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679353588;
        bh=yaXZgSE+xCFmCr4PCErEggAZ0puJQCwS/ik5TH+VHeg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ub3qa4pZvRu1j4yx5LD+RBviIZkyNSwBLv/sySylbXc/9s5aWwbfth7Plf14rys6+
         dpOtAJcUbOAMQGwR6y/sT1YI88jy9NSfHUc/sy/IBgUb5Z8Qvd8tZl9uau98NUOO1+
         4F8ukYlMIkS5gcN7UHa4d+7zg4HjHwKcTEK1CmDDQKliNpa8GvHoKC9g792QgzknOM
         4D2mhJpe0u8Qye7FRamDYhjArLdKji+75LTovDLzSo4wx1YYe9o5+Bga+PmYbJ4rQj
         DKPuDKlPufGTJx1lf5zlhL4uYgMYGgEhjAme3/KpkAoTdGi3jCaPMAr7vZbjYcbHOz
         WtTwldxjY6guQ==
Date:   Mon, 20 Mar 2023 16:06:26 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:core/urgent 1/1] include/linux/context_tracking.h:99:19:
 error: redefinition of '__ct_state'
Message-ID: <20230320230626.m3zg5pjkn7rwi67u@treble>
References: <202303202052.lv1EF1t6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202303202052.lv1EF1t6-lkp@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 09:04:00PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core/urgent
> head:   3e2619c4ebba2cab8414c55b131b7a28f628de3b
> commit: 3e2619c4ebba2cab8414c55b131b7a28f628de3b [1/1] entry: Fix noinstr warning in __enter_from_user_mode()
> config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20230320/202303202052.lv1EF1t6-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=3e2619c4ebba2cab8414c55b131b7a28f628de3b
>         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>         git fetch --no-tags tip core/urgent
>         git checkout 3e2619c4ebba2cab8414c55b131b7a28f628de3b
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc prepare
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303202052.lv1EF1t6-lkp@intel.com/

Not sure why I didn't get this build bot error before.  Thomas, can you
squash in this fix?

diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 4a4d56f77180..fdd537ea513f 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -46,7 +46,9 @@ struct context_tracking {
 
 #ifdef CONFIG_CONTEXT_TRACKING
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
+#endif
 
+#ifdef CONFIG_CONTEXT_TRACKING_USER
 static __always_inline int __ct_state(void)
 {
 	return arch_atomic_read(this_cpu_ptr(&context_tracking.state)) & CT_STATE_MASK;
