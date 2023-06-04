Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE57B72157E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 10:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjFDIFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjFDIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 04:05:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FD5ED
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 01:05:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E9A260B94
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 08:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19A6C433D2;
        Sun,  4 Jun 2023 08:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685865908;
        bh=TtMRPPkW835qPg/rcQ4E+f76i02QXwp3up0LOqxzIJY=;
        h=Date:From:To:Cc:Subject:From;
        b=SeRmbQCrRonMgZGYlStnXqz33UIcyQHfQNDwCjH/o1/m1rI4NalW+asSQoVZciuaR
         dPASz/myXZfGia2BEt6PQUuBvUYMLTMm2P1P8cyPGmvGi7pxYuPqCUmoLtbNae8UF0
         bszxsueSZVAq2ADHSAnhdZKSlZBh0CC2Zl48cn88=
Date:   Sun, 4 Jun 2023 10:05:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core fixes for 6.4-rc5
Message-ID: <ZHxFsQHCXZ9Q56uu@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.4-rc5

for you to fetch changes up to c26fabe73330d983c7ce822c6b6ec0879b4da61f:

  drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug (2023-05-31 20:36:47 +0100)

----------------------------------------------------------------
Driver core fixes for 6.4-rc5

Here are 2 small driver core cacheinfo fixes for 6.4-rc5 that resolve a
number of reported issues with that file.  These changes have been in
linux-next this past week with no reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
K Prateek Nayak (2):
      drivers: base: cacheinfo: Fix shared_cpu_map changes in event of CPU hotplug
      drivers: base: cacheinfo: Update cpu_map_populated during CPU Hotplug

 drivers/base/cacheinfo.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)
