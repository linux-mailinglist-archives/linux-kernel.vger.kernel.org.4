Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D32715283
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjE3AMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjE3AMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0DCD9;
        Mon, 29 May 2023 17:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4CD162917;
        Tue, 30 May 2023 00:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9283FC433D2;
        Tue, 30 May 2023 00:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685405559;
        bh=msPrcnJSgNCQtqeT+hSr1SNGfu6h2JevdDkGn3rRsug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RoQiMSR28K+Bu/nutrwh0vzTaVTJcDzx7H2G6kYE4zv5y4nTVC0dwYnUHMwYGcsPf
         B+iUS+BgMRZ5URniVUsVU8vE0qNuh41+aXj4Vyiyl046AiNONz9TrSW/ENaaHeB/rq
         3hI1sxLEneqyunfgW/t2vI1PJIioQpiKNr4vOIvQCr9Rojx0y8yTQeV9f9vf20ppnq
         7BFEwPazUgklYr/EMCDivNxJVqr+wf6SdGYJU9rP45vqBaA6vVx2CXpukb1s7rLHIK
         jUFuO0ZL4hLbVrjDzSe6wl0N5btgX9kNw0k6HO3GqzNMLcksFQxRgmLkevmVaFu1rw
         4d5AgeBBPE1Gw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Stephan Gerhold <stephan@gerhold.net>
Cc:     linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH 0/6] arm64: dts: qcom: msm8916/39: Clean up labels
Date:   Mon, 29 May 2023 17:16:23 -0700
Message-Id: <168540577537.2201922.5958435179653162412.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 14:46:57 +0200, Stephan Gerhold wrote:
> MSM8916 and MSM8939 are very similar and almost fully "pin-compatible",
> so there are some devices that exist in very similar variants with both
> MSM8916 and MSM8939. To allow sharing definitions for such devices the
> SoCs should be set up as similar as possible, e.g. using the same
> labels. At least for me this will also simplify maintenance and review
> because board DTs do not behave and/or look subtly different.
> 
> [...]

Applied, thanks!

[1/6] arm64: dts: qcom: msm8916: Rename &msmgpio -> &tlmm
      commit: 41e22c2ff38eaea777f1158071539e659aa7980d
[2/6] arm64: dts: qcom: msm8916/39: Rename &blsp1_uartN -> &blsp_uartN
      commit: c310ca82e229124e7b373125d82ea8fdbf2f9f81
[3/6] arm64: dts: qcom: msm8916/39: Use consistent name for I2C/SPI pinctrl
      commit: fdfc21f65023dbbfe11dcd8f106230668ba8d9e5
[4/6] arm64: dts: qcom: msm8916/39: Clean up MDSS labels
      commit: 835f939501769253eb7eb2dc5389b8592a63a3ed
[5/6] arm64: dts: qcom: pm8916: Rename &wcd_codec -> &pm8916_codec
      commit: 274cf2bdd6c94da2bf293f5a6c9a5f712dd4b01e
[6/6] arm64: dts: qcom: msm8916: Move aliases to boards
      commit: 154f23a8d70cd39158cfdcfb71c112f687352da4

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
