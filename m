Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5086266C4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 04:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiKLDwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 22:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiKLDvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 22:51:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF232D747;
        Fri, 11 Nov 2022 19:51:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C90162181;
        Sat, 12 Nov 2022 03:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDDEC43143;
        Sat, 12 Nov 2022 03:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668225113;
        bh=ifMvh+t/qPKcLBF5hA+5bimqtWuEYlJvON3B8f05rXQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=nPCOz/n15MVTnUi/HSklagueuxlnM339G3xJWL6ylDeRuxkV1hMNjS9wL2dMf7EwP
         TLJd1fhOsC4ecrz3pudT9NT3UI2oohUQvjU1pEyRtczMsNJcEYMWQKpeJCLnWEKYEx
         L9Bz3G5xJU2autKdS42yOeNxCB0fbojCkbW9v+TQ2sPIE3KnfDyPGmXSVPqw4gyBqt
         wj9tNsLh8uxUSZLWUfl2hDjGzIyfpRgk8rvQ7JEO7gIenWZZe3HUv/PAgEDlazuSuT
         UOe9ZRkbY50b69CjUkI95ZTNgIgF6lLFr+1GRxIG5mjWO/nL/53mgphoLLrd4Rr+io
         hDNXwqcTf+Bqw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        agross@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm8450: drop incorrect spi-max-frequency
Date:   Fri, 11 Nov 2022 21:51:47 -0600
Message-Id: <166822510241.978218.2262894194470592863.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221110152741.542024-1-krzysztof.kozlowski@linaro.org>
References: <20221110152741.542024-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 10 Nov 2022 16:27:41 +0100, Krzysztof Kozlowski wrote:
> spi-max-frequency is a property of SPI device, not the controller:
> 
>   qcom/sm8450-hdk.dtb: geniqup@8c0000: spi@880000: Unevaluated properties are not allowed ('spi-max-frequency' was unexpected
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sm8450: drop incorrect spi-max-frequency
      commit: b69e4bb48abdc5dd1fa6725dd1753f8abce3f38c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
