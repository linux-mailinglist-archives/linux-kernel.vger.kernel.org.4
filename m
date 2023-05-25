Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3CB7104D7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240020AbjEYE4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238541AbjEYEzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:55:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B541998;
        Wed, 24 May 2023 21:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E502642BF;
        Thu, 25 May 2023 04:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F6B1C433A7;
        Thu, 25 May 2023 04:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990312;
        bh=F6/uULF6FN5l2s3g/342UB9/dYWwXh5AFLk1fyerYK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MaFfXc8TybFoWZIKDc1OeyYQ6HkqmUA1PzKv9BvCuzYfFeK5k3wXhh3u8gYhuW4zD
         luQ44lTLN4odsbgMxJh335WRpb0cGAfIrBFP23PBn0VgO4UEVqisWhX140xeRplKT8
         HArrhOmXCRaYHA5VKwLaDrwjZ0Hm5CK7v1WdGzab9TjVRqsEsiWLQnLBNGgdW8WeGS
         34Pqx9oitiD88Nnn/4Xr94Wbeh2+poGrmY2zNng8UK2klzPqyW7SHRoNYv0R4so1R7
         e/WDRKPmxjcXqNEszoM8ejvnflS0pvaeQ23lX4jBNtDoC+PDbXRtVSpaYPMaoTP3zk
         PXylcXE5nDzUw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: pmk[345]50: enable reboot reason
Date:   Wed, 24 May 2023 21:54:31 -0700
Message-Id: <168499048185.3998961.1177670010112789343.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230503-topic-sm8450-upstream-reboot-reason-v1-0-c5ac3dd5b49f@linaro.org>
References: <20230503-topic-sm8450-upstream-reboot-reason-v1-0-c5ac3dd5b49f@linaro.org>
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

On Wed, 03 May 2023 16:13:27 +0200, Neil Armstrong wrote:
> Like SA8775P (at [1]), the SM8350, SM8450 & SM8550 platforms uses
> the SDAM2 nvmem to pass the reboot reason.
> 
> This simply adds the sdam2 and reboot reason nodes
> in the pmk8350 and pmk8550 dtsi.
> 
> Tested with:
> 
> [...]

Applied, thanks!

[1/2] arm64: dts: qcom: pmk8350: add reboot-mode node using sdam_2 nvmem
      commit: 399a3c34b390afda183b7b0bd91afeee3a4cfc0f
[2/2] arm64: dts: qcom: pmk8550: add reboot-mode node using sdam_2 nvmem
      commit: 138c427ade7bad3f4f764b506ce4f1079bfc22ee

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
