Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6848B65D599
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 15:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbjADO1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 09:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjADO1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 09:27:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6040D5F6A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 06:27:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECFAD61426
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A34C433D2;
        Wed,  4 Jan 2023 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672842469;
        bh=FMxAMEpT1VXnP8Hvgq6YL3NJlxU3HEXMyJnLb5yUQIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SWxWBL10zYO/oLjtckoJ2BDVpVZbWpAzyl7fL4SA5smgq2fuzDI5M+bciTb31epiH
         YFtvzqROO/BpdYu5kP5IHPbw5uJ982zC7pFc9qcbG3loD+xuaZK3huHarn0Rip62Rg
         nOZzvWyw0BjUzt+HMBkpNpgKlENlP00c2rpWnxXVtEU4kGnUmLD03boHbu9tYqkLf0
         hw2pewFQV7fm34dai/l4esJPkt4bt/RGWMaFfVFvxpMcY1V9E1z6fcHe9VbrkZekE0
         6zo3YnueWQ7cZYXvl87oKnqTygBZjG6aNmant9G/XdsnL+zUK4j47liDZVQPa8IlD3
         ZD51Io9Nsb9wg==
Date:   Wed, 4 Jan 2023 14:27:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] mfd: core: Spelling s/compement/complement/
Message-ID: <Y7WM4SwDzTMO4ZiH@google.com>
References: <547be5f648b6f3579b1834bac3e1b4fc82c54716.1672763938.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <547be5f648b6f3579b1834bac3e1b4fc82c54716.1672763938.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Jan 2023, Geert Uytterhoeven wrote:

> Fix a misspelling of "complement".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  include/linux/mfd/core.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Fine in general.

Would you mind resubmitting without the wrapping please?

If it passes checkpatch.pl, it's fine.

> diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
> index 0bc7cba798a34a7b..2b138fa0abfc3e17 100644
> --- a/include/linux/mfd/core.h
> +++ b/include/linux/mfd/core.h
> @@ -88,9 +88,9 @@ struct mfd_cell {
>  	const char		*of_compatible;
>  
>  	/*
> -	 * Address as defined in Device Tree.  Used to compement 'of_compatible'
> -	 * (above) when matching OF nodes with devices that have identical
> -	 * compatible strings
> +	 * Address as defined in Device Tree.  Used to complement
> +	 * 'of_compatible' (above) when matching OF nodes with devices that
> +	 * have identical compatible strings
>  	 */
>  	const u64 of_reg;
>  
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]
