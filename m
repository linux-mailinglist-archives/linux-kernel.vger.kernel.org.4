Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBF67B0CA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 12:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235138AbjAYLNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 06:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYLNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 06:13:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE958F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 03:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674645134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rInxY6e4WJZKCJha8/ifXWlTKhRv/ygfUfV+8czg03k=;
        b=e4aM05fZhtUMOfd+TOUp/ArYF/RR/7NgSgWgXSdEHe2SzPskfmod0vip5cjxQSoGEfhv3b
        fHUcFXxQQYrx7iht7P5/f3gsRHiRWA5rDbiXRKWD987fnWjelvxDt4Bf5eRYmPYWOqPY2u
        oJ1dt5Pbdu+SwiTKyZyGo6HFK5phjqE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-kz7XUeDqPo2y1GraayLAig-1; Wed, 25 Jan 2023 06:12:12 -0500
X-MC-Unique: kz7XUeDqPo2y1GraayLAig-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F3EF229AB3EE;
        Wed, 25 Jan 2023 11:12:11 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.193.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CBE962026D76;
        Wed, 25 Jan 2023 11:12:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Wolfram Sang <wsa@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH resend 0/2] i2c/extcon: intel-cht-wc: Lenovo Yoga Tab 3 Pro YT3-X90F support
Date:   Wed, 25 Jan 2023 12:12:07 +0100
Message-Id: <20230125111209.18343-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I'm resending these 2 patches since they seem to have fallen through
the cracks.

Regards,

Hans


Hans de Goede (2):
  i2c: cht-wc: Add charger-chip info for the Lenovo Yoga Tab 3 YT3-X90F
  extcon: intel-cht-wc: Add support for Lenovo Yoga Tab 3 Pro YT3-X90F

 drivers/extcon/extcon-intel-cht-wc.c |  1 +
 drivers/i2c/busses/i2c-cht-wc.c      | 46 ++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

-- 
2.39.0

