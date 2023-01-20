Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33011674CEA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjATF6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjATF6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:58:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8D45F51
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:57:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674194258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=/L01UEOFAUDLhmeL3RQigMabUa8K4IscFqsvKS8pwCg=;
        b=cGyupNBLONs2KVagy2g7SZlU3hbKJIgiKHtbpIBDusvVH+VXHY6ul116zhaRaB1UTYh7si
        HvBDLgPz8qLhQQWV29qDXDi1+gY1TVs3SuQDUECKhNdD+4C50j5qw3/CdOwO3IXO66rLp7
        bIzO3m9UwzuUWaV6ikX3ZajznVfvJlI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-ucut25HGMoOfFB6qwxueaw-1; Fri, 20 Jan 2023 00:57:35 -0500
X-MC-Unique: ucut25HGMoOfFB6qwxueaw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3DB3811E6E;
        Fri, 20 Jan 2023 05:57:34 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-98.bne.redhat.com [10.64.54.98])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E0CCA40C6EC4;
        Fri, 20 Jan 2023 05:57:31 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        gregkh@linuxfoundation.org, rafael@kernel.org, shan.gavin@gmail.com
Subject: [PATCH 0/2] drivers/base/memory: Two small cleanups
Date:   Fri, 20 Jan 2023 13:57:25 +0800
Message-Id: <20230120055727.355483-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PATCH[1] Fixes comments for phys_index_show() since it's showing
         the memory block ID instead of the section ID.
PATCH[2] Use an array to show memory block state in state_show()

Gavin Shan (2):
  drivers/base/memory: Fix comments for phys_index_show()
  drivers/base/memory: Use array to show memory block state

 drivers/base/memory.c | 34 ++++++++--------------------------
 1 file changed, 8 insertions(+), 26 deletions(-)

-- 
2.23.0

