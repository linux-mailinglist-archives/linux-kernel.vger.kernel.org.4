Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9423A702417
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 08:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235849AbjEOGHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 02:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjEOGGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 02:06:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED093C25;
        Sun, 14 May 2023 23:01:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42A4D61F33;
        Mon, 15 May 2023 06:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3956C433D2;
        Mon, 15 May 2023 06:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684130475;
        bh=QD/HwA4qfumc5WDkLMf7soF3JasPpx6RTvIErVLM/Qs=;
        h=From:To:Cc:Subject:Date:From;
        b=BVOEjRs0IWncanINrFIzP7r0gywzPtqVv39ClV8X0bMr/d9JmvfS+G71j4j2qqBIh
         K5npbpIwdW5jMMNXe/O7HcPNOASknxaBm5AxeidloxWARfpF02NSlwoeY256L8JHLZ
         H0M1+szAJ2JAahZwukMJpo4PP7a0fO0EjI5t94YbNXosG62CZ2g7+14UUQV8BHQZLL
         MbDbgyVC9R5s2PpvLJKu8UZENWWnv6wYpWioLf2w6qREPMYS5/aUB5CsSvdSdl8U6m
         t9lJJueUzjdnTqqPCe9c59eTe/lNoeqojDnevxLK/X0+Us7sfZf7vkxm1o5BJ4kHMZ
         otgSJFL1RIK7g==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pyRGi-003IYx-1I;
        Mon, 15 May 2023 07:01:12 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>,
        "Sakari Ailus" <sakari.ailus@linux.intel.com>,
        "Tomi Valkeinen" <tomi.valkeinen@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH] media: v4l2-subdev.h: document client_caps at struct v4l2_subdev_fh
Date:   Mon, 15 May 2023 07:01:11 +0100
Message-Id: <382ce82fe2b186c7d8067d8b4e945a947c7c7047.1684130460.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gets rid of this documentation warning:

	./include/media/v4l2-subdev.h:1130: warning: Function parameter or member 'client_caps' not described in 'v4l2_subdev_fh'

By adding a documentation about such new field.

Fixes: f57fa2959244 ("media: v4l2-subdev: Add new ioctl for client capabilities")
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 include/media/v4l2-subdev.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
index cfd19e72d0fc..62362da0d604 100644
--- a/include/media/v4l2-subdev.h
+++ b/include/media/v4l2-subdev.h
@@ -1119,6 +1119,9 @@ struct v4l2_subdev {
  * @vfh: pointer to &struct v4l2_fh
  * @state: pointer to &struct v4l2_subdev_state
  * @owner: module pointer to the owner of this file handle
+ * @client_caps:
+ *	client capabilities to inform the kernel of the behavior
+ *	of the client as set by VIDIOC_SUBDEV_S_CLIENT_CAP.
  */
 struct v4l2_subdev_fh {
 	struct v4l2_fh vfh;
-- 
2.40.1

