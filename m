Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9E76BC110
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbjCOXcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232894AbjCOXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:32:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B438617C;
        Wed, 15 Mar 2023 16:32:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49D6CB81F96;
        Wed, 15 Mar 2023 23:32:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C12FC43444;
        Wed, 15 Mar 2023 23:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678923135;
        bh=OAik14BnMmwph4fEKz+U+KG2WDfyPByRjtabEvk+jUE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gfWLRnhHyZO1ueLmlxNeN2YvMbXKtST+ofN318zelfo8UHxDtyicS2L1Kty+QRUxg
         A43e32CsKRnnN4c7G4o9Q1MPtRodm9A3yLODC9IQLetdTgG1ZGAJijANk5T3KSgDI9
         HzoXqU6I5Cz0LZWMibaxR7tku54icuUscIuFJTRPCfdajRfZ6DSXdbBDP/TukfhFuX
         j3hkIWNmRLZPcYsA7ax5H2qVMLc2WIh0nz0p8gyGt3Z3So4W8xTdCuCBKljPMTNrW7
         Plr9WR0TS8yZLQQApudcYLIr4jOfy+uEo5Fqt6Xs1CVdGLOO1tu4FaM82SEY+VN6ZT
         MlyEGUfYaoJDg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8150: fix the uart9 label
Date:   Wed, 15 Mar 2023 16:34:45 -0700
Message-Id: <167892332567.4030021.14244359647184839384.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315202751.1518543-1-brgl@bgdev.pl>
References: <20230315202751.1518543-1-brgl@bgdev.pl>
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

On Wed, 15 Mar 2023 21:27:51 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There's a typo in the @<address> part of the uart9 label. Fix it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8150: fix the uart9 label
      commit: 9ebaa4a8cdf11831090a7a7e8d5e82e12b4ff7a8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
