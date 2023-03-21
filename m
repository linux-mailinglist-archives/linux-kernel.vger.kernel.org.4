Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CE26C2713
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCUBNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjCUBNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE62D2E0F2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:12:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41C3F61904
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B9BC4339B;
        Tue, 21 Mar 2023 01:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361092;
        bh=yk0FyOBGi95zL0SFt5fPJVSYkYuI57/h+FnjW4XJWrM=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=rTkzC1scO0OIdjAcOUjQzGAvccGqhodeVnFfesIsWfccsKM8e2Sxp+9SVpIf7Cwpt
         jSAKNfgB1l7aZMmKc5XQdMs1CHZIKM5LLOiCfAVlokJPxKwJmO29FnskUBUmw/Sl54
         iKXa26SX4GFaMt2dHeERH+QSu8AjloagqVUql4lbXvKR4gfYwnWpBWiEoqyuuQsRIj
         SYMgp5lHhjlFTgoNTSHsPxR6ZrJcA4CtDEwY0ZHVU7dysB6bX0FkEIbsx6/9AJMaM1
         ePUoNVHW0AIu1KRSc1jfFN4MAeuR7Vn0zFVEq3hseWORgRLa9Can8aq2XWFA0ZdilU
         mITn1rkz9wGhg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 39C191540395; Mon, 20 Mar 2023 18:11:32 -0700 (PDT)
Date:   Mon, 20 Mar 2023 18:11:32 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu
Subject: [PATCH nolibc 0/14] nolibc updates for v6.4
Message-ID: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series contains nolibc updates for v6.4, plus one that is fixes a
regression and will thus be offered up soon for v6.3:

1.	tools/nolibc: always disable stack protector for tests, courtesy
	of Thomas Weiﬂschuh.  This one will be offered for v6.3.

2.	tools/nolibc: Add gitignore to avoid git complaints about sysroot.

3.	tools/nolibc: add stdint.h, courtesy of Vincent Dagonneau.

4.	tools/nolibc: add integer types and integer limit macros,
	courtesy of Vincent Dagonneau.

5.	tools/nolibc: enlarge column width of tests, courtesy of Vincent
	Dagonneau.

6.	tools/nolibc: add tests for the integer limits in stdint.h,
	courtesy of Vincent Dagonneau.

7.	tools/nolibc: add getuid() and geteuid(), courtesy of Willy
	Tarreau.

8.	selftests/nolibc: skip the chroot_root and link_dir tests when
	not privileged, courtesy of Willy Tarreau.

9.	tools/nolibc: check for S_I* macros before defining them,
	courtesy of Willy Tarreau.

10.	tools/nolibc: Include linux/fcntl.h and remove duplicate code,
	courtesy of Feiyang Chen.

11.	tools/nolibc: Add statx() and make stat() rely on statx() if
	necessary, courtesy of Feiyang Chen.

12.	tools/nolibc: Add support for LoongArch, courtesy of Feiyang Chen.

13.	selftests/nolibc: Add support for LoongArch, courtesy of
	Feiyang Chen.

14.	selftests/nolibc: Adjust indentation for Makefile, courtesy of
	Feiyang Chen.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/include/nolibc/.gitignore              |    1 
 b/tools/include/nolibc/Makefile                |    4 
 b/tools/include/nolibc/arch-loongarch.h        |  200 +++++++++++++++++++++++++
 b/tools/include/nolibc/arch.h                  |    2 
 b/tools/include/nolibc/std.h                   |   15 -
 b/tools/include/nolibc/stdint.h                |   24 +++
 b/tools/include/nolibc/sys.h                   |   42 +++++
 b/tools/include/nolibc/types.h                 |   23 ++
 b/tools/testing/selftests/nolibc/Makefile      |    3 
 b/tools/testing/selftests/nolibc/nolibc-test.c |   96 ++++++------
 tools/include/nolibc/stdint.h                  |   75 +++++++++
 tools/include/nolibc/sys.h                     |   58 +++++++
 tools/include/nolibc/types.h                   |    5 
 tools/testing/selftests/nolibc/Makefile        |   78 +++++----
 tools/testing/selftests/nolibc/nolibc-test.c   |   61 +++++++
 15 files changed, 577 insertions(+), 110 deletions(-)
