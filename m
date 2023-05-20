Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A62B70A480
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjETB5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjETB5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:57:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE8318C;
        Fri, 19 May 2023 18:57:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4962A60C70;
        Sat, 20 May 2023 01:57:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD182C433D2;
        Sat, 20 May 2023 01:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684547861;
        bh=azuFusQ9NW7jIU1XzP3wPmooaA8IuxkgXsIUkkoE0AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C6yxvZ6G8VVSxHkF+Su6cOSv5Dog3PSgxwmgLb5ZJ7yVogp5ofA7m8GcFzw2asyVy
         G26twydczUPC7SrHRir/S6B0XmS4YuWZ7Gl7IpsRQxxnP/7PyE5nRHBCoV3PsiX8+B
         KxQAM7VebO1zMgLHtI8aZxPHE5h/73PPIkqYYmC3IZERJFWtKydIFKSUBuV1CXsPc/
         X/L8xh7/sHDNY/hKP/BEleGlNFHhqtnwBOimOQgWsoOAhOuZ021Pqu6bRsYHoJ+5qF
         3HPUZxJj7snWN+uIWzr+tqTvlI1XnErzazd02d4jqYHnLywuv42MNWv32yhXOOZfn1
         LjxRoQ0SUYlhA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] More RPMhPD levels + sm8550
Date:   Fri, 19 May 2023 19:01:24 -0700
Message-Id: <168454808160.2842337.12287707566095048911.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517-topic-kailua-rpmhpd-v2-0-3063ce19c491@linaro.org>
References: <20230517-topic-kailua-rpmhpd-v2-0-3063ce19c491@linaro.org>
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

On Wed, 17 May 2023 22:12:49 +0200, Konrad Dybcio wrote:
> Bring in missing RPMhPd levels from downstream and add ones we'll
> need for GPU on SM8550.
> 
> Patch 1 adds the missing ones with an easy-to-read diff, patch 2
> reformats the block and patch 3 adds the necessary levels to 8550 dt.
> 
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: power: qcom,rpmpd: add missing RPMH levels
      commit: 4755e880b08d963db24a1b3a710ee0e62f36aa49
[2/3] dt-bindings: power: qcom,rpmpd: Format RPMh levels better
      commit: 1738600082987ddcf9cfce753ae3c581c8e46933
[3/3] arm64: dts: qcom: sm8550: Add missing RPMhPD OPP levels
      commit: 99d33ee61cb06e1235dab404b33d4694fe18088f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
