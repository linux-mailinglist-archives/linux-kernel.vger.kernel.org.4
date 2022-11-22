Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B4F633A7F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 11:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiKVKtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 05:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbiKVKsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 05:48:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6412D19
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:47:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D04AB819FF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 10:47:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB446C433C1;
        Tue, 22 Nov 2022 10:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669114071;
        bh=z5jHZXnfpR4uMGDRHA7iwHU4CEh2KqrEM7EyKMIZPe0=;
        h=Date:From:To:Cc:Subject:From;
        b=e2AaI1DwjnThPVgs+1ZMGfPa9sWB7BCC8YaagowfMSkWOtbRnqkHIsu+71FsdunpA
         f6yYr3swEQO/s904R+ji4i57h0MeQssguU1anWGD8/O1tdesxgccd9ZI16NlKf3/hV
         OTO6h/sUUSS59JlnHVa1M0EPUF/8O0kocig4XmGWVkazXLmRrQNzGWjhSiUx4meo32
         6rL8HybqlDZ0eRFjzpSdxM6J71wUycAdGvelQPpnWa2AgnebVt7223TQaTFZdG+Ge6
         R9sYa6G5rFvquMgU/Q7vza8lCPaqNfSXhcJ7tti0pK6eQuXNXw1DNbmUvJxITEjcjD
         +eg93v3KVxueQ==
Date:   Tue, 22 Nov 2022 12:47:46 +0200
From:   Oded Gabbay <ogabbay@kernel.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, gregkh@linuxfoundation.org
Subject: [git pull] new subsystem for compute accelerator devices
Message-ID: <20221122104746.GA320209@ogabbay-vm-u20.habana-labs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here is the pull request for creating the compute acceleration (accel)
subsystem. It includes the fixes to the few comments given in the latest
patch-set review.

Highlights of the patch-set contents are in the signed tag.

Thanks,
Oded

The following changes since commit fc58764bbf602b65a6f63c53e5fd6feae76c510c:

  Merge tag 'amd-drm-next-6.2-2022-11-18' of https://gitlab.freedesktop.org/agd5f/linux into drm-next (2022-11-22 13:41:11 +1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git tags/drm-accel-2022-11-22

for you to fetch changes up to cadbcc80e81800a3189f9fed23407fa014b8e3c3:

  doc: add documentation for accel subsystem (2022-11-22 12:41:08 +0200)

----------------------------------------------------------------
This tag contains the patches that add the new compute acceleration
subsystem, which is part of the DRM subsystem.

The patches:
- Add a new directory at drivers/accel.
- Add a new major (261) for compute accelerators.
- Add a new DRM minor type for compute accelerators.
- Integrate the accel core code with DRM core code.
- Add documentation for the accel subsystem.

----------------------------------------------------------------
Oded Gabbay (4):
      drivers/accel: define kconfig and register a new major
      accel: add dedicated minor for accelerator devices
      drm: initialize accel framework
      doc: add documentation for accel subsystem

 Documentation/accel/index.rst         |  17 ++
 Documentation/accel/introduction.rst  | 110 ++++++++++++
 Documentation/admin-guide/devices.txt |   5 +
 Documentation/subsystem-apis.rst      |   1 +
 MAINTAINERS                           |   9 +
 drivers/Kconfig                       |   2 +
 drivers/accel/Kconfig                 |  24 +++
 drivers/accel/drm_accel.c             | 323 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/Makefile              |   1 +
 drivers/gpu/drm/drm_drv.c             | 101 ++++++++---
 drivers/gpu/drm/drm_file.c            |   2 +-
 drivers/gpu/drm/drm_sysfs.c           |  24 ++-
 include/drm/drm_accel.h               |  97 ++++++++++
 include/drm/drm_device.h              |   3 +
 include/drm/drm_drv.h                 |   8 +
 include/drm/drm_file.h                |  21 ++-
 16 files changed, 711 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/accel/index.rst
 create mode 100644 Documentation/accel/introduction.rst
 create mode 100644 drivers/accel/Kconfig
 create mode 100644 drivers/accel/drm_accel.c
 create mode 100644 include/drm/drm_accel.h
