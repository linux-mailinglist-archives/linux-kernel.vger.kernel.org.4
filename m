Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB987082BB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjERNbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 09:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjERNbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 09:31:33 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B84FE;
        Thu, 18 May 2023 06:31:30 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4QMW8Z5gf5z9sbP;
        Thu, 18 May 2023 15:31:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dylanvanassche.be;
        s=MBO0001; t=1684416686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BYYC753MdUNsI3e8pjfC0ipVhim97KERMV0n3XYIbQU=;
        b=TQ/Jbr9NYTiqNzy3J5xFj7wjV3GMgq8Il5hco8tG/l9qOUbRE+emWoSKoA5q5LVEJaJUdd
        CRMsNgjc+3OBaHa66VBSl9f+il6JF0QQx8OIw9lfHuNLmJqwe+KhFKCPQC9sK0qfxek3q2
        52eToyTuQOYIRr+nQMDBF9h12SF09S3S6c3f/HHipmc1SDNmC93Yb3ofuBelseIi6USOrM
        B3MQoEukn1a/sXPXg+Li7bVHq066iV4HiHTH4xhVjbIz/0dpehcQBzEM8JpXpvr1fo8oQ4
        uxh243+7ngACBKCtAgSSisTeky68MWEPHM3O2unzMH1+/oU67bXwJ3ILLNOUww==
From:   Dylan Van Assche <me@dylanvanassche.be>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        pavel@ucw.cz, lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_fenglinw@quicinc.com
Cc:     linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        amartinz@shiftphones.com, Dylan Van Assche <me@dylanvanassche.be>
Subject: [PATCH v3 0/3] arm64: dts: qcom: pmi8998: add and enable flash LED controller
Date:   Thu, 18 May 2023 15:31:10 +0200
Message-Id: <20230518133113.273880-1-me@dylanvanassche.be>
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

Changes in v3:
- Adjust led-max-microamp and flash-max-microamp to better match downstream.
- Add Acked-by and Reviewed-by tags

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

