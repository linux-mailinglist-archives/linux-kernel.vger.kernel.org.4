Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9356B7063
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjCMHvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCMHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:51:30 -0400
Received: from out-31.mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AEB38E99
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:51:24 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678693882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=nxqm+4IZRFfG+BFvC8+di0Y0mHZDeyM6lhNBB5I4L7U=;
        b=M8Du3949TGpyn2LG7wdznTRteqQh3mthjAdt+w8K8WtFnZHa5Hu7N+eGvYSqaGqGAIGG0/
        tc99zF7hLgnSbcZesZMdrw7Mr1givl2KLdYRJ47AiExkjebLXDhf6Nl1xzkXy2h7+K+xVg
        fQwiShy8eNkR/ka+bX4VVDEAC4rQypA=
From:   richard.leitner@linux.dev
Subject: [PATCH RESEND v2 0/2] panel-simple: Add InnoLux G070ACE-L01
 support
Date:   Mon, 13 Mar 2023 08:50:15 +0100
Message-Id: <20230201-innolux-g070ace-v2-0-2371e251dd40@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFL4rv7kuNpeIVVdZesScHCv9vqO4NLNQhNaV2sJ/2bUmrZ0
 7bb1HaUsDGJcDLJiiiz2xlzt7rll7ysVdXJh5rAygQxh4OIUgImErWdkmHFcRVLv7OnVXJ79rIwLS+
 XPBP3zuFMYcduvQ9pXSrOFhZFhjfvKGTfZBa9fEf0WpFhyxedV/5KZt1KUPoqx/N5z79o8HgA=
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

