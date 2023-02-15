Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3EC697DDF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 14:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBONwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 08:52:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjBONvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 08:51:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61CE3A842
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 05:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676469036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kd160B/FX/7MKfFVMEY44JXFGF33xUGYuiKUdjlVIWg=;
        b=NnCXHvuYt2n7u25te94rTytu2RL7ZE4aZB79FIx0gFuKL94TxRfX5+KbqgzBIpb45BqE8h
        V7r7KiYWgrrhJblYPxVP1u343C2nq1Ae+sr5WD53Zmi2V5WD5bYL8dml00R48HiD7f5+q4
        DIfPTu5DHmYkQfAZsZ2aRLlwqCAB8aY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-504-FIpgQbl_M5Spq-OqX01rZQ-1; Wed, 15 Feb 2023 08:50:32 -0500
X-MC-Unique: FIpgQbl_M5Spq-OqX01rZQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C601F1C09048;
        Wed, 15 Feb 2023 13:50:31 +0000 (UTC)
Received: from plouf.local (ovpn-194-191.brq.redhat.com [10.40.194.191])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F290140EBF4;
        Wed, 15 Feb 2023 13:50:30 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
In-Reply-To: <20230209154916.462158-1-hadess@hadess.net>
References: <20230209154916.462158-1-hadess@hadess.net>
Subject: Re: [PATCH v3 1/2] HID: logitech-hidpp: Retry commands when device
 is busy
Message-Id: <167646902999.1556507.14351237231391498913.b4-ty@redhat.com>
Date:   Wed, 15 Feb 2023 14:50:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Thu, 09 Feb 2023 16:49:15 +0100, Bastien Nocera wrote:
> Handle the busy error coming from the device or receiver. The
> documentation says a busy error can be returned when:
> "
> Device (or receiver) cannot answer immediately to this request
> for any reason i.e:
> - already processing a request from the same or another SW
> - pipe full
> "
> 
> [...]

Applied to hid/hid.git (for-6.3/logitech), thanks!

[1/2] HID: logitech-hidpp: Retry commands when device is busy
      https://git.kernel.org/hid/hid/c/586e8fede795
[2/2] HID: logitech-hidpp: Add myself to authors
      https://git.kernel.org/hid/hid/c/1b136aeb3c4a

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

