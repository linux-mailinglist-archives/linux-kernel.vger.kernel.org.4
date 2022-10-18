Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1DF6021BD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbiJRDGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiJRDG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7368C8C45D;
        Mon, 17 Oct 2022 20:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F734B81BDF;
        Tue, 18 Oct 2022 03:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E37C433C1;
        Tue, 18 Oct 2022 03:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062382;
        bh=U3bFSldK5eRU95745OnbpVJJ8fIfAVmYz4B+/TV+g0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cmm0LgVXJcAS+TP+kaL41MOlO2zFUxt0/53A90h11TPwUhMZeHomwmCLIXulgUlgw
         7v4PRcNysWi98dkPDujByOIVYUUtjEzO2VXQdr+FK6G8j5GV3pvjK6qgeNUig8eR5o
         /Udkjq4zx9W4/DqWyynpHeVvTc81PnUcgeLJ1xPVLIXSgu+4kc6uJicB9nHwSWKjzT
         EH+HzpVauFgtbMBgrGLauD1JX2PJMuuKJT5mUDV/gKLLFsXr14qRpU03p5HPvgbAcW
         xjdMJ0fsiF7WHwiFENP5IN2SuInevLUQR4/Y/8gexbG/wB60klnmdJun6vKZIcoz1m
         pUsaZ/GZ8tOVw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, robh+dt@kernel.org,
        agross@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/4] arm64: dts: qcom: Lenovo Yoga battery and DP support
Date:   Mon, 17 Oct 2022 22:05:04 -0500
Message-Id: <166606235848.3553294.11965467834048068065.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
References: <20220810035424.2796777-1-bjorn.andersson@linaro.org>
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

On Tue, 9 Aug 2022 22:54:20 -0500, Bjorn Andersson wrote:
> This series introduces support for battery and external display on the Lenovo
> Yoga C630.
> 
> Enables implementation provided in:
> https://lore.kernel.org/linux-arm-msm/20220810030926.2794179-1-bjorn.andersson@linaro.org/T/#u
> https://lore.kernel.org/linux-arm-msm/20220810030500.2793882-1-bjorn.andersson@linaro.org/T/#t
> https://lore.kernel.org/linux-arm-msm/20220810035013.3582848-1-bjorn.andersson@linaro.org/T/#t
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sdm845: switch usb_1 phy to use combo usb+dp phy
      commit: d6838f267f16189a8c1954a7a6bfa36fb79896f7
[2/4] arm64: dts: qcom: sdm845: add displayport node
      commit: eaac4e55a6f419541da4983cd6d36f5d5de658ec

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
