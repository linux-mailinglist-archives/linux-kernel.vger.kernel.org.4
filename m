Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF5E724EED
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239757AbjFFVmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234384AbjFFVmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:42:17 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4027A7;
        Tue,  6 Jun 2023 14:42:16 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686087735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6PcfXqgkRAFVRmbupkXph6bVSIl668fEjh7jlXGINRk=;
        b=jJIHXvc/7cRINmR3iDHISsS4zx8ryuhgjIZOzgfVu4MiAPnJUjCPgXAicAI3aGkO3TLW/h
        b4gdgeiicQBF7fFAG850bd9/0pX6ImVOfIdRN5QLQ/RK9x5e4jAM0eh+4b8erY+pvFSDlE
        mEQask8SWaEBt5Z67/0U6OnmLliHnWx255pkBkHGgZ+kAQ+3ulHha5r4Ab3EJMIkwltOMq
        Be2EaRMg21RAI9c2uHcFb+xlBre41sBtbMAR3yr1SIsyndCN0/j6e6N7ETOBP0VzJCaPwM
        zY9nxGFW+wy/oDZyR8yo3qIPh79UInGvDwY9PS9qQDgHuTU3Joaeft9nbKo93g==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AD424FF802;
        Tue,  6 Jun 2023 21:42:14 +0000 (UTC)
Date:   Tue, 6 Jun 2023 23:42:14 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     linux-rtc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: stm32: remove dedicated wakeup management
Message-ID: <168608768267.37577.7065576834191404106.b4-ty@bootlin.com>
References: <20230531122732.1515594-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531122732.1515594-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 31 May 2023 14:27:31 +0200, Amelie Delaunay wrote:
> There is no more needs to use a dedicated wake up interrupt for RTC as
> EXTI block manages by itself now all interrupt lines.
> 
> Dedicated wakeup interrupt has been introduced with STM32 MP1 support
> commit b72252b6580c ("rtc: stm32: add stm32mp1 rtc support") because GIC &
> EXTI interrupts were not yet linked in EXTI driver.
> 
> [...]

Applied, thanks!

[1/1] rtc: stm32: remove dedicated wakeup management
      commit: 38e0689b27f8b9a0085815b2446b12f685d028aa

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
