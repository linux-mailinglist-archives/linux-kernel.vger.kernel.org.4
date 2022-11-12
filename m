Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA43A626A8D
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 17:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbiKLQ0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 11:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLQ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 11:26:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E6E9FDA;
        Sat, 12 Nov 2022 08:26:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE6D960C95;
        Sat, 12 Nov 2022 16:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB22C433D6;
        Sat, 12 Nov 2022 16:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668270400;
        bh=DU7lN2jn2h5AvAxcEVrgCYxlghLaUSgtfiNLgt81iA8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YhUUs1GBbCRTj5Vy4Vkjr9KUeED+f7/gp7ySPD6tMh5Ul5YAJ1B0NY9h0gU6y6Uia
         1vswlcHzpR/9LiT8z9z1bu5D/R14tPoHoxKuK74EIuMPCCQ+3nLTXpTdNMnOx+Dsas
         EJumwFsbaZ6ub7eKN0Q2zpvP4JN5yB7n+aSZpSDFDdwj+BKMQiurC/NVLFEYHi6/zi
         gBX9/uBjHkNUiwGN40msKCFpCPrZM4y9mQ3m6WxATTuCef4HiIXl2p3rem8fevF7C9
         V3pbS5Neuzpob0PUPTZgqQa2NLlbf5QjEiadigt5dmbHxoVefMtyCO9GIbaAMHVVuw
         yH9nsNBp4m8wg==
Date:   Sat, 12 Nov 2022 16:38:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, linmq006@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 2/2] dt-bindings: iio: adc: Remove the property
 "aspeed,trim-data-valid"
Message-ID: <20221112163853.5a9c8893@jic23-huawei>
In-Reply-To: <9ddc0bc9-c5cf-6c94-d15e-77a7a7e2b7f1@linaro.org>
References: <20221107091506.28630-1-billy_tsai@aspeedtech.com>
        <20221107091506.28630-2-billy_tsai@aspeedtech.com>
        <9ddc0bc9-c5cf-6c94-d15e-77a7a7e2b7f1@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 10:16:31 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 07/11/2022 10:15, Billy Tsai wrote:
> > The valid of the trimming data will use the otp default value as a
> > criterion.
> > 
> > Fixes: 2bdb2f00a895 ("dt-bindings: iio: adc: Add ast2600-adc bindings")  
> 
> If this is a fix, you need to describe the bug.

Hi Billy,

Please pull forwards some of the description from the previous patch.
Key thing is that people may be looking at the two parts of the
fix independently.

Also as Krzysztof noted, pick up Rob's tag for v3.

> 
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>  
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions. However, there's no need to repost patches *only* to add the
> tags. The upstream maintainer will do that for acks received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> 
> Best regards,
> Krzysztof
> 

