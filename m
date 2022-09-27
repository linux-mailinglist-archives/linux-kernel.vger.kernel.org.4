Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72C75ECF85
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 23:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbiI0Vt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbiI0Vtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 17:49:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F838356F4;
        Tue, 27 Sep 2022 14:49:50 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a14so12372546ljj.8;
        Tue, 27 Sep 2022 14:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zE62lohSmmRg7fAFt+FrW9alD8VE/4dzrMd0xT71Ofc=;
        b=ZAm5vsjD/1j5Tqdba1+CXQe/6uzu4duJ3xCqBosS8C+qdB7LjhMVq3a7GYSmIWroNU
         FDGQ/ZrPODP2Is1+loZJcV14tAHs/Wlik2Sq2jUNdo64zOZ2IR7HyzM4e+yfTgqL+3Lh
         aZJPJ3BkSMfoTXMq4VEMvTYgqey/02ityZU8x80RbNv2Xr9Mwh4JXdnw5vuBChQS1M/F
         J+eieVHEu9JSNrKE/SqP2DcH7UkRRsM9hLYahtNlMJYsBxsmc1P3XHWchPX2u8wg9NBr
         D/7cj1V+6C5p6TDo7IWIJAMZvUPPOy753MkZSg+pYhaKA/Yu6g26CuZS9LT+iSpbmzGb
         8jlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zE62lohSmmRg7fAFt+FrW9alD8VE/4dzrMd0xT71Ofc=;
        b=aZzuWispyvfktUUasyPPgh5Eoa8Z5+RJgqyasCYO8lM/49Xnj1N54mlcuSmhOtZVYr
         YnX2L4mMOsRkiqxa1/isvYIpGztePzZx6V27ArNo6qnMtC30zGeexnN6NRmg51sSu46u
         w0MXWSfnRuFpjWrjN1QONXI4dFTC3LrM9aP0K0I0iZicSv8KD+4GwLkiDAJOLvEWPZEq
         rzA3B6f0asqpQujlQ87BjOd60sVSXlEE1G6A0i/VxrmchTVzl4LUhQSvG823KIcQ+3J1
         tUxw5ciWthnywVZlRMBBjiIue5vku/ijt/6cIQue6l+T8gYAxIz13/+hse9F2LDRkXxo
         5Erg==
X-Gm-Message-State: ACrzQf0kMWKCjvykEEPNukyKwhlvUnULhCKbgZmuOud/gTCCXdCSc36U
        DqX4D0IDUXLdUXIUX3mPdpdikSegrVVd+g==
X-Google-Smtp-Source: AMsMyM67VhOkFX7L8TMXB/XXfnkcoKIBblGncvqYJHb/NiZ2/ny5mSUeK8hPKJr3Wo2hYsrubQI1kA==
X-Received: by 2002:a2e:b895:0:b0:26c:3b8:c015 with SMTP id r21-20020a2eb895000000b0026c03b8c015mr10005135ljp.67.1664315388299;
        Tue, 27 Sep 2022 14:49:48 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id u25-20020a2e2e19000000b0025fe7f33bc4sm279901lju.49.2022.09.27.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 14:49:47 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] Initial Samsung Galaxy Tab 4 10.1 (SM-T530) support
Date:   Wed, 28 Sep 2022 00:49:36 +0300
Message-Id: <20220927214940.244480-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for pm8226 GPIOs and support for the Samsung Galaxy
Tab 4 10.1 (SM-T530) tablet which is based on apq8026.

Changes in v6:
  - Set status as last property in nodes
  - Pad register addresses to 8 hex digits

Changes in v5:
  - Rename pm8226-regulators node to fix issue reported by make dtbs_check

Changes in v4:
  - Move delete-node to memory-region
  - Move usb-switch node to blsp_i2c4

Changes in v3:
  - Fix sdhc_2 bus width
  - Reorder includes

Changes in v2:
  - Change codename to matisse-wifi
  - Remove msm-id from device dts
  - Rename pm8226 gpio node

Matti Lehtimäki (3):
  ARM: dts: qcom: pm8226: Add node for the GPIOs
  dt-bindings: arm: qcom: Document samsung,matisse-wifi device
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 453 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8226.dtsi            |  10 +
 4 files changed, 465 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts

-- 
2.34.1

