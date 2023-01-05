Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D319465F16E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 17:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234503AbjAEQti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 11:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjAEQtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 11:49:36 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E6C4D727
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 08:49:35 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id i188so38651694vsi.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 08:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NP2Dg9YGoVI0aRQKZRKmk+2NtfJSRs4wKdvzmTJdN30=;
        b=RJeT9XepF5TTt/k0dUZV/SE5YL3hVU4D6mmbfEyA4pmwBB7u9Hos32VINgv35XTGab
         e1EXuv+4aVSIQ061+9zrQAbgzlhfggRsZKmpsPRyPT6cQRgiRsSJSnvXBa+4PG40zTNO
         00JGmopVss5r+0M6adjab+hKHQkwB2SUXfUXg9MzG2Or16N3U/ApampP8ko3k//fpf6s
         6OcTtIuf+RbrJsoHRYlVSFodrr9JJIv7aAGBgldqjq8vIrh6mD3/nhlVkwMkzMPkD/vb
         rR8Ff8MUNMLEtlbJhoALbRGIKZD6O0O/ULVVb6Khz/GuqpJZxjILWSz2pgplusYWSOXL
         GFcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NP2Dg9YGoVI0aRQKZRKmk+2NtfJSRs4wKdvzmTJdN30=;
        b=PY91pV1wY6KLEddP5Yr9Cx4I+fzk2pjMb3f/FwP3ooFsn9DCJqkzuaIS6bu3qXROrB
         tEPN6Dq5h/7rUBQrAWya0RAoMvlA8d/TlD3jAjE+AvLPsCN+S0xdpVLDhW1Oc2GORCul
         guHwELgnnNH7Pq1eU6J848Hg9DUMRs4IGMqUkQavlK4zb8cynqLHsYHx6Bg+ni4PV0Ft
         pfyr0G8jZvVf7jvFAw0ffZMNZN9q3JT6CwttxLJbeKUq6P9DDhuGolbX5iv6VBQW1322
         TQBB4OrFntQ/7hKaysrZQZAMKQAhbR+rig9Bco0AHbIzgYrQBl6dI1uqp9zyj8VWDse4
         1Feg==
X-Gm-Message-State: AFqh2kqraeRLJ4bsk1LDxfStJV2lZuGwyk9ZsaO72tMXgflLR1GO14iH
        tJdlzMRkkYUYOeXzEwioGPNxFy+RWaOfyFGgynM8hw==
X-Google-Smtp-Source: AMrXdXt4N8lhwv0Ijg2+gCVWyvzAM1F/iq8VgL5hQCW+zidR9kVMzq0d/GtKCdfAgZeULmnXAfCUBpSPOnUqtk9txS0=
X-Received: by 2002:a05:6102:3003:b0:3ce:c6d7:a4e3 with SMTP id
 s3-20020a056102300300b003cec6d7a4e3mr68204vsa.3.1672937374400; Thu, 05 Jan
 2023 08:49:34 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 5 Jan 2023 22:19:23 +0530
Message-ID: <CA+G9fYu6=N4OU11CcHqh5auVJ4WdrR4QmovHjni-z88N41y8zw@mail.gmail.com>
Subject: next: clang-15: s390x-linux-gnu-ld: BFD (GNU Binutils for Debian)
 2.35.2 assertion fail ../../bfd/elf64-s390.c:3349
To:     linux-s390@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org, llvm@lists.linux.dev
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The s390 clang-15 build failures on Linux next-20230105 due to following
errors / warnings.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

`.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o:
defined in discarded section `.exit.text' of fs/fuse/inode.o
`.exit.text' referenced in section `__jump_table' of fs/fuse/inode.o:
defined in discarded section `.exit.text' of fs/fuse/inode.o
`.exit.text' referenced in section `__bug_table' of crypto/algboss.o:
defined in discarded section `.exit.text' of crypto/algboss.o
`.exit.text' referenced in section `__bug_table' of drivers/scsi/sd.o:
defined in discarded section `.exit.text' of drivers/scsi/sd.o
`.exit.text' referenced in section `__jump_table' of drivers/md/md.o:
defined in discarded section `.exit.text' of drivers/md/md.o
`.exit.text' referenced in section `__jump_table' of drivers/md/md.o:
defined in discarded section `.exit.text' of drivers/md/md.o
`.exit.text' referenced in section `.altinstructions' of
drivers/md/md.o: defined in discarded section `.exit.text' of
drivers/md/md.o
`.exit.text' referenced in section `.altinstructions' of
drivers/md/md.o: defined in discarded section `.exit.text' of
drivers/md/md.o
`.exit.text' referenced in section `.altinstructions' of
net/iucv/iucv.o: defined in discarded section `.exit.text' of
net/iucv/iucv.o
`.exit.text' referenced in section `__bug_table' of
drivers/s390/cio/qdio_thinint.o: defined in discarded section
`.exit.text' of drivers/s390/cio/qdio_thinint.o
`.exit.text' referenced in section `__bug_table' of
drivers/s390/net/qeth_l3_main.o: defined in discarded section
`.exit.text' of drivers/s390/net/qeth_l3_main.o
`.exit.text' referenced in section `__bug_table' of
drivers/s390/net/qeth_l3_main.o: defined in discarded section
`.exit.text' of drivers/s390/net/qeth_l3_main.o
s390x-linux-gnu-ld: BFD (GNU Binutils for Debian) 2.35.2 assertion
fail ../../bfd/elf64-s390.c:3349
make[2]: *** [scripts/Makefile.vmlinux:34: vmlinux] Error 1
make[2]: Target '__default' not remade because of errors.
make[1]: *** [Makefile:1252: vmlinux] Error 2

metadata:
--------
build_name: clang-15-defconfig
config: https://storage.tuxsuite.com/public/linaro/lkft/builds/2JtJjVEWoJkAJtKsrWamxsxAQb2/config
git_describe: next-20230105
git_repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
git_sha: cc3c08b41a9c9402ead726ec6deb1217081d0d8b

build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2JtJjVEWoJkAJtKsrWamxsxAQb2/

Steps to reproduce with tuxmake:
--------------------------------
# To install tuxmake on your system globally:
# sudo pip3 install -U tuxmake
#
# See https://docs.tuxmake.org/ for complete documentation.
# Original tuxmake command with fragments listed below.

 tuxmake --runtime podman --target-arch s390 --toolchain clang-15
--kconfig defconfig LLVM_IAS=0

--
Linaro LKFT
https://lkft.linaro.org
