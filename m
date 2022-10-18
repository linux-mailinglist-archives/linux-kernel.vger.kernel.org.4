Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8CD6030F0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiJRQpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiJRQpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:45:45 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B48B2744
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:45:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l16-20020a05600c4f1000b003c6c0d2a445so12678935wmq.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xJHqz/NgmeygQyOjTE1MtbVMgIIcdyJ4beia91UBymk=;
        b=N7a/utxESGarBoQNzWgHerpAID5FzSF2po1uvvRf4SEXBwDpCOzNwq2gfrV+mDIWIH
         5qcdxQD7E0pXC4fxzlNA1i3xTdAck/rGOCvgLjjVbECNfDRu1PX4afMJo5g+2XA12o7t
         zICV8SzSZT8GdfmyKLROUhCPkswwUSdRLiSw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJHqz/NgmeygQyOjTE1MtbVMgIIcdyJ4beia91UBymk=;
        b=Ay9xo6+OKRQYHVzH2Dt0Mb96TusBQfMspXx/myQVGarOd1h9u7xkvHNaQLHOFjVu/t
         ByzhymVOUi1FRBmx8IMBkVD3scANZIm90iCabvmSeisnQutK41sqZxPoA/fU28MqFIJ9
         1OaqC1AHjk6+B33GBTyRljkQZAYCMns74B1kOtfkRn+4Ogsyr471bhSNo52RzuUv3GdS
         ZONiFMVYEaZJjqU16wrHhRHqHdMRql6h2dRAwBzNveZS3mBPDMXJLvTh3Wnzk0wdQ6uk
         3um6/Q92EShi6fRO/vtvCYLDzzCf3bdRKt0CQQjPboUz6pv/NPjLZSg0GdYpWHEcVVfY
         CuJg==
X-Gm-Message-State: ACrzQf0qGAVMiIQenLt4ryv4vK3z7Bl/spfS1syZCLWxvMus5Vp51lw5
        ch6e9GX/ENPBtt6z29of+zNyWQ==
X-Google-Smtp-Source: AMsMyM4OpRNEI5gAYmN/Bj5M7BbRi+XiCYYmExrNxQ9ylC+TvRKeZz++TRILLpShYUxZ/HXp1FYhKA==
X-Received: by 2002:a1c:ed11:0:b0:3b4:d3e1:bec with SMTP id l17-20020a1ced11000000b003b4d3e10becmr2679777wmh.196.1666111540648;
        Tue, 18 Oct 2022 09:45:40 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-54-207.cust.vodafonedsl.it. [188.217.54.207])
        by smtp.gmail.com with ESMTPSA id e26-20020a05600c4b9a00b003a5537bb2besm13545592wmp.25.2022.10.18.09.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:45:38 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     tommaso.merciai@amarulasolutions.com
Cc:     michael@amarulasolutions.com, linuxfancy@googlegroups.com,
        linux-amarula@amarulasolutions.com, kamlesh.gurudasani@gmail.com,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/tiny: add support tft display based on ilitek,ili9488
Date:   Tue, 18 Oct 2022 18:45:24 +0200
Message-Id: <20221018164532.1705215-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
This series  support for ilitek,ili9488 based displays like
Waveshare-ResTouch-LCD-3.5 display. Tested on Waveshare-ResTouch-LCD-3.5
connected to px30-evb via SPI.
This series is based on work done by Kamlesh Gurudasani in 2020:

 - "drm/tiny: add support for tft displays based on ilitek, ili9488"

(Thanks Kamlesh for your starting point)

Tests are done using the following tools coming from Yocto fs:

 - modetest -M "ili9488" -s 31:320x480@RG16 -v
 - fb-test
 - fb-rect

References:
 - https://patchwork.kernel.org/project/dri-devel/patch/00719f68aca488a6476b0dda634617606b592823.1592055494.git.kamlesh.gurudasani@gmail.com/
 - https://www.hpinfotech.ro/ILI9488.pdf
 - https://www.waveshare.com/wiki/Pico-ResTouch-LCD-3.5

Regards,
Tommaso

Tommaso Merciai (2):
  dt-bindings: add binding for tft displays based on ilitek,ili9488
  drm/tiny: add support for tft displays based on ilitek,ili9488

 .../bindings/display/ilitek,ili9488.yaml      |  72 +++
 drivers/gpu/drm/tiny/Kconfig                  |  13 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ili9488.c                | 440 ++++++++++++++++++
 4 files changed, 526 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/ilitek,ili9488.yaml
 create mode 100644 drivers/gpu/drm/tiny/ili9488.c

-- 
2.25.1

