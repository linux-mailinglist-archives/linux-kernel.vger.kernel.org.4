Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5E5710495
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbjEYEyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbjEYExM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798681706;
        Wed, 24 May 2023 21:51:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A1CD6429A;
        Thu, 25 May 2023 04:51:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2D4C433EF;
        Thu, 25 May 2023 04:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990295;
        bh=PPsRc5F9TzlufBkYRrXoJ2dTnBl9rgukik/j3SvDbZw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=ujl/3Kw2Isqyudl2d2INX/aNsvhuVBSKpp6uZJC8gQteuRgfPevWsjwCDpLumhwhO
         PUgDP8dcyrWiqB3yl07G3D646Q0MIAAc80lZX1gGKXlu62cDMWZoTb4SrlbmI7ZtKf
         X4S2F2I6VpTkAI9Ilyy3f3mCKwVeo1tkg5U4EGSSu6aERyGfwJLlxMYrqm39noIs1B
         J4hrE9y9+NobiRcdcO6feqcC1DvgLhWB5wv4yYOrAVrAat5uvBHnBD0SsGXKAd/6vx
         iXR8Qn0ucQvteE2PgNSpXKbBXnHVLoc0ZL0uMRxG9pkZUkQwmKNvpovMpZn8cN1Mz/
         CeaqP4AJkmuHA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH] dt-bindings: soc: qcom: smd-rpm: allow MSM8226 over SMD
Date:   Wed, 24 May 2023 21:54:15 -0700
Message-Id: <168499048183.3998961.15695496032767739661.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230410181036.25943-1-krzysztof.kozlowski@linaro.org>
References: <20230410181036.25943-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 20:10:36 +0200, Krzysztof Kozlowski wrote:
> The MSM8226 RPM uses SMD, so it must allow qcom,smd-channels:
> 
>   qcom-msm8226-samsung-s3ve3g.dtb: rpm-requests: qcom,smd-channels: False schema does not allow ['rpm_requests']
> 
> 

Applied, thanks!

[1/1] dt-bindings: soc: qcom: smd-rpm: allow MSM8226 over SMD
      commit: 1252ea653bff14eb1a2184245a977ecb8505be68

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
