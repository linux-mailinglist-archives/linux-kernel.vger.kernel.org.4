Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74C771312D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238148AbjE0BD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237823AbjE0BDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC16189;
        Fri, 26 May 2023 18:03:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C65965498;
        Sat, 27 May 2023 01:03:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEAE3C433EF;
        Sat, 27 May 2023 01:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149429;
        bh=TFi0vLMip0Sj9ozamWXpBAVzthIqOzGmqGBEq9KBuPo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=B4TFaR692TdoXThTKIlACB0EB/JjhNrGPtOZDVHOitqG6eqTE8ENYoxPjd5+/KQ6M
         7zYQX+eJle+3RxbobuVR2fniTyHfr1fwV9YLn6Ks65dLNJQ5IkEl7Ucpjqf/bfV0ll
         km90fZckZgl71wOqfFsrPI9fzVffuQlJ39ew4TfLHTrYZOflw+FPo27dtiziORwFOK
         SX0sxMsuv5B2fsCDChh89Yz2L1mt3FrCl7ltrCb6M0tFhW9z20Y4Cd8h/JALy4ggkj
         pMdU0BeKZG8150BGn1qWQfmVYifcr3Ys6jPvdtequIOSa3wf9aUkclS7GCrTk2F/Zl
         B53V24r6FaM3A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: msm8916: correct LPASS CPU clocks order
Date:   Fri, 26 May 2023 18:07:24 -0700
Message-Id: <168514964951.348612.10913055471454030655.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507174516.264936-1-krzysztof.kozlowski@linaro.org>
References: <20230507174516.264936-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 7 May 2023 19:45:14 +0200, Krzysztof Kozlowski wrote:
> Re-order the clocks for LPASS CPU node to match the bindings (Linux
> driver takes by name):
> 
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:1: 'mi2s-bit-clk0' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:2: 'mi2s-bit-clk1' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:3: 'mi2s-bit-clk2' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:4: 'mi2s-bit-clk3' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:5: 'pcnoc-mport-clk' was expected
>   msm8916-asus-z00l.dtb: audio-controller@7708000: clock-names:6: 'pcnoc-sway-clk' was expected
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: msm8916: correct LPASS CPU clocks order
      commit: 9903258a937b47b78d18c7cb8e342ccbb671d8c2
[2/3] arm64: dts: qcom: msm8996: correct MMCC clocks order
      commit: 3e8188b4b6c76bfa5c5389384bea2719a1271327
[3/3] arm64: dts: qcom: apq8096: fix fixed regulator name property
      commit: c77612a07d18d4425fd8ddd532a8a9b8e1970c53

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
