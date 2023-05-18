Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A52707A20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjERGON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 02:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjERGOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 02:14:12 -0400
X-Greylist: delayed 42739 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 17 May 2023 23:14:08 PDT
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B4E52;
        Wed, 17 May 2023 23:14:08 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QMKRv56gYz9sqc;
        Thu, 18 May 2023 08:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1684390443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qj2hNQs6e7b9/J4YVNaFwfq4+eID2dfYLuBUt5E1CTQ=;
        b=u5tpKkEM9Ko03m5ukA/ywrnNrNAPDQE+a1ees3WzNC9tuAIDpBok8xWUGMIEJIYmjG6091
        1paXPVNfgR3m9eBjBi5jn4WnHWqhlPgEPHG9F/xdCV/Gc5nAt+lNdSaUBbFECSTdHTwsLt
        CEvmuaKin2cAMA3qtFopZ5Lx1d9IY6VMrWN+p/wznugPeRpRvxhOL71bRoLrJdhI+S82BB
        ABr15kzOHc2GIPLixU0/l4bPiQD4X+CKPz2x3TYUhUM6C6jSFnOCo5KzWPryqTiDNiYqLI
        2U40TcLXMBRDB+7N8qga8C+LcnEcl44B4xv962/nliK/u9NEFAWBVuGgu9v3CQ==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com, Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v2 0/3] arm64: dts: qcom: pmi8998: add and enable flash LED controller
Date:   Thu, 18 May 2023 08:13:25 +0200
Message-Id: <20230518061328.146847-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm PMI8998 has support for 3 flash LEDs which got support in [1].
Add this driver to the PMI8998 DTS and enable 2 flash LEDs in the SHIFTPHONES SHIFT6mq 
smartphone. This smartphone has a white and yellow flash LED.

* Changelog *

Changes in v2:
- Document compatible for PMI8998 to fix missing compatible in DTS.
- Improved commit messages, following [2]

[1] https://lore.kernel.org/all/20230507172941.364852-1-me@dylanvanassche.be
[2] https://lore.kernel.org/all/20230516150202.188655-1-krzysztof.kozlowski@linaro.org/

Kind regards,
Dylan Van Assche

Dylan Van Assche (3):
  dt-bindings: leds: qcom,spmi-flash-led: add PMI8998
  arm64: dts: qcom: pmi8998: add flash LED controller
  arm64: dts: qcom: sdm845-shift-axolotl: enable flash LEDs

 .../bindings/leds/qcom,spmi-flash-led.yaml    |  1 +
 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  6 +++++
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 22 +++++++++++++++++++
 3 files changed, 29 insertions(+)

-- 
2.40.1

