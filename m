Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC2714F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjE2Rtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjE2Rtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEE7CD;
        Mon, 29 May 2023 10:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 451CC61D7E;
        Mon, 29 May 2023 17:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31E9C433EF;
        Mon, 29 May 2023 17:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685382579;
        bh=gas9HV6Oybcrt04Wh/oZpwwH73vnTB+e3dDemnX8cwQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=Be9UoCluJijqHwQffuDToehZLps59N6Uf8cZkLsPUBs9XSnyp5E55B2glJ/m5qbND
         sJn5SXkkDkqSyPWHZK4AVdWXcs7r5QU+/hrEeVOX7NbnX5i9xFUpOyCjNaCz12Ww+B
         66+rjAl/dW93Won078uEEP6dVflRW6kDgYZhNx5OKzbItYbu5Wrm7cabf143u6aolY
         2tZaRiJqBgNM57wfr1PMwvSAywDQ3GqUIFFY0QTzZ1XEfXNOVrUA6jg/mbOhrhlJN8
         5/pGQ89eX2NeQ9JLQ5qF0oZxW616v9lNHcASu0J3i/Sy8E2YflCPFBKE8rdIlGKGo9
         LKyHOw1AiyY3Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>, robh+dt@kernel.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Subject: Re: [PATCH 0/2] Add initial support for RDP442 of IPQ5332 family
Date:   Mon, 29 May 2023 10:53:23 -0700
Message-Id: <168538280003.437034.4117872163550463058.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509160133.3794-1-quic_kathirav@quicinc.com>
References: <20230509160133.3794-1-quic_kathirav@quicinc.com>
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

On Tue, 9 May 2023 21:31:31 +0530, Kathiravan T wrote:
> Add the initial device tree support for the Reference Design
> Platform(RDP) 442 based on IPQ5332 family of SoC. This patch carries
> the support for Console UART, SPI NOR, eMMC and I2C.
> 
> Kathiravan T (2):
>   dt-bindings: arm: qcom: document MI01.3 board based on IPQ5332 family
>   arm64: dts: qcom: ipq5332: add support for the RDP442 variant
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: arm: qcom: document MI01.3 board based on IPQ5332 family
      commit: 68c4c67156ec0e0e1abe11a90e4bb9bfe34ca722
[2/2] arm64: dts: qcom: ipq5332: add support for the RDP442 variant
      commit: a782318023f339213f29372e2ecae696c0ca4a69

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
