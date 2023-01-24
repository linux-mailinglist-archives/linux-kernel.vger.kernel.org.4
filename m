Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B229B67A60B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjAXWmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjAXWmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:42:05 -0500
Received: from out-212.mta0.migadu.com (out-212.mta0.migadu.com [91.218.175.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57AAC59DE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 14:42:03 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674600121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=oAapRs/RO6y9QOzK9GfRl6P67ERhquKIA38gdlc10UE=;
        b=F9hZW2m6lNyDvtRi0AzaKisYqewyHLR/1ADPdWh9FhsKqTvl8q/VaU1PJCfMsfSO+w6IEi
        tmbTPlUrATcShnkvCa3+ReiVF8V3IWzypuX0RdOvvjlr89FUZ9mK+lsSCBFTuC3NkUns5p
        fPnXDh78TFNKytnOHgLrCjkhIAcbAPY=
From:   Rayyan Ansari <rayyan@ansari.sh>
To:     dri-devel@lists.freedesktop.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Rayyan Ansari <rayyan@ansari.sh>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/2] SimpleDRM: allow configuring physical width and height
Date:   Tue, 24 Jan 2023 22:41:40 +0000
Message-Id: <20230124224142.7133-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The following patches:
- Add support for configuring the width-mm and height-mm DRM mode
  properties in the SimpleDRM driver via Device Tree
- Document these two new Device Tree properties

This is useful for allowing interfaces such as Phosh to calculate
proper scaling values and for early boot code knowing if hi-dpi
rendering is necessary.

Changes since v2:
- Remove $ref property (because it is an SI unit)
- Extend commit messages

Rayyan Ansari (2):
  drm/simpledrm: Allow physical width and height configuration via DT
  dt-bindings: display: simple-framebuffer: Document physical width and
    height properties

 .../bindings/display/simple-framebuffer.yaml  |  6 ++
 drivers/gpu/drm/tiny/simpledrm.c              | 60 ++++++++++++++++---
 2 files changed, 57 insertions(+), 9 deletions(-)

-- 
2.39.1

