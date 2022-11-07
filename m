Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C262B61E955
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiKGDOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiKGDOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:14:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E487212098;
        Sun,  6 Nov 2022 19:13:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5812B80D96;
        Mon,  7 Nov 2022 03:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F29C433D7;
        Mon,  7 Nov 2022 03:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790789;
        bh=NelhAz3/NzLf+Exw2Icns83B6LEXugkpO4QPHpm7pLk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rcXSwSN834FJc1PUPGUqhq535sIkiVgTqm2AimN+aj0Y12fZ28BOJfQfSVje+PDgS
         heARiEtjwuvqdQ+e83QTYpwYgmKWakfR0NU0EXfQytRk13Q96BrGzL2VibQui9QbS0
         qpltihGuGYRquZNeimIaCnYtE+5+lr7tHSn+rpSZi+Xl+wJ2Iv14ApBQ+PAKouHBiE
         ETGU5/zLPytqPLwLoHmwlgWo7r5Icf5ME6/Y9l6VDH2CBQMpk/MTBv67HpfKJ17vxe
         D+CG+w1agcdn+WeajSNSai6bp6DfLYueav7isUVViTeWWbf+r5a3BP06rkZIH/LqR6
         SJcSERVA4HjMg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     quic_jprakash@quicinc.com, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org, steev@kali.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH v4 00/12] sc8280xp-pmic updates and X13s thermal zone support
Date:   Sun,  6 Nov 2022 21:12:27 -0600
Message-Id: <166779074272.500303.17994434074801664841.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
References: <20221103095810.64606-1-manivannan.sadhasivam@linaro.org>
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

On Thu, 3 Nov 2022 15:27:58 +0530, Manivannan Sadhasivam wrote:
> This series adds below updates to sc8280xp-pmics:
> 
> PM8280_{1/2}:
> - Temp alarm
> - Thermal zones
> - VADC channels
> - ADC_TM5 channels
> 
> [...]

Applied, thanks!

[01/12] dt-bindings: iio: qcom: adc7-pm8350: Allow specifying SID for channels
        commit: 22f1d06f4f283e36622036726093032a07d67c0d
[02/12] arm64: dts: qcom: sc8280xp-pmics: Add temp alarm for PM8280_{1/2} PMICs
        commit: 6c82f40ec94ed99eb5200fc0d3afe79648078d93
[03/12] arm64: dts: qcom: sc8280xp-pmics: Add thermal zones for PM8280_{1/2} PMICs
        commit: 448a7821daa1bb12ec0978694cd0e77be3d9663b
[04/12] arm64: dts: qcom: sc8280xp-pmics: Add support for PMK8280 RESIN input
        commit: 34bd6d227ffc99d8ce1ced20bbfceacb14651869
[05/12] arm64: dts: qcom: sc8280xp-pmics: Add PMK8280 ADC7 block
        commit: e0f681f7294a9899dbae897f31720efc30807582
[06/12] arm64: dts: qcom: sc8280xp-pmics: Add support for TM5 block in PMK8280
        commit: 5cd549c7e7cd55453e0c0d4f2c1f51d071061451
[07/12] arm64: dts: qcom: sc8280xp-x13s: Enable PMK8280 RESIN input
        commit: 7858c676c8b243941d1539c6e2619c1713292025
[08/12] arm64: dts: qcom: sc8280xp-x13s: Add PMK8280 VADC channels
        commit: 9a6b3042c5337141a2ad202c6e6a28e4e0440c29
[09/12] arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} VADC channels
        commit: 3375151a71855d44edf4ff78aedac6d5272525ff
[10/12] arm64: dts: qcom: sc8280xp-x13s: Add PMR735A VADC channel
        commit: 9d41cd17394aca9ce3e00ab52edfa35f1848d2b3
[11/12] arm64: dts: qcom: sc8280xp-x13s: Add PM8280_{1/2} ADC_TM5 channels
        commit: 7c0151347401a55f98afa640f741f70e411ce685
[12/12] arm64: dts: qcom: sc8280xp-x13s: Add thermal zone support
        commit: 31863c523ac5bd2b0fe0857c6405a7431c59d653

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
