Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A09772EF65
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 00:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241116AbjFMW2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 18:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240504AbjFMW1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 18:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4051BEF;
        Tue, 13 Jun 2023 15:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901D663BA6;
        Tue, 13 Jun 2023 22:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588BEC433C8;
        Tue, 13 Jun 2023 22:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686695252;
        bh=yMr1AYGMoO1cXLLWZtA8GItn9b6uzDKwNLmnda9NSeE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=qtI3aG0MQqOdUK6qVZ4osC0c3Ezx83j80O6uJFEK5RNvNHBmPKHSHNNtHSpAq/rZn
         rnv63QKtyazOzvwDILbGk4HYv42ZKJbENRdC3g4CAQo4Bphh8gVBAQScN9LYenxRrl
         H9vcuVyBLKz6xR1RgNchDbELf/mXASrml8A/dsLsxkWGSVgTjnbb0cRWN9eooRVrQ2
         ui2rnosqUF5jyXJ49lSfE+KCZMe2ezWARSCpj2Gn5kgwm+jhAZwSIQUgn3NB7dTj/R
         EbPeTHw9g8ANwQdt5r2wTcLY5QLAvSqwNDfXJYEH8sqi5/vL/M4v4pS/T2yvH1cCtr
         3EueP34tznWCw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH V3 0/3] Minor updates in the IPQ5332 DTS files
Date:   Tue, 13 Jun 2023 15:30:28 -0700
Message-Id: <168669542895.1315701.11269966029913996614.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519133844.23512-1-quic_kathirav@quicinc.com>
References: <20230519133844.23512-1-quic_kathirav@quicinc.com>
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

On Fri, 19 May 2023 19:08:41 +0530, Kathiravan T wrote:
> Rename the MI01.2 DTS after Reference Design Platform(RDP) number to align
> with ipq5332-rdp468.dts, add UART1 node and reserve memory for U-boot
> and SBL to avoid losing the RAM contents which will be used in post
> morterm analysis.
> 
> Kathiravan T (3):
>   arm64: dts: qcom: ipq5332: rename mi01.2 dts to rdp441
>   arm64: dts: qcom: ipq5332: define UART1
>   arm64: dts: qcom: ipq5332: add few more reserved memory region
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: ipq5332: rename mi01.2 dts to rdp441
      commit: b59cd2902c58969230a8aca67a10ac3fbde0af15
[2/3] arm64: dts: qcom: ipq5332: define UART1
      commit: 66d141a15c19f89e7e259e57a007550a253e03d2
[3/3] arm64: dts: qcom: ipq5332: add few more reserved memory region
      commit: 0196b041aeec788e1bc516b6d24d9c59ea59b1a6

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
