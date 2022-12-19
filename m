Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B67651594
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbiLSWd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiLSWdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:33:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4299C6254;
        Mon, 19 Dec 2022 14:33:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EC800B81047;
        Mon, 19 Dec 2022 22:33:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60C78C433D2;
        Mon, 19 Dec 2022 22:33:18 +0000 (UTC)
Message-ID: <ac9f88a2-de77-d753-d1d6-210fca529c71@linux-m68k.org>
Date:   Tue, 20 Dec 2022 08:33:16 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v6.2
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu git tree changes for v6.2.

Only a single change to use the safer strscpy() instead of strncpy()
when setting up the cmdline.

Regards
Greg




The following changes since commit 76dcd734eca23168cb008912c0f69ff408905235:

   Linux 6.1-rc8 (2022-12-04 14:48:12 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.2

for you to fetch changes up to af5d74e32eb8e1b833f687047f0ffe3801d7229d:

   m68k: use strscpy() to instead of strncpy() (2022-12-05 09:07:21 +1000)

----------------------------------------------------------------
m68knommu: updates and fixes for v6.2

Fixes include:
. use strscpy() instead of strncpy() for cmdline setup

----------------------------------------------------------------
Xu Panda (1):
       m68k: use strscpy() to instead of strncpy()

  arch/m68k/kernel/setup_no.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)
