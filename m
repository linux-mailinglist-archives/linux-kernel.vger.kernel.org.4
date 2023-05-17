Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559247070A6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjEQSVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEQSVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:21:52 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20691739;
        Wed, 17 May 2023 11:21:48 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QM1dz0p6hz9sm8;
        Wed, 17 May 2023 20:21:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1684347703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JZFA1fokFB4103V8XqAdq7PRJrsJa9ZW4IaScwv4dpM=;
        b=i5afpNj+4tAaMSY8vlNVHk+zeq6oDydbw0sned08JSk0QG2ULlRKKZJE2Lfw1Nc8hku5RW
        QEHTWDL/cXPZstB7f8ffijGwCBi8oHdKaGhLc7yuukO/3YUT3xf9LcNqMab80kew57vjOM
        Ng+q4WLNmZXazxiZ7gMaMsXFkcd3ZavPNT2NO8HOCj+VHbDRcE10Efhx0RsyqzC+5PNEbN
        jQWyVA92TPb8aevE2DqqR86SkqFAz+f5AAbckMMWHPfZC9yken4oCxIhPRTj7ARrsm4YDy
        nJtW6LwIh3sMuFP5j4aC+xSRYvaqdXYWdE/Kw/YoSYj0cj9/4+gPiO84qUDvlw==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com, Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH 0/2] arm64: dts: qcom: pmi8998: add and enable flash LED
Date:   Wed, 17 May 2023 20:21:31 +0200
Message-Id: <20230517182133.72590-1-me@dylanvanassche.be>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qualcomm PMI8998 has support for 3 flash LEDs which got support in [1].
Add this driver to the PMI8998 DTS and enable 2 flash LEDs in the SHIFTPHONES SHIFT6mq 
smartphone. This smartphone has a white and yellow flash LED.

[1] https://lore.kernel.org/all/20230507172941.364852-1-me@dylanvanassche.be

Kind regards,
Dylan Van Assche

Dylan Van Assche (2):
  arm64: dts: qcom: pmi8998: add flash LED
  arm64: dts: qcom: sdm845-shift-axolotl: enable flash LED

 arch/arm64/boot/dts/qcom/pmi8998.dtsi         |  6 +++++
 .../boot/dts/qcom/sdm845-shift-axolotl.dts    | 22 +++++++++++++++++++
 2 files changed, 28 insertions(+)

-- 
2.40.1

