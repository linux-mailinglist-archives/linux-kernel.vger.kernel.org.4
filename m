Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A026AFBC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 02:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCHBIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 20:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjCHBIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 20:08:04 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F164ECEB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:08:03 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z4-20020a63e104000000b005033bc79287so3492889pgh.22
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 17:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678237683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NtzlIfpk9YdNwky09HPcEQ6276tdVtHWZhXfb1xy5GE=;
        b=ime9ags+Wyv3pjLIK0fcn+N5WqR3JdATyDXWzSTdLotDDE3ci/o+5yTe9yKHSuMjAc
         cru7FeDNYTMaUQsVDmhI4quRop59dYffhWsIJi1MHArHFvFKJMv0igu7Rk80p/Dxlsui
         zKoqkbkDsGA/c4Wg+D+VFamrLovXTeWsjYa5S85F6o84I/j8ADGeIVl0WG5IuqppkH8m
         GQP55g8CWt/Jq6p8RCcAekT7mM4hTFKY6/bSppkFxb751q554Qm7sEQU3j2M9pw+m5C/
         cg8wbjUnihomOjHKoum9PuzMg8FRUBRPeYWQhsxAibmTxXUjb+/vLdg7IcbtzTi6wHco
         YL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678237683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NtzlIfpk9YdNwky09HPcEQ6276tdVtHWZhXfb1xy5GE=;
        b=0dVpmkVLJRfY1lAMuXxro7MTz67YZSmynYqG3mV5dkwC01MZWtJmOOBsiYqcjvNdPC
         ztYrwU9wog5bVbMLHjQ/SR6Wt6JHxBeBEyIPr5h7X5HoCR+v1qFPdJ6Y0xeOk/SDer99
         XvtL5s9BtIqkoqFBv2tsYn+JRBx8O5ZgQJG/l78r2+6FtY9mJfr6+hKyyZa79vV6v7Dg
         gd6uYSRN0CWhiaNNOHDJIYl6mxIRTh9JWtfSMyqy90c76Wtk+/uAHCxwOMHqFuSTFU8G
         RvsrnM0zlBhUQV66rPRomeP+5z3W8QDPAbkFEUQfh8SMQgtqT4xWn+OLuxq6l9F0br+W
         FZPg==
X-Gm-Message-State: AO0yUKX0fQM9AjAVEDx3NA2l5+K1XPT0IfFXpYeyB26b0hMpnKWow75T
        zW+jHtT9e/HljgpeB5Wk13IPvkGJOSo=
X-Google-Smtp-Source: AK7set9jyf4N4HoUd9tny2NoKM+cjaI03S38wtivNHC6AdCk+Tj0xaeOWkit8U3qmrA5NiA/4ZV6s6HZ28s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:924d:0:b0:503:a26e:b4cf with SMTP id
 s13-20020a63924d000000b00503a26eb4cfmr5779022pgn.8.1678237682848; Tue, 07 Mar
 2023 17:08:02 -0800 (PST)
Date:   Tue, 7 Mar 2023 17:08:01 -0800
In-Reply-To: <202303031630.ntvIuYqo-lkp@intel.com>
Mime-Version: 1.0
References: <202303031630.ntvIuYqo-lkp@intel.com>
Message-ID: <ZAff8U7CmMxpY8Ig@google.com>
Subject: Re: arch/powerpc/kvm/e500mc.c:171:5: error: no previous prototype for 'kvmppc_e500mc_check_processor_compat'
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <lkp@intel.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2eb29d59ddf02e39774abfb60b2030b0b7e27c1f
> commit: 7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f KVM: PPC: Fix refactoring goof in kvmppc_e500mc_init()
> date:   5 weeks ago
> config: powerpc-randconfig-r001-20230302 (https://download.01.org/0day-ci/archive/20230303/202303031630.ntvIuYqo-lkp@intel.com/config)
> compiler: powerpc-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 7cb79f433e75b05d1635aefaa851cfcd1cb7dc4f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303031630.ntvIuYqo-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> arch/powerpc/kvm/e500mc.c:171:5: error: no previous prototype for 'kvmppc_e500mc_check_processor_compat' [-Werror=missing-prototypes]
>      171 | int kvmppc_e500mc_check_processor_compat(void)
>          |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> 
> 
> vim +/kvmppc_e500mc_check_processor_compat +171 arch/powerpc/kvm/e500mc.c
> 
>    170	
>  > 171	int kvmppc_e500mc_check_processor_compat(void)

Gah, should be "static".  I'll send a patch.
