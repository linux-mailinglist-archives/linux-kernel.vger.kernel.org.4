Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C89665390
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236508AbjAKFUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 00:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjAKFSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:18:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5393C13F08;
        Tue, 10 Jan 2023 21:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E191A61A35;
        Wed, 11 Jan 2023 05:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C4B4C43396;
        Wed, 11 Jan 2023 05:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673413804;
        bh=CKbClLF+g+hC5+lcJjg/YQ/Ig30tr77g4LUy0sdho8o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=U3s1Hu0gLASZ9/U0nDBUmxgB5wBDkPrRGumjfeZEoCKBEEZOzBaYn3Y5bSMNft9Qt
         wtKYoogqjUWPDmLH1E9+aXrr+yfs+PkfEYUq1l8SCUI5Ncv1YfKnfnc3Hc3sJ91Z3y
         92JREArZ9BXWuXN5PSAPM4nOwcvtebJ9sdErEL01Vj00f14Zt2xgIjyVzuCt5s/DEP
         /R4ywuoJVIcu/TUGsyuM58K1zNYN5WqMPyX+3PrDkkknIjl7I9GW0UKpVsSjzaRZrw
         HXiyPMTyfcs2A1U3TmiagCPPV6CpxQprTebSK1b78OG8dwapt6QS1+QSUGn1U+Ouqh
         oMd49qZTIg8ag==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: correct Soundwire wakeup interrupt name
Date:   Tue, 10 Jan 2023 23:09:29 -0600
Message-Id: <167341377730.2246479.3556869667168791195.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221223132121.81130-1-krzysztof.kozlowski@linaro.org>
References: <20221223132121.81130-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 23 Dec 2022 14:21:21 +0100, Krzysztof Kozlowski wrote:
> The bindings expect second Soundwire interrupt to be "wakeup" (Linux
> driver takes by index):
> 
>   sm8450-hdk.dtb: soundwire-controller@33b0000: interrupt-names:1: 'wakeup' was expected
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: correct Soundwire wakeup interrupt name
      commit: 5eafe69af43d77cb117f27201076ee50f48363f1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
