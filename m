Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6B7870E5B2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 21:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238436AbjEWTgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 15:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjEWTgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 15:36:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D88E46;
        Tue, 23 May 2023 12:36:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F24E635F4;
        Tue, 23 May 2023 19:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605FFC433EF;
        Tue, 23 May 2023 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870576;
        bh=h+3J2/kQs8KgMBX1Ri0hpNm+PeqkYnaMbFlEZ4b/N3s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Reu1bVBzxD84t0xCL8rYuGo7XS6sgfLnweBpUKpYIOg4E2AXI0KGXpVYw+fyd6AW4
         y9n+mi6TGmqjacA8DHkBSZF3U2LXGYeRciGBpWazApc3VcT+TsPSOcoP7q7/LNR5uW
         iRky8r2GqGVC2Z8nSd85byK84nCKxTcBcHMYLgi/ioFr/FmYVU9YHZdfo9FdenXUjL
         pUBYNvXTNkVUtOVVJcqW2honcW+z4S9TrjMmjXR6AhRVJwIqQAzjGpwgM9VGH37/j7
         Q7ul5klYGrxq2+AR6aKCNjTpHc6zd2sXw7bhsooVh5vCmgKal857kYatdxIoAeG9eq
         RaEfmDm2r0dVA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8550-qrd: add PCIe0
Date:   Tue, 23 May 2023 12:40:05 -0700
Message-Id: <168487080174.3522253.15462164789347169851.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516133011.108093-1-krzysztof.kozlowski@linaro.org>
References: <20230516133011.108093-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 16 May 2023 15:30:10 +0200, Krzysztof Kozlowski wrote:
> Add PCIe0 nodes used with WCN7851 device.  The PCIe1 is not connected,
> thus skip pcie_1_phy_aux_clk input clock to GCC.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8550-qrd: add PCIe0
      commit: b8ae83eb0c9648a3f9c386cfb191e31139050143
[2/2] arm64: dts: qcom: sm8550-qrd: add USB OTG
      commit: d97a6332c5841df4fb03aef996a7139465d68ca8

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
