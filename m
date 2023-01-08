Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADCF1661407
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 08:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjAHHgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 02:36:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjAHHgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 02:36:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C625BD4F
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 23:36:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D76ECCE068A
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 07:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E44C433EF;
        Sun,  8 Jan 2023 07:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673163360;
        bh=+gaFFdaaw8KpOYzmSDAIAoUflBWBrtH2q3+VuJJusH4=;
        h=Date:From:To:Cc:Subject:From;
        b=dVNk1OdoAV+hALLxm7wetArvLJ03z60s09MU7uGeUHIJMFs+3KF5JZAQ0HD5acNIK
         RObbel9wRtJGRa5RLiBeocc2oYIklRblmxGxM++4KUTqymYqwbw44xWXjvgTiARaZm
         fntOqBYjJmXQ+ivTCKr0jNTws6A2RIuW4CZb0XEdVMXAppGXi7oHWhS7585Gx8mBd+
         IN1nV2WRUl8RqGHpfmtLAJr0uF0RVUUSQz46UzZ/2mJQVZ7E8TW6eRnDmTQHcVRua/
         UvtzBI7ZSDB8PD0Q+FPvdRHC7HOgmAcrYsWNMANp8vkkSMJbjHkgzw5o8eOPPcqzfu
         XB2eoHb8wCc8g==
Date:   Sun, 8 Jan 2023 09:35:46 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Aaron Thompson <dev@aaront.org>, Miaoqian Lin <linmq006@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] memblock fixes for v6.2-rc3
Message-ID: <Y7pyUprzAC/9VyNw@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

The following changes since commit 88603b6dc419445847923fcb7fe5080067a30f98:

  Linux 6.2-rc2 (2023-01-01 13:53:16 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/fixes-2023-01-08

for you to fetch changes up to fa81ab49bbe4e1ce756581c970486de0ddb14309:

  memblock: Fix doc for memblock_phys_free (2023-01-04 12:31:22 +0200)

----------------------------------------------------------------
memblock: small fixes in kernel-doc and tests

* Fix kernel-doc for memblock_phys_free() to use correct names for the
  counterpart allocation methods
* Fix compilation error in memblock tests

----------------------------------------------------------------
Aaron Thompson (1):
      memblock tests: Fix compilation error.

Miaoqian Lin (1):
      memblock: Fix doc for memblock_phys_free

 mm/memblock.c                     | 2 +-
 tools/testing/memblock/.gitignore | 1 +
 tools/testing/memblock/Makefile   | 3 ++-
 3 files changed, 4 insertions(+), 2 deletions(-)

-- 
Sincerely yours,
Mike.
