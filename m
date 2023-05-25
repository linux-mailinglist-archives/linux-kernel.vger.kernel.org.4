Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE357104BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbjEYEzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239470AbjEYEyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E901732;
        Wed, 24 May 2023 21:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2E49642A8;
        Thu, 25 May 2023 04:51:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8648BC433D2;
        Thu, 25 May 2023 04:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990307;
        bh=ez3D8fuLcI2F25obBylshOkOWazf7BuCNrxi08ePRHE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GDKSJazXp7/jKYoPuCF3/6GgslIvVeVomdz7IktiG7XzzyKqXB8x56hAnJaJNTDJL
         uD2mR+OSvrtdE0n/FIzbsEfh8nSgkB9ZBHQIku56WpWmHqU7ARa4WXolLTZWLCJdEm
         4rYfMu0uS8EHbQNgKRFcbuHUJr3jizhMiDLbImFtkePIUMATg62HqQq7+RkXTkYkB8
         PrPRTlbOUEcOxQ6NPqxzKkVm5/y8/es2DBF+9AZG0tkLZtEXSEAbJtVJhFBRdilrB1
         /SIETI55rhB6fct9Cz/GOz7R+IDqlo54g4Ykue6dxksLV+k1FMjAtd2gg3EZFYwcmC
         tQIHaqgUaapTg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Luca Weiss <luca@z3ntu.xyz>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: (subset) [PATCH v3 0/3] Add PMI632 PMIC and RGB LED on sdm632-fairphone-fp3
Date:   Wed, 24 May 2023 21:54:25 -0700
Message-Id: <168499048187.3998961.2050518696021366636.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
References: <20230414-pmi632-v3-0-079d2cada699@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 22:41:27 +0200, Luca Weiss wrote:
> Add support for the PMI632 PMIC in the spmi-gpio & qcom-lpg driver, add
> the dtsi for the PMIC and enable the notification LED on fairphone-fp3.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: Add PMI632 PMIC
      commit: a1f0f2ebb044c7248c3f30b98de0f151505bd4bd
[2/3] arm64: dts: qcom: sdm632-fairphone-fp3: Add notification LED
      commit: 0c4f10917d22e6f36080617bfe71de1ae854ee58

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
