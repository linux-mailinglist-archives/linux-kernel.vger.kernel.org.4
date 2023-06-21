Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080E6738ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 18:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbjFUQUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 12:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFUQUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 12:20:16 -0400
Received: from imap5.colo.codethink.co.uk (imap5.colo.codethink.co.uk [78.40.148.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8995E10DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 09:20:12 -0700 (PDT)
Received: from [167.98.27.226] (helo=rainbowdash)
        by imap5.colo.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qC0Yw-00CSao-DZ; Wed, 21 Jun 2023 17:20:07 +0100
Received: from ben by rainbowdash with local (Exim 4.96)
        (envelope-from <ben@rainbowdash>)
        id 1qC0Yx-001z4O-00;
        Wed, 21 Jun 2023 17:20:07 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com
Cc:     Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [RFC 0/5] updates for i3c error printing
Date:   Wed, 21 Jun 2023 17:20:00 +0100
Message-Id: <20230621162005.473049-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During work on an i3c compatible system some of the
probing does not produce much useful error output. This
series is an attempt to add error reporting where it
would be useful to track down the culprit.

Ben Dooks (5):
  i3c: show error with node for invalid reg property
  i3c: add error print to show device failing during populate bus
  i3c: show node when printing unsupported 10-bit i2c dev
  i3c: show error messages in of_i3c_master_add_i3c_boardinfo
  i3c: dw; add print if cannot get resources

 drivers/i3c/master.c               | 28 +++++++++++++++++++++-------
 drivers/i3c/master/dw-i3c-master.c | 12 +++++++++---
 2 files changed, 30 insertions(+), 10 deletions(-)

-- 
2.40.1

