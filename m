Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9D46BC471
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 04:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjCPDSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 23:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjCPDR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 23:17:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C014195E1A;
        Wed, 15 Mar 2023 20:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66DD3B81FAF;
        Thu, 16 Mar 2023 03:17:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725ABC433A4;
        Thu, 16 Mar 2023 03:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678936670;
        bh=Ihvqi4dHaV61z9aA3eusvLlgrX+DgyO9fJn8BOfg004=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hN5/b8trMcH37kTQUoSxSAWmlZADYsE14Z7ui0ZrNkA53FnJ3oxbJT0nlz5kDoD5y
         IaPlFbMa63LavnpjtAz0krGJe0Uw2xL/My8dPpoBh9tf42HJ7y3Lxn0OO6NGQm2vnq
         /SVtjCbMLL9Yu2Ie8YjaqEr5KVubzbQHlKF3BYnpqxPjjHWAjNQ1SL+dlatONbgsEm
         e54zCSzBRmnq0G30bp0MKUKaY2uPYofKGsHXFxBsdMINZhScxScaZhl1wScZjodkAo
         XfD1XsONo8Zc+eM7RHThhbWryWc3ZIk3EcmswQNClLIu7Zaj5fLkYMO1M0wo6EvIFE
         tCT+S2Llerblw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH 1/8] arm64: dts: qcom: sm8150-kumano: correct GPIO keys wakeup
Date:   Wed, 15 Mar 2023 20:20:54 -0700
Message-Id: <167893686410.303819.10219240132568263627.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
References: <20230304123358.34274-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 4 Mar 2023 13:33:51 +0100, Krzysztof Kozlowski wrote:
> gpio-keys,wakeup is a deprecated property:
> 
>   sm8150-sony-xperia-kumano-bahamut.dtb: gpio-keys: key-camera-focus: Unevaluated properties are not allowed ('gpio-key,wakeup' was unexpected)
> 
> 

Applied, thanks!

[1/8] arm64: dts: qcom: sm8150-kumano: correct GPIO keys wakeup
      commit: b26d66228e9744f4ac278d4fa891fc973b00dc6b
[2/8] arm64: dts: qcom: msm8998-fxtec: correct GPIO keys wakeup
      commit: d7f1f0fd7944b89d45accde9017095feab2b4675
[3/8] arm64: dts: qcom: msm8998-sony-xperia: correct GPIO keys wakeup
      commit: ff348b7d963a8b80502997bc266d47e31406db45
[4/8] arm64: dts: qcom: sc7280-idp: correct GPIO keys wakeup
      commit: aa03d854ad656ae214f7ebb13e7d95e436e99da1
[5/8] arm64: dts: qcom: sdm630-sony-xperia: correct GPIO keys wakeup
      commit: f06c0f2779e4567e3a83986646bdd7f63edfee17
[6/8] arm64: dts: qcom: sm6115p-lenovo-j606f: correct GPIO keys wakeup
      commit: d30f4d6de95ab05cec138929f54f5b92a394c68b
[7/8] arm64: dts: qcom: sm8250-sony-xperia: correct GPIO keys wakeup
      commit: 77a7e394287177b57ec14172a046819eec1a8e90
[8/8] arm64: dts: qcom: sm8250-xiaomi-elish: correct GPIO keys wakeup
      commit: df03c41673308006fab6ba71a8458b15a79181f6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
