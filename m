Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA45ECD31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiI0TxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiI0TxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:53:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0560C96FD0;
        Tue, 27 Sep 2022 12:53:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id C6A235C00E8;
        Tue, 27 Sep 2022 15:52:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 27 Sep 2022 15:52:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1664308378; x=1664394778; bh=7t7ZSB2d97
        FUKxKcAQJgF8klof7GgnZ1fb9Gj6c5RzQ=; b=cRSBxxSOyLaVoMUJH54v5PDP8Y
        uyJEhEWa4HdUTpYrVrkWqnhITZX0fQiG6K3I+dmPW1NHLLsCldGUtVUcKAj06+0v
        m3mrKr0ECfTVhXNWigzKIrZamj4iyPLQkuQ4HK3dx1BQ3Z22B/t41jgX2D0B5Y0G
        F4F6I24ehXW4U/SeqV82bQj3oEc4jPWFQxG4PlM0cHlJpKxvHMpRD+qLXoPFAW4B
        /pVx+b8U/UAznJF04fonbGRQpGv6zcNxLO33whuvpXiKR/c3IHo8UWQqx0OKKKVK
        BZR2v5PE7751lpBcmTR0Rj6pV+S00qz62kt2ab+PgGsYZTdiEDN8AqRdPX6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1664308378; x=1664394778; bh=7t7ZSB2d97FUKxKcAQJgF8klof7GgnZ1fb9
        Gj6c5RzQ=; b=BfE43Jsu8CUJz65dHl9oE7WNYUJ7ePxlBH19BHYfXyLkIK5CeYm
        mBed2EYiMjRX7NBiX5f/L2IApuSHXn1s6CXhDgG6Q3HfRaHf1y0q+wOJBq9QIkwO
        M7lxcOTmqCGlgY8LOkBdnbjuVbdYtZvXSteJ8ram30qpHVYsF/LXUOxFJp3rCG6P
        qiVAN0ZF0nPEgaSPWO0/E9kb7wyExpfNIFy5rVrFM81tkMQHTuBxz2foyTDFxHaT
        kI/KITD19PcwerXCr/mxKv7Hj6PG7GWa6DuO47SF9QJiTiEI5xaO2QJ3yTlI460F
        Ul9mWoekBUcu7KbiVoWJigB2aGGchZ2McPQ==
X-ME-Sender: <xms:mlQzY1aZqUKgF6HnEMAcoi8H23RU2vI207Y7lbHSCcAxE1W0SuWEKw>
    <xme:mlQzY8apN_ktvGYHBbIxc8lkKsgtdn4rP5-6__s7kKPU6gAh9BAFf5l64tnRymimy
    smOHwl8VZ3PuRQy1HQ>
X-ME-Received: <xmr:mlQzY3-FI02zyKnCMXPWDn7vkfzhXSQrb0lkRTJnTmzvlMQtK0mFG4B6swYRX45VB_yJ5a0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeegiedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekre
    dtredttdenucfhrhhomhephghilhhlucevhhgrnhgulhgvrhcuoeiffhgtseiffhgthhgr
    nhgulhgvrhdrohhrgheqnecuggftrfgrthhtvghrnhephfegffevtdeuueeugedvledvfe
    eikeefueetteekffdthfekfeeggffgheelleehnecuffhomhgrihhnpehkvghrnhgvlhdr
    ohhrghdpfhgvughorhgrphhrohhjvggtthdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpeiffhgtseiffhgthhgrnhgulhgvrhdrohhr
    gh
X-ME-Proxy: <xmx:mlQzYzpdBzrqmkWrgL71hBie0yHdZCqDi2t0sDlMIIsIWh1lM_mbKw>
    <xmx:mlQzYwqSoMxxg7QiMzNJhl9O2RD9ao-Dcc46vPC5-Lveuzr-K5XuAA>
    <xmx:mlQzY5TGsTFxp2xOgV5PMJW5wDOK-adF98KpkmgJn7PdG2QfZ8GXZQ>
    <xmx:mlQzY31A9uXv7LPxprs8rjgODL536pnNLusdUd8YQltNWr-0zDl-kw>
Feedback-ID: ica594744:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Sep 2022 15:52:57 -0400 (EDT)
From:   Will Chandler <wfc@wfchandler.org>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, wfc@wfchandler.org
Subject: [PATCH] perf tools: Fix empty version number when building outside of a git repo
Date:   Tue, 27 Sep 2022 15:52:28 -0400
Message-Id: <20220927195228.47304-1-wfc@wfchandler.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf is built in a full source tree that is not a git repository,
e.g. from a kernel source tarball, `perf version` will print empty tag
and commit strings:

  $ perf version
  perf version

Currently the tag version is only generated from the root Makefile when
building in a git repository. If PERF-VERSION-FILE has not been
generated and the source tree is not in a git repository, then
PERF-VERSION-GEN will return an empty version.

The problem can be reproduced with the following steps:

  $ wget https://git.kernel.org/torvalds/t/linux-6.0-rc7.tar.gz
  $ tar -xf linux-6.0-rc7.tar.gz && cd linux-6.0-rc7
  $ make -C tools/perf
  $ tools/perf/perf -v
  perf version

Builds from tarballs generated with `make perf-tar-src-pkg` are not
impacted by this issue as PERF-VERSION-FILE is included in the archive.

The perf RPM provided by Fedora for 5.18+ is experiencing this problem.
Package build logs[0] show that the build is attempting to fall back on
PERF-VERSION-FILE, but it is not present.

To resolve this, always use the tag from the root Makefile if available.

[0] https://kojipkgs.fedoraproject.org/packages/kernel-tools/5.19.4/200.fc36/data/logs/x86_64/build.log

Fixes: 7572733b8499 ("perf tools: Fix version kernel tag, 2022-02-21")
Signed-off-by: Will Chandler <wfc@wfchandler.org>
---
 tools/perf/util/PERF-VERSION-GEN | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
index 0ee5af529238..43b8a8ea6f53 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -15,10 +15,13 @@ LF='
 #
 CID=
 TAG=
-if test -d ../../.git -o -f ../../.git
+if test -r ../../Makefile
 then
 	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
-	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
+	if test -d ../../.git -o -f ../../.git
+	then
+	    CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
+	fi
 else
 	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
 fi
-- 
2.37.3

