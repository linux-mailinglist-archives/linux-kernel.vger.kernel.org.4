Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B815FBC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJKUmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJKUmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:42:10 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166369DDB3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:42:07 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id f11so23388241wrm.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 13:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JPaqaQpCA6j/bQzuqNFHI2KUkN19JR0/BVhLmboxsZY=;
        b=QY4rW3OhBtMg926stweYItI2vbTgWXOe80hyUmMtTkSz5Kamf7HDDzSQwLhYqv7TOV
         0IaI2m6mieI3JRT3GlAUL+K0fqyGSqYVy8DL+t8Kauh90qK9oZBDHMI0j1hUH64GMJOn
         snvvvSPufjKC02q5YMJgKQEGV5xmhuHx1fdh1JJmpoc+Jcqy9pkkH54Bbm2w1r1uokm2
         BZnyuAkQGN5lSyJFnSe7PHTOQWf59R8UIW6KshBH++AcGs2KlOFkDHqYeCs/CSyMJt70
         EneAPTo15FKUNdhVU7MeRSD0LH0b/y9N5NdQkt9mLaM7HeOZiEWptcvGVuPBxEsiXBLF
         YNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPaqaQpCA6j/bQzuqNFHI2KUkN19JR0/BVhLmboxsZY=;
        b=IAv4T3F04AxT4CHtY8y+8roC6Uv3vqHfGy+ty9y722By3zQcWb4R5zN9Lu+KG2vl+c
         QFyyBbXcUpZijezr5i57WU/DtY0vuHYPCNYc2FkSdwsojpUZzPJ0+Otn82/YAzUoQHq8
         6m2dDQofqgSBcyDsOFGgNFR0kEfBs/KlImC6iMIJJt8cHSV5Ahkc2df1p7AeoyppxKWf
         UGeWkiqfbV464DWETWlzF6S/seYMORUT14C67lYo8X6GzsIcRr3BS1ahTuLbS2rsI1zt
         7+h2MAqx1wl8zVLbqdRAq56SCEA47BiI9SnX5jL07IX7oPhMQWpPD51J9ADehg+YH4Vl
         /lXQ==
X-Gm-Message-State: ACrzQf1INIGkVXssRx41DfBGoyOKYU8g6KJX2mutpBs5K+PjVV0lCchW
        yJbbdT+L5PK6FZo4VNSYGIDVb0/S48HektQSMomLf7qkhak=
X-Google-Smtp-Source: AMsMyM4GGtyfQs3Poz9WXTx8MGyTwsq+hIA/zVW61KaT8VPQ00EMgHLxgyWuXcC/ltkImhrsg6rwM/fu6Gmxkf3EkAI=
X-Received: by 2002:a5d:5a82:0:b0:224:f744:1799 with SMTP id
 bp2-20020a5d5a82000000b00224f7441799mr16035416wrb.582.1665520925453; Tue, 11
 Oct 2022 13:42:05 -0700 (PDT)
MIME-Version: 1.0
References: <202210120440.qmxr3KCs-lkp@intel.com>
In-Reply-To: <202210120440.qmxr3KCs-lkp@intel.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 11 Oct 2022 13:41:29 -0700
Message-ID: <CAJD7tkZD5zWMaytpnOnGhL9X_+19nhwxWmsy3rz8EheFgqaUbg@mail.gmail.com>
Subject: Re: [ammarfaizi2-block:tj/cgroup/for-next 3/5] kernel/cgroup/cgroup.c:6765:
 warning: expecting prototype for cgroup_get_from_fd(). Prototype was for
 cgroup_v1v2_get_from_fd() instead
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 1:39 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://github.com/ammarfaizi2/linux-block tj/cgroup/for-next
> head:   8248fe413216732f98563e8882b6c6ae617c327b
> commit: a6d1ce5951185ee91bbe6909fe2758f3625561b0 [3/5] cgroup: add cgroup_v1v2_get_from_[fd/file]()
> config: m68k-randconfig-r005-20221010
> compiler: m68k-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/ammarfaizi2/linux-block/commit/a6d1ce5951185ee91bbe6909fe2758f3625561b0
>         git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
>         git fetch --no-tags ammarfaizi2-block tj/cgroup/for-next
>         git checkout a6d1ce5951185ee91bbe6909fe2758f3625561b0
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/cgroup/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>    kernel/cgroup/cgroup.c:6251: warning: Function parameter or member 'f' not described in 'cgroup_get_from_file'
> >> kernel/cgroup/cgroup.c:6765: warning: expecting prototype for cgroup_get_from_fd(). Prototype was for cgroup_v1v2_get_from_fd() instead
>    kernel/cgroup/cgroup.c:6783: warning: Function parameter or member 'fd' not described in 'cgroup_get_from_fd'
>
>
> vim +6765 kernel/cgroup/cgroup.c
>
> 16af439645455fb kernel/cgroup.c        Tejun Heo        2015-11-20  6754
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6755  /**
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6756   * cgroup_get_from_fd - get a cgroup pointer from a fd

Ugh I forgot to update this line in the comment. Tejun, is this
patchable in place or should I send a patch for this?

> a6d1ce5951185ee kernel/cgroup/cgroup.c Yosry Ahmed      2022-10-11  6757   * @fd: fd obtained by open(cgroup_dir)
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6758   *
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6759   * Find the cgroup from a fd which should be obtained
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6760   * by opening a cgroup directory.  Returns a pointer to the
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6761   * cgroup on success. ERR_PTR is returned if the cgroup
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6762   * cannot be found.
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6763   */
> a6d1ce5951185ee kernel/cgroup/cgroup.c Yosry Ahmed      2022-10-11  6764  struct cgroup *cgroup_v1v2_get_from_fd(int fd)
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30 @6765  {
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6766        struct cgroup *cgrp;
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6767        struct file *f;
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6768
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6769        f = fget_raw(fd);
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6770        if (!f)
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6771                return ERR_PTR(-EBADF);
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6772
> a6d1ce5951185ee kernel/cgroup/cgroup.c Yosry Ahmed      2022-10-11  6773        cgrp = cgroup_v1v2_get_from_file(f);
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6774        fput(f);
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6775        return cgrp;
> 1f3fe7ebf6136c3 kernel/cgroup.c        Martin KaFai Lau 2016-06-30  6776  }
> a6d1ce5951185ee kernel/cgroup/cgroup.c Yosry Ahmed      2022-10-11  6777
>
> :::::: The code at line 6765 was first introduced by commit
> :::::: 1f3fe7ebf6136c341012db9f554d4caa566fcbaa cgroup: Add cgroup_get_from_fd
>
> :::::: TO: Martin KaFai Lau <kafai@fb.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
>
> --
> 0-DAY CI Kernel Test Service
> https://01.org/lkp
