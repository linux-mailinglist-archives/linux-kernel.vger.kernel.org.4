Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDEB731AC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344714AbjFOOFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344704AbjFOOFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:05:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC2BB107
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 07:05:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D3161D2E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 14:05:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10069C433C0;
        Thu, 15 Jun 2023 14:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686837942;
        bh=pEsBk/1CX2xgWRPlvMgLiWhEWL+m3P52hV5LCf6LOGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTEsYhfYEOcld0j8WfzIP4utqRbNs8yDiqyY5dj0hSSaUKQ1JOVEisxVY5FZmXHVo
         3/tk4SZiAyV09edh7aXGlsovR0qSEQx6hbUswl0b8iYxxM/vEobIAg3BoUkGRI1eDP
         zazO+hlPBqfRE5oFrkjRrazvlRcT87jLwBO8K2+B108+vCEy0n1s/Whns08skUaExG
         djWWBaH/UDFv4WahFWutmssy1MZsxFYXM2+YaNQz3uyXNH2taN97D6DBUJ4RUVuLZ1
         ZZNgCrs78wy59OiDp43ZCCTbYMpfi3SvWFQy+hePGJ2F/4WoBd9ddBonjK7Ex60MrS
         m1SG7IcSg1ecA==
Date:   Thu, 15 Jun 2023 15:05:37 +0100
From:   Lee Jones <lee@kernel.org>
To:     Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amelie Delaunay <amelie.delaunay@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] mfd: stmfx: Fix error path in stmfx_chip_init
Message-ID: <20230615140537.GF3635807@google.com>
References: <20230609092804.793100-1-amelie.delaunay@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230609092804.793100-1-amelie.delaunay@foss.st.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jun 2023, Amelie Delaunay wrote:

> In error path, disable vdd regulator if it exists, but don't overload ret.
> Because if regulator_disable() is successful, stmfx_chip_init will exit
> successfully while chip init failed.
> 
> Fixes: 06252ade9156 ("mfd: Add ST Multi-Function eXpander (STMFX) core driver")
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  drivers/mfd/stmfx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
