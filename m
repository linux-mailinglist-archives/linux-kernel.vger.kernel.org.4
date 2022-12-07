Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B49C645C70
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiLGOZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiLGOZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:25:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B21115FCB
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670423084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tipv5qnt6NZvkwm/vwn87B2/byCyPHwWIVvD8ose/Ok=;
        b=F1sDgzY7j7Qo3z+UfPySxWsSzp7BRE3M/gR2b8zjpJd5C0Kvo5qlJ2jRcBmgANguiNW1wz
        qSaCVfGEBPT7/y8lUKk0mWS44EhvFNNclIY0yuByx6hIGzxfgvmD3/BSIQ65VG2t+8G9Fm
        ORhEm3T7C46LeTQOSTw0AJCb/Kpvfc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-651-vdeifLxyMWWLzednTBAFRA-1; Wed, 07 Dec 2022 09:24:39 -0500
X-MC-Unique: vdeifLxyMWWLzednTBAFRA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C15A58828C0;
        Wed,  7 Dec 2022 14:24:38 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.193.117])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AA3D2027061;
        Wed,  7 Dec 2022 14:24:37 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bastien Nocera <hadess@hadess.net>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v1 0/2] HID: Revert catchall handling of Bluetooth device in hid-logitech-hidpp
Date:   Wed,  7 Dec 2022 15:24:31 +0100
Message-Id: <20221207142433.1158329-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are basically too late in the 6.1 cycle to be able to do anything
else. Let's revert these 2 patches as we are in a situation where we
would break too many users.

We will reintroduce them during the next cycle with proper fixes in the
driver.

Cheers,
Benjamin

Link: https://lore.kernel.org/linux-input/CAJZ5v0g-_o4AqMgNwihCb0jrwrcJZfRrX=jv8aH54WNKO7QB8A@mail.gmail.com/

Benjamin Tissoires (2):
  Revert "HID: logitech-hidpp: Remove special-casing of Bluetooth
    devices"
  Revert "HID: logitech-hidpp: Enable HID++ for all the Logitech
    Bluetooth devices"

 drivers/hid/hid-logitech-hidpp.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

-- 
2.38.1

