Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643E563A6F8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiK1LSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiK1LR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:17:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91CA512A95;
        Mon, 28 Nov 2022 03:17:57 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id z4so16259162wrr.3;
        Mon, 28 Nov 2022 03:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=xi6pBFQ2Iy9JcIpqhAKb8IIPjJ3///r7Dh4vpWsLSDI=;
        b=Afqs52V6ygFs3v3SzJpElSKc8n8lhgdoNoJoZh8moM1X7PpFmU1sIZnqdJWIW0T+8o
         IjrgAsMN/2zOlpN4w1GjijMH/r6PP2NJMtpPq3pRzaCiV7AQ6eLN6pOMsB7pgaZJWTqB
         T+v+2Dhd+g2EcmUwPza5x3GkMfh7hA1ZGCR6UA6U9lVWLI1mYC00Cs+4OteWMpR2Du9p
         kHv0ITGPXKP05U8RAS8REcRtBAzSwu+ikWpAG2rJh1y8XMQVWQ+fTSlsKaydSt/uTwhX
         0RaJth+7+or+j0k+fnceSzvDSREhrEhTCZYY+biGdfsQ2HhH7Pg2fDisgf5qk43wb+uz
         GD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xi6pBFQ2Iy9JcIpqhAKb8IIPjJ3///r7Dh4vpWsLSDI=;
        b=Zu2rqdZFkhGDRYtiL+1XPE3IGwfwiH4pZ4+f/xw/jFaMg3cciVDaVVXykNjZqlZ61t
         ER3Vlk8J6g/Q47vRN6AZsDgLFz/U67QMuZFV5MGs7p23wmY3HeJnqnlxZHUnOjTlmvNp
         bPdb0AoZIiJ/Sa7ScBb3u6nSHDioIJXJhvWzc1Lji9YuJVsa+w4BddVIspP/sNLnnY8X
         hEPoNg3fbxIlMsWHnvvDKPJ9KxcAB2MHYhvPUaDyqdaZdCpp9nFBtJ7jD+0Mdi3bYuxn
         yir9dhdB/4VAEhOOaZO22vAFRewmzpmYBs+kGQtQKqqARtbDz+ksXdVUMMNcqT4tXG0F
         YJKA==
X-Gm-Message-State: ANoB5pmXw7xa3EuJesn5ZTfvpCnhS9B+mxK0CDC/xltQMtEvF1HUroFY
        gCMTkEa+hg1oQ4dVa6zQzj0=
X-Google-Smtp-Source: AA0mqf4GXJ9ZPIdgGqed8M0XM3SA8kk373G85PorjEdJ2qU7LCAoGh5UUBa4ygk+8Y0CVY8ueeVo8Q==
X-Received: by 2002:a5d:688c:0:b0:242:1059:2118 with SMTP id h12-20020a5d688c000000b0024210592118mr4869395wru.245.1669634275707;
        Mon, 28 Nov 2022 03:17:55 -0800 (PST)
Received: from cizrna.home (cst-prg-44-69.cust.vodafone.cz. [46.135.44.69])
        by smtp.gmail.com with ESMTPSA id g3-20020adffc83000000b0024207ed4ce0sm7711817wrr.58.2022.11.28.03.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 03:17:54 -0800 (PST)
Sender: Tomeu Vizoso <tomeu.vizoso@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc:     italonicola@collabora.com,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR VIVANTE GPU
        IP),
        etnaviv@lists.freedesktop.org (moderated list:DRM DRIVERS FOR VIVANTE
        GPU IP), Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC
        support),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson
        SoC support), linux-kernel@vger.kernel.org (open list),
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux+etnaviv@armlinux.org.uk>
Subject: [PATCH v2 0/5] Support for the NPU in Vim3
Date:   Mon, 28 Nov 2022 12:17:33 +0100
Message-Id: <20221128111740.39003-1-tomeu.vizoso@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for the Verisilicon VIPNano-QI NPU in the A311D
as in the VIM3 board.

The IP is very closeley based on previous Vivante GPUs, so the etnaviv
kernel driver works basically unchanged.

The userspace part of the driver is being reviewed at:

https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/18986

Regards,

Tomeu

Tomeu Vizoso (5):
  dt-bindings: reset: meson-g12a: Add missing NNA reset
  dt-bindings: power: Add NNA power domain
  soc: amlogic: meson-pwrc: Add NNA power domain for A311D
  arm64: dts: Add DT node for the VIPNano-QI on the A311D
  drm/etnaviv: add HWDB entry for VIPNano-QI.7120.0055

 .../boot/dts/amlogic/meson-g12-common.dtsi    | 11 +++++++
 .../amlogic/meson-g12b-a311d-khadas-vim3.dts  |  4 +++
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c        | 31 +++++++++++++++++++
 drivers/soc/amlogic/meson-ee-pwrc.c           | 17 ++++++++++
 include/dt-bindings/power/meson-g12a-power.h  |  1 +
 .../reset/amlogic,meson-g12a-reset.h          |  4 ++-
 6 files changed, 67 insertions(+), 1 deletion(-)

-- 
2.38.1

