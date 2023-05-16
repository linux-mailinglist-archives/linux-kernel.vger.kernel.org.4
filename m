Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2722370484E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjEPI5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjEPI5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:57:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E0D2738
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:57:28 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 316F81FD88;
        Tue, 16 May 2023 08:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684227447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Z7Z17UxwlPZXAFlulVYyXcdhXoFSKT89glSYZBLFJ7s=;
        b=spYdVKPjDgzF7j+X6HgjFuBngEzQOJfDn61kr4+qcrvucrxbWQOqjsz2XVy+UHFPmR4RQm
        fk0CK5p8kCxjxHJ7Pjy8PwR5xjatqt/wHFJx2GTeOjHa8gCYkiTVHFSKuBuWX1IAMGxS4b
        MODkFgV9Bwmh+Om+5B149DVFeEpI12M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684227447;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=Z7Z17UxwlPZXAFlulVYyXcdhXoFSKT89glSYZBLFJ7s=;
        b=Wx8Nm2Lcj/TeCb3cjebdMYgwl295oqu7IwhnRLMXegMq4km5vCxQ23qk2gOIIVNQ2rXmWB
        +to/vxDrx3CJQtAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CB24138F5;
        Tue, 16 May 2023 08:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id v8L4BXdFY2T7OQAAMHmgww
        (envelope-from <chrubis@suse.cz>); Tue, 16 May 2023 08:57:27 +0000
Date:   Tue, 16 May 2023 10:58:29 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     ltp@lists.linux.it, linux-kernel@vger.kernel.org,
        libc-alpha@sourceware.org
Cc:     lwn@wn.net, akpm@inux-foundation.org, torvalds@linux-foundation.org
Subject: The Linux Test Project has been released for MAY 2023
Message-ID: <ZGNFtfP2ioTEEpC3@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good news everyone,

the Linux Test Project test suite stable release for *May 2023* has been
released.

Since the last release 199 patches by 33 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests
  - kvm_svm01 aka CVE-2021-3653
  - cgroup_core03 test case for the cgroup kill
  - hugetlb32 regression test for:
    - ba9c1201beaa (mm/hugetlb: clear compound_nr before freeing gigantic pages)
    - a01f43901cfb (hugetlb: be sure to free demoted CMA pages to CMA)
  - mmap20 test for mmap() with MAP_SHARED_VALIDATE
  - mqnotify03 aka CVE-2021-38604
  - mprotect05 regression test for:
    - 2fcd07b7ccd5 (mm/mprotect: Fix successful vma_merge() of next in do_mprotect_pkey())
  - fsconfig03 aka CVE-2022-0185
  - madvise11 regression test for:
    - d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
  - mount07 test case for MS_NOSYMFOLLOW

* Increased coverage
  - NFS tests now run on btrfs, ext4 and xfs
  - setpgid were rewritten and increased coverage in a few corner cases
  - ioctl01 added more termios coverage

* fs_fill test was fixed on 256+ CPUs

* loongarch support was added

+ The usual amount of fixes and cleanups

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

- NFS tests now run on btrfs, ext4, xfs
  (might be extended to more filesystems later)
- nfs08.sh a new test for NFS cache invalidation

RUNLTP-NG
=========

* The new runltp-ng was finally included in the previous release tarball
  - https://github.com/linux-test-project/runltp-ng/#readme
  - https://www.youtube.com/watch?v=JMeJBt3S7B0

* There were no changes done in this release, however parallel text execution
  is being worked on, possibly there would be preview ready for the next release

REMOVED TESTS
=============

* tomoyo testsuite which is maintained elsewhere by tomoyo devs

* execltp script which was unmaintained for years

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20230516

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

git shortlog -s -e -n 20230127..

    58  Petr Vorel <pvorel@suse.cz>
    20  Andrea Cervesato via ltp <ltp@lists.linux.it>
    19  Yang Xu <xuyang2018.jy@fujitsu.com>
    15  Martin Doucha <mdoucha@suse.cz>
    11  Andrea Cervesato <andrea.cervesato@suse.com>
    11  Edward Liaw <edliaw@google.com>
    10  Wei Gao <wegao@suse.com>
     8  Avinesh Kumar <akumar@suse.de>
     5  Cyril Hrubis <chrubis@suse.cz>
     5  Teo Couprie Diaz <teo.coupriediaz@arm.com>
     4  Li Wang <liwang@redhat.com>
     3  Hao Ge <gehao@kylinos.cn>
     3  Ping Fang <pifang@redhat.com>
     3  Richard Palethorpe <rpalethorpe@suse.com>
     3  Tarun Sahu <tsahu@linux.ibm.com>
     2  Hao Zeng <zenghao@kylinos.cn>
     2  Leo Yu-Chi Liang <ycliang@andestech.com>
     2  Sowmya Indranna <reachmesowmyati@gmail.com>
     1  Andrei Gherzan <andrei.gherzan@canonical.com>
     1  Ashwin Dayanand Kamat via ltp <ltp@lists.linux.it>
     1  David Hildenbrand <david@redhat.com>
     1  Enze Li <lienze@kylinos.cn>
     1  Fabrice Fontaine <fontaine.fabrice@gmail.com>
     1  Frank He <hexiaoxiao@kylinos.cn>
     1  Hui Min Mina Chou <minachou@andestech.com>
     1  Jan Stancek <jstancek@redhat.com>
     1  Liam R. Howlett <Liam.Howlett@oracle.com>
     1  Mahesh Kumar G <maheshkumar657g@gmail.com>
     1  Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
     1  Paulson Raja L <paulson@zilogic.com>
     1  Seth Forshee (DigitalOcean) <sforshee@kernel.org>
     1  Vignesh Raman <vignesh.raman@collabora.com>
     1  William Roche <william.roche@oracle.com>


And also thanks to patch reviewers:

git log 20230127.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

     68 Cyril Hrubis <chrubis@suse.cz>
     60 Petr Vorel <pvorel@suse.cz>
     36 Richard Palethorpe <rpalethorpe@suse.com>
     35 Li Wang <liwang@redhat.com>
      7 Jan Stancek <jstancek@redhat.com>
      4 Avinesh Kumar <akumar@suse.de>
      3 Yang Xu <xuyang2018.jy@fujitsu.com>
      2 Andrea Cervesato <andrea.cervesato@suse.com>
      1 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

-- 
Cyril Hrubis
chrubis@suse.cz
