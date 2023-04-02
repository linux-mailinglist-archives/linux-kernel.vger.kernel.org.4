Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A016D38CE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 17:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjDBPle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 11:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjDBPlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 11:41:32 -0400
Received: from kozue.soulik.info (kozue.soulik.info [108.61.200.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5103E7EC3
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 08:41:27 -0700 (PDT)
Received: from ritsuko.sh.sumomo.pri (unknown [112.64.60.49])
        by kozue.soulik.info (Postfix) with ESMTPSA id 579C9101D5C;
        Mon,  3 Apr 2023 00:34:07 +0900 (JST)
From:   Randy Li <ayaka@soulik.info>
To:     dri-devel@lists.freedesktop.org
Cc:     Randy Li <ayaka@soulik.info>, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org, tfiga@chromium.org,
        nicolas@ndufresne.ca, laurent.pinchart@ideasonboard.com,
        ribalda@chromium.org
Subject: [PATCH v7 0/2] Add pixel formats used in Synatpics SoC
Date:   Sun,  2 Apr 2023 23:33:56 +0800
Message-Id: <20230402153358.32948-1-ayaka@soulik.info>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those pixel formats are used in Synaptics's VideoSmart series SoCs,
likes VS640, VS680. I just disclose the pixel formats used in the video
codecs and display pipeline this time. Actually any device connected to
the MTR module could support those tiling and compressed pixel formats.

https://synaptics.com/products/multimedia-solutions

Changelog:
v7:
Fixed all warnings and errors for its document.
Add its document to GPU tree.
v6:
Refresh and fix warnings in its document.
v5:
Moving back the document and rewriting the description.
v4:
Removed the patches for V4L2, V4L2 would use the drm_fourcc.h .
Moving the documents to the mesa project.
v3:
There was a mistake in format macro.
Correcting the description of 64L4 variant modifiers.
v2:
The DRM modifiers in the first draft is too simple, it can't tell
the tiles in group attribute in memory layout.
Removing the v4l2 fourcc. Adding a document for the future v4l2 extended
fmt.
v1:
first draft of DRM modifiers
Try to put basic tile formats into v4l2 fourcc

Hsia-Jun(Randy) Li (1):
  drm/fourcc: Add Synaptics VideoSmart tiled modifiers

Randy Li (1):
  Documentation/gpu: Add Synaptics tiling formats documentation

 Documentation/gpu/drivers.rst   |  1 +
 Documentation/gpu/synaptics.rst | 81 +++++++++++++++++++++++++++++++++
 include/uapi/drm/drm_fourcc.h   | 75 ++++++++++++++++++++++++++++++
 3 files changed, 157 insertions(+)
 create mode 100644 Documentation/gpu/synaptics.rst

-- 
2.39.2

