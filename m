Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B08716415
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 16:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbjE3O2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 10:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjE3O20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 10:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89386E4B
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 07:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685456784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=94BTDN4VWVFQfkvjBSdpixM1dxKT80KRY3XqvsTb4ik=;
        b=Mciyg7iLMfvLruk0HK1mb9fI5ZKKaKeFWAJm3owIZRzb4bGMeKohlWcpA2Vq3rvZDNnPP/
        /qKgY0rvRw8UlkjoVW3Wcb8o1u1k20hgaPmzMEpM6erBYHpCHj7MmdwroMZ2XqIAnioTdK
        52tiPxUp4ht0yPyAIAgkGcdfepjaC9w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-sv1RyystNgaId8KJKFySLw-1; Tue, 30 May 2023 10:26:23 -0400
X-MC-Unique: sv1RyystNgaId8KJKFySLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB8562A5957E;
        Tue, 30 May 2023 14:26:21 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.193.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5A0FC154D1;
        Tue, 30 May 2023 14:26:20 +0000 (UTC)
From:   Jocelyn Falempe <jfalempe@redhat.com>
To:     tzimmermann@suse.de, airlied@redhat.com, javierm@redhat.com,
        lyude@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH] MAINTAINERS: Add myself as reviewer for mgag200 and ast drivers
Date:   Tue, 30 May 2023 16:26:15 +0200
Message-Id: <20230530142615.57014-1-jfalempe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've contributed to these two drivers, fixing bugs and performance
issues.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 250518fc70ff..92a991643b36 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6398,6 +6398,7 @@ F:	drivers/gpu/drm/aspeed/
 DRM DRIVER FOR AST SERVER GRAPHICS CHIPS
 M:	Dave Airlie <airlied@redhat.com>
 R:	Thomas Zimmermann <tzimmermann@suse.de>
+R:	Jocelyn Falempe <jfalempe@redhat.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc
@@ -6549,6 +6550,7 @@ F:	drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
 DRM DRIVER FOR MGA G200 GRAPHICS CHIPS
 M:	Dave Airlie <airlied@redhat.com>
 R:	Thomas Zimmermann <tzimmermann@suse.de>
+R:	Jocelyn Falempe <jfalempe@redhat.com>
 L:	dri-devel@lists.freedesktop.org
 S:	Supported
 T:	git git://anongit.freedesktop.org/drm/drm-misc

base-commit: 8b817fded42d8fe3a0eb47b1149d907851a3c942
-- 
2.40.1

