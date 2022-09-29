Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3655EFE30
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiI2Tw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiI2Tw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:52:26 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8123C8F6;
        Thu, 29 Sep 2022 12:52:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id u24so3336239edb.11;
        Thu, 29 Sep 2022 12:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=emc9s70uHNUzyZPgEpvfqwaCXJYyWsYo5CNPx2MSFOQ=;
        b=QHyWa1mMeYWy9atrnKuccLRFrfB9R37bQHOuKlNfphLvr556kSpo6npqk5ZDfRXDmu
         2I0cDwPCOOOJ6Mz6mr8zKuJWBo546WecQvMZbh21VPNPXw9kl0npFzvAKL1jAoiYACUc
         e9ARAL9Uuv53Y9+uoDKte0XONk8JUQfKLgybCWCRYG8M2BLR62V4P7aZOAXxHmMYDcGN
         365sQuUNJq9bRRZLLogNzrwKne7Op6aNDOWofaT3iKwvkg1dB5PglAGD9USSZDQSJCvL
         C/298tflxNj/Iu2Eb4qAz7Ttbq90gT21fuyJPlV85InFHC3xUmA42DbGZDXnZGAVaYYS
         7YeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=emc9s70uHNUzyZPgEpvfqwaCXJYyWsYo5CNPx2MSFOQ=;
        b=Rvb2WdkjBb4Pad0bst6JocV51UMznDfH3wRC+PIN7j9gRriX58HQVPQkQVbYXWzS/p
         LUoRmpYilW6WWGmvlPV0V7Jjyk3D3oV86qZFaRyCdPdyHpUiQRN4J325jByfcSxK1D4L
         hkNPxEDqpxJM2jxQMumAMmUZ3YbpQFNXOMwAn8whKEl9wtsX0dSIneXON1AIwRv34Ptd
         ILiMNzjQ7R2ucXSl3Pq7MdWDUKlNexTZA6XQWYpDhcVipkhYhCKUGY7H9CDrdc0weBuX
         f0u35/53ufu281TmYEMs3EwoBGh5DhYSHGfMRRlS6tZBJdk2bUEJ6/AylP5xmyAsZa3k
         2Lpg==
X-Gm-Message-State: ACrzQf1BqUaU8UD3WUkUHXRy7JCu6PpsdaEznr2iQaGMYR38xxJVoN+9
        IVKzdZ4JeleI9onLPEDZPVEu2vkZ4EFAoKVZT2w=
X-Google-Smtp-Source: AMsMyM6jNucFDbnsJD9zn/owio/7vL+2hrmBdiQs5pIwPSz48lyuEa/jQscRs0puqEdi9ROH6IWBaSkSCbdELiTm5xQ=
X-Received: by 2002:a05:6402:34d0:b0:458:a4a:6dd0 with SMTP id
 w16-20020a05640234d000b004580a4a6dd0mr4789329edc.297.1664481143951; Thu, 29
 Sep 2022 12:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220927085702.10026-1-zhoujie@nfschina.com> <202209292358.oyaafCLq-lkp@intel.com>
In-Reply-To: <202209292358.oyaafCLq-lkp@intel.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Thu, 29 Sep 2022 21:52:12 +0200
Message-ID: <CAOi1vP_GQ7CwQ1W0wbA_BQxHHgZBTCSSSd_g4_-czoHkKEVp7A@mail.gmail.com>
Subject: Re: [PATCH] fs/ceph:Modify the return value to void
To:     kernel test robot <lkp@intel.com>
Cc:     Zhou jie <zhoujie@nfschina.com>, jlayton@kernel.org,
        xiubli@redhat.com, llvm@lists.linux.dev, kbuild-all@lists.01.org,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 5:19 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Zhou,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on ceph-client/for-linus]
> [also build test ERROR on linus/master v6.0-rc7 next-20220928]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Zhou-jie/fs-ceph-Modify-the-return-value-to-void/20220927-165857
> base:   https://github.com/ceph/ceph-client.git for-linus
> config: hexagon-randconfig-r041-20220926
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 791a7ae1ba3efd6bca96338e10ffde557ba83920)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/6c7163052ce6f51c217c650bc5592b7ef50b2280
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Zhou-jie/fs-ceph-Modify-the-return-value-to-void/20220927-165857
>         git checkout 6c7163052ce6f51c217c650bc5592b7ef50b2280
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash fs/ceph/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> fs/ceph/debugfs.c:281:38: error: incompatible function pointer types passing 'void (struct inode *, struct ceph_cap *, void *)' to parameter of type 'int (*)(struct inode *, struct ceph_cap *, void *)' [-Wincompatible-function-pointer-types]
>                    ceph_iterate_session_caps(session, caps_show_cb, s);
>                                                       ^~~~~~~~~~~~
>    fs/ceph/mds_client.h:540:16: note: passing argument to parameter 'cb' here
>                                         int (*cb)(struct inode *,
>                                               ^
> >> fs/ceph/debugfs.c:349:1: error: incompatible function pointer types passing 'void (struct seq_file *, void *)' to parameter of type 'int (*)(struct seq_file *, void *)' [-Wincompatible-function-pointer-types]
>    DEFINE_SHOW_ATTRIBUTE(mdsmap);
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/seq_file.h:199:27: note: expanded from macro 'DEFINE_SHOW_ATTRIBUTE'
>            return single_open(file, __name ## _show, inode->i_private);    \
>                                     ^~~~~~~~~~~~~~~
>    <scratch space>:79:1: note: expanded from here
>    mdsmap_show
>    ^~~~~~~~~~~
>    include/linux/seq_file.h:166:38: note: passing argument to parameter here
>    int single_open(struct file *, int (*)(struct seq_file *, void *), void *);
>                                         ^
>    fs/ceph/debugfs.c:350:1: error: incompatible function pointer types passing 'void (struct seq_file *, void *)' to parameter of type 'int (*)(struct seq_file *, void *)' [-Wincompatible-function-pointer-types]

Hi Zhou,

As you can see from the above output, the signatures of these
functions are dictated by debugfs infrastructure.  Even though
we happen to return 0 in all cases, changing the return type to
void is wrong.

Thanks,

                Ilya
