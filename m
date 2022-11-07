Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A9461E91D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiKGDNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbiKGDM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:12:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059BC10551;
        Sun,  6 Nov 2022 19:12:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A55C60E86;
        Mon,  7 Nov 2022 03:12:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32720C43152;
        Mon,  7 Nov 2022 03:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790771;
        bh=mweBuL50kxsp/aioXeFamnDpfnxNOo+ji52Azj8DQi4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFiujuQQprBMUq4qe7Q7UNX6rHJNHmuRVkitKVMqoXPgXaykPe3e/ERcC7u8QbsUh
         HlcdurDBRDW2tezIngRX4HHcuhIU+h119d4CjtPkJ4zfLOux1euJPEybwEBhPitkpT
         5z3jMo+0aLLH8js8XwzPh4cjbHDGkmH9ZTnd7NkyBhhDnEoVKdHWFiwqMViEDcNN3+
         YmP2y7KcpbC0MyhPXIlSj+BDpBUYLyYij4NR7lbBfZVTwG5ghmX3r2ZqasC1o1OJoG
         3asofeR+75ZI375mDwsdtrVV9q2118gbRfyLBVadEEf5ZPGU1s42qGSU/VOBQMOE2Y
         FvCqBHh6nltUw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Cc:     dmitry.baryshkov@linaro.org
Subject: Re: [PATCH 0/4] arm64: dts: qcom: sm8450: add SDHCI
Date:   Sun,  6 Nov 2022 21:12:09 -0600
Message-Id: <166779074265.500303.15502116502642876255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
References: <20221026200357.391635-1-krzysztof.kozlowski@linaro.org>
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

On Wed, 26 Oct 2022 16:03:53 -0400, Krzysztof Kozlowski wrote:
> Depends on:
> https://lore.kernel.org/all/20220410205127.1670705-2-dmitry.baryshkov@linaro.org/
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (4):
>   arm64: dts: qcom: sm8450: move SDHCI pin configuration to DTSI
>   arm64: dts: qcom: sm8450: disable SDHCI SDR104/SDR50 on all boards
>   arm64: dts: qcom: sm8450-hdk: add SDHCI for microSD
>   arm64: dts: qcom: sm8450-qrd: add SDHCI for microSD
> 
> [...]

Applied, thanks!

[1/4] arm64: dts: qcom: sm8450: move SDHCI pin configuration to DTSI
      commit: a0646262ec94faaf95b3dba8f17774d9762ee9ac
[2/4] arm64: dts: qcom: sm8450: disable SDHCI SDR104/SDR50 on all boards
      commit: 9d561dc4e5cc31e757f91eb7bb709d2e2a8c9ce0
[3/4] arm64: dts: qcom: sm8450-hdk: add SDHCI for microSD
      commit: 1f52331285ed9f412f85e321ae6574714725d634
[4/4] arm64: dts: qcom: sm8450-qrd: add SDHCI for microSD
      commit: 4a5923fe4e1df52fafa4026363a349f30c061a15

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
