Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC96062CD85
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiKPWVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231564AbiKPWVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:21:10 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0A11B9F8;
        Wed, 16 Nov 2022 14:21:09 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6205C60007;
        Wed, 16 Nov 2022 22:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668637267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CesiKwdebkd+NnI1wWOiivNhWinGWLWCz0wPBQwPdog=;
        b=SHioic4LsvYDkw4gZ4wR9hI9SYylWzaA6y8uVJRRXKaGrQjnwM4k4l3GzOMEEnq//KRBLA
        2YPsCoYSc/Up26wzz5UMjG+BiPdbKh4+KOHVxNKbbPZqr6eyj43Pa23jxDkSkNwUg47x6f
        YXsPKzBIpC8WcIFB8334Md/A3IkPMJet6gLoPS5FKFaJKGXyo0DvYQA3DBnAlrLnQ7m1/7
        APnSTfaTEpfAPYXSjuKfosZNU0gswSoxop095beI1YAOyqCDYPaDRWtKqF2i3xK17XfBXg
        HOgZafIacewU9n9QLZtsVNMxTqXJjRs9lDxFtgNnpzVQ54dFp2zZ0LslnyBeZw==
Date:   Wed, 16 Nov 2022 23:21:07 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     paulmn <paulmn@axis.com>
Cc:     linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH] rtc: pcf8523: fix for stop bit
Message-ID: <166863723714.2505656.147470674808069300.b4-ty@bootlin.com>
References: <20220829124639.10906-1-paulmn@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220829124639.10906-1-paulmn@axis.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Aug 2022 14:46:39 +0200, paulmn wrote:
> Bugfix for an issue detected when a goldcap capacitor gets
> fully discharged due to a long absence of the power supply,
> and then recharges again. The RTC failed to continue to keep
> the real-time clock.
> 
> This was caused by the incorrect handling of the STOP bit in
> the RTC internal register.  This fix solves the problem.
> 
> [...]

Applied, thanks!

[1/1] rtc: pcf8523: fix for stop bit
      commit: fe0157ba679dc95407dd5eae6550a4ceaea75040

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
