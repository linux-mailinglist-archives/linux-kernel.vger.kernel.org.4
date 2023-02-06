Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C433968BF02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjBFN6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbjBFN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604C4265B3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 05:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675691741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bSQLbEXggHrT21oZHJrOUjq0WzgU0HbMjnGqgRF5M4Q=;
        b=OK09GgQ9CE0+MVKw5rIBgGFpzxTZjx/DPz236D37EiQMwKc+yg/DBZuE4NeO/IUxzdrxY4
        CV4Zu4aL3tQxeAGxjUXjrE3pnOg+5IDNh6dYl8DQYLjB1vUAg9iQ8XeGWlOi7ah2Jmy+cw
        Egk5+vZ3y8+eQh/2qZBoL/9mDcKYnwE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-opQ8bxgvOBqkRV-94J772A-1; Mon, 06 Feb 2023 08:55:38 -0500
X-MC-Unique: opQ8bxgvOBqkRV-94J772A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33BE7101A52E;
        Mon,  6 Feb 2023 13:55:38 +0000 (UTC)
Received: from plouf.local (ovpn-192-160.brq.redhat.com [10.40.192.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0D2D32026D37;
        Mon,  6 Feb 2023 13:55:36 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     linux-input@vger.kernel.org, Bastien Nocera <hadess@hadess.net>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
In-Reply-To: <20230125121723.3122-1-hadess@hadess.net>
References: <20230125121723.3122-1-hadess@hadess.net>
Subject: Re: [PATCH v2 1/2] HID: logitech-hidpp: Don't restart
 communication if not necessary
Message-Id: <167569173683.2840310.12968837250225354880.b4-ty@redhat.com>
Date:   Mon, 06 Feb 2023 14:55:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Wed, 25 Jan 2023 13:17:22 +0100, Bastien Nocera wrote:
> Don't stop and restart communication with the device unless we need to
> modify the connect flags used because of a device quirk.
> 
> 

Applied to hid/hid.git (for-6.3/logitech), thanks!

[1/2] HID: logitech-hidpp: Don't restart communication if not necessary
      https://git.kernel.org/hid/hid/c/1f3c80667df5
[2/2] HID: logitech-hidpp: Remove HIDPP_QUIRK_NO_HIDINPUT quirk
      https://git.kernel.org/hid/hid/c/8c1919ab6d33

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

