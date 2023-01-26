Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B339167D411
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231912AbjAZSY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjAZSYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:24:53 -0500
Received: from out-231.mta0.migadu.com (out-231.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED208599A8
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:24:51 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
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
Subject: [PATCH v4 0/2] SimpleDRM: allow configuring physical width and height
Date:   Thu, 26 Jan 2023 18:24:33 +0000
Message-Id: <20230126182435.70544-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v3:
- Use panel node

Rayyan Ansari (2):
  drm/simpledrm: Allow physical width and height configuration via panel
    node
  dt-bindings: display: simple-framebuffer: Document the panel node

 .../bindings/display/simple-framebuffer.yaml  |  9 ++++++
 drivers/gpu/drm/tiny/simpledrm.c              | 32 +++++++++++++------
 2 files changed, 32 insertions(+), 9 deletions(-)

-- 
2.39.1

