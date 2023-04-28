Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AE46F20D2
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346785AbjD1WeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346512AbjD1WeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:34:17 -0400
X-Greylist: delayed 4160 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Apr 2023 15:34:15 PDT
Received: from elastic.org (elastic.org [96.126.110.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047EF19B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=elastic.org
        ; s=default2; h=Content-Type:MIME-Version:Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JuVrP9QSRagdAWAzN4wlVTpKBtUsoDuBKet22DURwDQ=; b=d51zfL4ZSj0o6qGBnQ/UayfZQs
        heV31W1zxUi6B2th3NWBUW9/+6DJO93JEwv2EQqVeuuV7mA7C+qmmBk0V0WTMNGh55cym3aUBljKE
        AAefFwxjVf1Fo/30aPQSoNYI3t+BpoAiEPWJpHbBUyzyg8Bkuohyl8WiWjFrzQOfhpQrlJNHN8ati
        O7pt4E2v5Zfqv6a44lw6Kv7csVKxoiyDCxkf1VtjHgsDhgK7xdGC8qEwHnDELMROaoTSwAjVAHfEM
        /sp1Fo/cfM0LCQMVnV5PxRvSMpVCqcZA+mzkXrVJN/FdCHW9bC6QmL9jY6bN015otWsIcvVeksYkN
        Hq212qgA==;
Received: from vpn-home.elastic.org ([10.0.0.2] helo=elastic.org)
        by elastic.org with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <fche@elastic.org>)
        id 1psVaH-0007kQ-2C;
        Fri, 28 Apr 2023 21:24:53 +0000
Received: from very.elastic.org ([192.168.1.1])
        by elastic.org with esmtp (Exim 4.96)
        (envelope-from <fche@elastic.org>)
        id 1psVaH-0005W1-2G;
        Fri, 28 Apr 2023 17:24:53 -0400
Received: from fche by very.elastic.org with local (Exim 4.96)
        (envelope-from <fche@very.elastic.org>)
        id 1psVaH-0076fr-0p;
        Fri, 28 Apr 2023 17:24:53 -0400
Date:   Fri, 28 Apr 2023 17:24:53 -0400
From:   "Frank Ch. Eigler" <fche@elastic.org>
To:     systemtap@sourceware.org
Cc:     linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: SystemTap release 4.9
Message-ID: <ZEw5pdqi7y/jYqeA@elastic.org>
Reply-To: systemtap@sourceware.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Sender-Verification: ""
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 4.9

Enhancements to this release include: Jupyter web-based interactive
frontend, language-server-protocol backend


= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-4.9 (commit ebb424eee5599fc)

  There have been over 70 commits since the last release.
  There have been 10 bugs fixed / features added since the last release.


= SystemTap backend changes

* Corrected handling of DWARF5 implicit-pointer and entry-value data
  and bit-fields.

* Corrected accidental runtime double-hit of some types of synthetic
  probes.

* Improved kernel backtrace repeated artifacts.


= SystemTap frontend (stap) changes

* Added a Jupyter based front-end to stap.  This may be invoked via a
  container - or built locally (likely via pip3 downloads).  The user
  interface becomes an interactive notebook in a web browser.  See the
  "stap-jupyter" man page.

* Added a "--language-server" option to stap, which switches it into
  an LSP server on stdin/stdout.  This allows users of a variety of
  editors to trigger symbol-completions and similar operations in
  context.  This code includes a small reusable jsonrpc server library
  implementation in C++.

* Improved documentation generation scripts, so the website doc
  snapshots can be fresher.

* Improved deterministic buildability of dtrace-flavoured .h/.c file
  generation.
  
* Temporarily disabled $context-variable liveness safety checks on
  retpoline kernels.


= SystemTap tapset changes

* Python3 version range compatibility much improved.

* Updated for NFS, VFS and other kernel changes.

* Updated system call name tables.


= SystemTap sample scripts

* All 180+ examples can be found at https://sourceware.org/systemtap/examples/

* The new Jupyter front-end includes a default notebook that includes
  several scripts and fragments, equipped with webby eyecandy!

* The livepatch.stp sample script for CVE band-aids is better
  documented.
  

= Examples of tested kernel versions

  3.10.0 (RHEL7)
  4.18.0 (RHEL8 + CentOS Stream 8 x86_64, aarch64, ppc64le, s390x)
  5.14.0 (RHEL9 + CentOS Stream 9 x86_64, aarch64, ppc64le, s390x)
  5.19.16 (Fedora 36 x86_64)
  6.2.11 (Fedora 37 x86_64)
  6.3.0-rc (Fedora rawhide x86_64)


= Known issues with this release

- There are intermittent buffer transmission failures for high-trace-rate
  scripts.  Bulk mode (stap -b) helps. (see PR29108)

- There are known issues on kernel 5.10+ after adapting to set_fs()
  removal, with some memory accesses that previously returned valid data
  instead returning -EFAULT. (see PR26811)


= Contributors for this release

Aaron Merey, Frank Ch. Eigler, *Gioele Barabucci, Mark Wielaard,
Martin Cermak, Ryan Goldberg, Serhei Makarov, Stan Cox, William Cohen

Special thanks to new contributors, marked with '*' above.


= Bugs fixed for this release <https://sourceware.org/PR#####>

29801	--monitor mode gets 2 hits to procfs("monitor_control").write for every 1 write
29838	DWARF5 DW_OP_implicit_pointer and DW_OP_entry_value unhandled
29676	wildcard function/symbol expansion inconsistent in debuginfo vs nondebuginfo cases
29837	kernel build compiler warning makes testsuite fail
29832   probe python.function.entry does not get hits (while .return does)
29766	kernel.function("__set_page_dirty_buffers") not found in tapset/linux/vfs.stp
29037	Systemtap unable to find struct bitfield members for gcc11 compiled code
30123	bitfield.exp fails with fresh kernels
29824	BUG: using smp_processor_id() in preemptible [00000000] code: stapio/58567
30372	dyninst liveness analysis with retpoline kernels slow
30396	kernel 6.3.* objtool/ibt warnings during pass 4

