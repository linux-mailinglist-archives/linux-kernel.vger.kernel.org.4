Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 690AD6E01A6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDLWEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDLWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:04:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF337EC7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 642B0639C9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 22:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD216C4339B;
        Wed, 12 Apr 2023 22:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681337038;
        bh=yl49Jyqc6STyNi95I9IiDSvYxoTkbez6JMMTpbVF9m4=;
        h=Date:From:To:cc:Subject:From;
        b=kvJhNniScUaApPAZkj1RMFJ2ZYjmssSQZvr9KPr0EpXaiMFe2kg3iDz1QDMR/0NM5
         CvlMnZm/rbUteP+CR+FKCXDV8p4GmfNOEppk25R83PnFV6SQtzpi7uzPs3uwU9WmT1
         LodecTuzWUfDIdQCWL6QqTtsqtHhNUULYrM+G7OYGI3idWW5JRcHoHyG3gZVn+RRgr
         UDwPTZkaizvu5QIhMv8CHs6TM3OoS09erWxmzkIkIUBadhQoPCqKQk0X1YZk6tXXN/
         McMgssGpP5NRbn44l7LmVOlWqjzrxxzg+nO6Wm69zrUXkhjdlEKJ1wwmmD4c+eWv4x
         DFbCe7Fwc80tQ==
Date:   Thu, 13 Apr 2023 00:03:55 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2304130001520.29760@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023041201

to receive fixes for HID susbsytem, namely:

=====
- kernel panic fix fo intel-ish-hid driver (Tanu Malhotra)
- buffer overflow fix in hid-sensor-custom driver (Todd Brandt)
- 2 device specific quirks (Alessandro Manca, Philippe Troin)
=====

Thanks.

----------------------------------------------------------------
Alessandro Manca (1):
      HID: topre: Add support for 87 keys Realforce R2

Philippe Troin (1):
      HID: add HP 13t-aw100 & 14t-ea100 digitizer battery quirks

Tanu Malhotra (1):
      HID: intel-ish-hid: Fix kernel panic during warm reset

Todd Brandt (1):
      HID: hid-sensor-custom: Fix buffer overrun in device name

 drivers/hid/Kconfig                   | 2 +-
 drivers/hid/hid-ids.h                 | 4 ++++
 drivers/hid/hid-input.c               | 6 ++++++
 drivers/hid/hid-sensor-custom.c       | 2 +-
 drivers/hid/hid-topre.c               | 2 ++
 drivers/hid/intel-ish-hid/ishtp/bus.c | 4 ++--
 6 files changed, 16 insertions(+), 4 deletions(-)

-- 
Jiri Kosina
SUSE Labs

