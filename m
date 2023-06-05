Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F63F723261
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjFEVj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjFEVjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:39:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D9BF9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:39:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 019E662B17
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 21:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A77EC433D2;
        Mon,  5 Jun 2023 21:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686001161;
        bh=3ObtkGPrvKYbZF22+gXHKd21OaMeqYSSKKzqwTmzR9Y=;
        h=Date:From:To:cc:Subject:From;
        b=K2MLjtd1QnyA7HsQN8cRwZ+y/T/Q+6PyJJaIwbOqrvmlxELf2WF3Y+Xnm7tiV7PsR
         1qoAm4zoD8UiTmttpKZ5se2+/n/BfFratYtDT1o59O4AIsP7tvf7Vo3o3PoIPPYVcy
         mqj0Y03paOFSZGlSkLeUPB62LLvhXx65pfHg49YREpZJDHuIJF/EKAaNxm4HN/ZrYZ
         1euapAhfjQ4BMdbFW6T7d8kzn23tVPMALUig1UBNOgVdM8a1414j0zrggCKlHJ1naC
         6pdR8sZi1xQkqWLr9V1k85UQuNgL/TU4b0OoD/qfbgySmgfFf/BFWQtNxkvk1mt91P
         RwW7TupKmzikQ==
Date:   Mon, 5 Jun 2023 23:39:17 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID regression fix
Message-ID: <nycvar.YFH.7.76.2306052334360.29760@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023060501

to receive 

=====
- Final, confirmed fix for regression causing some devices connected via 
  Logitech HID++ Unifying receiver take too long to initialize (Benjamin 
  Tissoires)
======

----------------------------------------------------------------
Benjamin Tissoires (1):
      HID: hidpp: terminate retry loop on success

 drivers/hid/hid-logitech-hidpp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
Jiri Kosina
SUSE Labs

