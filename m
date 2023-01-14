Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E7F66A9AF
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 07:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjANGjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 01:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjANGjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 01:39:42 -0500
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F8B4ED2;
        Fri, 13 Jan 2023 22:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673678372;
        bh=fTWOf2xuRe2mU+NqN+3qMJT9tELkw0/Wp+h3uXQVpdE=;
        h=From:To:Cc:Subject:Date;
        b=TcUdZ5TgJY8vek0JAzoH2PHZikva76FHlCvaRPUP/vke8PE4Wz9eBaLXjIxMhiyxf
         ENI0+P1yWZobNbddWsJDiO9z6bm6cXJ5lcFOBjxXF6yirjeuJVNQbL90vTdNVnfxx4
         bc+ZbJmIeC5+k+GZpmHw+p7UqCz8BauXkM4QMBCo=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 9D611E2E; Sat, 14 Jan 2023 14:39:22 +0800
X-QQ-mid: xmsmtpt1673678362tz613eefd
Message-ID: <tencent_542D047A15F0BB3B25BFD71C41345E385F06@qq.com>
X-QQ-XMAILINFO: OOWntbL6xj16PCEPfzvbPmDCgQGdV7XjYLK6HIDrmkB01P4V5K3yNXFk3ZoDad
         ObjvmrD4dFpR7XniX5eyX5YD80iW6Uv9Blv98aOqk4sKAdkSXRe/Ynt+olCC2exLOYGLFKV+X0YP
         aUHZzb/7j5NO0+k9dlq+ZCePijSoKjmajAa7C446p2hOztD3UybCE4HohS4t7XzElrWS5hlbTesC
         APpTYdCZzGRprEaKiJC8ZJTsIkwE1QFLUUXB+n/cTEMlay9zRy75Eo3KtY++jWK0TggPRUsM1Ksd
         zQ4Cyxdd7e8E84U+hLlRHk4u0mg0ZazRU5yhiEwrKodcNlJxv2GKRZc0zMs7IFxZeGIgGIzGzKbs
         ezxBW9D96Hiagha71ABF++4k2mPVEpDDcuCPWxF+y9EQn9CjvIWm0/FSEm9vy44srtPLX/6T3t1f
         ZA4RJ8W9USHkKwBa6nmAA53FL6DnaWCt8wIdm7PYPPrKBiXoh0uto//g6C39bauOfmp3saR1nLjY
         UEQZMfbHe7TpVkBjHmdq5BuGxFEpECo+4mFYrKugTSILzLcm1iFUm5fPW1W1s9DfpzvUnL99WHXx
         559GWLVTOUmaqMw/qJH49dqy/nknhFW/vAlzvtUT4UQK6e5VJoPsydsEHrTeQPNN3dJOhLqMuDPY
         640qVSSPxgwwwpwMZHF7VH0V/iQzWx2neuFMXOsUyYwB1Zx07FITfMXubeVaNbtTwhZ84yEpbM0O
         8v8O/utMGu21l17fzG1wJrV84cuT5oY2D3XdB8lNlX0vxTCrMS1QIAcHZzk7uDRnOt7VGbkRaEPk
         mago+KbxSnPwlNGnVRG6BDIz5ti2ngCBBLrlQz0ezqvOAirvPgDPajDoOrmfZqSRMkGVa/4sAtBV
         BAxkUNbSov37E0a3EKxV4qWfP9vnU9GjOl7m0C+LDVBzfSHEq5ootg9doSAnyqORjFLc5agp7R6U
         gssIrxEfKU+j0V16NPHL8WAhQbXeSRXxjaoB6m6cuV0T7xUD4rsQ==
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Yang Xiwen <forbidden405@foxmail.com>,
        Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v4 0/3] Support for MSM8916-based UFi ufi001c and uf896
Date:   Sat, 14 Jan 2023 14:38:43 +0800
X-OQ-MSGID: <20230114063846.2633-1-forbidden405@foxmail.com>
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

These devices are equipped with 512MB RAM, 4/8GB eMMC and MSM8916.
This series introduces support for them and adds a dtsi for the class of
MSM8916-based UFIs.

v4:
- Fix some minor typing mistakes
- Modify common definitions for leds
v3:
- Sort vendor-prefixes alphabatically
v2:
- Managed to get the real vendor
- Remove some reduntant descriptions
- Rename dtsi more formally

Yang Xiwen (3):
  dt-bindings: vendor-prefixes: add thwc
  dt-bindings: qcom: Document msm8916-thwc-uf896 and ufi001c
  arm64: dts: qcom: msm8916-thwc: Add initial device trees

 .../devicetree/bindings/arm/qcom.yaml         |   2 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/qcom/Makefile             |   2 +
 .../boot/dts/qcom/msm8916-thwc-uf896.dts      |  39 +++
 .../boot/dts/qcom/msm8916-thwc-ufi001c.dts    |  39 +++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi     | 250 ++++++++++++++++++
 6 files changed, 334 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-uf896.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-thwc-ufi001c.dts
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi

-- 
2.39.0

