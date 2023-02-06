Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A23D68C516
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjBFRsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBFRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:47:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DA32B2A8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675705627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8kU/0Xl/lLioSQe+1DD5y93hh4p9Kul9hBcSRrRm2WM=;
        b=AuGrr91kYxt2MpjulRboyUBO3HCb1r9d/AKL0qXEQ9Bp4bpFXhlir5783vVSspzJfSdZAL
        ep8PpaHmTFG7NWfsVQiwp5UM4YIZJzAb1vNO+a79VJ65hp3U80AfM23hWDFF7KQUx+psVV
        cWbXkz6yMxGj5/s/OJTLeLW43sVL300=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-wNvbI6y2Niq_8PudbmjNCA-1; Mon, 06 Feb 2023 12:47:04 -0500
X-MC-Unique: wNvbI6y2Niq_8PudbmjNCA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C8352183B3C7;
        Mon,  6 Feb 2023 17:47:03 +0000 (UTC)
Received: from plouf.local (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 137241121315;
        Mon,  6 Feb 2023 17:47:02 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Philippe Valembois <lephilousophe@gmail.com>
In-Reply-To: <20230125211511.12266-1-lephilousophe@gmail.com>
References: <20230123211843.10028-1-lephilousophe@gmail.com>
 <20230125211511.12266-1-lephilousophe@gmail.com>
Subject: Re: [PATCH v3 1/1] HID: evision: Add preliminary support for
 EVision keyboards
Message-Id: <167570562271.2904739.17104170264756053608.b4-ty@redhat.com>
Date:   Mon, 06 Feb 2023 18:47:02 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Wed, 25 Jan 2023 22:15:10 +0100, Philippe Valembois wrote:
> For now only supports one model and only filters out bogus reports sent
> when the keyboard has been configured through hidraw.
> Without this, as events are not released, soft repeat floods userspace
> with unknown key events.
> 
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.3/evision), thanks!

[1/1] HID: evision: Add preliminary support for EVision keyboards
      https://git.kernel.org/hid/hid/c/f5cd71cfdb5c

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

