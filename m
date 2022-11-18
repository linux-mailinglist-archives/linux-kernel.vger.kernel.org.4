Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0662EFCE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbiKRInF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241053AbiKRIm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:42:59 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF3E0F7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:42:58 -0800 (PST)
Received: from ideasonboard.com (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AE823AF4;
        Fri, 18 Nov 2022 09:42:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668760975;
        bh=TCrYINWxM0LvCaPr72NP5lRPmCGfFoHIG7JjVzCGjrU=;
        h=From:To:Cc:Subject:Date:From;
        b=quBB7pfvSnnPccL7fq/8zUsbsX0sa6m7O7sFCS+qF3m4G8DQSEBatBqf8elaJXzA2
         nRjuVgyy/4UiPLDUV4rOw4TWYE1d66St1DlBVZCxMp6KwcmsnKT5BNWEDSA37EnHFK
         vHESTzMQK5E5BbL9YL/5YZ/SwL3pyROpmreA2DoU=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Dan Carpenter <error27@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kieran.bingham@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH v2 0/3] staging: vc04_services: Promote bool usage
Date:   Fri, 18 Nov 2022 14:12:41 +0530
Message-Id: <20221118084244.199909-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 7967656ffbfa ("coding-style: Clarify the expectations around
bool") the check to dis-allow bool structure members was removed from
checkpatch.pl. It promotes bool structure members to store boolean
values. This enhances code readability.

Changes in v2:
- Drop ':1' in bool foo:1 usage as mistaken understood as initization
  by me (apologies).


Umang Jain (3):
  Revert "staging: mmal-vchiq: Avoid use of bool in structures"
  vc04_services: mmal-vchiq: Use bool for vchiq_mmal_component.in_use
  vc04_services: bcm2835-camera: Use bool values for
    mmal_fmt.remove_padding

 .../bcm2835-camera/bcm2835-camera.c           | 30 +++++++++----------
 .../vc04_services/vchiq-mmal/mmal-vchiq.c     | 18 +++++------
 .../vc04_services/vchiq-mmal/mmal-vchiq.h     |  6 ++--
 3 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.38.1

