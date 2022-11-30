Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F03E63D2E5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 11:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiK3KMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 05:12:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235687AbiK3KL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAF73C6CB
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 02:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669803052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eIucrPGcl8vfw93STiikStMqPK1unlX4NE3HghFj3sw=;
        b=PRkFoCj4sHWBhmVcyd4UYxohgfymwBKt0UQL2lbiZwtq80vtKQgS7PZCIBhGQLqXJTl4Ns
        zeAqnIMcOsfFot7Ctp3WDDGPYpZ5IajN7GDMj9AUmCL3XPKby1KqTIO1lI283DJJISWoFb
        ciewtd2BRx0x1ynumgVkXEwgrdtK04s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-7wZPFks_PHWQuX2Kpi8Pcw-1; Wed, 30 Nov 2022 05:10:51 -0500
X-MC-Unique: 7wZPFks_PHWQuX2Kpi8Pcw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D556805B72;
        Wed, 30 Nov 2022 10:10:45 +0000 (UTC)
Received: from plouf.redhat.com (unknown [10.39.195.154])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E28340E9785;
        Wed, 30 Nov 2022 10:10:25 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Florent Revest <revest@chromium.org>,
        Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 0/2] HID-BPF: Kconfig fix
Date:   Wed, 30 Nov 2022 11:10:19 +0100
Message-Id: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
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

Hi,

As discussed in [1], we need to add some more dependencies to HID-BPF in
the Kconfig. This way, when fmod_ret will be available on arm64, HID-BPF
will get enabled automatically.

Jon, would you mind giving a shot at that patch on your test system and
confirm the error disappeard?

Cheers,
Benjamin



[1] https://lore.kernel.org/r/CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com

Benjamin Tissoires (2):
  HID: bpf: enforce HID_BPF dependencies
  selftests: hid: ensures we have the proper requirements in config

 drivers/hid/bpf/Kconfig            | 4 +++-
 tools/testing/selftests/hid/config | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.38.1

