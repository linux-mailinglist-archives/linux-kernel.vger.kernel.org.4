Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879C16B0348
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjCHJnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjCHJnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:43:00 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567A0B8F28;
        Wed,  8 Mar 2023 01:42:27 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6D69E40011;
        Wed,  8 Mar 2023 09:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678268541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZIakPN4TFSYdlgwkEYats89Z2k6gICYxrTlj917Vt6U=;
        b=JLFEk8wZXt7V5TZsangwXm0pBeGRVpyVw+ooUQNA7/s08ZIOuuaYnHyV3TjMZ/yFFG7nJk
        KwYHrDD7aTo+pRRP9CIetlP3TiGU23MLg2Cxh1sqQJZ8p06WxFHm+rL2mDmYpePr3XGC8n
        pr4mJJHXUDg60TTFwjfPSCXpivBCjyRPW5b7sK/V/Yus+U3IJ78Wbf2WqJbRDtIKN+RRtr
        h288ae3AK4EuEx9hyiRKglorXs2++95PKu50pNPhrCxCzisHLXQTNhYKxce5FvHbAOPh8f
        ZqgLo1otaIXzGqK5zBvK2u84VUiSRk4erhgfpTTU+ZNEzlaokaKI1EnCrIQwuw==
Date:   Wed, 8 Mar 2023 10:42:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH v1] max77663-rtc: pass rtc address from device tree node
 if exists
Message-ID: <202303080942204be1ceeb@mail.local>
References: <20230308083759.11692-1-clamor95@gmail.com>
 <f1df5968-4322-3f67-3da8-c10ea50386a8@linaro.org>
 <CAPVz0n24odz4bxt8nRe08-UJFoaDSTGMAPfj2b2RBG+ZbwntfQ@mail.gmail.com>
 <190897d3-39b6-fb7c-dc18-dac580fadea6@linaro.org>
 <06f8eec8-94f3-0fed-b496-831c77baf368@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06f8eec8-94f3-0fed-b496-831c77baf368@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 10:14:22+0100, Krzysztof Kozlowski wrote:
> On 08/03/2023 10:11, Krzysztof Kozlowski wrote:
> > On 08/03/2023 09:58, Svyatoslav Ryhel wrote:
> >> I would love to, but max77663 uses max77686 rtc
> >> https://github.com/torvalds/linux/blob/master/drivers/mfd/max77620.c#L123
> >> how to handle this?
> > 
> > Don't top post.
> > 
> > Hm, so it seems max7763 is already documented via max77620. I missed
> > that. Add the new property to max77620, not to max77686 RTC. It does not
> > look like RTC's property, but the PMIC's.
> 
> To clarify - the I2C address selection for regmap is in max77686 RTC,
> but I meant DT property.
> 
> Different thing is that we do not pass addresses as property fields.
> These should be devices on the I2C bus rather... unless you are aware of
> existing property like this?
>

I'd say that the RTC should have been modeled as a discrete component
from the beginning instead of using an i2c dummy device
 
> Best regards,
> Krzysztof
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
