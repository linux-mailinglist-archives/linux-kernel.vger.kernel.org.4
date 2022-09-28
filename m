Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7395EE236
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 18:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbiI1QqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 12:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiI1Qpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 12:45:34 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C233C8DA;
        Wed, 28 Sep 2022 09:44:48 -0700 (PDT)
Date:   Wed, 28 Sep 2022 16:44:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1664383486; x=1664642686;
        bh=o11CrCXx0Cb6C3dCffIEI1V7Knf/291iZPlpw60/k7s=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID;
        b=II4PFDatDgvVCAc5JpwIoJeo0c6RfoQ/A64+1axy28EsmTCGy3tr1leeMjjzjzFhk
         HlGjrqEX3DMn37lrTPHD9jIiWc4Nb7McgxfTELycQdnYXsiRU3zMRTT8nQWnMsCJHh
         2JQQfA9VAKCR5SaqInad3H3dYtmCM5BHZxLjSq+B3ICMjbqaazWNhMU+GimDYDWUG7
         1tkZeaPqizUHUKpem8Fi4tYWUU6f2v0qnOrs/xodI+4S8kArs+TJ49SshZTRN/iy18
         O9uyx0wL+8j1Ww1laS3/1tQmLrToy7D3Twbk8f+/CQWjTOUtOeuN6/i//s2nTntY+2
         tECKquGX0Qz9w==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Josef W Menad <JosefWMenad@protonmail.ch>,
        Markuss Broks <markuss.broks@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v3 0/5] arm64: dts: qcom: msm8916-samsung-j5: Use common device tree
Message-ID: <20220928164427.178837-1-linmengbo0689@protonmail.com>
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

