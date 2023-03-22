Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70F66C4E39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjCVOny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbjCVOnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:43:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703A6702E;
        Wed, 22 Mar 2023 07:42:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BA476216F;
        Wed, 22 Mar 2023 14:42:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7A3C433A1;
        Wed, 22 Mar 2023 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679496142;
        bh=EHlOGgxaDumDm4/snyGXr2UQj4MaOQdf88cTvJ6jCZY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LVHCzrFquf7lVI2y0rlqYYyoLuQoUTdBGs5EwMmvWZP/8EYRh2nvfwEXUL0IHsqCW
         xWZpzCTh5XKdE19EwM8sLps5UOTRfGQE8qBs+HAOiIHltJncsoaPqoJIAZUX99/wuu
         0WSuyEM1g9/3TkbpEX/3TU7uly21KWDBvGzJ8J+VI9iAl2RTURagMgChrdmItueh6z
         YhJfIf6+TaIHq3mPsC5/yT8qbGUzeuYJer7d03Dk5Su6Lp4jWDS0kbZNZOwfY/RgBe
         BknIR74xAGc6mHaSFWwWDbo3JcEedBSCZveS0JeyAm5D6487wFSFBja/RTO0nBtIBn
         x60/mThyUcZmw==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Jianhua Lu <lujianhua000@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Katherine Perez <kaperez@linux.microsoft.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: sm8250-xiaomi-elish: fix USB maximum speed property
Date:   Wed, 22 Mar 2023 07:45:13 -0700
Message-Id: <167949631652.1081726.7071406068350302022.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230304130315.51595-1-krzysztof.kozlowski@linaro.org>
References: <20230304130315.51595-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 4 Mar 2023 14:03:14 +0100, Krzysztof Kozlowski wrote:
> Fix typo in USB DWC3 node maximum speed property.
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: sm8250-xiaomi-elish: fix USB maximum speed property
      commit: 613f14a3a9d7e12a832ff822f85a33ad0ebee952
[2/2] arm64: dts: qcom: sm8350-microsoft-surface: fix USB dual-role mode property
      commit: 0beda02e530f8fc571877939645cb20ade113027

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
