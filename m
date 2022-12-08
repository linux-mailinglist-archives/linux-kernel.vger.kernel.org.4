Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE41646C8B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:16:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLHKQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:16:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLHKQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:16:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30371BD0;
        Thu,  8 Dec 2022 02:16:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6A82B821EB;
        Thu,  8 Dec 2022 10:16:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6855C433C1;
        Thu,  8 Dec 2022 10:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670494589;
        bh=KLaSZ5blId5Z7aDCG2Qh6BNgobCKMPPmG8Rf8GJpJAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLZTtEwkJBTfxeJJ77Yxq/MviOgCl2D9CY39vBvKkk070riGQ54+RiNIkozhE3rdF
         mDPYgF28ilhYWoM0/5oELjHwmU1uWVigLCdXtf7nrPG9hNZdcvDlw0wSiZDi+Kclvo
         DIQeP+klD4gnv+VFDjVX/7DP+iL9m82iV4N0RpKrkze6nZr+DYfIT6XmccRSwsrOGk
         BhpWj/7672A46pax/edJNyySK1sKXoZilUyLdMt4sKqQRVEcoN8bODfncQS16Hmfqz
         mLG2QFbfzq2W1BHuxtQp52GLUJVyaRDNYcTwNZD1Qao4eiUforqzHHo6ilxcfGDHG0
         VzEO1KX172WvQ==
Date:   Thu, 8 Dec 2022 10:16:22 +0000
From:   Lee Jones <lee@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Gene Chen <gene_chen@richtek.com>,
        Daniel Mack <zonque@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Add missing 'unevaluatedProperties' to
 regulator nodes
Message-ID: <Y5G5duIqBYuEXqJU@google.com>
References: <20221206211554.92005-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221206211554.92005-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Dec 2022, Rob Herring wrote:

> Several regulator schemas are missing 'unevaluatedProperties' constraint
> which means any extra properties are allowed. Upon adding the
> constraint, there's numerous warnings from using the deprecated
> 'regulator-compatible' property. Remove the usage as examples shouldn't
> be using long since deprecated properties.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> I'd suggest that Mark take this if that's okay with Lee. Or I can take 
> it.

No problem from my side.

>  Documentation/devicetree/bindings/mfd/max77650.yaml  |  2 --
>  .../devicetree/bindings/mfd/mediatek,mt6360.yaml     |  9 ---------
>  .../bindings/power/supply/mt6360_charger.yaml        |  2 +-
>  .../bindings/regulator/max77650-regulator.yaml       |  1 +
>  .../devicetree/bindings/regulator/max8660.yaml       |  6 +-----
>  .../bindings/regulator/mt6360-regulator.yaml         | 12 +++---------
>  6 files changed, 6 insertions(+), 26 deletions(-)

Acked-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
