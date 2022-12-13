Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3624D64B2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiLMJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:59:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiLMJ7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:59:36 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BDF1AD86;
        Tue, 13 Dec 2022 01:59:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id bx10so15061541wrb.0;
        Tue, 13 Dec 2022 01:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6UowvKlOyeaP+8GVBuYViR8VGZ0vnkHefUDXIg11pCI=;
        b=nNn5v+eyVou2K7P0bdkZ0tMP+OCamHkBWOi+DurF1TwAKt3/SaIxwEUwaPb7O5p34K
         vB2Pc/hW2dqc3a9pcZd3tGwK4aMNdSX+R+ZmFxMfEnbqfIBD1Sso+cZb35AQIPYy6wOs
         1ucBsHDKFQ2a8xmZGd4P6+Ng8fwKGyGu4dXmER3jbTglzSiVSI8BCPLD2y4W2e9MSiMD
         hbxtbbC102W+ExVk461MFCX6+Pyxlou5plkRKewNmDvr4V3lvDrpk/Y0FDBwr85Vjipi
         K02cXTAUQ9i5/1hqh0PpoflAx/+cimgBAkXF2VwfkBmjiT3AcZxhx0cr/sPiVEbjRDwG
         Yo1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UowvKlOyeaP+8GVBuYViR8VGZ0vnkHefUDXIg11pCI=;
        b=up9hZMyyePpnZZm0vsX27M1ACJt9H+5Ve5rEhR4xnrFsT2iV9GK8zE9CKHp8k1jw/P
         KYRShblKV3feaMNT9doGxQgStq59gy0BmFBVbvgaD2AJUjuFToz6Is2OKJfXi7rl18+n
         VMzIlWjzWXXR73bYgn0O1D/TspJKmZFE8fp1R9GAv7nVpuHU1Jr1kYT79y8kJopOTPtQ
         hD/PY5LAxoCD3tEJOdS5vHO3PDaI/0614nv47guDP7I9TmVAMUa7oY+Gm0uN+Vid1Bp0
         UUz+EWwrylhoKOUTS8ZvZD5vHJfRYd2CHOrWd3RY0EZnhwKXca+oWgjrjJbNMZFpdcj4
         7z9A==
X-Gm-Message-State: ANoB5plEIn5t4rip3ziihKCpU/Y6DN6+Az7Zb0j29S0s0uAH5EFfc89n
        /uRkoppkUo56ti9maC+MK0I=
X-Google-Smtp-Source: AA0mqf4SLgHw8Um+MbvGZHFpnDJZ1BuLVj4XCUAQr1TTxO+xy8a5Q9Vu8eD0BK25EEDz58Kqkt2MVw==
X-Received: by 2002:adf:db81:0:b0:236:695b:82d4 with SMTP id u1-20020adfdb81000000b00236695b82d4mr11828961wri.30.1670925573480;
        Tue, 13 Dec 2022 01:59:33 -0800 (PST)
Received: from xeon.. ([188.163.112.59])
        by smtp.gmail.com with ESMTPSA id z5-20020adff1c5000000b002258235bda3sm11190053wro.61.2022.12.13.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:59:32 -0800 (PST)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2, re-send 0/1] TF101 accel matrix fix
Date:   Tue, 13 Dec 2022 11:59:04 +0200
Message-Id: <20221213095905.14042-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
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

Accel matrix in device tree was taken from downstream
and is inverted. This new matrix is generated directly
on a device and works correctly.

Svyatoslav Ryhel (1):
  ARM: tegra: asus-tf101: fix accelerometer mount matrix

 arch/arm/boot/dts/tegra20-asus-tf101.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.37.2

