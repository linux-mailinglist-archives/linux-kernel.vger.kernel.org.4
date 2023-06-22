Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FACF739519
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 04:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjFVCET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 22:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFVCES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 22:04:18 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387211735
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 19:04:17 -0700 (PDT)
Date:   Thu, 22 Jun 2023 02:03:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687399453; x=1687658653;
        bh=/cve8Q6U6rQp6Q0xdA16Ihm8oDULhwZvYL+WJ6ax/6Y=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=s9LG+7vpA7ypY/BCUDmB+frs8jhsUVlCoKiGifnrNogAmLivjy6H1BXCmrGvZlIBL
         VjxFtDDRACIoxgwI0TCKXC9cwMVjmMU7aAmxGTNWqJSszy9oUQWk2bw7MFo+MgEbxE
         wx5kS7N7ud6diG6ZFAjVpYbL8Y92D8jfo5WC8pbEyfHtaM402S0//vBjcMxsBjooDI
         UtCn8kpll+yYDFep5YId/93pdn+x4RONmF0Ji3MlUD6szDkUMf4pxAF6LLFTcDpoeR
         6n8WuXTgzmJfVCYfMBeUHzeKb2vW3SQaoCe80s4hl4vAGJCeO1CofCkTFexAsguPKp
         UVuXQMSkH/mAg==
To:     linux-kernel@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 0/8] arm64: dts: qcom: msm8939-samsung-a7: Add initial dts
Message-ID: <20230622020344.65745-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This dts adds support for Samsung Galaxy A7 smartphone released in 2015.

Add a device tree for A7 with initial support for:

- GPIO keys
- Hall Sensor
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5502 MUIC)
- WCNSS (WiFi/BT)
- Regulators
- Touch key
- Accelerometer/Magnetometer
- Fuelgauge
- NFC
- Vibrator
- Touchscreen

