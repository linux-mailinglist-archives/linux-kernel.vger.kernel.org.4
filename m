Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3920F658645
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232929AbiL1TNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1TNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:13:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3488C15FC2;
        Wed, 28 Dec 2022 11:13:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C539E615DE;
        Wed, 28 Dec 2022 19:13:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78194C433D2;
        Wed, 28 Dec 2022 19:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672254828;
        bh=FLgCSHlktWD9fY/v//RzQRC2EngFuFi1eVa/On5TaM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ap6jXG65tzs4mq6lS+SI5Z7n2WFKz8jnrDG5MU1FXnmZdRPlth3X7V2SZi20+6qdw
         xsOxIIXStTSGS17Gvd6vXC3AqE6zD0FGsuPdORIuMvpaDuw7olJ5dCmgbZsIhTtfDD
         ZhPMIjIKWeceYynt8oxWsdR5R2YTkUwRmCR1t9CvwvrjTZGxT9H2sKkyXYqyq7CXiL
         qrXOS0tcV0Fy3IZj/+Dwo73xEo+gOX2nTWOKnV7LQuaODpPNmXsS7HJhQ73Gvu7EUY
         5uIrgUbK6ezKmsf3Q4KDGo6OiE2gHPq1z+x8e9U9QV0jxvJwONxepNTdgr2DoJhbkS
         LMqCzJmO0Vr6g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, srinivas.kandagatla@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp-x13s: move 'regulator-vph-pwr' node
Date:   Wed, 28 Dec 2022 13:13:43 -0600
Message-Id: <167225482207.977158.17222712055864100936.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221228085614.15080-1-johan+linaro@kernel.org>
References: <20221228085614.15080-1-johan+linaro@kernel.org>
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

On Wed, 28 Dec 2022 09:56:14 +0100, Johan Hovold wrote:
> Move the new 'regulator-vph-pwr' node before the wlan regulator node to
> restore the root-node sort order (alphabetically by node name).
> 
> While at it, add a couple of newlines to separate the properties for
> consistency with the other regulator nodes.
> 
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp-x13s: move 'regulator-vph-pwr' node
      commit: 3abf1f5c18a3f5a8da7f858e0aa5926e59575b1b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
