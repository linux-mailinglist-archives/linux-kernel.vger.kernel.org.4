Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6826C691451
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 00:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjBIXZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 18:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIXZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 18:25:27 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C706520059;
        Thu,  9 Feb 2023 15:25:25 -0800 (PST)
Received: from localhost.localdomain (51b6913b.dsl.pool.telekom.hu [::ffff:81.182.145.59])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 000000000006F729.0000000063E580E2.002B657E; Fri, 10 Feb 2023 00:25:22 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
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
Subject: [PATCH v2 0/3] Add tri-state-key for oneplus6
Date:   Fri, 10 Feb 2023 00:25:09 +0100
Message-Id: <20230209232510.91431-1-soyer@irl.hu>
X-Mailer: git-send-email 2.39.1
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

V1 -> V2: rebase to qcom/for-next

Gergo Koteles (3):
  Input: gpio-keys - add support for linux,input-value dts property
  Input: add ABS_SND_PROFILE
  arm64: dts: qcom: sdm845-oneplus: add tri-state-key

 Documentation/input/event-codes.rst           |  6 +++
 .../boot/dts/qcom/sdm845-oneplus-common.dtsi  | 39 ++++++++++++++++++-
 drivers/hid/hid-debug.c                       |  1 +
 drivers/input/keyboard/gpio_keys.c            |  3 ++
 include/uapi/linux/input-event-codes.h        |  1 +
 5 files changed, 49 insertions(+), 1 deletion(-)


base-commit: 02ac8d2a011b630481d959298a1cc76ca0717f3e
-- 
2.39.1

