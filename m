Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56B372EF74
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241200AbjFMW3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241043AbjFMW2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:28:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 220BB268C;
        Tue, 13 Jun 2023 15:27:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F83B63BB6;
        Tue, 13 Jun 2023 22:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3757CC433C0;
        Tue, 13 Jun 2023 22:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695252;
        bh=JH4dCePPgEWIrUp+j9XNysCS+Z9R3OtiHs368Pq+8W8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KjrbxrPKqu51qKWae6jgLuWZra6LCqSY2Rt+/+xXujSlI5puhUctmieRblOafFwch
         9PaGdv7XuX6IY2DASnBa8uNrhw3EF7sE9ti3l4BuOFKPQv9Fc74iFEh2dd/R76Tzgx
         0PdTtbuTtQzfdO80t+exTtczXbOkKxFXiglbed5RviSPAoesUsCUZZy45TcrhN7L+z
         bSnf4YsLIWxVaROD6DJhLROozSWpFDsJmoerVso1b63daMIdLIZnq6foYbTIVk4rv1
         2vrLTY/iQ7Am/hg6UFlqHGMLZ4VPm3xJHpaUjeodrncJTvbSsdGfu78hLLjYZ22B91
         h1oANVBdiEmIQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Komal Bajaj <quic_kbajaj@quicinc.com>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/2] arm64: dts: qcom: qdu1000: add IMEM
Date:   Tue, 13 Jun 2023 15:30:29 -0700
Message-Id: <168669542896.1315701.7413308610480150255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522151206.22654-1-quic_kbajaj@quicinc.com>
References: <20230522151206.22654-1-quic_kbajaj@quicinc.com>
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

On Mon, 22 May 2023 20:42:04 +0530, Komal Bajaj wrote:
> Add IMEM on QDU1000 and QRU1000 SoCs.
> 
> Komal Bajaj (2):
>   dt-bindings: sram: qcom,imem: document qdu1000
>   arm64: dts: qcom: qdu1000: Add IMEM and PIL info region
> 
> .../devicetree/bindings/sram/qcom,imem.yaml         |  1 +
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi               | 13 +++++++++++++
>  2 files changed, 14 insertions(+)
> 
> [...]

Applied, thanks!

[2/2] arm64: dts: qcom: qdu1000: Add IMEM and PIL info region
      commit: 21c9c7af1b37f3b38960f6abaf1b0b43f9db2467

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
