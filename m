Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B91731AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344893AbjFOOIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344881AbjFOOIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:08:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC3C2684;
        Thu, 15 Jun 2023 07:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4B0E63805;
        Thu, 15 Jun 2023 14:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2316C433C8;
        Thu, 15 Jun 2023 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686838091;
        bh=pnMGY4VOdSfwPwH1mhg80pokWgIcdnqfvZi5gTGn9PA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRocs38yV3gnDxREsF09Z91oBExE2+Nkj8r7L/ZLT29hDOgBRzrZz+BmVMfopWPdt
         KBq3/ztk2pCqLSX3vvM1JfUNQANqPiTAyQknaURYp1Zh2i+oqEFvBEPW1wXsA6z/vp
         fH91WH4qq+D7i73O5CL2yxVCOsz7z7P7TDg27DvMWYm7PZR6uUqSzxQfQU4qR5rKR0
         G06hpnVXQuMQmCs3LVhXviJEtz/Fg/oK3v5+97lQeuhDJaOjCiEOMOXJEOiAEtC1K4
         gy9ex126qCpQu9Y6aEJIDtw9mpg1ZEDwrxPbYlowfJqlKa5NefjAiBIxkTdGLPRhyc
         BwmvrpX4Bx8NA==
Date:   Thu, 15 Jun 2023 15:08:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: drop unneeded quotes
Message-ID: <20230615140805.GI3635807@google.com>
References: <20230609140725.64771-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609140725.64771-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Krzysztof Kozlowski wrote:

> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/leds/leds-class-multicolor.yaml         | 2 +-
>  Documentation/devicetree/bindings/leds/rohm,bd71828-leds.yaml   | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
