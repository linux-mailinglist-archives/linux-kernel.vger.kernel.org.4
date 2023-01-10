Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7FFA664565
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 16:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238861AbjAJPyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 10:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234632AbjAJPyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 10:54:23 -0500
X-Greylist: delayed 196 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 07:54:21 PST
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F454C72E;
        Tue, 10 Jan 2023 07:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673366057;
        bh=3fg3syAbmIaZWNk40gjo2tn+vj9YYWyQmPN36W7+evE=;
        h=From:To:Cc:Subject:Date;
        b=M6Q9HWQQjHhp5NyWsMQyO97J6Hr+HMz2XKr6RPqhDXY4BOO75UZpdgmOQxsb+5WMd
         IuPcZ+X/ClLkzhuA4BaTZp9HQNAHhSXj7Dd7vTAmQ6EffNbVD09e8Z7YPVg8CMMsg8
         qWNevyhu68DL/N/WzPFlUALkw/2n6cQY9T+zkKx8=
Received: from localhost.localdomain ([2409:8a4c:808f:5b0:d92f:83a8:9ac7:4de5])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id C9A3CA11; Tue, 10 Jan 2023 23:50:26 +0800
X-QQ-mid: xmsmtpt1673365826tygdrm88h
Message-ID: <tencent_1CF967E6E0A317C2036BA5D18D813DDCD909@qq.com>
X-QQ-XMAILINFO: OQwUWlGGdA3tdg1KQ62p4QXK3Fc8nVzKJhAyXM2+bl41VENpqZmjzl8/RO9e8j
         FzqwGTwpg0GCREkeYw2NoXA7qjFdMn6inhQRBAdnXcAQuxcpsfL/a0T/l6SLxPmYCQdwmD+g6Q6q
         aBrorB0OYw65zl/OD7NVIJAnE7voHyAs/wc2gWG538tsv+RO3hhZppQIdZsK/9YeMENFeIqTAbcg
         dZjmphTJw4KQhcAdiy7AHi8SFq3Y5oxw9TxBqLLGNnV1sESr0coWXgM9ld+yPx0NqYxSKfYDlSMz
         yziiK1Kp0vajkpqtqTcSYU6+W3Q94FfPwJEtMBhKcvrQCyFl6Zz/s1SEPcMfbsYLIfC3fGq8deyN
         vK+9VZKfX3KVA1pEL3xlDNzFrJku+ei1phCtsclS8NaDxXaEMCNL0IcJusefIT++K/pUwJSZpJnk
         4jG1WVGXfKF9lxxiqpcowAKWpraeZ/vvSmwGqnj5cGGv9Ny+8jheSnpUK9t/9TTt27QxS24Evw1f
         lXEbmVG4ZRtMeIbM1JREY5rePYFIE0u/wxh9L1Cs6bziBoQ3TJGWFhs0nt6IK5E+tvKfhgjiz8ph
         SsMg9qqxyPIGWVfMZ0Qp1EfUy91PdQqO16T2D/zRbN5SoLOxB2j1rA+IcapfxakAkGcCAJQPtaQB
         mINPwjky+rg29Mf3fV11N4H/tHb5kG1kRMz7ad6xs3fAsoj00gycodYUQdT0VeGrHjIxsQzmZf36
         LoefqKEckSZsOIpVoD9+GmFJRjE6neg+au/51ddcwj+Pghsl0zz46rlljsuSo+gQtCYEn1UBbfLn
         2xpTxzcVD1TJVGTdbVHrewf/0DbYFijIZa11jApMnNvom1/rYnH6ZfQ3OlR+zJz+5yqLqgDYqWOB
         quYljBVMNCAOfxYZTQIDIHR2tsP6JoIv18t65/YtwgtReQ7zVvJyDsA8W24gLKKE/i+h/pfoWg4y
         LPF0eTzhYXIl/ymaGeKrCRtmM+k2rzQB/LPDPrjgcB08ai7J+ZIAqPRhAUY6PP2o3vYjWGYC1BMR
         Oz1GUlCA==
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH 0/3] Support for various MSM8916-based USB sticks
Date:   Tue, 10 Jan 2023 23:50:11 +0800
X-OQ-MSGID: <20230110155014.31664-1-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vendor is unknown. Zhihe is a widely used name to refer to such
sticks in some forums.

Yang Xiwen (3):
  dt-bindings: vendor-prefixes: add zhihe
  dt-bindings: qcom: Ducument bindings for new msm8916-zhihe-uf896 and
    msm8916-zhihe-ufi001c
  arm64: dts: qcom: msm8916-zhihe: Add initial device tree for zhihe
    Wifi/LTE dongle UFI-001C and uf896

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8916-zhihe-uf896.dts     |  41 +++
 .../boot/dts/qcom/msm8916-zhihe-ufi001c.dts   |  39 +++
 arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi   | 246 ++++++++++++++++++
 6 files changed, 332 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe-uf896.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe-ufi001c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-zhihe.dtsi

-- 
2.39.0

