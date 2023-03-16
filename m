Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848446BD485
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:59:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjCPP66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjCPP6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:58:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132B817CC0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 08:58:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA8A0B82271
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 15:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7552FC4339B;
        Thu, 16 Mar 2023 15:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678982330;
        bh=2d9KobQPF4y4TBonf20/k7wpul54XYv+jQgj5ylTgmE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/q/QuN6JpDmoWZpxQm/nhCEOYsvcgBaE4hCzgZj0vhs89SqbAtKOTJPXiWv9DmqJ
         FkyjgzugBci6Dlx//v4F/QqpBEFYIpBwmr60aSi8+eYyf3zssZssrnXeGjsaKxLdvV
         hlYmRJPD//xRf0RqxgEiYBrdY4r0RR9WyGYKFVdO/GxVzlVIeMxpUuoiuxjnSOHio5
         B2ZZ71gXb/lcUyHOBcxldYTGliIqTGR1pxqVWMBQyTyFTnP3fInEF2F99ZojBUxc/e
         48LSk3+WveQzd+y/3P7+5/bHAN552/AX6kjYnbNk8pIFutHkB6JR7/+Ka20SsffMWJ
         ZFJ84vO4XP3YQ==
Date:   Thu, 16 Mar 2023 15:58:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] mfd: atmel-smc: Mark OF related data as maybe unused
Message-ID: <20230316155845.GO9667@google.com>
References: <20230311111629.251830-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311111629.251830-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Mar 2023, Krzysztof Kozlowski wrote:

> The driver can be compile tested with !CONFIG_OF making certain data
> unused:
>
>   drivers/mfd/atmel-smc.c:326:34: error: ‘atmel_smc_ids’ defined but not used [-Werror=unused-const-variable=]
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/mfd/atmel-smc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

--
Lee Jones [李琼斯]
