Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D572672D00
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbjARXxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbjARXww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:52:52 -0500
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 18 Jan 2023 15:52:07 PST
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732F24617C;
        Wed, 18 Jan 2023 15:52:04 -0800 (PST)
Received: from fedori.lan (c3e47541.dsl.pool.telekom.hu [::ffff:195.228.117.65])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000642EF.0000000063C884ED.0028DB16; Thu, 19 Jan 2023 00:46:52 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 0/3] Add tri-state-key for oneplus
Date:   Thu, 19 Jan 2023 00:46:35 +0100
Message-Id: <20230118234638.189098-1-soyer@irl.hu>
X-Mailer: git-send-email 2.39.0
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gergo Koteles (3):
  Input: gpio-keys - add support for linux,input-value dts property
  Input: add ABS_SND_PROFILE
  arm64: dts: qcom: sdm845-oneplus: add tri-state-key

 Documentation/input/event-codes.rst           |  6 +++
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 43 ++++++++++++++++++-
 drivers/hid/hid-debug.c                       |  1 +
 drivers/input/keyboard/gpio_keys.c            |  3 ++
 include/uapi/linux/input-event-codes.h        |  1 +
 5 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.39.0

