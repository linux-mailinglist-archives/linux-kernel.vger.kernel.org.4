Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05EE6572BB
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 05:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbiL1Ehl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 23:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiL1EhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 23:37:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DFDDF84;
        Tue, 27 Dec 2022 20:37:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 40CCAB803F8;
        Wed, 28 Dec 2022 04:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36519C433EF;
        Wed, 28 Dec 2022 04:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672202222;
        bh=aGmc6xsJp33KlEBRhQcMUVXCEM6KRTvaR00HYvi5igY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f59NL1IZgW+hb3T+DYpBKdPGDRy1pJDUShmIqGENMNU1B3LjPk4QGLMkTg0ndg12D
         gvGqtCDWOe4SSy/K0AB497+jVtMf46EuwXyRltJI55do8xGQeOeeaknmFX0VekLNSN
         99Vb8wy822VmKPlgrj9cpruLuAA0yrAU+6ZpGbK+U4J/yvNWm53GkJGO0V1hta1bWs
         iOQpMTZ9+NPN81bWsDH+qfsMDM5hTKd/27eJuzu0ZieFA5JyLm9FQH3F/9rRD6vjtx
         RY47iudM5SYt8olzwdV3Kobn9mhfZQZhz+nIl/8S12mGLLE1QOJmqAzTeiZZV6HQ8c
         akX8n8g5PnsPw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@linaro.org
Cc:     krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, patches@linaro.org
Subject: Re: (subset) [PATCH 1/3] arm64: dts: qcom: sm8150-kumano: Add GPIO keys
Date:   Tue, 27 Dec 2022 22:36:37 -0600
Message-Id: <167220221234.833009.5281648564483023437.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221210142525.16974-1-konrad.dybcio@linaro.org>
References: <20221210142525.16974-1-konrad.dybcio@linaro.org>
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

On Sat, 10 Dec 2022 15:25:23 +0100, Konrad Dybcio wrote:
> Configure hardware buttons (V-, Camera Shutter/Focus) on Kumano
> devices.
> 
> 

Applied, thanks!

[1/3] arm64: dts: qcom: sm8150-kumano: Add GPIO keys
      commit: 0ead2d1758714fb724e062f76fdb4868ba8303e6
[2/3] arm64: dts: qcom: sm8150-kumano: Add NXP PN553 NFC
      commit: 6cef82a8a7d9cbfacc94914791fbbe526709aa43
[3/3] arm64: dts: qcom: sm8150-kumano: Configure resin as volume up key
      commit: 632a35e24fefa24f79a97310e8c4642e33919204

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
