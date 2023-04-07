Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626EB6DB2E2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjDGSeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbjDGSeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:34:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C410DA;
        Fri,  7 Apr 2023 11:34:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA6B665389;
        Fri,  7 Apr 2023 18:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3622FC433EF;
        Fri,  7 Apr 2023 18:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680892440;
        bh=Bce6y4Fx1bqJudCEQcNv92Lvcc5s5a37i9Cq32lk/TM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DrSBd6D1s3PR42qG12f3CWVc4MYizc67Yfg/chbOuRIoYaCLxgdd/iHpukOGC2DuO
         +mTj2rWhRMCCPFMIdE4cecb78cnnjmuGsKQHM7q7ErPgCbo+GqFiW1Vb9qysFnbt1/
         C78Ps2EHlNJQ/DsFyugehoyLKyfcBwzgLrijyQ+W7D80TzbdO6nMKgwvsXFMDPJCMf
         gdQ92pqVT4rf6UstDTwpgyJhNIuo9aY9ppx+oTkTAg+7AEE5bQ/G9P8PNzDSznKBu/
         0ctF+wEbP+71tDg4IFw1WjYeoyqtpnal8mgme63RJkyHvUQYgCMerdMMKXQN4yuvqA
         lZsIefzyCRp8Q==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Das Srinagesh <quic_gurus@quicinc.com>,
        Robert Marko <robimarko@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: Re: (subset) [PATCH v2 0/5] RB1 + QCM2290 support
Date:   Fri,  7 Apr 2023 11:36:45 -0700
Message-Id: <168089260339.2666024.3907516503842293122.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403-topic-rb1_qcm-v2-0-dae06f8830dc@linaro.org>
References: <20230403-topic-rb1_qcm-v2-0-dae06f8830dc@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023 17:50:29 +0200, Konrad Dybcio wrote:
> v1 -> v2:
> - Fix missing newline in pm2250.dtsi
> - Use an enum in [2/5] to allow for more QRB2210 boards
> - Squash the dt patches into one per SoC, PMIC and board
> - pick up rb on [1/5]
> 
> v1: https://lore.kernel.org/r/20230403-topic-rb1_qcm-v1-0-ca849b62ba07@linaro.org
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: qcom: Add initial QCM2290 device tree
      commit: a64a0192b70cfe7537072ae61a5e0d1d99f976bc
[4/5] arm64: dts: qcom: Add initial PM2250 device tree
      commit: c309b9a54039053892cc5417193e9f0089073ae3
[5/5] arm64: dts: qcom: Add initial QTI RB1 device tree
      commit: e18771961336647121c40cad4585caa794980887

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
