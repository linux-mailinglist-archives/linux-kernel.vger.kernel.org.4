Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69286C37F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbjCURNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjCURNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:13:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB88A51F88
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:12:52 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id ek18so62535284edb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679418760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u17vmZyfy9dal6qK63POybZ13EfyIridDcw13EXlO4M=;
        b=W4qm9akF9juiuXaVT6glKvmi0z/19+DnQysJlCdUFHKPJtdR+0d44A2QGDy0t1GihG
         nifsjFwOn3UVP9s7E7KLx1PzdOiQDyZL3oPG02ee5O+csxIHVxZ6jbdmhmwxxBCm0TPH
         Wi/Q9iqIYZAF23VZH/g5Nm9d73gLSwAz2Vu8ECnWYUjOC27SQJM08DDtX10lW9xOHQ10
         w7KYiXLQDpucPQwqlCQtQ4CjtzDaGjO9S18gWB3xiUpNbnAITZSK2bOvi+70gfmnpUFG
         RcWPpFQhfXHor/38op4w2Pd35LnBl3iwm9CtVHeLqFq36MqF+Bf6zHK1Y9m4ZIU/C9QR
         zS5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679418760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u17vmZyfy9dal6qK63POybZ13EfyIridDcw13EXlO4M=;
        b=jXVSYboQZMmJbPRZ6k8pan2NQggnZBCdHKYF8eUW16aSi58Rt5c8cKIR/kV2XDGeAY
         u8plbYzYaV19RMZtDLRS6D+m09Dbfuxl6n+4wXC9oRjllFududz6p91hrWekHVBxIb5a
         4Dj/qkEEdXDE2xh0+2PbpTozuqjJuv4a66Hj3aJL/uboaR0TAXh4Bg0amqnOf/bqWsoZ
         o/dH3MRznzzG2nz1NFRL1zhwIyEvLSQPKqpLFZ5eklSvBxhCY8eIaBpVdB1GHEHeT+1/
         QRiMzbi5zR/9EZcOjnVWZhelcqSj+1pPV95wApEfb4wmxXvf8ZFI9hw4eD4FZnxlClsz
         PWSw==
X-Gm-Message-State: AO0yUKX+YNhDeOevoZJGa4PHOA/idMLE+5VIUvTMU08HZT948fcLQjLI
        pAdantkPVOntw3GjJpCv1197S8IO+hs=
X-Google-Smtp-Source: AK7set87eu8TVE1uR+HziZluiDi+FIovip8LKHrk156iTChkOxm5IL0b3BhpBhsZ5rtlD7TwJiEaAA==
X-Received: by 2002:a05:6402:54b:b0:4fb:6357:f393 with SMTP id i11-20020a056402054b00b004fb6357f393mr3974740edx.1.1679418760450;
        Tue, 21 Mar 2023 10:12:40 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-bc57-1c00-0000-0000-0000-0e63.c23.pool.telefonica.de. [2a01:c23:bc57:1c00::e63])
        by smtp.googlemail.com with ESMTPSA id c14-20020a509f8e000000b005003fd12eafsm6474959edf.63.2023.03.21.10.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 10:12:40 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        neil.armstrong@linaro.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v1 0/3] ARM: dts: Enable WiFi and Bluetooth support on MXIII-Plus
Date:   Tue, 21 Mar 2023 18:12:10 +0100
Message-Id: <20230321171213.2808460-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MXIII-Plus comes with a Ampak AP6330 Bluetooth and WiFi combo chip.
The 32kHz clock is provided by the SoC and is enabled by simply using
the correct pin mux.
Also this is the first board which uses the SDXC_A for connecting to
the SDIO chip.

Other than the two new pin muxes this is just a matter of describing
the hardware in meson8m2-mxiii-plus.dts.


Martin Blumenstingl (3):
  ARM: dts: meson8: add the xtal_32k_out pin
  ARM: dts: meson8: add the SDXC_A pins
  ARM: dts: meson8m2: mxiii-plus: Enable Bluetooth and WiFi support

 arch/arm/boot/dts/meson8.dtsi             | 17 ++++++++
 arch/arm/boot/dts/meson8m2-mxiii-plus.dts | 48 ++++++++++++++++++++++-
 2 files changed, 64 insertions(+), 1 deletion(-)

-- 
2.40.0

