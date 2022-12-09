Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57454647BE1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 03:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiLICGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 21:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLICG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 21:06:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C791A7D096
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 18:06:26 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so3466091pjm.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 18:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FS1or+ESDzH1o6ptNvHwAIRTD0TlQD7xITLX41K53Jg=;
        b=bg0AHeRjVkHV4Ayw7htxZ+TvjKtKgD6b29SnzACkNPnoYgwu42MecOxPDbxuOmO5mF
         z9SXrH91PAK5dJs7P+KZTTbffBSyTau9vlEaxQuGsphp2feedVLOnkD1/NU12Srf1tGG
         P8a707xGeo0i/xRyrg46TgNSeeE2Cgs2Gwp2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FS1or+ESDzH1o6ptNvHwAIRTD0TlQD7xITLX41K53Jg=;
        b=mkOx7QOEP/b7QQranYtSYegzFHZ/M+XS6Hs2nlzlfBUHohH0ym4RlUidy7lx5/eqc/
         YkB2/FKt192H9F2nn10Xhy4Dx82NFJSK3m0mrw6cGAZpu4e+cg8Fkj9O9FcAxq80Jpmj
         Y0yUwzblSL9WEfnkJQ65z9tNy2p38G49F6ielRFpIGc6bMtqV3WRIptKtoGMSVryW2lV
         S3r/lVeQtMwzM/5lWcQtDix9nu49btH89wfe5SpY312AlDKRIP2OeobbFmoki3sExXX8
         sis4X14m+4ZlIohbo9Vm1w/Hkg7DZHRAi+XMN3OCcSFAObwip246oaTxnOvDXdpsLZpQ
         pveQ==
X-Gm-Message-State: ANoB5pkgotUtgPQhG2l0LugmHbkZOnuAnb5V0gY4sqXSEXEY5PDSgMdv
        ZNwNB4iE0oYdXuqoLw1BGX4jlA==
X-Google-Smtp-Source: AA0mqf5cZ+ajHa2LZIGsjgn7Kfhiu0E+xom3phksHn7SWU30IPZvQjh/pHJEKH32eNqvWsl8Iy8sSg==
X-Received: by 2002:a05:6a20:1010:b0:a2:ed21:d820 with SMTP id a16-20020a056a20101000b000a2ed21d820mr7037169pzd.42.1670551586213;
        Thu, 08 Dec 2022 18:06:26 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9a82:7898:7bf4:b4f])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a648300b00218ddc8048bsm233473pjj.34.2022.12.08.18.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 18:06:25 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, mka@chromium.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org, swboyd@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Johnny Chuang <johnny.chuang.emc@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] arm64: dts: qcom: sc7180: Make pazquel360's touchscreen work
Date:   Thu,  8 Dec 2022 18:06:07 -0800
Message-Id: <20221209020612.1303267-1-dianders@chromium.org>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches adds / fixes problems with pazquel360's
touchscreen. A few notes here:

1. Originally the touchscreen was supposed to be added as part of the
first landing of the pazquel360 device tree. ...but the fact that
Yunlong changed email addresses seems to have messed up Bjorn's
scripts. What landed was v3 [1] instead of v5 [2]. The pazquel360 part
of this series is that diff.

2. We delayed sending the fixup till now because soon after the series
landed upstream we found that some laptops were having trouble
initting the touchscreen in cases where the eDP/touchscreen regulator
was left on by the bootloader. We've been struggling to make sense of
all of this. As part of this investigation we landed a85fbd649844
("Input: elants_i2c - properly handle the reset GPIO when power is
off") but that wasn't enough. That fix, together with the fixes in
this series, is enough though.

3. This series is mostly device tree changes with one more change to
the Elan driver. They are fine to land in separate trees. It turns out
that with _just_ the device tree changes things are actually working
OK but the timing is tight, so getting a little extra breathing room
from the Linux driver is nice.

4. Despite the fact that we did debugging here on pazquel360, many of
the changes here are made in general for trogdor devices. I believe
that this will make the timing more correct on those devices even if
we weren't actually seeing problems.

[1] https://lore.kernel.org/r/20220901024827.v3.2.Iea2d2918adfff2825b87d428b5732717425c196f@changeid
[2] https://lore.kernel.org/r/20220923083657.v5.3.Iea2d2918adfff2825b87d428b5732717425c196f@changeid

Changes in v2:
- Fix typo in commit message (Matthias)
- Fix typo in commit message (Matthias)
- udelay -> usleep_range (Patches Robot, Dmitry)

Douglas Anderson (5):
  arm64: dts: qcom: sc7180: Bump up trogdor ts_reset_l drive strength
  arm64: dts: qcom: sc7180: Add trogdor eDP/touchscreen regulator
    off-on-time
  arm64: dts: qcom: sc7180: Start the trogdor eDP/touchscreen regulator
    on
  arm64: dts: qcom: sc7180: Add pazquel360 touschreen
  Input: elants_i2c: Delay longer with reset asserted

 .../dts/qcom/sc7180-trogdor-homestar.dtsi     | 18 ++++++++++++++++
 .../qcom/sc7180-trogdor-parade-ps8640.dtsi    | 20 ++++++++++++++++++
 .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 21 +++++++++++++++++++
 .../dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi | 20 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi  | 10 ++++++++-
 drivers/input/touchscreen/elants_i2c.c        |  4 ++--
 6 files changed, 90 insertions(+), 3 deletions(-)

-- 
2.39.0.rc1.256.g54fd8350bd-goog

