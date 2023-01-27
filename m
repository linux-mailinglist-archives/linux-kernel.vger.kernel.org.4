Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491AD67E8A4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjA0Owd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjA0Owc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:52:32 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82415BA5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:52:30 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 97B021F74B;
        Fri, 27 Jan 2023 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1674831149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=NWKJzVLEskhh5spnHD49SgEFwuW9F6uuTnyL8tKjFlo=;
        b=oSWYOAHrzq73sQB+EAdSXD81kcOoITJUvbV2K2GeoRFWlVq0vwm7u43RpsyOdFOt9iBKOn
        g1Gtqk0JK+3abIiiZPJdm8RrOHmyjBdPVuojhcjFa01IZp2WUXaVkcgTirKrr70SDILjXe
        VvfKbX7FgqRVomxZc3IAVXYUt1rIK7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1674831149;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=NWKJzVLEskhh5spnHD49SgEFwuW9F6uuTnyL8tKjFlo=;
        b=n9VF+8cM4QnU/vlYykHU6d9BofYIBo1Tv2gI426E5y1IvILeFDlnV7XKoG0ntdXQrD0aKO
        Se8z5pR2tTOHFtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B42E1336F;
        Fri, 27 Jan 2023 14:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WtCkFS3l02OoUQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 27 Jan 2023 14:52:29 +0000
Date:   Fri, 27 Jan 2023 15:54:02 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     lwn@lwn.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [ANNOUNCE] The Linux Test Project has been released for JANUARY 2023
Message-ID: <Y9Plit9dXSDhSqC9@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news everyone,

the Linux Test Project test suite stable release for *January 2023* has been
released.

Since the last release 278 patches by 37 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests
  - 31 hugetlb tests were cleaned up and ported from libhugetlbfs
  - test for cve-2022-4378 /proc/sys/ files overflow on writing
  - cgroup_core02 regression test for e57457641613 aka CVE-2021-4197
  - dirtyc0w_shmem aka CVE-2022-2590
  - openat04 regression test for ac6800e279a2
  - nice05 basic functional test for nice()
  - madvise03 new test for MADV_DONTNEED
  - prctl10 basic test for PR_SET/GET_TSC

* Increased coverage
  - mount03 add tests for MS_STRICTATIME, MS_NODIRATIME validate f_flags
  - getitimer01 add check for nonzero timer
  - setitimer01 add interval timer test
  - getitimer02 add ITIMER_VIRTUAL timer error check
  - madvise01 add tests for MADV_COLD and MADV_PAGEOUT

* The minimal supported kernel version was raised to 3.10
  - LTP is no longer tested on older kernels
  - various checks for old kernels were removed from the test code

* The AIO test cleanup was finished with rewrite of aiocp and aio-stress

* LTP is now compiled with explicit -std=gnu99 which forces reasonably
  modern C even on oldest distributions we still have to support

* LTP build system now forces LC_{COLLATE, NUMERIC}=C in order to have
  reproducible builds

* 31 tests were cleaned up and converted for the new test API

+ The usual amount of fixes and cleanups

RUNLTP-NG
=========

* The new runltp-ng is finally included in the released tarball
  - https://github.com/linux-test-project/runltp-ng/#readme
  - https://www.youtube.com/watch?v=JMeJBt3S7B0

REMOVED TESTS
=============

* fs-bench which was broken beyond repair and not worth of keeping

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20230127

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

https://github.com/linux-test-project/ltp/wiki/C-Test-API

https://github.com/linux-test-project/ltp/wiki/C-Test-Network-API

https://github.com/linux-test-project/ltp/wiki/Shell-Test-API

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.

CREDITS
=======

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20220930..

    50  Petr Vorel <pvorel@suse.cz>
    34  Yang Xu <xuyang2018.jy@fujitsu.com>
    33  Tarun Sahu <tsahu@linux.ibm.com>
    28  Avinesh Kumar <akumar@suse.de>
    21  Richard Palethorpe <rpalethorpe@suse.com>
    13  Martin Doucha <mdoucha@suse.cz>
    15  Andrea Cervesato <andrea.cervesato@suse.com>
     9  Li Wang <liwang@redhat.com>
     9  Zhao Gongyi <zhaogongyi@huawei.com>
     6  Akihiko Odaki <akihiko.odaki@daynix.com>
     6  David Hildenbrand <david@redhat.com>
     6  Jan Stancek <jstancek@redhat.com>
     6  Tudor Cretu <tudor.cretu@arm.com>
     6  Luo xiaoyu <luoxiaoyu9@huawei.com>
     4  Wei Gao <wegao@suse.com>
     3  Edward Liaw via ltp <ltp@lists.linux.it>
     3  Jan Kara <jack@suse.cz>
     2  Alessandro Carminati <alessandro.carminati@gmail.com>
     2  Alex <aleksandrosansan@gmail.com>
     2  Cyril Hrubis <chrubis@suse.cz>
     2  Pengfei Xu <pengfei.xu@intel.com>
     2  Rong Tao <rongtao@cestc.cn>
     2  Teo Couprie Diaz <teo.coupriediaz@arm.com>
     1  He Zhe <zhe.he@windriver.com>
     1  Huangjie Liao <liaohj.jy@fujitsu.com>
     1  Ilya Kurdyukov <59548320+ilyakurdyukov@users.noreply.github.com>
     1  Jie2x Zhou <jie2x.zhou@intel.com>
     1  Joerg Vehlow <joerg.vehlow@aox.de>
     1  Khem Raj <raj.khem@gmail.com>
     1  Murphy Zhou <jencce.kernel@gmail.com>
     1  Nikolaus Voss <nikolaus.voss@haag-streit.com>
     1  Randolph <randolph@andestech.com>
     1  Sven Schnelle <svens@linux.ibm.com>
     1  Vitaly Chikunov <vt@altlinux.org>
     1  chenhx.fnst@fujitsu.com <chenhx.fnst@fujitsu.com>
     1  wangkaiyuan <wangkaiyuan@inspur.com>
     1  zijunzhao <zijunzhao@google.com>

And also thanks to patch reviewers:

git log 20220930.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    106 Richard Palethorpe <rpalethorpe@suse.com>
     70 Petr Vorel <pvorel@suse.cz>
     47 Cyril Hrubis <chrubis@suse.cz>
     45 Li Wang <liwang@redhat.com>
     14 Yang Xu <xuyang2018.jy@fujitsu.com>
      7 Jan Stancek <jstancek@redhat.com>
      8 Martin Doucha <mdoucha@suse.cz>
      3 Avinesh Kumar <akumar@suse.de>
      2 Pengfei Xu <pengfei.xu@intel.com>
      1 Richard Purdie <richard.purdie@linuxfoundation.org>
      1 Khem Raj <raj.khem@gmail.com>
      1 Christian Brauner (Microsoft) <brauner@kernel.org>
      1 Chang S. Bae <chang.seok.bae@intel.com>
      1 Andrea Cervesato <andrea.cervesato@suse.de>
      1 Akihiko Odaki <akihiko.odaki@daynix.com>
-- 
Cyril Hrubis
chrubis@suse.cz
