Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5E6B4642
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjCJOle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:41:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjCJOlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:41:32 -0500
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC011F611;
        Fri, 10 Mar 2023 06:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678459283;
        bh=soCWwAGQ9Hj6gEjz8DtblP8KJXV25YB7LOn17SHTfY0=;
        h=From:To:Cc:Subject:Date;
        b=w5fAD03aToUBdQ+mSx7HC7cdpkDJZ/DQg+VfDyLLt0mw7dHB5UyosCwZf+AA0Kqep
         lDb5rtg/I2RYndKUscO/QG+yEsbBHE7Fbc1syctNF0xxxDpFqKRh5WjVVuixLnyohN
         X9O9IOPvV9QF626t3MG78HApZay+oqK7NQRJXPhQ=
Received: from DESKTOP-ZMX.localdomain ([115.156.143.0])
        by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
        id 8A61225E; Fri, 10 Mar 2023 22:34:38 +0800
X-QQ-mid: xmsmtpt1678458878ti79xj3r5
Message-ID: <tencent_BCFFDEDC763443B8582D3BBA01F0867B1406@qq.com>
X-QQ-XMAILINFO: MmpliBmRb3iCHKrUiuMBKXhk8DIR+AcjF3g4Y/USHl5yuSV7N5X4j0N+Pyg6Bc
         OBX2tZHYc/PKuF2AU1OlwvLZzmQBofQT8As3Yo8Y7f+SOrIZqqwAFv8KZGM+1aFAleOq40/rl88l
         BXKzUvflwm6nfPhwaNmMPGilwBdE/2LArJPdCWAORvfHPNslbYmkUWUPQAWmM6vhXreodK0iMG4o
         jAl7JvEnWvl6Rl028XIYIXBsM4FOAEhH6ffhkYCxygtaGOMXIyonpVL5NGpml9K67BtkD8i1+S0t
         V9unwNrVXd/YA9RuHX0sJs7CL8itSXPWKDPfDJ0YMncmzPgpNcvN2PtoOIHyAxwavAwOnMYT+zMf
         eCGi/OE21F7HLqaLQM3pthTieqgXg1yAxOVdK4HRTbr+YYaBI2es/OZ4MMuKdfiRvY8F+7NUvOaH
         VD71zX71+CtvztXWNeU4SBbW4Vdh326lTvxgekgqbZSIpQlAZTHPXSUHIBIljATjMWzIZTsYwt2z
         A7Riv2nuqlA8kyypdAIZA8naC8iD/zSh4Gy4uaL4+BDqG0hG9ZwU152i1phIEu3wnPRbfZrmxPra
         yyzJTeAuGrxcNveY2p6z43HdAjMsS3H4iblBl34ZcHMMH98JuenfkdT5pb1HkOcDl7pAMLCZOEjM
         tdZtTeif97kAphOQXS4UqE7Fnf9QbUSCnHcCFfh9yJGaKuiN5P7mkRpCfp4yzjPVCC6fBc1NnTWC
         o3lMw1b2g94umhUxqeY5UbyOPBbnBRlWPA3iilw290jplb3kknVKRGQVILAQbZ6dnfdCMqnKTqPa
         f4zOpyt7bCPyA+Cskd9/jA9bredfS1Tm0JTb/Pp8+i9aKu+VLezRBICL+LaWBZ3z+geN01CBETG8
         2pdBkxxPnbTjNvfRhW9/leK2yGm7Mn3N+AZcfW0Wr984qbgOJk8uWEH4jB2/mdsncNNFw7jQL3hO
         HZ12JJ8D957WwhdKGe+ESUiPe7jKlgZ6WfZtmqWILhA/fKpzujWw==
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nikita Travkin <nikita@trvn.ru>,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH 0/3] arm64: dts: qcom: Add device tree for LTE dongle UZ801 v3.0
Date:   Fri, 10 Mar 2023 22:33:27 +0800
X-OQ-MSGID: <20230310143330.9485-1-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is another model of msm8916-based LTE dongles made by Henan Yiming
Technology Co., Ltd..

Yang Xiwen (3):
  dt-bindings: vendor-prefixes: Add Henan Yiming Technology Co., Ltd.
  dt-bindings: arm: qcom: Add Yiming LTE dongle uz801-v3.0
    (yiming-uz801v3)
  arm64: dts: qcom: msm8916-yiming-uz801v3: Add initial device tree

 .../devicetree/bindings/arm/qcom.yaml         |  1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 ++
 arch/arm64/boot/dts/qcom/Makefile             |  1 +
 .../boot/dts/qcom/msm8916-yiming-uz801v3.dts  | 35 +++++++++++++++++++
 4 files changed, 39 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8916-yiming-uz801v3.dts

-- 
2.39.1

