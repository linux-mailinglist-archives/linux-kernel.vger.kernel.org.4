Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380B770A47D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjETB5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjETB5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:57:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE284103;
        Fri, 19 May 2023 18:57:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 435F465B80;
        Sat, 20 May 2023 01:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2348C433A8;
        Sat, 20 May 2023 01:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684547860;
        bh=Lcb2PBdZaOQiHSRuGVfSZqdmINnLoTJ1MH7/3eC3K5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XJTPEK1QHrIkExhx3/KW0MBlQBnqcujy1rOcMjA3Wf5y8g7BMA+9zlq6P7+WE2Bkz
         Ibfv1ftsoI2eCHIppnxlMfKfjjj077iW/sswp/MqNN3CPnlD1V1NTntrx+/EOaONIq
         RNnurlJsSrHu/4+Zlezk79dO4ysFFMHasSV3E158Ai9WEIvguHmchTPaJ2Oe2NT6+o
         Bl8F5H8cMtlJx4otXEk5fCycwR+mBIkVUtVD7kgZZxhOW+XoQaR9Kc6OWpXL28ivmp
         1Q/Aa45oMIeRKQgKMCPY3n4jY4XL2gD9TKRwBVyJxUGapPO3C7u9tsYfJ51ubv8S6W
         giZKIG3M94jVQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?q?Andr=C3=A9=20Apitzsch?= <git@apitzsch.eu>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-longcheer-l8910: Add front flash LED
Date:   Fri, 19 May 2023 19:01:23 -0700
Message-Id: <168454808160.2842337.13607524844165375797.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230514-x5_front_flash-v2-1-845a8bb0483b@apitzsch.eu>
References: <20230514-x5_front_flash-v2-1-845a8bb0483b@apitzsch.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 08:32:31 +0200, André Apitzsch wrote:
> l8910 uses OCP8110 flash LED driver. Add it to the device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-longcheer-l8910: Add front flash LED
      commit: 5d8d9330921770fb953e8e749bbd049ac0fae988

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
