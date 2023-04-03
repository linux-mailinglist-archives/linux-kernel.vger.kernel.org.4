Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6427E6D45E4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjDCNeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjDCNeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116124488
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680528810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JyfxTuY5/xh7VPseiqigRtNycTkUaZEskRcra14ejzk=;
        b=jUUMJJVxXLbD/VPkd3BGINRuvm+AQsttMmRA/pBsYm3pMovmmUTwN06FBw6YHS71JpQ9qT
        0ijOlbarHav5PmwCUHf886S5Ep3aQ9sEhjcrIe6MViKH43mo/+U02Ds8p0YmhKAslk7+XE
        Kc/2fP1u9CrIzmLD8IqBBOO+/Ov2HHs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-yneao8GaMLGZi3nbwK5j0Q-1; Mon, 03 Apr 2023 09:33:27 -0400
X-MC-Unique: yneao8GaMLGZi3nbwK5j0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E32C2A5957F;
        Mon,  3 Apr 2023 13:33:27 +0000 (UTC)
Received: from plouf.local (unknown [10.45.224.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFE04175AD;
        Mon,  3 Apr 2023 13:33:25 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
In-Reply-To: <20230302130117.3975-1-hadess@hadess.net>
References: <20230302130117.3975-1-hadess@hadess.net>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: Don't use the USB serial for
 USB devices
Message-Id: <168052880551.319947.16770302494731931983.b4-ty@redhat.com>
Date:   Mon, 03 Apr 2023 15:33:25 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Mar 2023 14:01:16 +0100, Bastien Nocera wrote:
> For devices that support the 0x0003 feature (Device Information) version 4,
> set the serial based on the output of that feature, rather than relying
> on the usbhid code setting the USB serial.
> 
> This should allow the serial when connected through USB to (nearly)
> match the one when connected through a unifying receiver.
> 
> [...]

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.4/logitech-hidpp), thanks!

[1/2] HID: logitech-hidpp: Don't use the USB serial for USB devices
      https://git.kernel.org/hid/hid/c/7ad1fe0da0fa
[2/2] HID: logitech-hidpp: Reconcile USB and Unifying serials
      https://git.kernel.org/hid/hid/c/5b3691d15e04

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

