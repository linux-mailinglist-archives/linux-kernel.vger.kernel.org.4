Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7B062872A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbiKNReP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbiKNReN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:34:13 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC829626A;
        Mon, 14 Nov 2022 09:34:11 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1A2A11BF209;
        Mon, 14 Nov 2022 17:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668447250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mlcJiaG0uVlAgQTk//G6p0ZlIUMqbuo3UmpLXtJzOc0=;
        b=RWN3Wfo7c2CGqX/LVlaysSJrdwkxFkEH3DWhKfptipxWU3omwmvaTiSNmEoMTB7Em7w2t3
        k/PoDlLI6wHrApFmN1CLs4b2edwTm5cKMnQ6nVe1D+A3yYH1ttlV1020KN2/8XbDSGlVb7
        s1X8D8i99gQOOOQEn8HvMD/McUnWuPdx3onXvZ7rgbGHOUNYmDr190po6grpCrDlMwMrCN
        ZIpGXDHd7I2zd83pib08JbfSqXVOY/20uHA1hPYA/2jnCdLu3nOyCKwM6CgkoTqUSPTRN9
        v4MJrZdaSQ5gAgCpfr+JfN49/mXkvaffbL2t6dgthZQasvFhbPTA/Tbrfz9fGg==
Date:   Mon, 14 Nov 2022 18:34:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     a.zummo@towertech.it, zys.zljxml@gmail.com,
        miquel.raynal@bootlin.com, michel.pollet@bp.renesas.com
Cc:     linux-rtc@vger.kernel.org, Yushan Zhou <katrinzhou@tencent.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: rzn1: Check return value in rzn1_rtc_probe
Message-ID: <166844722182.2090248.1797479285104673416.b4-ty@bootlin.com>
References: <20221107092544.3721053-1-zys.zljxml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107092544.3721053-1-zys.zljxml@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Nov 2022 17:25:44 +0800, zys.zljxml@gmail.com wrote:
> From: Yushan Zhou <katrinzhou@tencent.com>
> 
> The rzn1_rtc_probe() function utilizes devm_pm_runtime_enable()
> but wasn't checking the return value. Fix it by adding missing
> check.
> 
> Fixes: deeb4b5393e1 ("rtc: rzn1: Add new RTC driver")
> 
> [...]

Applied, thanks!

[1/1] rtc: rzn1: Check return value in rzn1_rtc_probe
      commit: 0ef7422f0f40423143b6488e52a30444f33cdc89

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
