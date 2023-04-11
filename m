Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013556DE2B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDKRhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDKRhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:37:17 -0400
Received: from mail-vs1-xe31.google.com (mail-vs1-xe31.google.com [IPv6:2607:f8b0:4864:20::e31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284894C1D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:37:16 -0700 (PDT)
Received: by mail-vs1-xe31.google.com with SMTP id y13so8285268vss.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681234635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lhDQvgwbEigeXXlhjN0Q22Hgc1o3hW4XorfhYiSjVOw=;
        b=wM0eU9iLTKS2qIwAZM91w9fyzPeNpHKK5in6tKFab7b8hwc1DfX2rk1esKdYhShKWr
         z6++KMS11Y3BY7X8+mYRdqbevzVHWtjam5+uWqDFEjhBXbE6pe1FXVQ0GVdPwIdoanuV
         uNT6git+LHi4jWXGsIpCXmY3sazX0UNtZAVVP2x83QHV9m4Kt3xN7AfNgBKnLyKqB7jo
         gwiiANyEFIKbSGVZCxUbvo/uQsuy42VBndU4t1lUMAJDf8qdl5SaLqaTGjRvroD5nu2l
         TWDWbGVc4OO3GEa4nAIrUAUqzGX/e/5BtYYPkx/xe4iWG+OGQRSaa8PeZHsCxkSx4DxG
         tRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681234635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhDQvgwbEigeXXlhjN0Q22Hgc1o3hW4XorfhYiSjVOw=;
        b=Qww6L/4ISnM1AtYZg9ojS2Bv9ecUnOhQ5+zZmazEwy04BaZac0UN5jnYqIfpFe1m4n
         VZNRzo90rBauaGsaS5LXktogKHEpbc+RSZc+WvAxIoR/aXFvpJtCuY41nysdHiKgUoPy
         zRzwjZBURlNdPcQB42TBPiOLKPPYWMdTJ5qwZQFmPSctp4ibsh5L9wkWLyhxApKqJAea
         64g6+vHjqgaoKlY91MaVVglJP4Qif3f0exvJfFgUlopLxwqjGYjGxnscW3YBdXO224JS
         m6OZpKQ9pcu7GhmHLqmorMEvHsfEmGN39eUmOJZ4s3pArDm0TqgszEgTziH6c8UkGAK8
         7orQ==
X-Gm-Message-State: AAQBX9cGivFsGi3vPg+nbh3NRdZb1E+4Y1FdSju7CZ9B0Ib6t52spG+U
        f5G+E4TV7MpguDD8NDrC04GUXqVdAfg2hIaTgmXV/A==
X-Google-Smtp-Source: AKy350YpuoPk7W++ajGy+qfyAsaan1Z7UNoHbZNPGVodEYE9qqPd4lFm1tkfjtHuOoVmq8hz4BUp9kM3Y3qx/OT3ZLk=
X-Received: by 2002:a67:d293:0:b0:416:2ad3:35ba with SMTP id
 z19-20020a67d293000000b004162ad335bamr8779166vsi.1.1681234634941; Tue, 11 Apr
 2023 10:37:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtVXsKSbdxcTNiLc8oYRTBOZzWNQRF92daLE58NPbOkFg@mail.gmail.com>
 <96b67ae8-98dd-40fe-9dde-302e09d12551@app.fastmail.com> <20230406105646.GB1545779@pevik>
 <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
In-Reply-To: <CA+G9fYs461=iJqZqKe8_iRkfsMemSSA+ByOPRc9k-kBf4Hp8og@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 11 Apr 2023 23:07:02 +0530
Message-ID: <CA+G9fYtvp+iu-hA0YnMuT9gVET+4VFuz7faGTUWfmY_=dPtzZg@mail.gmail.com>
Subject: Re: LTP: list of failures on 32bit and compat mode
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>, llvm@lists.linux.dev,
        chrubis <chrubis@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>,
        Benjamin Copeland <ben.copeland@linaro.org>,
        Tudor Cretu <tudor.cretu@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 22:15, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> On Thu, 6 Apr 2023 at 16:26, Petr Vorel <pvorel@suse.cz> wrote:
> >
> > > On Thu, Apr 6, 2023, at 11:11, Naresh Kamboju wrote:
> > > > Following LTP syscalls failed on the i386 and arm environments with
> > > > Linux next / mainline kernels. The userspace is coming from Open
> > > > Embedded kirkstone.

<Trim>
> > testcases/kernel/syscalls/fstatfs/fstatfs02.c was converted to new LTP API in
> > 5a8f89d35 ("syscalls/statfs02, fstatfs02: Convert to new API"), which was
> > released in 20220930. There is already newer release 20230127.
> > Generally it's safer to test mainline kernel with LTP master,
> > but this fix has already been in the latest LTP release 20230127.
> > And this error has been later fixed with
> > 492542072 ("syscalls/statfs02, fstatfs02: Accept segfault instead of EFAULT")
>
> Thanks for insite about the failed test investigations.
>
> >
> > @Naresh which LTP do you use for testing? It must be some older LTP :(.
>
> Our build system started running LTP version 20230127.
> I will keep you posted with the latest findings.

Few quick updates,
Do you see these failures on compat mode ?

Following regressions noticed with LTP version 20230127 on Linux next.

Regressions found on juno-r2-compat:
Regressions found on qemu_arm64-compat:

  ltp-syscalls/fcntl34
  ltp-syscalls/fcntl36
  ltp-syscalls/fcntl34_64
  ltp-syscalls/fcntl36_64

tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
fcntl34.c:87: TINFO: write to a file inside threads with OFD locks
fcntl34.c:33: TINFO: spawning '18' threads
tst_kernel.c:87: TINFO: uname.machine=aarch64 kernel is 64bit
fcntl34.c:63: TBROK: fcntl(4, F_OFD_SETLKW, { 1, 0, 0, 1, 0 }): EINVAL (22)

tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
fcntl34.c:87: TINFO: write to a file inside threads with OFD locks
fcntl34.c:33: TINFO: spawning '18' threads
tst_kernel.c:87: TINFO: uname.machine=aarch64 kernel is 64bit
fcntl34.c:63: TBROK: fcntl(4, F_OFD_SETLKW, { 1, 0, 0, 1, 0 }): EINVAL (22)

tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
fcntl36.c:288: TINFO: OFD read lock vs OFD write lock
tst_kernel.c:87: TINFO: uname.machine=aarch64 kernel is 64bit
fcntl36.c:166: TBROK: fcntl(3, F_OFD_SETLKW, { 0, 0, 0, 4096, 0 }): EINVAL (22)

tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
fcntl36.c:288: TINFO: OFD read lock vs OFD write lock
tst_kernel.c:87: TINFO: uname.machine=aarch64 kernel is 64bit
fcntl36.c:166: TBROK: fcntl(3, F_OFD_SETLKW, { 0, 0, 0, 4096, 0 }): EINVAL (22)

Test details links,
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230411/testrun/16168516/suite/ltp-syscalls/test/fcntl36/history/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230411/testrun/16168516/suite/ltp-syscalls/test/fcntl34/history/
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230411/testrun/16168516/suite/ltp-syscalls/test/fcntl36/log

Steps to reproduce:

# To install tuxrun on your system globally:
# sudo pip3 install -U tuxrun==0.41.0
#
# See https://tuxrun.org/ for complete documentation.

tuxrun   \
 --runtime podman   \
 --device qemu-arm64   \
 --kernel https://storage.tuxsuite.com/public/linaro/lkft/builds/2OGsEcyUv1ZWPkcY6bowUEt67EK/Image.gz
  \
 --modules https://storage.tuxsuite.com/public/linaro/lkft/builds/2OGsEcyUv1ZWPkcY6bowUEt67EK/modules.tar.xz
  \
 --rootfs https://storage.tuxsuite.com/public/linaro/lkft/oebuilds/2OFRZRfcnhLXEnzmi2qNYuD7o3k/images/am57xx-evm/lkft-tux-image-am57xx-evm-20230410193023.rootfs.ext4.gz
  \
 --parameters SKIPFILE=skipfile-lkft.yaml   \
 --parameters SHARD_NUMBER=10   \
 --parameters SHARD_INDEX=2   \
 --image docker.io/lavasoftware/lava-dispatcher:2023.01.0020.gc1598238f   \
 --tests ltp-syscalls   \
 --timeouts boot=30 ltp-syscalls=50


--
Linaro LKFT
https://lkft.linaro.org
