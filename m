Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6272E67D05E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjAZPjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjAZPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:39:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26974172C
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674747515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=djrJC5jl8hw1WPQkoTgHRSAmPOKjMJ0SWC0GWLzxol4=;
        b=NU3rT77fXi9TsgqUzqL6c652xgSbYgs/aGM3Wo5cCS4jrD4qIhD0X57FtHc0EZIRVFNw1e
        BXC0QjSm7kOKmUabnS8ibrHxfDnArheM4UYnUUStrREBwUwxokawP+GAoPMk3WbZ8BOXzc
        NFUvzhXkcnnFFDyHWt+XulzW6ttvzic=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-l0VMB3wuOsaG0sz9_qnC5g-1; Thu, 26 Jan 2023 10:38:33 -0500
X-MC-Unique: l0VMB3wuOsaG0sz9_qnC5g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B05F2A59553;
        Thu, 26 Jan 2023 15:38:33 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.192.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 318D3C15BA0;
        Thu, 26 Jan 2023 15:38:32 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Wolfram Sang <wsa@kernel.org>, Lee Jones <lee@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 resend 0/3] mfd: intel_soc_pmic_chtwc + cell drivers Lenovo Yoga Tab 3 YT3-X90F support
Date:   Thu, 26 Jan 2023 16:38:20 +0100
Message-Id: <20230126153823.22146-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee, et. al.

Here is a resend of my patch series to add support for
the Lenovo Yoga Tab 3 YT3-X90F tablet to the intel_soc_pmic_chtwc
driver + 2 of the drivers for instantiated mfd-cells.

This is unmodified from the previous version except for
having acks from the i2c, resp. extcon subsys maintainers
for routing the entire series through the MFD tree.

Still I have marked this as v2, to distuingish this from the resend
of patches 2-3 yesterday, which I did because I was under the wrong
impression that patch 1/3 was already merged.

Regards,

Hans



Hans de Goede (3):
  mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Tab 3 X90F to
    intel_cht_wc_models
  i2c: cht-wc: Add charger-chip info for the Lenovo Yoga Tab 3 YT3-X90F
  extcon: intel-cht-wc: Add support for Lenovo Yoga Tab 3 Pro YT3-X90F

 drivers/extcon/extcon-intel-cht-wc.c |  1 +
 drivers/i2c/busses/i2c-cht-wc.c      | 46 ++++++++++++++++++++++++++++
 drivers/mfd/intel_soc_pmic_chtwc.c   |  8 +++++
 include/linux/mfd/intel_soc_pmic.h   |  1 +
 4 files changed, 56 insertions(+)

-- 
2.39.0

