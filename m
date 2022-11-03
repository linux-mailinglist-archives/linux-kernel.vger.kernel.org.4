Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F256618B01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 23:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiKCWCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 18:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbiKCWBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 18:01:44 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF16D22B3F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 15:01:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 7058E5C00C3;
        Thu,  3 Nov 2022 18:01:40 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute5.internal (MEProxy); Thu, 03 Nov 2022 18:01:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1667512900; x=1667599300; bh=/qXxDCY82+Tq7gdknZkmxloD/1sIUhD7xka
        fuRuU+mI=; b=K5bL8PJNKWehcTGjAC8Bkebq9ArZhHxeX0+CUqDV8SRZ6qAkl0B
        XVwViOeW+6b2g0sp/XkZvBZl7qc5KsC1fZNZM6lbt5ugEW+6siEpBY1aCwTHhoGv
        UFNuLFfaL9hCOF2a7qaTUP/+LZizArrcrzVouf4zivKXyl2yhw/JOGA6GwZXpL0L
        QBT3ehADs4dO9DW/aUn1M2Nn7W9kAesjdIHOi1Tt25Y0/mFZVAwCACkxnkkG+avr
        CyM4+DDnxQk7mMdsbuvv2yBSpHnCsc+feTWRXMeYbc4AA4VSWNJDjARkc3+rRctG
        Wgj2sAmDDgPli/5CHeNMLzSIXnnjO2gZBjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1667512900; x=
        1667599300; bh=/qXxDCY82+Tq7gdknZkmxloD/1sIUhD7xkafuRuU+mI=; b=U
        sbhwwrdUj8DLwG6Y23PTWsooxH9Mrj02/yTmny4NnRbD80NawY9n36mo+1E8zNXZ
        Z+45dPpgjiuDkY51wSuYwBGtO3/HEkGcXSLw8khhMBntKyin+JgdS5iBil+a/Ab3
        jGOhG7f6aBKaee5BCfoYTpGpEZczJFCibcG4XuzuAxHkkLaNLXAHDUZvRDkHez1h
        kukxC6q8tyEgDd6TDPdNUbKaKQDNGxMYBk0c8bDuk1IGl/+Y8ru6i3ydw+ccRIZj
        GiW0gj1kjw01Xe0dlJWYDfw+PaC0uWGiFDtaKCNdpILTPc0IPSKT6hWDqZ0Y+PJI
        o0eIrAa16LFPUOTHu3tbw==
X-ME-Sender: <xms:QzpkY1VCwmoW74FJN29QRveA74mMruiOzsEAkyAAi7u6PhC7SkSsdg>
    <xme:QzpkY1m4oCDi3CKzVaz896e5INY0ysa6LESPoik6btjcyC95ptXZm6gQxkLb6BQun
    egFUNLIGh42erZyuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudelgdduhedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvvefutgesthdtre
    dtreertdenucfhrhhomhepfdfuvghrhhgvihcuofgrkhgrrhhovhdfuceoshgvrhhhvghi
    sehsvghrhhgvihdrihhoqeenucggtffrrghtthgvrhhnpeeuleduuddtheehfffgffekie
    etkeettdelgfefffehvedvheduffffleduvdefgeenucffohhmrghinhepshhouhhrtggv
    figrrhgvrdhorhhgpdhfvgguohhrrghprhhojhgvtghtrdhorhhgpdhgihhthhhusgdrtg
    homhdpvggsphhfrdhmugenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehsvghrhhgvihesshgvrhhhvghirdhioh
X-ME-Proxy: <xmx:QzpkYxbMemF3amQ-23syX4BmuAgZ8IKM0DE39nqgs8HplrbyqiyAUg>
    <xmx:QzpkY4UV0FGGRVqcd5wBqyIzUrqE_QmjT5fiFxJv2TuieyziXU8SAA>
    <xmx:QzpkY_lrzjFVSniRzaoTZyvy1HTXezTbI1tuj-0PZMyhDRcxdo-3Cw>
    <xmx:RDpkY-sVESew-b3ak63q8IDc4t1WdGYNkJfE0fDp4lKP3O2V-rFxVg>
Feedback-ID: i572946fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8A4D41700089; Thu,  3 Nov 2022 18:01:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <3d2f6b92-d2fb-4e79-9d87-00cd90c2b588@app.fastmail.com>
Date:   Thu, 03 Nov 2022 18:01:19 -0400
From:   "Serhei Makarov" <serhei@serhei.io>
To:     systemtap <systemtap@sourceware.org>
Cc:     linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: SystemTap release 4.8
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 4.8

Enhancements to this release include: kernel runtime improvements
on multi-CPU systems, python3 tapset support through python3.11,
tapset and template script for cve livepatching, bpf backend
embedded-code assembler improvements

= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-4.8 (commit b176afb2e49119ef844d193d27b0752a6d84fe8f)

  There have been over 95 commits since the last release.
  There have been 10+ bugs fixed / features added since the last release.

= SystemTap backend changes

- The kernel runtime now uses much less memory when the number of
  "possible CPUs" are way more than the online ones. For example,
  VMWare guests usually have 128 "possible CPUs" while fewer
  CPUs are actually present or online in the guest system.

- The memory allocation size is now irrelevant to the value of
  NR_CPUS of the current kernel. It is only subject to the number
  of "possible CPUs" or "online CPUs".

- CPU hotplug is supported to the extent that there won't be any
  kernel panics or memory corruptions.

= SystemTap frontend (stap) changes

- DWARF-related probes (.function, .statement) now merge DWARF and
  non-DWARF symbol-table based matches, rather than being either-or.

- The bpf backend's embedded-code assembler has been improved to
  support more conventional assembly syntax with named opcodes. The
  opcode names are based on the iovisor bpf-docs documentation at
  https://github.com/iovisor/bpf-docs/blob/master/eBPF.md

= SystemTap tapset changes

- A template cve band-aid script is now included, which demonstrates
  how to use a new 'livepatch.stp' tapset to standardize activation,
  interactive control, and monitoring of systemtap cve band-aids.

- The python3 tapset was extended to support python3 3.9, 3.10, and 3.11.
  See stapprobes(3stap) for further details on probing python functions.

- New tapsets:

  livepatch.stp
  The new tapset for creating security band-aid scripts.

= SystemTap sample scripts

- All 180+ examples can be found at https://sourceware.org/systemtap/examples/

- New sample scripts:

  general/pyexample.stp
  Combined version of the py2example.stp and py3example.stp sample scripts.

  security-band-aids/security-bandaid-template.stp
  The new template for creating security band-aid scripts.

  security-band-aids/cve-2016-0728-templatized.stp
  security-band-aids/cve-2018-6485-templatized.stp
  Example band-aid scripts based on the new template, for historical purposes only.

= Examples of tested kernel versions

  2.6.32 (RHEL6 x86_64, i686)
  4.18.0 (RHEL8 + CentOS Stream 8 x86_64, aarch64, ppc64le, s390x)
  5.14.0 (RHEL9 + CentOS Stream 9 x86_64, aarch64, ppc64le, s390x)
  5.19.9 (Fedora 35 x86_64)
  5.19.16 (Fedora 36,37 x86_64)
  6.0.0-rc5, 6.1.0-rc2, 6.1.0-rc3 (Fedora rawhide x86_64)

= Known issues with this release

- There are intermittent buffer transmission failures for high-trace-rate
  scripts.  Bulk mode (stap -b) helps. (see PR29108)

- There are known issues on kernel 5.10+ after adapting to set_fs()
  removal, with some memory accesses that previously returned valid data
  instead returning -EFAULT. (see PR26811)

= Contributors for this release

Sultan Alsawaf, Lumir Balhar*, Martin Cermak, William Cohen, Stan Cox,
Frank Ch. Eigler, Ryan Goldberg*, Serhei Makarov, Noah Sanci,
yaowenbin*, Yichun Zhang (agentzh)

Special thanks to new contributors, marked with '*' above.

= Bugs fixed for this release <https://sourceware.org/PR#####>

29676     wildcard function/symbol expansion inconsistent in debuginfo vs nondebuginfo cases
29246     sdt probes can fail inside a c++ method
27728     at_*.exp regressions (from bunsen data)
27730     abort.exp minor regressions (from bunsen data)
28634     ioscheduler.stp broken with new kernel 5.16.0-0.rc2
29037     Systemtap unable to find struct bitfield members for gcc11 compiled code
29507     update sample python interface tapset to rely on @cast auto context
29570     Standardized template stap script for security band-aids
29577     NULL pointer dereference in kernel tracepoint int3 execution
29661     default --rlimit-as is too small
29668     The make rpm target broken 
