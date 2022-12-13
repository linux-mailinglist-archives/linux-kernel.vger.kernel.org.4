Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AC464BAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 18:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiLMRLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 12:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbiLMRKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 12:10:48 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF4A22B35;
        Tue, 13 Dec 2022 09:10:46 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 094711C0002;
        Tue, 13 Dec 2022 17:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670951445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7iuMiw/eBTs7pQOsswp5hx4LvKR8NcA0YmrtdyMH2Po=;
        b=hpOmW4vlAby3uSeaFtMos4HfPzGvIJ7xY52aI8qt4i0vVab1nAZUQL0NY0FrmjGyPInWVg
        T4PuGD5g1nk/cK9rtXCH1DEWRJjV4Xzoput34JsASq0MVUeK+LuewoKjKxuDPso3nm6N11
        1jPGTiBab1kT3YWgL7mmxUsr71bIP3U7uZcrK+z8dXbBCFFg2TP3Ck56nf5SEMYOco+Fs/
        aa3kZekDvDhM37fHYTH8mR2CbVJr3SkaIQvstk6ZbVbGLmH79VB3sMgxnDOb1dZ0cXQ6hZ
        7jHDR7Dj8NU4HrUkg1D9P5caq239b5syzh+uhulW2UHPiNlVl0G8K5si4B12lQ==
Date:   Tue, 13 Dec 2022 18:10:44 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     upstream@phytec.de, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wadim Egorov <w.egorov@phytec.de>
Cc:     a.zummo@towertech.it
Subject: Re: [PATCH] rtc: rv3028: Use IRQ flags obtained from device tree if
 available
Message-ID: <167095141138.625012.10617503828700847507.b4-ty@bootlin.com>
References: <20221208133605.4193907-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208133605.4193907-1-w.egorov@phytec.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Dec 2022 14:36:05 +0100, Wadim Egorov wrote:
> Make the interrupt pin of the RV3028 usable with GPIO controllers
> without level type IRQs support, such as the TI Davinci GPIO controller.
> 
> Therefore, allow the IRQ type to be passed from the device tree if
> available.
> 
> Based on commit d4785b46345c ("rtc: pcf2127: use IRQ flags obtained from device tree if available")
> 
> [...]

Applied, thanks!

[1/1] rtc: rv3028: Use IRQ flags obtained from device tree if available
      commit: 2d620d98d74311ac06719adf08dc9a695bd1a10b

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
