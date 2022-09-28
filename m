Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2A35ED345
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiI1DHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiI1DGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:06:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBC31CE91B;
        Tue, 27 Sep 2022 20:06:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D090A61CFB;
        Wed, 28 Sep 2022 03:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B7FC4347C;
        Wed, 28 Sep 2022 03:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664334411;
        bh=E2ZGBiLzDQ8mnNJYWNsiVZPK0S1Pay8r3W0mHB5xPsY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=MJvoXsyCV1v8BgZ9JWIAs71JQkckWxOM9STSpr2AE2WK7tohpRWqFfDEwMwAopi1X
         oIkil8ZRqbRsxbvTZyUzposZySqP83QnfBDvo6VS05S6Afl+MK6wZcA0TGnRKwcTO9
         5tCRAhOErxhmH8MnLsUl7cO48nf0M2f1FtvXxzz1rOq2EetDcUvv8lqfnBqiXYyG95
         53kjr2EX9xswYKvEhVGCes+ReZddBFvczC+GPUg18gujrtltMI9a/VKjikQ3vp9dR3
         U7EWzLNuKpMx5PNHbGi0UA35THYcsux9DKFJROqxOccmteKfxPp2MVOr1H/m/vsVeI
         Vh5eixYkD9P/A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     devicetree@vger.kernel.org, robh+dt@kernel.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, konrad.dybcio@somainline.org,
        krzysztof.kozlowski@linaro.org, mturquette@baylibre.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Subject: Re: [PATCH] dt-bindings: clock: qcom,a53pll: replace maintainer
Date:   Tue, 27 Sep 2022 22:06:45 -0500
Message-Id: <166433439994.1849007.1333877193310870502.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220924081329.15141-1-krzysztof.kozlowski@linaro.org>
References: <20220924081329.15141-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2022 10:13:29 +0200, Krzysztof Kozlowski wrote:
> Emails to codeaurora.org bounce ("Recipient address rejected:
> undeliverable address: No such user here.").
> 
> 

Applied, thanks!

[1/1] dt-bindings: clock: qcom,a53pll: replace maintainer
      commit: 46e0962ff2825790fecfc689f6f1135eab5c6e45

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
