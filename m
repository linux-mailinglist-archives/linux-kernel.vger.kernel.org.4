Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF98D71313D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 03:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243688AbjE0BEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 21:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbjE0BD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 21:03:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF93C189;
        Fri, 26 May 2023 18:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB9A36102D;
        Sat, 27 May 2023 01:03:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FDDC433A1;
        Sat, 27 May 2023 01:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685149435;
        bh=lgvGY1tPD3ix46LGgwmZGph729z5NcjQrDl/2B+G8aQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=k5twF7VJ4mDyhoOzL+Y7bOtVdChW5dh7tvNChz0Z9IQ5OGcfrdeDB2ZjfQZOwyNGe
         7AFFo+pBpmfMBh35G2WYlMjAnkEaerT/3dI5BsKD4qucvshIrWZtYWaPaqj2IptgLJ
         vZFjYHCfeKQP3mg9Nz/aYSqtd9MFscMrSLSe5EFJRj55ChHclyRuPq25GEAGEmD9jP
         6cjntrIKf+9j+aLbap86cgzm8XX5Z6dSOVt8ryIo/Pgzpm4S5wk1AG+6//nA4nZZer
         SxrUDydvkOMqgDGyZ1ximTOj/72jR/jUza4SXedYdM45Br7I2XQHgzfvGvJsDW4UZM
         tRcDGWDCe8fog==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH V2 0/4] Add QFPROM support for few IPQ SoCs
Date:   Fri, 26 May 2023 18:07:30 -0700
Message-Id: <168514964949.348612.4263495262715923048.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526125305.19626-1-quic_kathirav@quicinc.com>
References: <20230526125305.19626-1-quic_kathirav@quicinc.com>
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

On Fri, 26 May 2023 18:23:01 +0530, Kathiravan T wrote:
> Like any other SOCs, Qualcomm's IPQ SOCs also have an efuse region which
> exposes the HW quirks like CPU Freq limit and so on. This series add the
> basic support for the efuse. Feature specific fuses will be added along
> with the feature set.
> 
> Kathiravan T (4):
>   dt-bindings: nvmem: qfprom: add compatible for few IPQ SoCs
>   arm64: dts: qcom: ipq5332: add QFPROM node
>   arm64: dts: qcom: ipq6018: add QFPROM node
>   arm64: dts: qcom: ipq9574: add QFPROM node
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: nvmem: qfprom: add compatible for few IPQ SoCs
      commit: 8fa13a6e61a799b102b3314c623d27cb8c078d21
[2/4] arm64: dts: qcom: ipq5332: add QFPROM node
      commit: 2f34a2aa4c88f4882e3c5df8c9b78f8bbd3f564f
[3/4] arm64: dts: qcom: ipq6018: add QFPROM node
      commit: 546f0617a22a481f3ca1f7e058aea0c40517c64e
[4/4] arm64: dts: qcom: ipq9574: add QFPROM node
      commit: 05e6b82f395c406333253d6c492d884e7f14ef46

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
