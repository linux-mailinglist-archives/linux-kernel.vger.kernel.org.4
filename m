Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594A0682159
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 02:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjAaBVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 20:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAaBVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 20:21:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8CE1A4B6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 17:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=XwacVAoDlSbhvdOZfOteaBXk54tWeyXApMz+z+NJOP8=; b=S7YpfgA9tRx/yCrjFvVnTUdkaq
        7fd9YB2tGyuYg39ZO5DFdQRLD4Ou1hGkwFM2Eq7C+l6B4EaVTCtrCoQDgJZ+WUeJyvT2cYsK+vlH5
        E5olaslqFU49EEFSlhmPkNAvLKYFzAb5xQ3Tqne+jAgVRn2o9LKWESJeBKPuwoR18mjmRKPNkhEd/
        bgZgTvNyuF82ZeAmrqO3fozLEY6kN5xQaxb0RYUHxT4HDIDXRpC1RhqLuQuiXtoFAvJbzTd9htorE
        PtLW/OB0rdr+mHu6hOo7W+sIRN8uCfj6Dbu3hCEv2E82KVpkn5oJBDLZKvzkGoImLw63P/YYTfq1U
        X1EdmorQ==;
Received: from [2601:1c2:d00:6a60::9526] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMfKg-005zG6-D6; Tue, 31 Jan 2023 01:21:10 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH -next] drm/client: fix kernel-doc warning in drm_client.h
Date:   Mon, 30 Jan 2023 17:21:07 -0800
Message-Id: <20230131012107.20943-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/kernel-doc complains about the comment for hotplug_failed,
so fix it:

include/drm/drm_client.h:111: warning: Incorrect use of kernel-doc format:          * @hotplug failed:

Fixes: 6a9d5ad3af65 ("drm/client: Add hotplug_failed flag")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: David Airlie <airlied@gmail.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 include/drm/drm_client.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/include/drm/drm_client.h b/include/drm/drm_client.h
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -108,7 +108,7 @@ struct drm_client_dev {
 	struct drm_mode_set *modesets;
 
 	/**
-	 * @hotplug failed:
+	 * @hotplug_failed:
 	 *
 	 * Set by client hotplug helpers if the hotplugging failed
 	 * before. It is usually not tried again.
