Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3975F0E95
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiI3PPW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbiI3PPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:15:14 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9C8357FA;
        Fri, 30 Sep 2022 08:15:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 3ABE15C0152;
        Fri, 30 Sep 2022 11:15:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 30 Sep 2022 11:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wfchandler.org;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664550902; x=
        1664637302; bh=7ybg3nygxexcalhGkErIErfbpCmI7RsWlhy3369WZl4=; b=d
        mUWXPZDjuHbt2NyX/KmxCb2IyQCDshCaBsDgOgvxQFDcxpo4YriENNC6PRazqazu
        0EshSJRb/YgDTtpu1bMmjr0czaBxB2bDXsL9U9QMG8F7reDq/MzgysLJOXpxNeno
        rytuXQMrtxwDl3n7hRaZ6W1h88YsAsscQlm6VHbauglX51E0owC5dBdw55NImfU9
        xyKAbMSBgFKWZk6v+3CH7OUYd92GeKXg5D5U3t2fRZkE5VDCkK3bEu17X1hmwaUr
        QBHAvugiuQvn3s2cuWm8H/UHv18MgJnJprq0cZozbC3aZApXuMAg1Zn30GbEnQWR
        SkWsNJnVFocQDBOwXjmzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1664550902; x=1664637302; bh=7ybg3nygxexca
        lhGkErIErfbpCmI7RsWlhy3369WZl4=; b=uporRloMRiFQf3jMpoxNGv5NU1P8q
        q3iWFcUUi9Y8de1WBNdgNomytpup9K1VJ5bnOtq44Ca4eFCjHVJYM1Ckv+Uv+ErW
        tiVV+/LwMbtZh6KVstdKw+ut2cJH6cpo6kd4W7kb6cwNu856NNnvoSlkpLuBULRS
        pVLliOUVVq90yyxPuaiT5YOR7P9FID1hCFLOsi1XXXFM/8NuP+i+kNyQg9Gwc/Yu
        Lcg8JW7igc9gNW84CtmKkoxCN6JCX0uKl4v0qbc+ZD7eCCdzHH6Q/53+5rz9RSgI
        cazqmbvoWOzlXml/9CcKG2ktRWdcPNrWCZ5I615RIB4cub0NwyQ8pcSEg==
X-ME-Sender: <xms:9Qc3YwkbWADDbESKhlh6yt0i7N1qiFnBWDpVqNPonq32vN1w6S4EGw>
    <xme:9Qc3Y_20D1BEGLPLifIjlGfaeSecvXX80D9by9jU3xYk42DMsOCz_mAXvYJ4fNyaX
    Eoqg-icN7ISOg1Lxis>
X-ME-Received: <xmr:9Qc3Y-q152kCr24lrnjiI6u40wU4v6zf4cSCnqReNlfGNSXaFHqMf6rR4oubUaXzN87L_oc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeghihhllhcuvehhrghnughlvghruceofihftgesfihftghh
    rghnughlvghrrdhorhhgqeenucggtffrrghtthgvrhhnpefhkedvueefvdeuffefvdfhve
    evkeeuhfevueeuhefhleejtdevgefgueeihfeuudenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgpdhfvgguohhrrghprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfihftgesfihftghhrghnughlvghrrdho
    rhhg
X-ME-Proxy: <xmx:9Qc3Y8kctCktnDqSK1piz4lWkgikmrzo0_Zt8CTpIZcOdtxDlpLuug>
    <xmx:9Qc3Y-2bHKfHzWn_7uARZ_tNORdQNLnIWIxcLr6EF8d-yBaiZiTLdQ>
    <xmx:9Qc3Yzvup6D7RLU4R1Md5bnk9e55y7ftWC0_QYf2feQiSLGbDIfRfg>
    <xmx:9gc3Y8wBHoejb5njVgGyWEveD7nRC18x5yqRpp3joBWOMl2Op71iIg>
Feedback-ID: ica594744:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 11:15:00 -0400 (EDT)
From:   Will Chandler <wfc@wfchandler.org>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     john.garry@huawei.com, wfc@wfchandler.org
Subject: [PATCH v2] perf tools: Fix empty version number when building outside of a git repo
Date:   Fri, 30 Sep 2022 11:11:57 -0400
Message-Id: <20220930151157.529674-1-wfc@wfchandler.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220927195228.47304-1-wfc@wfchandler.org>
References: <20220927195228.47304-1-wfc@wfchandler.org>
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

To resolve this, revert back to the previous logic of using the kernel
Makefile version if not in a git repository and PERF-VERSION-FILE does
not exist.

[0] https://kojipkgs.fedoraproject.org/packages/kernel-tools/5.19.4/200.fc36/data/logs/x86_64/build.log

Fixes: 7572733b8499 ("perf tools: Fix version kernel tag, 2022-02-21")
Signed-off-by: Will Chandler <wfc@wfchandler.org>
---
Range-diff against v1:
1:  8195a5ccd82d < -:  ------------ perf tools: Fix empty version number when building outside of a git repo
-:  ------------ > 1:  a3beccdab700 perf tools: Fix empty version number when building outside of a git repo

 tools/perf/util/PERF-VERSION-GEN | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/PERF-VERSION-GEN b/tools/perf/util/PERF-VERSION-GEN
index 0ee5af529238..3cc42821d9b3 100755
--- a/tools/perf/util/PERF-VERSION-GEN
+++ b/tools/perf/util/PERF-VERSION-GEN
@@ -11,7 +11,8 @@ LF='
 '
 
 #
-# Always try first to get the version from the kernel Makefile
+# Use version from kernel Makefile unless not in a git repository and
+# PERF-VERSION-FILE exists
 #
 CID=
 TAG=
@@ -19,9 +20,14 @@ if test -d ../../.git -o -f ../../.git
 then
 	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
 	CID=$(git log -1 --abbrev=12 --pretty=format:"%h" 2>/dev/null) && CID="-g$CID"
-else
+elif test -f ../../PERF-VERSION-FILE
+then
 	TAG=$(cut -d' ' -f3 ../../PERF-VERSION-FILE | sed -e 's/\"//g')
 fi
+if test -z "$TAG"
+then
+	TAG=$(MAKEFLAGS= make -sC ../.. kernelversion)
+fi
 
 VN="$TAG$CID"
 if test -n "$CID"
-- 
2.37.3

