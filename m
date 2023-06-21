Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC765738492
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 15:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjFUNM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 09:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjFUNMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 09:12:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493A61706
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 06:12:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01D411FE58;
        Wed, 21 Jun 2023 13:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687353171; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dSMeF9skFmtCn8hLggDS/2RupwvwvzyY4wh88cjmpM4=;
        b=AEBk+VKsouIEGMeIlFU05Rw/AfKxlJeP1JCeS/fyO3wICryTAb6Qc+ubGBrmnQMTpr3EUG
        IBjQZ2XuvxJtNeDkxrCOVtYX3TzJZW//o6S/5VDNxKmmwULOf7dDRaKXoV0e/MaH1ZPu2L
        cboQc8Xya1NJoEfTVHQR87RGo+ysnQo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2B45134B1;
        Wed, 21 Jun 2023 13:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NxZ0LlL3kmQKYQAAMHmgww
        (envelope-from <petr.pavlu@suse.com>); Wed, 21 Jun 2023 13:12:50 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 0/2] Fix Linux dom0 boot on a QEMU/KVM virtual machine
Date:   Wed, 21 Jun 2023 15:12:12 +0200
Message-Id: <20230621131214.9398-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix two problems that prevent booting Linux dom0 on a QEMU/KVM virtual
machine, which is sometimes useful for testing purposes.

Petr Pavlu (2):
  xen/virtio: Fix NULL deref when a bridge of PCI root bus has no parent
  xen/virtio: Avoid use of the dom0 backend in dom0

 drivers/xen/grant-dma-ops.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.35.3

