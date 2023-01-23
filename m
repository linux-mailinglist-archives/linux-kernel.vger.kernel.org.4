Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B821678BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbjAWXIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjAWXIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:08:41 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AC62ED5E;
        Mon, 23 Jan 2023 15:08:40 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 29F15240003;
        Mon, 23 Jan 2023 23:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674515319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J33aaJyPYAfZ+SkosVyWUGvSEGeaI1V9w/hijx4U0To=;
        b=mpecTJHwdK9fLjly42/PyfsI396WOUPWmXXWNvQTZcyoCzsjE45wQ5+zZDs9B3Cu76trFl
        7Azy7BHnxyx/KiOeiYSQUHBMU/mwVSIhmB7j00iA/QIjkiClj8GgB4GyKtFNzzvvjkYXOZ
        pWYQaTcoMyqoSUtKmGbaRsEsSvgwId+ci+sNzc+MS3gT/ULSVZXXnbMBC04jClgjehl6ag
        h9igUr5gyWH94DJ7nhdRMzf1owVb732iW/i7FmuG0Y7REj2bQtMXYiimF8YpeqbgMy+uOn
        SuwVlxMxT9xletupBNkdvOZEP9jNAEwWWE6lnLQt+5iTZ2CUWSKxO/Y557eMfw==
Date:   Tue, 24 Jan 2023 00:08:37 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Doug Berger <opendmb@gmail.com>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/6] rtc: brcmstb-waketimer: add RTC alarm irq
Message-ID: <167451526504.1264870.8427240602882815591.b4-ty@bootlin.com>
References: <20230120190147.718976-1-opendmb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120190147.718976-1-opendmb@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Jan 2023 11:01:41 -0800, Doug Berger wrote:
> Support is added for an interrupt that can be triggered from the
> brcmstb-waketimer hardware while the system is awake.
> 
> This interrupt allows the driver to pass the rtctest selftest.
> 
> Doug Berger (6):
>   rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
>   rtc: brcmstb-waketimer: non-functional code changes
>   rtc: brcmstb-waketimer: compensate for lack of wktmr disable
>   rtc: brcmstb-waketimer: rename irq to wake_irq
>   dt-bindings: rtc: brcm,brcmstb-waketimer: add alarm interrupt
>   rtc: brcmstb-waketimer: allow use as non-wake alarm
> 
> [...]

Applied, thanks!

[1/6] rtc: brcmstb-waketimer: introduce WKTMR_ALARM_EVENT flag
      commit: 90226f6b17a3edcb0bddaf2f16991861c99d6a15
[2/6] rtc: brcmstb-waketimer: non-functional code changes
      commit: 2cd98b22c1443d1f2921a371baee658da184868e
[3/6] rtc: brcmstb-waketimer: compensate for lack of wktmr disable
      commit: 516ae02c38ff3ae867f9b19fa050f78157e2bdae
[4/6] rtc: brcmstb-waketimer: rename irq to wake_irq
      commit: eae258edcb8705932c9e5c61a99f91d8235f688b

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
