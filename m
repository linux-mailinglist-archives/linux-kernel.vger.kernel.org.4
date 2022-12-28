Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF6B6572CB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbiL1Eiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiL1EhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4618FDFB3;
        Tue, 27 Dec 2022 20:37:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB0E8B81253;
        Wed, 28 Dec 2022 04:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0C7C433F0;
        Wed, 28 Dec 2022 04:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202231;
        bh=eQo731r6J0vnUhIuGi+fzinVFg0BIeIGdcqK/dDED64=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNBcsgsEdH6Z6uTekQCGf5m6MTbA+QtS6PDv4oHXJSD0j2suKLyMzTRz/ntnCkq/b
         G+2Qquzb/g50mAZrNOIzZ0652X8YP8xM4HxE9nWDM91px72yNPzrunpTRl1NWuQomi
         1W6eXRAcT0fU0FfL+h7Oi7na/lm1+jO/lxX93gmsQjoBPt+Pd0geGUg+OMCSaqIdBS
         g0TL40c0RwCoGYJSUgqueITM9z6xtFPc40CAxPonrBD49NEBEByrhadUHXaWThAYxO
         sxPZeA0g6DzRcKeZkBSW3abmfFAE7u7NvCbRiMy5WXh3WskYmZFMm0AaNHtBpMY1Y6
         +9/Sr484AqF3g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, linmengbo0689@protonmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, nikita@trvn.ru,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org, stephan@gerhold.net,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH v6 0/4] arm64: dts: qcom: msm8916-acer-a1-724: Add initial device tree
Date:   Tue, 27 Dec 2022 22:36:46 -0600
Message-Id: <167220221216.833009.15491800760089839147.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221123033524.148682-1-linmengbo0689@protonmail.com>
References: <20221123033524.148682-1-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2022 03:37:15 +0000, Lin, Meng-Bo wrote:
> v6: Fix incorrect commit message and newlines in touchscreen.
> resend: Fix incorrect in-reply-to
> v5: Add touchscreen.
> v4: Sort properties in l11.
> v3: Set property status = "okay"; as the last property.
> Reword the bindings patch.
> v2: Fix a typo in dt-bindings commit message
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: qcom: Document msm8916-acer-a1-724
      commit: 17c073500e9060281a115e34b00424d486be9450
[2/4] arm64: dts: qcom: msm8916-acer-a1-724: Add initial device tree
      commit: 0fbf49b3eac98495c1c75ea16019e5613cda109b
[3/4] arm64: dts: qcom: msm8916-acer-a1-724: Add accelerometer/magnetometer
      commit: 85e0a0f8bfa42dc05b7d89798df6fbc2c13147a6
[4/4] arm64: dts: qcom: msm8916-acer-a1-724: Add touchscreen
      commit: 7b8847e9d56f5e397b37df63f271f3166a09f3a8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
