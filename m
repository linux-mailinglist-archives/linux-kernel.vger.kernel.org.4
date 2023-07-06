Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA474A3C1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjGFS21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFS2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:28:25 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 778B31FC1;
        Thu,  6 Jul 2023 11:28:23 -0700 (PDT)
Received: from [192.168.192.83] (unknown [50.47.134.245])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 2190141FE2;
        Thu,  6 Jul 2023 18:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688668100;
        bh=8NFL9we8Y8MHZ5EOLhjaIYmRvFfm/t1AXz0LAFwiLEE=;
        h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
        b=JVG74TzNws+vAkajJR/u+ElIXuGZ5sIoYbCYQZlnskJhB0/9oO5DTp5cvznk0TR5n
         3fgqol2JqsVAY69cjcBKhXTHNLT0lZUQpqLih6a8vzmA5EO6PNhLJce3QBrlf0M/Bd
         IaIg6I7OEmn8my9O5m/wcS7Ww8a+dIE0VOUrqh0FNKWLfWAIVUuZhxtNJolg5RFiny
         UGtSKB7q3vd1flIQ1KLN1AzyEaK3DzeTvyKnLow7yHIeIGISRvUG3x4idj+t2TZ6pK
         8klGUBAsFobSU/mXMtDtx+zXYcPUiG9d0gXWrAG/3XPBnZnLR0y8v18y2A1B9BRi8F
         Rrqa+3wOKPHYg==
Message-ID: <b68ad9e0-2ce1-50d5-4856-e4d8fe97fc82@canonical.com>
Date:   Thu, 6 Jul 2023 11:28:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   John Johansen <john.johansen@canonical.com>
Subject: [GIT PULL] apparmor bug fixes for 6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKLM <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Content-Language: en-US
Organization: Canonical
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the following set bug fixes to apparmor for 6.5 or 6.5-rc1

+ Bug Fixes
   - fix missing error check for rhashtable_insert_fast
   - add missing failure check in compute_xmatch_perms
   - fix policy_compat permission remap with extended permissions
   - fix profile verification and enable it
   - fix: kzalloc perms tables for shared dfas
   - Fix kernel-doc header for verify_dfa_accept_index
   - aa_buffer: Convert 1-element array to flexible array
   - Return directly after a failed kzalloc() in two functions
   - fix use of strcpy in policy_unpack_test
   - fix kernel-doc complaints
   - Fix some kernel-doc comments

thanks
- john


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jj/linux-apparmor tags/apparmor-pr-2023-07-06

for you to fetch changes up to 3f069c4c643225f2b96b4b3f8c30e4445f079d2e:

   apparmor: Fix kernel-doc header for verify_dfa_accept_index (2023-07-06 11:12:10 -0700)

----------------------------------------------------------------
+ Bug Fixes
       apparmor: fix missing error check for rhashtable_insert_fast
       apparmor: add missing failure check in compute_xmatch_perms
       apparmor: fix policy_compat permission remap with extended permissions
       apparmor: fix profile verification and enable it
       apparmor: fix: kzalloc perms tables for shared dfas
       apparmor: Fix kernel-doc header for verify_dfa_accept_index
       apparmor: aa_buffer: Convert 1-element array to flexible array
       apparmor: Return directly after a failed kzalloc() in two functions
       apparmor: fix use of strcpy in policy_unpack_test
       apparmor: fix kernel-doc complaints
       AppArmor: Fix some kernel-doc comments

----------------------------------------------------------------
Danila Chernetsov (1):
       apparmor: fix missing error check for rhashtable_insert_fast

John Johansen (5):
       apparmor: add missing failure check in compute_xmatch_perms
       apparmor: fix policy_compat permission remap with extended permissions
       apparmor: fix profile verification and enable it
       apparmor: fix: kzalloc perms tables for shared dfas
       apparmor: Fix kernel-doc header for verify_dfa_accept_index

Kees Cook (1):
       apparmor: aa_buffer: Convert 1-element array to flexible array

Markus Elfring (1):
       apparmor: Return directly after a failed kzalloc() in two functions

Rae Moar (1):
       apparmor: fix use of strcpy in policy_unpack_test

Randy Dunlap (1):
       apparmor: fix kernel-doc complaints

Yang Li (1):
       AppArmor: Fix some kernel-doc comments

  security/apparmor/crypto.c             |  10 ++--
  security/apparmor/file.c               |   2 +-
  security/apparmor/lsm.c                |   8 +--
  security/apparmor/policy.c             |  20 +++++--
  security/apparmor/policy_compat.c      |  20 +++++--
  security/apparmor/policy_unpack.c      | 102 +++++++++++++++++++++------------
  security/apparmor/policy_unpack_test.c |  13 ++---
  security/apparmor/secid.c              |   3 +-
  8 files changed, 110 insertions(+), 68 deletions(-)
