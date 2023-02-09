Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460B568FF04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 05:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbjBIEcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 23:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjBIEba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 23:31:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2985B3401B;
        Wed,  8 Feb 2023 20:31:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E974B82007;
        Thu,  9 Feb 2023 04:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94788C433A8;
        Thu,  9 Feb 2023 04:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675916521;
        bh=sDXSnp0IG2nLtTC+Y0+XAyD+oj7jakrPvqPcZnwlaS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p0ZrfWd6GR+zhLDr+NJBYibtULnqSArVxsCEQNuVv7/0WhgbCd7B9HjJYwJg8EB9v
         xODVutyv5sGLlXp/mIRAPVpz49mP2gcmBwcalpdpA6FYCBCS7b7imJAAo3PWIReLIC
         rbPv7eylvWNY0uN8Fh3GuHyr0gcEqY+glZjkrx54PwI5iCxmzFczU76tB3V0XdBLMS
         uf4fW4rI6py3U4ynbVbDnYRRAE/7mvX8m76sgkZ78PfaDWfqxe3bh6CFSDbCa7/PLy
         RfzBCEIvzQSByTR/dSNfcIgfTTamXKpEXon+51K94HoGVil23jOEdCXcnbOEfuwD5h
         zDkEdBDXFFGJA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Rob Herring <robh+dt@kernel.org>, Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        phone-devel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Add support for some features on OnePlus One
Date:   Wed,  8 Feb 2023 20:23:17 -0800
Message-Id: <167591660372.1230100.18279259930296933606.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230122-msm8974-bacon-features-v2-0-06bb83c20a58@z3ntu.xyz>
References: <20230122-msm8974-bacon-features-v2-0-06bb83c20a58@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Feb 2023 21:40:13 +0100, Luca Weiss wrote:
> Add support for the vibrator, volume keys, hall sensor, backlight and
> notification LED to the device tree of the OnePlus One smartphone.
> 
> 

Applied, thanks!

[1/5] ARM: dts: qcom: pm8941: Add vibrator node
      commit: 3d2cc00d6d4e552c9bb4a77b6155104185e8d58f
[2/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add vibrator
      commit: b2f82484c5216af9a227a567c31fe03934e05ee4
[3/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add volume keys and hall sensor
      commit: de0520a6e27299c6a893c01aa5bb098810ef7349
[4/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add backlight
      commit: 44244ed2a95956b9ac1c3e6c7ffd77c88fac05bd
[5/5] ARM: dts: qcom: msm8974-oneplus-bacon: Add notification LED
      commit: 3835f9a0cf56fab884d3072a991482c1f222c942

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
