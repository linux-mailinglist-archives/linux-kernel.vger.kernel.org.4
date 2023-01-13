Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4505F6698F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 14:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbjAMNq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 08:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbjAMNqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 08:46:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46555BC7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 05:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673617143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Ds9fJM+IQz5XjzI4U9iFIkKY9nlQiZP6Si1nTkrNrts=;
        b=FLwa1O7D90selQ1avA8zXAjyysntEoKUia7yKjVSdqb7Yh7d1oqIX0O+9LK5nB5pqZHWZl
        V7wdrLEcHvWG7A6tSUBXX1utm5/QVfnwMxJ0uE/yULiX3ifgP9223jo6thpQMWaZTcds+Z
        zXjh5vKBFM14jV3Pma+WCOt3UBlo9P8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-S-wCyD-fMHK4e0dBcH-hvw-1; Fri, 13 Jan 2023 08:38:51 -0500
X-MC-Unique: S-wCyD-fMHK4e0dBcH-hvw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 14356857F46;
        Fri, 13 Jan 2023 13:38:46 +0000 (UTC)
Received: from ovpn-194-184.brq.redhat.com (ovpn-194-184.brq.redhat.com [10.40.194.184])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 874B11415308;
        Fri, 13 Jan 2023 13:38:45 +0000 (UTC)
Date:   Fri, 13 Jan 2023 14:38:43 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     keescook@chromium.org
Cc:     linux-kernel@vger.kernel.org
Subject: ll_rw_block() funcation has been removed
Message-ID: <20230113133843.ivsmaqjbf5cn2ui6@ovpn-194-184.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ll_rw_block() has been removed with commit 79f597842069 ("fs/buffer:
remove ll_rw_block() helper"), but I noticed that it's still beeing
referenced in drivers/misc/lkdtm/core.c. I know nothing about LKDTM so I
can't even tell whether it's a problem at all, but I though it's worth
letting you know.

Best regards,
-Lukas

