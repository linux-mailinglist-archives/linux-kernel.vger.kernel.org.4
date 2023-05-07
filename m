Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B2B6F9A96
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 19:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231644AbjEGRcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 13:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEGRcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 13:32:02 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [IPv6:2001:67c:2050:0:465::202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546EB93C8;
        Sun,  7 May 2023 10:31:56 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QDs144nl0z9sTS;
        Sun,  7 May 2023 19:31:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1683480712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RQPVnOmT5Rx6sI76v3BMcGlgaIUBrNyVx3grvraWAAE=;
        b=mArWJN/XkWGwWEminCzDSpCuEYz3WmdnYbQch6QNsnn5d/AJsz4sGEOWyHD8Rr2erguK4f
        te9rOhRgpcPlhl6P/anviRThQ7J+hkEOsMenVTU6MGu/VboJu2nqFJm0a5OCP8qXu4KEBI
        q4mtiR/qTzMfyCoJ0qW0Pft394kBxeqzcrasWUNBdomM9s8AGAvz0KegHs20+aL6km6fDd
        hfsZve6VNxAcuaRo2Hj8vC3suHfYoxT2B1C6MHfdJ/SzCLWil/CxWWgMvs+x0HrX1o3t+5
        idPs0lUsFQriX3hJV+EeuBZaaaaY8enWOKOcxdtZxSbhHzMaeCcr29PFedkxJA==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     pavel@ucw.cz, quic_fenglinw@quicinc.com, lee@kernel.org
Cc:     trix@redhat.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 0/2] leds: flash: leds-qcom-flash: add PMI8998 support
Date:   Sun,  7 May 2023 19:29:39 +0200
Message-Id: <20230507172941.364852-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchserie adds support for the Qualcomm PMI8998 PMIC to the 
pending leds-qcom-flash LED driver (v8) [1]. The following changes 
are necessary to support the Qualcomm PMI8998 PMIC:

- Add subtype 0x3 for the Qualcomm PMI8998 PMIC.
- Disable LED when changing the brightness to make brightness changes
propagate when the LED was already enabled.

@Fenglin Wu: Feel free to pull these patches in with your v9 if you like them.
We discussed support for this PMIC in the past around v3, but never could make
it work until now.

[1] https://lore.kernel.org/all/20230303095023.538917-1-quic_fenglinw@quicinc.com/

Kind regards,
Dylan Van Assche

Dylan Van Assche (2):
  leds: flash: leds-qcom-flash: add PMI8998 support
  leds: flash: leds-qcom-flash: disable LED when changing brightness

 drivers/leds/flash/leds-qcom-flash.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

-- 
2.40.1

