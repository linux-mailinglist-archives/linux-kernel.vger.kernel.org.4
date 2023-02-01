Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61CD6869CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 16:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjBAPQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 10:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjBAPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 10:15:46 -0500
X-Greylist: delayed 497 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 07:15:19 PST
Received: from out-116.mta1.migadu.com (out-116.mta1.migadu.com [IPv6:2001:41d0:203:375::74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DE93430D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 07:15:19 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675264015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nxqm+4IZRFfG+BFvC8+di0Y0mHZDeyM6lhNBB5I4L7U=;
        b=GUq1RuIKjuHYjuQS0jputOzcj0/VxfTUnQhpAlMxu3EKAJpuWWXJ4wcbA/39Jk7pSv0Bcu
        NoHJhkYBq0vLxCoNPoCwb9Wy3dweusdLPCpaRvbde4ZOvdGWPTIKuecSwKFZT7iBO1asdX
        MlYBWxkGto5S34mB4mqwF/MTA6lJJB4=
From:   richard.leitner@linux.dev
Subject: [PATCH v2 0/2] panel-simple: Add InnoLux G070ACE-L01 support
Date:   Wed, 01 Feb 2023 16:06:28 +0100
Message-Id: <20230201-innolux-g070ace-v2-0-ebac7aaf004f@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPR/2mMC/w3LOwqAMAwA0KtIZgMxDn5uE2u0gZJCiyKId7fjG
 94LVYtphbV7oeht1bI3cN9BiOKnou3NwMQjMQ1o7jldD540kQTFYxcewrzooQxtbVIVtyIeYnt
 +pfR9PyMz4h5mAAAA
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Richard Leitner <richard.leitner@skidata.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=674;
 i=richard.leitner@skidata.com; h=from:subject:message-id;
 bh=qICrJNgSNpd/ysAFIuK7QMeqbUpb/LYnyvOjJ/HgBBQ=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGJJvNfBVv8synxZ3gD9/9u59d6c9y5i862bqvO8361hn8YSZ
 zfc61VHKwiDGxSArpshib8zV7p5b9r5SUScXZg4rE8gQBi5OAZiIDy8jw6sZNxbmnU3UmXydZa6P8+
 s/hb4prla3T2hrfHfyFUld9pXhf4Dm1h9dqjM+LwiZHMjz+lfoETeLT8t2Fpaq3Lb/XrJ2NT8A
X-Developer-Key: i=richard.leitner@skidata.com; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the InnoLux G070ACE-L01 7" 800x480 TFT LCD
panel with WLED backlight.

Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
---
Richard Leitner (2):
      dt-bindings: display: simple: add support for InnoLux G070ACE-L01
      drm/panel: simple: Add InnoLux G070ACE-L01

 .../bindings/display/panel/panel-simple.yaml       |  2 ++
 drivers/gpu/drm/panel/panel-simple.c               | 35 ++++++++++++++++++++++
 2 files changed, 37 insertions(+)
---
base-commit: c0b67534c95c537f7a506a06b98e5e85d72e2b7d
change-id: 20230201-innolux-g070ace-fda21c89efe2

Best regards,
-- 
Richard Leitner <richard.leitner@skidata.com>

