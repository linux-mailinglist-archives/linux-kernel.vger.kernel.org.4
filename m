Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC306A4237
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjB0NF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjB0NFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:05:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E63A5FB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677503105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xRmR1CN+obq5pY+FZwyMcM5CeiZouCVJNHeLMfMNdyw=;
        b=BqpnZFsJgF/YZoH1YKC2KO22HekiH7J2rkMG/qTb68K99bjpQhKEPd7yELM9ouA+1DzKSg
        LARbY0xPI03cWecN4VoryUDGEBvQvB8BK2PqK2oNVCAukNI1WaaV2HkTAY0onWDrxhMcZg
        mEuqaYT8wsTSJDIxS5gk2d/Rz2CrfNw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-5AxZlnDrPsK3vqtJG9fKtg-1; Mon, 27 Feb 2023 08:04:59 -0500
X-MC-Unique: 5AxZlnDrPsK3vqtJG9fKtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22BAD87A9E2;
        Mon, 27 Feb 2023 13:04:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E042D1121314;
        Mon, 27 Feb 2023 13:04:57 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] smb3: Miscellaneous fixes
Date:   Mon, 27 Feb 2023 13:04:52 +0000
Message-Id: <20230227130454.2673622-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Here are a couple more fix patches for you.

David

David Howells (2):
  cifs: Fix cifs_write_back_from_locked_folio()
  iov: Fix netfs_extract_user_to_sg()

 fs/cifs/file.c      | 1 +
 fs/netfs/iterator.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

