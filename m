Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727AC69FF35
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 00:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBVXFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 18:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBVXFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 18:05:03 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14AE65BA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 15:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=gpK/SvuIMsPG6YxkrIUFcD4AgvZOABAO3vC/qA0zK2g=; b=qATg/QP1btunTJ3GYtn93Yhrsy
        5YTq7AjUIf9HNyIqVEF+T6G4Np9rnrsbV8k+fvn3Z1DT68AAodZhxu/XFWn7lFVBm8yY1JIN2R4Co
        Q6eVWn3H5SA5slX9Rjg6OK7+KdgpHAkoqgB1Jz41lwh/g+GCHWq8k6tF2JmIHDFPrKkjZI43cnpfu
        +MB9lNKK6gIsZWDDyPkSjVtkSNX8Hw0GnxTt3oUJF8nK+3OejzmeoTq5EQEAEqs8epvPWPzUnSDFl
        lXkGe8OI15Qh8lC0tuWowlz6XnD2dAvRCppDzdfEuVh1+S0PRO43ic271cpQZUr7biY1/RhK9IpsO
        SoVXrvjg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUy9T-00ENjo-9a; Wed, 22 Feb 2023 23:03:55 +0000
Date:   Wed, 22 Feb 2023 15:03:55 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, omosnace@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org
Subject: [GIT PULL] sysctl changes for v6.3-rc1
Message-ID: <Y/afW5sNLrLRbDho@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b72607d7321e66829e11148712b3a2ba1dc83e7:

  Merge tag 'thermal-6.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm (2023-02-21 12:32:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ tags/sysctl-6.3-rc1

for you to fetch changes up to f1aa2eb5ea05ccd1fd92d235346e60e90a1ed949:

  sysctl: fix proc_dobool() usability (2023-02-21 13:34:07 -0800)

----------------------------------------------------------------
sysctl-6.3-rc1

Just one fix which just came in, this just hit linux-next just yesterday
with a success build report. But since its a fix and reviewed I think its
good to take in.

Sadly the eager beavers willing to help with the sysctl moves have slowed.

----------------------------------------------------------------
Ondrej Mosnacek (1):
      sysctl: fix proc_dobool() usability

 fs/lockd/svc.c        |  2 +-
 fs/proc/proc_sysctl.c |  6 ++++++
 kernel/sysctl.c       | 43 ++++++++++++++++++++++++-------------------
 mm/hugetlb_vmemmap.c  |  2 +-
 4 files changed, 32 insertions(+), 21 deletions(-)
