Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D995D60220D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiJRDJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiJRDIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:08:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475889AF94;
        Mon, 17 Oct 2022 20:07:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0605B81C63;
        Tue, 18 Oct 2022 03:07:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095C8C43147;
        Tue, 18 Oct 2022 03:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062419;
        bh=ZNARmTPC1srI3y8ng8vzEqhDpuNGJbK9Zs+b5BMHmBQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=GE8L+6K2L8fG9D38efXLe7zaEXuI8yeVO3QM/MzvK5nVE/tZNA7jgPzcEngVHU5GW
         XdM81QxZacNCmzm6hYXEW8j+vF7lxUr9TjOhu82GYMjJcsHRftHdhqANVf58dW2uHI
         hqmiQJDjLtUbtTbVtyKzG5OuEJJdJ0pt/6lPO9n8zj70KV4xJptacWXCUhvSyviJco
         H1Homf5mnw3OqNu5D7zjSAR7nLwPYCutybkceKxZ1dg0amucuwEB1PvjujfxhVzVd9
         sOW5eHQPvqMgyDP89PcW9KROh/pcAdqz6+7svOi9JMvVGfU6Nn4XhkgL8oLt3apQRU
         LPNDCaAlyqxfw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: correct white-space before {
Date:   Mon, 17 Oct 2022 22:05:33 -0500
Message-Id: <166606235847.3553294.5825428739627391651.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220919163333.129989-1-krzysztof.kozlowski@linaro.org>
References: <20220919163333.129989-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Sep 2022 18:33:33 +0200, Krzysztof Kozlowski wrote:
> Add missing space or remove redundant one before opening {.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: correct white-space before {
      commit: c24c9d53e001a38ac1637674304987ab061a38eb

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
