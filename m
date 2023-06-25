Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D5B73D51B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 00:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjFYWxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 18:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYWxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 18:53:51 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4821BD;
        Sun, 25 Jun 2023 15:53:49 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687733627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=91V4pnakccT6+XFMU742bsmDiavjEOdvbvLU0XTwQvY=;
        b=mwbT4VbuJXwBXS211JxOKc+gcDdr7KpmLiuB9yAcnozdk4LJm8YfPueIezl8j9V6fhuJlG
        DOeOdoZpqWMVLAsiUKPDO88tkkPgiY5AZ5QfIPXAhs8w2ltkPxBIJnSIT8vpohbrYCS4bO
        zum7y6IfHKudaK9UyuYX/2Esb1tCIhu/jkqo/ozjJDgeq+LRY4xsPdCRj2WyZh1s8MyTlp
        MRRDXYZfWHppKUkIjdKlOtqOLXdtufg/Hk+OLsDU34wr6Ux9qT9K4TS7FNSPTZEH5JZh1R
        oYAYdv/4XX4Pwhhk3jvL2VcGiiJFUcu+nQreHXmEfESnMmJNZaIAWr63jAwJ4w==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D980FF802;
        Sun, 25 Jun 2023 22:53:45 +0000 (UTC)
Date:   Mon, 26 Jun 2023 00:53:44 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Lee Jones <lee@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-rtc@vger.kernel.org
Subject: Re: [PATCH 1/2] rtc: st-lpc: Release some resources in
 st_rtc_probe() in case of error
Message-ID: <168773360575.108774.14111248625147359235.b4-ty@bootlin.com>
References: <866af6adbc7454a7b4505eb6c28fbdc86ccff39e.1686251455.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <866af6adbc7454a7b4505eb6c28fbdc86ccff39e.1686251455.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 08 Jun 2023 21:11:42 +0200, Christophe JAILLET wrote:
> If an error occurs after clk_get(), the corresponding resources should be
> released.
> 
> Use devm_clk_get() to fix it.
> 
> 

Applied, thanks!

[1/2] rtc: st-lpc: Release some resources in st_rtc_probe() in case of error
      commit: 06c6e1b01d9261f03629cefd1f3553503291e6cf
[2/2] rtc: st-lpc: Simplify clk handling in st_rtc_probe()
      commit: 0e6f36cca1bd3f5257315b55d9f31519ea4cc059

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
