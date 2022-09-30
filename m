Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7597F5F1166
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbiI3SNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbiI3SNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:13:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC64310371B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:12:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DD8AC2191A;
        Fri, 30 Sep 2022 18:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1664561528; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=OiE25FjVnIW4Bs0RVrwDJln37wEihvwuw0yERDMNqhA=;
        b=qI3suvSAHjfnFWWBVl4aujaqxMgF85UIWycmk9tJJZWaX1XTgTm52WuG27SlVPYHDo10yn
        zey+b9iN9aI363hOV9lbt3Xc882I4gWBVU/2beYBsl4K/FhA4G7/xZWBoz0EQ29lfyXd7m
        UyVxeq8UdMdJrDNf4lHF+FYnPv5e9r0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1664561528;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=OiE25FjVnIW4Bs0RVrwDJln37wEihvwuw0yERDMNqhA=;
        b=tw79sQhYvbNCOH3RsUxfOVVdjHfZM1hcUi3mcWM8sCku0WKkNmD+2DDHUxKSrp214yDo5F
        eDj+hCCZdye/9rAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8D4413776;
        Fri, 30 Sep 2022 18:12:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id zKNQL3gxN2PWLgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Fri, 30 Sep 2022 18:12:08 +0000
Date:   Fri, 30 Sep 2022 20:14:02 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     lwn@lwn.net, akpm@linux-foundation.org,
        torvalds@linux-foundation.org
Subject: [ANNOUNCE] The Linux Test Project has been released for SEPTEMBER
 2022
Message-ID: <Yzcx6uooLln8rXLA@yuki>
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

the Linux Test Project test suite stable release for *September 2022* has been
released.

Since the last release 326 patches by 34 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests
   - bpf_prog07 aka CVE-2022-23222
   - bpf_prog06 aka CVE-2021-4204
   - dirtypipe aka CVE-2022-0847
   - execve06 test for argv[0] handling aka CVE-2021-4034

* Increased coverage
  - creat09 added test for another variant of the CVE-2018-13405
  - fanotify10 test for FAN_MARK_IGNORE with FAN_ONDIR
  - fanotify10 test for FAN_MARK_IGNORE with FAN_EVENT_ON_CHILD
  - fanotify09, fanotify14 add test cases for FAN_MARK_IGNORE
  - fanotify14 add test cases for events not allowed on non-dir
  - fanotify09 add test cases for merge of ignore mask
  - fanotify23 test for FAN_MARK_EVICTABLE
  - fanotify12 test for inotify mask flags IN_ONESHOT and IN_EXCL_UNLINK
  - futex_waitv01 test for EAGIN/ETIMEDOUT
  - mount_setattr01 basic functional test

* Minimal filesystem size was increased from 256MB to 300MB in
  order to be able to format it with XFS (mkfs.xfs 5.19)

* More testcaseses were made runtime aware + runtime fixes

* Improvements in the shell test library
  - filesystem detection have been improved
  - added $TST_SKIP_FILESYSTEMS support to match C API
  - added $TST_ALL_FILESYSTEMS support to match C API

* Improvements in open posix testsuite build and installation

* Shell cgroup testcases were rewritten and cleaned up

* 46 tests were rewritten to the new library

+ The usual amount of fixes and cleanups

WHAT IS IN THE QUEUE
====================

* Tracking of minimal device sizes per filesystem, which will allow to run test
  with smaller device sizes for a subset of filesystems

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

* Removed old RPC tests: rup01.sh, rusers01.sh
* Moved rpc01.sh and rpcinfo01.sh to runtest/net.rpc_tests and deleted runtest/net.rpc
* The tst_net.sh library was fixed for cases when IPv6 was disabled
* netns tests were rewritten to use tst_net.sh

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20220930

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

git shortlog -s -e -n 20220527..

    97  Petr Vorel <pvorel@suse.cz>
    50  Avinesh Kumar <akumar@suse.de>
    26  Martin Doucha <mdoucha@suse.cz>
    22  Amir Goldstein <amir73il@gmail.com>
    19  Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
    12  Cyril Hrubis <chrubis@suse.cz>
    12  Yang Xu <xuyang2018.jy@fujitsu.com>
    10  Andrea Cervesato <andrea.cervesato@suse.de>
    10  Li Wang <liwang@redhat.com>
     9  Richard Palethorpe <rpalethorpe@suse.com>
     7  Jan Stancek <jstancek@redhat.com>
     6  Andrea Cervesato via ltp <ltp@lists.linux.it>
     6  Edward Liaw <edliaw@google.com>
     5  Joerg Vehlow <joerg.vehlow@aox.de>
     5  Tudor Cretu <tudor.cretu@arm.com>
     5  Zhao Gongyi <zhaogongyi@huawei.com>
     3  Dylan Jhong <dylan@andestech.com>
     2  Andrea Cervesato <andrea.cervesato@suse.com>
     2  Chen Hanxiao <chenhx.fnst@fujitsu.com>
     2  Hongchen Zhang <zhanghongchen@loongson.cn>
     2  Rong Tao <rongtao@cestc.cn>
     1  Bogdan Lezhepekov <blezhepekov@suse.de>
     1  Cristian Marussi <cristian.marussi@arm.com>
     1  Huangjie Liao <liaohj.jy@fujitsu.com>
     1  Jan Kara <jack@suse.cz>
     1  Jun Huang <huangjuniter@foxmail.com>
     1  Khem Raj <raj.khem@gmail.com>
     1  Leo Yu-Chi Liang <ycliang@andestech.com>
     1  Luo xiaoyu <luoxiaoyu9@huawei.com>
     1  Ross Burton <ross.burton@arm.com>
     1  Sharan Turlapati <sturlapati@vmware.com>
     1  Xiao Liang <xiliang@redhat.com>
     1  Xiao Yang <yangx.jy@cn.fujitsu.com>
     1  Zhao Gongyi via ltp <ltp@lists.linux.it>

And also thanks to patch reviewers:

git log 20220527.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    118 Petr Vorel <pvorel@suse.cz>
    114 Cyril Hrubis <chrubis@suse.cz>
     77 Li Wang <liwang@redhat.com>
     65 Richard Palethorpe <rpalethorpe@suse.com>
     18 Jan Kara <jack@suse.cz>
     13 Martin Doucha <mdoucha@suse.cz>
      6 Yang Xu <xuyang2018.jy@fujitsu.com>
      5 Matthew Bobrowski <repnop@google.com>
      4 Amir Goldstein <amir73il@gmail.com>
      2 Jan Stancek <jstancek@redhat.com>
      1 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
      1 Joerg Vehlow <joerg.vehlow@aox-tech.de>
      1 Christian Brauner (Microsoft) <brauner@kernel.org>
      1 Avinesh Kumar <akumar@suse.de>

-- 
Cyril Hrubis
chrubis@suse.cz
