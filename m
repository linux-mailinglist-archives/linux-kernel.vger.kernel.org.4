Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4433678C39
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjAWXr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjAWXr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:47:27 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BCC0B76C;
        Mon, 23 Jan 2023 15:47:25 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 7385F40003;
        Mon, 23 Jan 2023 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674517644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jwmcVqno/YcAQeOYokZ/vj5NmGSag+BGNuxqJkFhlmI=;
        b=o9k+1bE129WTOlXJLiQquy0CTYzOwComZEGon0prGdvsiAf488iRtFThFaM4UroTt6/LT/
        G3ELWt95VYwPuntnrvHYWEakost8RHFHFZAW52XcWNoT7z09LFn/w/rwGZZ7+r5KU98o+J
        nSFE5ljwVM/wnTOoZ+8FqonPaYeCXc6gBt+u8GnzM15MT4NpJEH5EFOzJb6UCOi+2DrmSg
        zncttuEeq3nhJU/abbCOcc8EyvGveWxnhH0h4rGXhBb2zieEEqhd2UZBZFD3Fy7nD9o3xq
        o01T+pnHjf6Q6U3C/QezLMCYydBrBtUuFs3/gfM5B01JUn1/QMYmV2T2UBG6jw==
Date:   Tue, 24 Jan 2023 00:47:23 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] rtc: sun6i: Always export the internal oscillator
Message-ID: <167451762667.1272571.6826220647911763740.b4-ty@bootlin.com>
References: <20221229215319.14145-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221229215319.14145-1-samuel@sholland.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 29 Dec 2022 15:53:19 -0600, Samuel Holland wrote:
> On all variants of the hardware, the internal oscillator is one possible
> parent for the AR100 clock. It needs to be exported so we can model that
> relationship correctly in the devicetree.
> 
> 

Applied, thanks!

[1/1] rtc: sun6i: Always export the internal oscillator
      commit: 344f4030f6c50a9db2d03021884c4bf36191b53a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
