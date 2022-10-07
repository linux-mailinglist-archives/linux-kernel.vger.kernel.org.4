Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86505F7BCC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJGQsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJGQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E86AA59A5
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFD8861D8E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 16:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE830C433D6;
        Fri,  7 Oct 2022 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665161314;
        bh=xnvCp26wfMkHxfmfHX2eMz0iiuUCXBLntpxfocsTo+8=;
        h=Date:From:To:Cc:Subject:From;
        b=YSVf0R2ReDhci1MRLSHMQ3HDFiv7vFm/XAdzUM/liEz1jo1xqZHSoh5fLcN/xO7P4
         IGlz29gmw6G8lGp4kVA1RskJ5DCbdB4wD2WBiLRbgJMCzxTXhwPNaJj6V7iUGQhuYe
         5xddyNihPvjlPtMNXiulKu9Ze8BuvxbzQDxtB6NE=
Date:   Fri, 7 Oct 2022 18:49:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 6.1-rc1
Message-ID: <Y0BYiwvr4JZio4RH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1707c39ae309bf91965aa6f04d63816a090d90a1:

  Merge tag 'driver-core-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2022-09-23 09:12:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-6.1-rc1

for you to fetch changes up to fda8c908bc2d523c0770ded667dcdad29c06ff52:

  docs: filesystems: sysfs: Make text and code for ->show() consistent (2022-09-30 14:53:13 +0200)

----------------------------------------------------------------
Driver core changes for 6.1-rc1

Here is the big set of driver core and debug printk changes for 6.1-rc1.
Included in here is:
	- dynamic debug updates for the core and the drm subsystem.  The
	  drm changes have all been acked by the relevant maintainers.
	- kernfs fixes for syzbot reported problems
	- kernfs refactors and updates for cgroup requirements
	- magic number cleanups and removals from the kernel tree (they
	  were not being used and they really did not actually do
	  anything.)
	- other tiny cleanups

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andy Shevchenko (2):
      device property: Add const qualifier to device_get_match_data() parameter
      docs: filesystems: sysfs: Make text and code for ->show() consistent

Brian Norris (2):
      drivers: base: Print error code on synthetic uevent failure
      debugfs: Only clobber mode/uid/gid on remount if asked

ChenXiaoSong (1):
      debugfs: use DEFINE_SHOW_ATTRIBUTE to define debugfs_regset32_fops

Christian A. Ehrhardt (1):
      kernfs: fix use-after-free in __kernfs_remove

Christoph Hellwig (1):
      devres: remove devm_ioremap_np

Christophe JAILLET (1):
      devres: Slightly optimize alloc_dr()

Gaosheng Cui (1):
      driver core: remove make_class_name declaration

Greg Kroah-Hartman (2):
      Merge 6.0-rc5 into driver-core-next
      Merge 1707c39ae309 ("Merge tag 'driver-core-6.0-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core") driver-core-next

Jim Cromie (30):
      dyndbg: fix static_branch manipulation
      dyndbg: fix module.dyndbg handling
      dyndbg: show both old and new in change-info
      dyndbg: reverse module walk in cat control
      dyndbg: reverse module.callsite walk in cat control
      dyndbg: use ESCAPE_SPACE for cat control
      dyndbg: let query-modname override actual module name
      dyndbg: add test_dynamic_debug module
      dyndbg: drop EXPORTed dynamic_debug_exec_queries
      dyndbg: cleanup auto vars in dynamic_debug_init
      dyndbg: gather __dyndbg[] state into struct _ddebug_info
      dyndbg: add class_id to pr_debug callsites
      dyndbg: add __pr_debug_cls for testing
      dyndbg: add DECLARE_DYNDBG_CLASSMAP macro
      kernel/module: add __dyndbg_classes section
      dyndbg: add ddebug_attach_module_classes
      dyndbg: validate class FOO by checking with module
      doc-dyndbg: describe "class CLASS_NAME" query support
      doc-dyndbg: edit dynamic-debug-howto for brevity, audience
      dyndbg: add drm.debug style (drm/parameters/debug) bitmap support
      dyndbg: test DECLARE_DYNDBG_CLASSMAP, sysfs nodes
      drm_print: condense enum drm_debug_category
      drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.
      drm_print: interpose drm_*dbg with forwarding macros
      drm_print: wrap drm_*_dbg in dyndbg descriptor factory macro
      drm-print.h: include dyndbg header
      drm-print: add drm_dbg_driver to improve namespace symmetry
      drm_print: optimize drm_debug_enabled for jump-label
      drm_print: prefer bare printk KERN_DEBUG on generic fn
      drm_print: add _ddebug descriptor to drm_*dbg prototypes

Mukesh Ojha (1):
      devcoredump : Serialize devcd_del work

Salvatore Bonaccorso (1):
      Documentation: stable: Document alternative for referring upstream commit hash

Shuah Khan (1):
      docs: update mediator information in CoC docs

Tejun Heo (9):
      kernfs: Simply by replacing kernfs_deref_open_node() with of_on()
      kernfs: Drop unnecessary "mutex" local variable initialization
      kernfs: Refactor kernfs_get_open_node()
      kernfs: Skip kernfs_drain_open_files() more aggressively
      kernfs: Improve kernfs_drain() and always call on removal
      kernfs: Add KERNFS_REMOVING flags
      kernfs: Factor out kernfs_activate_one()
      kernfs: Implement kernfs_show()
      cgroup: Implement cgroup_file_show()

Wolfram Sang (1):
      driver_core: move from strlcpy with unused retval to strscpy

Yang Yingliang (2):
      class: use IS_ERR_OR_NULL() helper in class_unregister()
      driver core: use IS_ERR_OR_NULL() helper in device_create_groups_vargs()

наб (20):
      Documentation: remove nonexistent magic numbers
      a.out: remove define-only CMAGIC, previously magic number
      Bluetooth: RFCOMM: remove define-only RFCOMM_TTY_MAGIC ex-magic-number
      MIPS: remove define-only GDA_MAGIC, previously magic number
      Documentation: HFS is not a user of magic numbers
      Documentation: sndmagic.h doesn't exist
      Documentation: zh: remove references to IrDA
      Documentation: zh: remove stale magic numbers
      Documentation: CG_MAGIC isn't a magic number
      Documentation: FULL_DUPLEX_MAGIC isn't a magic number
      Documentation: RIEBL_MAGIC isn't a magic number
      Documentation: SAVEKMSG_MAGIC[12] aren't magic numbers
      Documentation: COW_MAGIC isn't a magic number
      Documentation: EEPROM_MAGIC_VALUE isn't a magic number
      Documentation: FW_HEADER_MAGIC isn't a magic number
      nbd: remove define-only NBD_MAGIC, previously magic number
      Documentation: NBD_REPLY_MAGIC isn't a magic number
      Documentation: ENI155_MAGIC isn't a magic number
      a.out: restore CMAGIC
      Documentation: NBD_REQUEST_MAGIC isn't a magic number

 Documentation/admin-guide/dynamic-debug-howto.rst  | 246 +++++------
 Documentation/driver-api/driver-model/devres.rst   |   1 -
 Documentation/filesystems/sysfs.rst                |   2 +-
 .../process/code-of-conduct-interpretation.rst     |   2 +-
 Documentation/process/magic-number.rst             |  65 ---
 Documentation/process/stable-kernel-rules.rst      |   6 +
 .../translations/it_IT/process/magic-number.rst    |  66 ---
 .../translations/zh_CN/process/magic-number.rst    |  66 ---
 .../translations/zh_TW/process/magic-number.rst    |  67 ---
 MAINTAINERS                                        |   2 +
 arch/mips/include/asm/sn/gda.h                     |   2 -
 drivers/base/base.h                                |   2 -
 drivers/base/class.c                               |   2 +-
 drivers/base/core.c                                |   4 +-
 drivers/base/dd.c                                  |   2 +-
 drivers/base/devcoredump.c                         |  83 +++-
 drivers/base/devres.c                              |   4 +-
 drivers/base/property.c                            |   4 +-
 drivers/block/nbd.c                                |   2 -
 drivers/gpu/drm/Kconfig                            |  12 +
 drivers/gpu/drm/Makefile                           |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c            |  14 +
 drivers/gpu/drm/display/drm_dp_helper.c            |  13 +
 drivers/gpu/drm/drm_crtc_helper.c                  |  13 +
 drivers/gpu/drm/drm_print.c                        |  48 ++-
 drivers/gpu/drm/i915/i915_params.c                 |  12 +
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  13 +
 fs/debugfs/file.c                                  |  16 +-
 fs/debugfs/inode.c                                 |  37 +-
 fs/kernfs/dir.c                                    | 107 +++--
 fs/kernfs/file.c                                   | 151 ++++---
 fs/kernfs/kernfs-internal.h                        |   1 +
 include/asm-generic/vmlinux.lds.h                  |   3 +
 include/drm/drm_print.h                            |  78 +++-
 include/linux/cgroup.h                             |   1 +
 include/linux/dynamic_debug.h                      | 176 ++++++--
 include/linux/io.h                                 |   2 -
 include/linux/kernfs.h                             |   3 +
 include/linux/property.h                           |   4 +-
 kernel/cgroup/cgroup.c                             |  20 +
 kernel/module/internal.h                           |   4 +-
 kernel/module/main.c                               |  20 +-
 lib/Kconfig.debug                                  |  10 +
 lib/Makefile                                       |   1 +
 lib/devres.c                                       |  15 -
 lib/dynamic_debug.c                                | 450 +++++++++++++++++----
 lib/test_dynamic_debug.c                           | 165 ++++++++
 net/bluetooth/rfcomm/tty.c                         |   1 -
 48 files changed, 1325 insertions(+), 695 deletions(-)
 create mode 100644 lib/test_dynamic_debug.c
