Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6814067672F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 16:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjAUPg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 10:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjAUPgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 10:36:25 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBC62A9A8;
        Sat, 21 Jan 2023 07:36:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ansari.sh; s=key1;
        t=1674315380;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/TK50vANIeT0VcQuhI0R9JP1NtC98hHehgAPETS4Aik=;
        b=d48CK7Gsqlk9f29ouxtCo7pGt6AhCFUrJtA+xsJUBwULn6foz7n3xEMGka43KJZbYtRD+g
        RhHqONZJ7iV8V0j+SnzZzZelkFE+v2+9XEd6qQDPw/e7V+MHp7v+199CTyIWlfOSzIrwgU
        0iyX8vYaZczdM2cTPA8c43qWA9xpo2M=
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
Subject: [PATCH v2 0/2] SimpleDRM: allow configuring physical width and height
Date:   Sat, 21 Jan 2023 15:35:42 +0000
Message-Id: <20230121153544.467126-1-rayyan@ansari.sh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
proper scaling values.

Changes since RFC:
- Switch to using 32-bit DT property
- Report errors for return values of of_property_read_u32 except -EINVAL
- Calculate default value during probe
- Add documentation

Rayyan Ansari (2):
  drm/simpledrm: Allow physical width and height configuration via DT
  dt-bindings: display: simple-framebuffer: Document physical width and
    height properties

 .../bindings/display/simple-framebuffer.yaml  |  8 +++
 drivers/gpu/drm/tiny/simpledrm.c              | 60 ++++++++++++++++---
 2 files changed, 59 insertions(+), 9 deletions(-)

-- 
2.39.0

