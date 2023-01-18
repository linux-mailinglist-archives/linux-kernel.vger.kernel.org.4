Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92508672D28
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjARX4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjARX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:56:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619384A1EC;
        Wed, 18 Jan 2023 15:55:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE08261AE4;
        Wed, 18 Jan 2023 23:55:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B41C433EF;
        Wed, 18 Jan 2023 23:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086155;
        bh=bGktQr6CID0RA42Vw90gEQWeUTjQ8XSiZzgElS0VMqY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RAqAvxyaUFv3d6ZWNMGdFa8MIPXXjjN13c/4BBlXqwfeYnsIuErb+QuiHhENeLaYm
         qdmib7BKCf3/v3j0SVk3w2+efRczLd0zjwfUoAdiqQSo71mEfx/loyp08C81va5KyG
         AY4hk3+sj37IzRRyFLnCbeZKr0lDkM38kMmCsOXznrH0lKLYh40Bq9L9ms1Va2lwLS
         L0eAL9qrCUCRVL3b1ntfmfpOCNG2Gzai3TEcvwMkz9BcUNV0nV3vEn0K0AZVLE50JT
         Rzve5qjUvoQoGIayD+AvTjNUtnvPC/mshYAF8M3/wltgwPTMrOYZg+ph2P6FtGjdeI
         icp4tALx1TwQw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     neil.armstrong@linaro.org, Rob Herring <robh+dt@kernel.org>,
        konrad.dybcio@somainline.org, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        abel.vesa@linaro.org
Subject: Re: [PATCH v3 0/3] arm64: dts: qcom: Add ADSP, CDSP & MDSS support to SM8550 and MTP board
Date:   Wed, 18 Jan 2023 17:55:38 -0600
Message-Id: <167408614065.2989059.7261682427241729811.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221115-topic-sm8550-upstream-dts-remoteproc-v3-0-815a1753de34@linaro.org>
References: <20221115-topic-sm8550-upstream-dts-remoteproc-v3-0-815a1753de34@linaro.org>
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

On Wed, 18 Jan 2023 17:25:11 +0100, neil.armstrong@linaro.org wrote:
> This adds support for the aDSP, cDSP and MPSS Subsystems found in
> the SM8550 SoC.
> 
> The aDSP, cDSP and MPSS needs:
> - smp2p support nodes to get event back from the subsystems
> - remoteproc nodes with glink-edge subnodes providing all needed
> resources to start and run the subsystems
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: qcom: sm8550: Add interconnect path to SCM node
      commit: 2e3790de9b18f1e4761e44332ee50f4147282152
[2/3] arm64: dts: qcom: sm8550: add adsp, cdsp & mdss nodes
      commit: d0c061e366ed55ba81ee11a7b648d4c87ebc8517
[3/3] arm64: dts: qcom: sm8550-mtp: enable adsp, cdsp & mdss
      commit: 6c409f633f2373adf6815365876a206d7919fca2

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
