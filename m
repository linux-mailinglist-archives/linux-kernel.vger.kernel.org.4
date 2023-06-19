Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55817355FC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 13:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjFSLk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 07:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjFSLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 07:40:23 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 410D1100;
        Mon, 19 Jun 2023 04:40:22 -0700 (PDT)
Received: from desky.lan (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99C5EFB;
        Mon, 19 Jun 2023 13:39:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1687174786;
        bh=rhLeZ6GPYosHmW0rIiwhPfb4O4j9n5rI5RPNNzZoc+s=;
        h=From:To:Cc:Subject:Date:From;
        b=r2Ve28ab6H6UPmquBHslsAGIrCxj986J0KZ81tV/hEgCR/8zIXLUjhKNrZ//x9DKu
         kQ/nc2G9ws34eoZ3lphv9FO0NjpGEqYRbw/ou0I/jt7XBZbMYKw1kXqUZytgiWTs3g
         jKIAoubOjCkLKW3h8iGPZ+90yIU8LOwAIq4v3ejk=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Jai Luthra <j-luthra@ti.com>,
        Vaishnav Achath <vaishnav.a@ti.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 0/4] media: ti: cal: Improvements
Date:   Mon, 19 Jun 2023 14:40:03 +0300
Message-Id: <20230619114007.297393-1-tomi.valkeinen@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains the simpler fixes & improvements from the 
"[PATCH v3 0/5] media: ti: cal: Streams support" series. I have opted to
keep the patch that adds the streams support still in my WIP branch, as
I want to experiment with a few things.

However, the rest of the patches in that series should be fine for
merging. These are unchanged, but I have added Jacopo's RBs.

Here's a link to the v3:

https://lore.kernel.org/all/20230302100755.191164-1-tomi.valkeinen@ideasonboard.com/

 Tomi

Tomi Valkeinen (4):
  media: ti: cal: Clean up mbus formats uses
  media: ti: cal: Fix cal_camerarx_create() error handling
  media: ti: cal: Use subdev state
  media: ti: cal: Implement get_frame_desc for camera-rx

 drivers/media/platform/ti/cal/cal-camerarx.c | 206 +++++++------------
 drivers/media/platform/ti/cal/cal-video.c    |  23 ++-
 drivers/media/platform/ti/cal/cal.c          |  66 ++----
 drivers/media/platform/ti/cal/cal.h          |  10 -
 4 files changed, 115 insertions(+), 190 deletions(-)

-- 
2.34.1

