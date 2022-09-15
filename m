Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8B25B9342
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIODha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiIODhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:37:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AA992F6E;
        Wed, 14 Sep 2022 20:37:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D123B81D09;
        Thu, 15 Sep 2022 03:37:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1343C433B5;
        Thu, 15 Sep 2022 03:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663213033;
        bh=HAnqVuTXs/olzlkIfnFHXyRyiJPlRWsk1Jmvd26k2Dc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=AhPURUUuJr+rfHq6DMs0HbUQOCG+R1dKm3wPn4LqybYTuuuLpcUB5olKGB4p/VFIm
         v7tQeZ5LGeLhk/om9VWaWibqTBWCcYzL6o8yyFQLILXN4u8qjdlS67PeP3+PG/Gs8r
         7sYXplZStKq+k57QGXoVhUPvssrtk7ycZBAa0jOgVWcGkWoF7qLHyGRKVGkRHDlJYG
         1ucRFnc/bHFfqsVQxQJmrITJVKfX+fziICowyzaJGahAiALU1XTT5IVyAyybp9Ai1M
         TtY/0dv1JHr6hwoM6M4+0rAfk5PbFuo74lg1OLBXsMhmbPnmWsNvOEZWStPO6vIgmY
         UQcqJ4dEzbSMg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org
Subject: Re: (subset) [PATCH 1/5] arm64: dts: qcom: pmi8994: add missing MPP compatible fallback
Date:   Wed, 14 Sep 2022 22:36:55 -0500
Message-Id: <166321302065.788007.14702217477325546051.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220908081050.29751-1-krzysztof.kozlowski@linaro.org>
References: <20220908081050.29751-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Sep 2022 10:10:46 +0200, Krzysztof Kozlowski wrote:
> Bindings require usage of generic MPP fallback in compatible:
> 
>   qcom/apq8094-sony-xperia-kitakami-karin_windy.dtb: pmic@2: mpps@a000:compatible: ['qcom,pmi8994-mpp'] is too short
> 
> 

Applied, thanks!

[1/5] arm64: dts: qcom: pmi8994: add missing MPP compatible fallback
      commit: 8cd012f75178c4dffe8df692aa991e829286a8d4
[2/5] arm64: dts: qcom: msm8994-msft-lumia-octagon: align resin node name with bindings
      commit: 308ff92e77aa2febec9b81b6917ebb0f38da8cb5
[3/5] arm64: dts: qcom: msm8996-xiaomi: align PMIC GPIO pin configuration with DT schema
      commit: b94d7c1fc7c6ac4e2ce83e9fc6a84fc3034b631c
[4/5] arm64: dts: qcom: sa8295p-adp: add fallback compatible to PMIC GPIOs
      commit: afa774bc17e607ef98cc660657cf5208a39591a2
[5/5] arm64: dts: qcom: sa8295p-adp: add missing gpio-ranges in PMIC GPIOs
      commit: aa510b0c1fa34338babbde366b2c98b9b39aa282

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
