Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6AE56EBB7E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 23:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjDVVZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 17:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjDVVZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 17:25:51 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B63E810DF;
        Sat, 22 Apr 2023 14:25:49 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1pqKjr-0004Ox-00; Sat, 22 Apr 2023 23:25:47 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C3F3CC0133; Sat, 22 Apr 2023 23:25:34 +0200 (CEST)
Date:   Sat, 22 Apr 2023 23:25:34 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.3
Message-ID: <20230422212534.GA7257@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit ab327f8acdf8d06601fbf058859a539a9422afff:

  mips: bmips: BCM6358: disable RAC flush for TP1 (2023-03-18 14:36:06 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.3_2

for you to fetch changes up to 6dcbd0a69c84a8ae7a442840a8cf6b1379dc8f16:

  MIPS: Define RUNTIME_DISCARD_EXIT in LD script (2023-04-21 23:59:43 +0200)

----------------------------------------------------------------
Fix for link errors

----------------------------------------------------------------
Jiaxun Yang (1):
      MIPS: Define RUNTIME_DISCARD_EXIT in LD script

 arch/mips/kernel/vmlinux.lds.S | 2 ++
 1 file changed, 2 insertions(+)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
