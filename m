Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0C6E10AE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjDMPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDMPLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83288A4F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681398633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9wbYHm819npHT+b6BeTJ/TQb4JBO3E8F7RCt0WWdpos=;
        b=X8oJJhQUR1oyNeKqRXntJZc22wzL9gU9qVN+Zplqkw6FOdP5wlrPp3pSJGVc/W2vvJuFoa
        1+cfS0uC2WINhjaVkaRPe5otDj6A+l5vDoVbLM1PWiUFoYr9P49DxxBZoQ+YCsA68gnfZ1
        iRln7EX7BtDHim659H7j4USof0G5CSw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-WcPl51wXOOqaPq5JQ0vAvQ-1; Thu, 13 Apr 2023 11:10:29 -0400
X-MC-Unique: WcPl51wXOOqaPq5JQ0vAvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FA60857FB3;
        Thu, 13 Apr 2023 15:10:28 +0000 (UTC)
Received: from plouf.local (unknown [10.45.224.142])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9B70EBC88;
        Thu, 13 Apr 2023 15:10:27 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
References: <20230215-power_supply-leds-hid-v1-0-35b6f1dcee8a@weissschuh.net>
Subject: Re: (subset) [PATCH 0/4] HID: explicitly include linux/leds.h
Message-Id: <168139862725.858454.13863617018965976517.b4-ty@redhat.com>
Date:   Thu, 13 Apr 2023 17:10:27 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Feb 2023 01:03:33 +0000, Thomas Weißschuh wrote:
> Instead of relying on an accidental, transitive inclusion of linux/leds.h
> use it directly.
> 
> 

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git (for-6.4/led-includes), thanks!

[1/4] HID: steelseries: explicitly include linux/leds.h
      https://git.kernel.org/hid/hid/c/f28bb5ce4f15
[2/4] HID: lg-g15: explicitly include linux/leds.h
      https://git.kernel.org/hid/hid/c/21c5bd5b4b06
[3/4] HID: asus: explicitly include linux/leds.h
      https://git.kernel.org/hid/hid/c/a2654c1f640c

Cheers,
-- 
Benjamin Tissoires <benjamin.tissoires@redhat.com>

