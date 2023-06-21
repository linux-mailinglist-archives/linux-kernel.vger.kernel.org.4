Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA57380F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjFUKQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbjFUKQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:16:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA481199C;
        Wed, 21 Jun 2023 03:16:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4E461486;
        Wed, 21 Jun 2023 10:16:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF83C433C0;
        Wed, 21 Jun 2023 10:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687342574;
        bh=VsCWEbIecds/CwCh2JBhfxSS84DL8XLpqHx1IapwRl4=;
        h=From:To:Cc:Subject:Date:From;
        b=smpM+WV2wanyxUVPkUNwWUuMjNql2Fero2zLnoRESEW+cmE1OiKMWZQmlZfEmLnws
         hn3+0KesXa0k6yXWWapKVzPQDNwVJtbDZyObjM+ACFzeehnZzDSOLq4K03Hldhyxot
         2zxkBO2YEw7cKQhY3ULM4OzC+73Cn41e97lka1jY73FG4wcya+WuEcqSh0BPqwJ88c
         uSVKufnxZPMuAOVt9z7lPiu7iwEcXFAhKQHvkdyE14OKy5Slib50Oxpee2Mg9dUcyD
         JY3d2i9l2C46Pq0f3nAGJQE8Log9sCBSy66CDHF0OOb6L5S83hhhhgOf2BWPbylWT9
         WYj7Gg56gc3/g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/6] tty_audit: random cleanups
Date:   Wed, 21 Jun 2023 12:16:05 +0200
Message-ID: <20230621101611.10580-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are random clean up patches which I came up with while doing more
invasive cleanup over the tty layer (to be sent later).

Jiri Slaby (SUSE) (6):
  tty_audit: use TASK_COMM_LEN for task comm
  tty_audit: use kzalloc() in tty_audit_buf_alloc()
  tty_audit: invert the condition in tty_audit_log()
  tty_audit: make icanon a bool
  tty_audit: make tty pointers in exposed functions const
  tty_audit: make data of tty_audit_log() const

 drivers/tty/tty.h       | 11 ++++++-----
 drivers/tty/tty_audit.c | 43 +++++++++++++++++++++--------------------
 2 files changed, 28 insertions(+), 26 deletions(-)

-- 
2.41.0

