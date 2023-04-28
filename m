Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D87566F1966
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 15:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346263AbjD1N1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 09:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346262AbjD1N1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 09:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B8C1FC6;
        Fri, 28 Apr 2023 06:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9FDF363920;
        Fri, 28 Apr 2023 13:26:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E566DC433D2;
        Fri, 28 Apr 2023 13:26:55 +0000 (UTC)
Message-ID: <201e8b3c-dc53-2475-1cff-34dd21ceeeea@linux-m68k.org>
Date:   Fri, 28 Apr 2023 23:26:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v6.4
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu git tree changes for v6.4.

A couple of minor changes. One to remove the long dead uclinux.org web
address and email list from the MAINTAINERS entry for UCLINUX. The other
to remove dead config options in the m68knommu Kconfig.

Regards
Greg




The following changes since commit 6a8f57ae2eb07ab39a6f0ccad60c760743051026:

   Linux 6.3-rc7 (2023-04-16 15:23:53 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.4

for you to fetch changes up to 8ab89e9563161921ffc86724eb3217d228eaad57:

   m68k: Kconfig.machine: remove obsolete configs ROMBASE and ROMSIZE (2023-04-17 09:30:53 +1000)

----------------------------------------------------------------
m68knommu: updates and fixes for v6.4

Fixes include:
. remove dead uclinux.org web and email list from MAINTAINERS
. remove dead config options

----------------------------------------------------------------
Lukas Bulwahn (1):
       m68k: Kconfig.machine: remove obsolete configs ROMBASE and ROMSIZE

Randy Dunlap (1):
       MAINTAINERS: drop uclinux.org

  MAINTAINERS               |  2 --
  arch/m68k/Kconfig.machine | 17 -----------------
  2 files changed, 19 deletions(-)
