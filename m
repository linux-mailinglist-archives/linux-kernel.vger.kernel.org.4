Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBF96572DB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiL1EkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbiL1EiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:38:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14717F005;
        Tue, 27 Dec 2022 20:37:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F2ABB8125D;
        Wed, 28 Dec 2022 04:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF2BC433F1;
        Wed, 28 Dec 2022 04:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202242;
        bh=qmTIPcc5k/0rl87F3qFtbj0b4DMAy7wPQEMd2iI2M9g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxP8HBOwOocWQECHkCZG7SwhMMgf4AEA6w3uXzWd1uLUeksbdJg6/wQta8rBkNev1
         IhXvW5o7l63mIWpH4thHVifiDwwoY5NIs51n541MEGQWNslu/FIFHP5VbXgCFzO2qR
         gZ7h82vA6tl8w/973LaoXFlPsQYSILMye0KoA3FiTkHJIoz+t3OCs5+qL+gxwkT4XG
         W3DocCb39ETJtSN7k3pO8qul3vnKh8fFbBMLzKl+TTMWocjgS9Ms/Uvco69/Jky1sZ
         rHk6GOccubuc58PGygXscGanT372eaFDaeBq06wtj5Xvv7CqFvTcdp27oXdGXp/Lnt
         Zo88UrE2/Ww6w==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, srinivas.kandagatla@linaro.org
Cc:     konrad.dybcio@somainline.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] arm64: dts: qcom: sc8280xp: add audio support
Date:   Tue, 27 Dec 2022 22:36:56 -0600
Message-Id: <167220221217.833009.5730063788271218487.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221123104342.26140-1-srinivas.kandagatla@linaro.org>
References: <20221123104342.26140-1-srinivas.kandagatla@linaro.org>
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

On Wed, 23 Nov 2022 10:43:39 +0000, Srinivas Kandagatla wrote:
> This patchset adds audio support for sc8280xp Lenovo x13s.
> Support for Headset Playback/Capture, Speaker Playback and DMIC is
> tested.
> 
> A prebuit ASoC topology file available at
> https://git.linaro.org/people/srinivas.kandagatla/audioreach-topology.git/tree/prebuilt/SC8280XP-LENOVO-X13S-tplg.bin
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sc8280xp: add gpr node
      commit: e73defb2deee74f3f4988196bf0c21782dffa415
[2/3] arm64: dts: qcom: sc8280xp: add SoundWire and LPASS
      commit: c18773d162a63f65024e80ae355e3fbc923e7255
[3/3] arm64: dts: qcom: sc8280xp-x13s: Add soundcard support
      commit: f29077d8665221ba2802a29ee7bd9fcef66cde81

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
