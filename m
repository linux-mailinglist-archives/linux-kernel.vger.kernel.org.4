Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCC67032EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:29:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjEOQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242506AbjEOQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:29:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1724E78;
        Mon, 15 May 2023 09:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC0B620A8;
        Mon, 15 May 2023 16:29:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAE8C433D2;
        Mon, 15 May 2023 16:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684168158;
        bh=5XprFilnhuGul/8RuO7nBubqxMRZkO5vyT5plQ1G+J0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gQmOvdO4PG/MZUVNbBTrHxIVWjWgxmrVwaD4pJE/uQjPweq3dIsSmfk2GrnYonkog
         IHx5+uCrY9W6qnP8Q2GaSzwDz7F6RnvkqlVA4+sWkkGR0z66grSJSFdh0E8ZLbvOv0
         7kLIAanTbXvr8eWr4y/fpIbJG8ZlrfpPBzH+l6WPzwNBsqkHmIhj4NR2rhdMBIeRuJ
         jiLy5X6fdxzBs47o3vZWHjCA1w5EYq8Et/0yGo4llNmQwRQcd6OlUS9kekd8iuRKtj
         XMRST4JZg17OrPrjYprYMUy96HoH8CooS6LrBIHapFxc5c0TcWp+edRlm+XH3r7J5f
         h07+1jas+J0bA==
Date:   Mon, 15 May 2023 17:29:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: Make LEDS_TI_LMU_COMMON invisible
Message-ID: <20230515162914.GB10825@google.com>
References: <91f6efaa48c36320e58b6a312025ae9b39ee206b.1683644796.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91f6efaa48c36320e58b6a312025ae9b39ee206b.1683644796.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2023, Geert Uytterhoeven wrote:

> Currently, LEDS_LM3697 and LEDS_LM36274 depend on LEDS_TI_LMU_COMMON,
> which contains the common code to support TI LMU devices.  This means
> the user is asked about the common code first, followed by the
> individual drivers, if their dependencies are met.
> 
> Simplify this, and reduce the number of questions by making
> LEDS_TI_LMU_COMMON invisible, and letting it be selected when needed.
> 
> Fixes: 3fce8e1eb9945c27 ("leds: TI LMU: Add common code for TI LMU devices")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Exposed by commit a61079efc8788858 ("leds: TI_LMU_COMMON: select REGMAP
> instead of depending on it").
> ---
>  drivers/leds/Kconfig | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)

Fixes: tag removed and applied, thanks.

-- 
Lee Jones [李琼斯]
