Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2E65EE22C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234349AbiI1Qns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbiI1QnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:43:15 -0400
X-Greylist: delayed 14595 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 28 Sep 2022 09:43:14 PDT
Received: from mail-4324.protonmail.ch (mail-4324.protonmail.ch [185.70.43.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8593CE7C30;
        Wed, 28 Sep 2022 09:43:14 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:42:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664383392; x=1664642592;
        bh=o11CrCXx0Cb6C3dCffIEI1V7Knf/291iZPlpw60/k7s=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=ND23sbLU5butRIwTVoikUa3Do09MRayFc/fZy7pOzj6blGZpLrAi+l0RdLDt/Tfg3
         ZtC0BTVOi6HFR9+lGHvI89FZHbxUaBdr1e8QVkuuwMKLBviG8wqdL9EQRipnCK3pOT
         Fddlv1pQ8vX01hH3JNrZGvRffOEoED7GCAgYrQjpM77tE6fDg2+mAumE+6H5ZUs8Cv
         b6xDdIFkXvbX8TIAONXVHUkYiyg2rsjVQXPbW5WrK4CxcDdoT5LIbw3X7mf8YmlLAo
         jW9SJvtbULhGgM5jHteaN0uWo8Sw9DJYc6qzhIp/P4sust8ooYioLHcD0gDoOCY7pe
         P5nim3cXZgqfQ==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 0/4] arm64: dts: qcom: msm8916-samsung-j5: Use common device tree
Message-ID: <20220928164243.178777-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3: Drop msm8916-samsung-j5.dts temporarily before moving it.
Minor rewords.
v2: Reword and resend. Split common dtsi patch.
Add missing suffix state in pinctrl.

The smartphones below are using the MSM8916 SoC,
which are released in 2015-2016:

Samsung Galaxy J5 2015 (SM-J500*)
Samsung Galaxy J5 2016 (SM-J510*)
Samsung Galaxy J3 2016
- SM-J3109/SM-J320Y/SM-J320YZ
- SM-J320N0/SM-J320ZN
- SM-J320P/SM-J320R4/SM-J320V/SM-S320VL

Add a common device tree for with initial support for:

- GPIO keys
- SDHCI (internal and external storage)
- USB Device Mode
- UART (on USB connector via the SM5703 MUIC)
- WCNSS (WiFi/BT)
- Regulators

The three devices (some varints of J3, all other variants of J5 released
in 2015 and J5X released in 2016) are very similar, with some differences
in display and GPIO pins. The common parts are shared in
msm8916-samsung-j5-common.dtsi to reduce duplication.

