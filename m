Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CCE7199B6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjFAK2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjFAK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:28:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813F21717
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:27:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF2106434C
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:27:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2A1C433EF;
        Thu,  1 Jun 2023 10:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685615247;
        bh=ENBV4DLE9RRwjCZ/c9/2iTTd6netv8y+c7So/eQRweU=;
        h=Date:From:To:cc:Subject:From;
        b=h3EGH9TaaJBylDePLAg/NbuFU5GUreTtz7IcRRcWuXjeE5hNur52wyJ6fQU3ZplrD
         sxoL6HI4pRaTsrnaf5fKGNchoXyyzRKloaldf06OivOwb+JuVRbkxK7tSboDQKyCgq
         HCu31puoJwaMtn8gsS6zKpcVxXb59dZ0QYt7v9JIhBcuXY2w4f9k9+BXAPiHmknNze
         zhlV4Aze7emvVGXQwFrA/dYp64Z9eqGyXSl6luKLyde7NpWk8skEc4G44/yuxuO73u
         f7fUy0ojmB4nwYUaHTpj/b5jg79UtTBABjjQoeQLfFzHQ0qg4WxangrT+psuxy32Vw
         IVj15YF1JN7ww==
Date:   Thu, 1 Jun 2023 12:27:24 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2306011224050.29760@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023060101

to receive HID subsystem fixes, most importantly:

=====
- Regression fix for overlong long timeouts during initialization on some 
  Logitech Unifying devices (Bastien Nocera)
- error handling and overflow fixes for Wacom driver (Denis Arefev, Jason 
  Gerecke, Nikita Zhandarovich)
=====

Thanks.

----------------------------------------------------------------
Bastien Nocera (1):
      HID: logitech-hidpp: Handle timeout differently from busy

Denis Arefev (1):
      HID: wacom: Add error check to wacom_parse_and_register()

Jason Gerecke (1):
      HID: wacom: Check for string overflow from strscpy calls

Nikita Zhandarovich (1):
      HID: wacom: avoid integer overflow in wacom_intuos_inout()

Sung-Chi Li (1):
      HID: google: add jewel USB id

 drivers/hid/hid-google-hammer.c  |  2 ++
 drivers/hid/hid-ids.h            |  1 +
 drivers/hid/hid-logitech-hidpp.c |  1 +
 drivers/hid/wacom_sys.c          | 21 ++++++++++++++++-----
 drivers/hid/wacom_wac.c          |  2 +-
 5 files changed, 21 insertions(+), 6 deletions(-)

-- 
Jiri Kosina
SUSE Labs

