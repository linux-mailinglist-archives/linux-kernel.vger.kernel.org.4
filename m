Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA99748B00
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbjGERyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjGERx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:53:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974718E;
        Wed,  5 Jul 2023 10:53:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2813361692;
        Wed,  5 Jul 2023 17:53:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AE13C433C8;
        Wed,  5 Jul 2023 17:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688579637;
        bh=rhBS1vS11SfoH+CqKqR2jF9CDyllTzyq64ClP3Lgg2g=;
        h=From:To:Cc:Subject:Date:From;
        b=06k3W6wrd/2HLBDakqWLRTmfLzgMIb6We74UMhdJ5vo0HK40OxKJbxJbOKvLbXzBz
         RtJdb+RUS+mxtBrLeO5X/u/7nHu2f5QyWW9t1++VAABXAV+3BA6ojNnkV2NsBOZFpl
         mr0Ts+sGSD+77NeFiBscvcQ+CEQpe13hgKpwLNIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.120
Date:   Wed,  5 Jul 2023 18:53:53 +0100
Message-ID: <2023070553-juror-flask-481c@gregkh>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 5.15.120 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                   |    2 -
 arch/parisc/include/asm/assembly.h         |    4 --
 arch/x86/kernel/cpu/microcode/amd.c        |    2 -
 arch/x86/kernel/smpboot.c                  |   24 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |    1 
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     |    4 ++
 drivers/hid/hid-logitech-hidpp.c           |    2 -
 drivers/hid/wacom_wac.c                    |    6 +--
 drivers/hid/wacom_wac.h                    |    2 -
 drivers/nubus/proc.c                       |   22 ++++++++++---
 drivers/thermal/mtk_thermal.c              |   14 +-------
 include/linux/highmem.h                    |   24 +++++++++++++++
 include/linux/mm.h                         |    5 ++-
 kernel/bpf/verifier.c                      |    7 +++-
 mm/memory.c                                |   33 ++++++++++++++------
 net/can/isotp.c                            |    5 +--
 net/mptcp/protocol.c                       |   46 +++++++++++++----------------
 net/mptcp/subflow.c                        |   17 ++++++----
 scripts/tags.sh                            |    9 +++++
 tools/perf/util/symbol.c                   |   17 +++++++++-
 20 files changed, 158 insertions(+), 88 deletions(-)

Ahmed S. Darwish (1):
      scripts/tags.sh: Resolve gtags empty index generation

Bas Nieuwenhuizen (1):
      drm/amdgpu: Validate VM ioctl flags.

Ben Hutchings (1):
      parisc: Delete redundant register definitions in <asm/assembly.h>

Borislav Petkov (AMD) (1):
      x86/microcode/AMD: Load late on both threads too

Finn Thain (1):
      nubus: Partially revert proc_create_single_data() conversion

Greg Kroah-Hartman (1):
      Linux 5.15.120

Jane Chu (1):
      mm, hwpoison: when copy-on-write hits poison, take page offline

Jason Gerecke (1):
      HID: wacom: Use ktime_t rather than int when dealing with timestamps

Krister Johansen (2):
      bpf: ensure main program has an extable
      perf symbols: Symbol lookup with kcore can fail if multiple segments match stext

Mike Hommey (1):
      HID: logitech-hidpp: add HIDPP_QUIRK_DELAYED_INIT for the T651.

Oliver Hartkopp (1):
      can: isotp: isotp_sendmsg(): fix return error fix on TX path

Paolo Abeni (2):
      mptcp: fix possible divide by zero in recvmsg()
      mptcp: consolidate fallback and non fallback state machine

Philip Yang (1):
      drm/amdgpu: Set vmbo destroy after pt bo is created

Ricardo Cañuelo (1):
      Revert "thermal/drivers/mediatek: Use devm_of_iomap to avoid resource leak in mtk_thermal_probe"

Thomas Gleixner (1):
      x86/smp: Use dedicated cache-line for mwait_play_dead()

Tony Luck (1):
      mm, hwpoison: try to recover from copy-on write faults

