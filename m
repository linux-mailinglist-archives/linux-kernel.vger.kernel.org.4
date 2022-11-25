Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A05B638F73
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 19:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiKYSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 13:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiKYSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 13:00:28 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182A653EE2;
        Fri, 25 Nov 2022 10:00:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fy37so11856515ejc.11;
        Fri, 25 Nov 2022 10:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c0rYuzAxULrdHur/y5TCtz7+5K0txbc/x5K5DhHN34Y=;
        b=QvfiLxFDaY2/VzJNbz4grXDD/kXNFb2Kp9TmkyQ3k8vQ9oC12xoPWKSWtyAmSfT2sd
         MpPaghYcxx5TYl0eyf0HTSjH5MdtKTtbgMtEiNU4ZXT862oU+OeBHnP+9d8wBKFfBTww
         CRfCkKSFCvcSUUZq8VfuspFCw960rz/lNTarRqfUclTcTRezPsYTLPMewexMcpJojce0
         nLwzxKlfLQ33YXslsWnsMmOK5+reF2LGlUeMEy3Gn85x7Xn/gn00KaRVl93E+doAXdTI
         eIGhVUj3aZuhmpJavba5lcGEZF4RFdCpXXqVKyiW/JWkJBw6upt2nA+hRPIneDPH41eJ
         F+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:content-language:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c0rYuzAxULrdHur/y5TCtz7+5K0txbc/x5K5DhHN34Y=;
        b=WGxj4o+RfaqQXJ1PMQXp0IkP5s35gHjTWAwvEFK5h+yksc0Zv4MA+yBbJFB9oTRnte
         DbTVyvfPf4fXiAxCMs6o+V8zU/9biygmw+2Ho1UzzcyHP2amtZ2DISx5bPOzJ+UM1mik
         neBjKNFxW8js2bjdlh2C3jiZj43mhsHKlf/zuLGUI0NJ+sLnSWSHZ5bWroHvq0V2uyKe
         kPh9YmpDxcgUJD5mROO+iUyWkMpXEbWlmvLtD66hITjH0EECtr9/Wx7PnKSWQZuNe7On
         ceqhGhenW48vaLppK4dOQEW6TwCvpuEYhhjHokWjR/hSlrv/EWAG5+urpPD8woIQKABD
         YQ2w==
X-Gm-Message-State: ANoB5pmsTXjX+rYPINa7UZ8cbA4eNuZ8pjwAyHOulWBkgtuGTf4oFJPV
        Q2WHHjOfzReHPy7byAgs1RiyAPG5VmV3DA==
X-Google-Smtp-Source: AA0mqf503dntU4cQY4CFUWoBQKXWGaLfG8CKJ+p/PwYiVfOz/wKl3CmYMbwFAXtWZjDhYTUXSGxmkg==
X-Received: by 2002:a17:906:be9:b0:78d:3e11:1036 with SMTP id z9-20020a1709060be900b0078d3e111036mr33905298ejg.76.1669399226664;
        Fri, 25 Nov 2022 10:00:26 -0800 (PST)
Received: from [192.168.178.2] (dslb-092-072-004-196.092.072.pools.vodafone-ip.de. [92.72.4.196])
        by smtp.gmail.com with ESMTPSA id f26-20020a17090631da00b0077909095acasm1810208ejf.143.2022.11.25.10.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 10:00:26 -0800 (PST)
Message-ID: <29019f53-93d9-04de-7f3d-622069e6cc1e@gmail.com>
Date:   Fri, 25 Nov 2022 19:00:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
From:   =?UTF-8?Q?Otto_Pfl=c3=bcger?= <affenull2345@gmail.com>
Subject: [PATCH 3/4] dt-bindings: display: panel: mipi-dbi-spi: Add missing
 power-supply
Content-Language: en-US
To:     =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-supply property is currently only mentioned in the
description, but not listed in the properties section as it should be.
Add it there.

Signed-off-by: Otto Pflüger <affenull2345@gmail.com>
---
  .../devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml  | 3 +++
  1 file changed, 3 insertions(+)

diff --git 
a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml 
b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
index c2df8d28aaf5..d55bf12ecead 100644
--- 
a/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
+++ 
b/Documentation/devicetree/bindings/display/panel/panel-mipi-dbi-spi.yaml
@@ -80,6 +80,9 @@ properties:
        Controller data/command selection (D/CX) in 4-line SPI mode.
        If not set, the controller is in 3-line SPI mode.

+  power-supply:
+    description: Power supply for the display module (Vdd).
+
  required:
    - compatible
    - reg
-- 
2.30.2
