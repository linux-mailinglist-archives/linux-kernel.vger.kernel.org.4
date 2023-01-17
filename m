Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165DD66E6CD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 20:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjAQTRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 14:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232517AbjAQTKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:10:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E9823EFE5;
        Tue, 17 Jan 2023 10:24:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF2F0614FF;
        Tue, 17 Jan 2023 18:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D776C43392;
        Tue, 17 Jan 2023 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673979880;
        bh=RIaZFAO0OsIISDYJgw5XnaM2yGAXBtLRfHwKCCLuL6E=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aQtakGJ0FhykbY1KpOieEhVOCkQvsamzgcGUsd0uoQ9Fc2+hXU5v+gWjo0ITZ57RB
         ZIqeNeKnmz12TsV+nnD78zBe6OrgOx8m7QCyGG1VNidKGp7GFVTtuau57EnNrNXpUR
         CG9/bowbr86TpeJRRaQKCDiPXTP3AiBz5lVB5MDWuNt1yrd2EE5rDUJyoPXCnaYsfl
         Opn4ZaqZtbGMI/zU4TxDKrzwqlGgMnHEt40fji4b8flyMWMo36BqX0VjjKniIFNp2C
         eMa/DdGReJuH27inJAv+QNZRYndXuOpo+T64n69vU8qtAHZjbdeEa1i/QuL1jhJsJ1
         7oBZJj34jK8FA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        agross@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8350: drop unused dispcc power-domain-names
Date:   Tue, 17 Jan 2023 12:24:25 -0600
Message-Id: <167397986255.2832389.9734241939317325667.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221227163158.102737-1-krzysztof.kozlowski@linaro.org>
References: <20221227163158.102737-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 27 Dec 2022 17:31:57 +0100, Krzysztof Kozlowski wrote:
> Display clock controller bindings do not allow power-domain-names:
> 
>   sm8350-hdk.dtb: clock-controller@af00000: 'power-domain-names' does not match any of the regexes: 'pinctrl-[0-9]+'
> 	From schema: Documentation/devicetree/bindings/clock/qcom,dispcc-sm8x50.yaml
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8350: drop unused dispcc power-domain-names
      commit: 2aa8c53eb8d711b694545b4eec7f248d50116b8c
[2/2] arm64: dts: qcom: sc7180-trogdor: align DAI children names with DT schema
      commit: eef26fb45b6a8d8f68bbfce67db0dfc5fad2946f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
