Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A522653116
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 13:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiLUMw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 07:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiLUMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 07:52:26 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EDE1C916;
        Wed, 21 Dec 2022 04:52:24 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id C252C3FB17;
        Wed, 21 Dec 2022 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1671627141; bh=5yksC0Cq9kVpLaymRwg/jBmhLY9pNV/TWld2lFBpej4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UNMFxg1Em5F+GVkdEbsfpromULeOq0/SPyW/deGz7kpYSgTRCr/6jR87+2cOHEowi
         S5fFLAzZ0PNimshCf1kkl1+uPRchbUV5/0Obu2GOEb++L6P2HGbdCHrZGZ/zMzk4dS
         HK5zjQ0cqFfNKo5TIcDTL0kbNSaau49pvwkuuUM1V8Ow6f46K75ctek7LbkItd/g55
         MeYz52RWfZSmvpGY9ODkOnhh08azfqwChl6dwnXRBiueJweVRVgBEz20ia9+c2MrTg
         lW/i/i1HPZ2+tehZsEjJG+I6CE+RFLxXC/Jz3YySIr44vIp2V1snTB3JMeExapjhTR
         K6NGXELZ7C/NA==
Message-ID: <b13f4181-7818-6780-2aaa-7966d5722780@marcan.st>
Date:   Wed, 21 Dec 2022 21:52:16 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4 2/4] pwm: Add Apple PWM controller
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Sasha Finkelstein <fnkl.kernel@gmail.com>
Cc:     thierry.reding@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sven@svenpeter.dev,
        alyssa@rosenzweig.io, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221209111313.2701-1-fnkl.kernel@gmail.com>
 <20221209111313.2701-3-fnkl.kernel@gmail.com>
 <20221219130610.yxggztlqnssm4k7c@pengutronix.de>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20221219130610.yxggztlqnssm4k7c@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 22.06, Uwe Kleine-König wrote:
> Hello,
> 
> over all the driver looks good. Just a few smaller issues below.
> 
> I wonder if it's a good idea to call this driver "apple". SoC vendors
> seem to reinvent their peripherals (or buy them somewhere else) for
> their different generations of processors. Maybe call it "apple-s5l"
> already today and not only when the next generation SoC appears?
> (I don't feel strong here, if you want to delay that renaming until
> there is an incompatible SoC that's fine for me.)

Well... considering s5l refers to the s5l8920x, the SoC used in the
iPhone 3GS released in 2009, and here we are with the M1 13 years later
and it's still the same, I think we're doing pretty well here.

(Apple doesn't reinvent their peripherals nearly as often as other vendors).

- Hector
