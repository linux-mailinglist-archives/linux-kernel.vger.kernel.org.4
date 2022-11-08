Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA5D6205ED
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 02:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiKHB2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 20:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233298AbiKHB2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 20:28:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E742AE12;
        Mon,  7 Nov 2022 17:28:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 308BBB81711;
        Tue,  8 Nov 2022 01:27:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D5AC4347C;
        Tue,  8 Nov 2022 01:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667870877;
        bh=IS8r4265qntSOAdEhp1YIe8QGcNP2ABXBfe8fRSQtmY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kv5Bn8g+Sv4EUVJg/LEJr1dHEqzm88nZZpFJlTfP8TvNNsi4aoghxhR8TxQWsHaPz
         0M5hadlOzxWeApyzY1q6DF/mN3Ygk0w20pLPhnHF6zstvG4F9KANe6ToN1fgXnCsqc
         r4183khyX2ykFFpUbCTIMXdTUg13wv/z5JlS3AdB9vJ3CtLvVaiWciBCd7p9EAtOR0
         MW/ARYnatE27aVBMDDkOh+kjbBe026cwaCHyCGLhYFbMq16XFx40cGlJJJEUhDLHkU
         co1G0+r/dHF3FSy7bxfxSwZ/IEnedKwYRFNeqEC8uuXrPjJQ00GnppqfZlkftPKqSE
         hBCWbmwC++dLA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     luca@z3ntu.xyz, linux-arm-msm@vger.kernel.org
Cc:     lars@metafoo.de, devicetree@vger.kernel.org, robh+dt@kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        krzysztof.kozlowski+dt@linaro.org, afd@ti.com,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: iio/adc: qcom,spmi-iadc: use double compatibles
Date:   Mon,  7 Nov 2022 19:27:29 -0600
Message-Id: <166787084684.599230.11552570406621990817.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221031182456.952648-1-luca@z3ntu.xyz>
References: <20221031182456.952648-1-luca@z3ntu.xyz>
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

On Mon, 31 Oct 2022 19:24:54 +0100, Luca Weiss wrote:
> As in other bindings, let's use specific compatibles together with the
> fallback compatible. Adjust the bindings for it.
> 
> 

Applied, thanks!

[2/2] ARM: dts: qcom: pm8941: fix iadc node
      commit: f659cd2770767c5ceabadace1b334df9de468eae

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
