Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0553262DC26
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbiKQNAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiKQNAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:00:07 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DE06456D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:00:06 -0800 (PST)
Received: from ideasonboard.com (unknown [103.251.226.79])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 11B0B929;
        Thu, 17 Nov 2022 13:59:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668690003;
        bh=1QQRNgimyKov9bKl7TJpIiPIdUN7If/628V/9chreyo=;
        h=From:To:Cc:Subject:Date:From;
        b=c6T14Bl7VHDYGP2dTSg8C3kUchtdndJ4cZIKnc7ujNtwemVjVJQFl5V9FpvbniTWX
         TcVKkA/nnFCIYJUZsyC2i0+NblonPPQnDr360PBKEvUADomrBb0cD4NhLrMQw8JcTG
         UKffceW9/I9fXbLIIRvWoowQGTJSUrmC5KxMo85c=
From:   Umang Jain <umang.jain@ideasonboard.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     kieran.bingham@ideasonboard.com,
        Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/2] vc04_services: vchiq-mmal: Drop bool usage
Date:   Thu, 17 Nov 2022 18:29:51 +0530
Message-Id: <20221117125953.88441-1-umang.jain@ideasonboard.com>
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

Simple fixes to drop bool usage from vchiq-mmal.
Individual patches contains details.

Dave Stevenson (1):
  staging: vc04_services: mmal-vchiq: Do not assign bool to u32

Umang Jain (1):
  staging: vc04_services: mmal-common: Do not use bool in structures

 drivers/staging/vc04_services/vchiq-mmal/mmal-common.h | 6 +++---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c  | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.38.1

