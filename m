Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 965006A9252
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 09:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjCCIXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 03:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjCCIXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 03:23:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998EF5942B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 00:21:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C736177D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 08:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A123DC433EF;
        Fri,  3 Mar 2023 08:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677831712;
        bh=hCKGSiKvIcxZVZdweCbB73LwC3v6H/47hoxmeQECwHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s7BF0ZBwLED3cwPkr+A3M1rClDSaEHq3pFAbcKpSdsuFGaIQ377miTIydiDwXPM8q
         YoWWJrL3Osj7Vy8oavanEUT5mp7eliKSHJKy/jLEZe2AG6R/E8hivwBuRQPfVzmujf
         AYvXyzfz5fhRR5Tkufwfenry4pzpZ5eYQDBZmBLYb7Mz1lyqCaC9OncoU/kjFJSINY
         /EYeDxlfRnbcULT6C5+03TFwoncvUKZ1G4A53tRRcDxy6i9r0iIcSBQbLzwUlgt6/R
         9BlSaBMIS8qA1nwLGMvOhDxpw+/5+7DgF4pe/eR3I+cwRKyu1QulVz+AKCZqY44r96
         g1swX61TCJ5Ig==
Date:   Fri, 3 Mar 2023 08:21:47 +0000
From:   Lee Jones <lee@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: =?iso-8859-1?Q?atmel-flex?=
 =?iso-8859-1?Q?com=3A_use=A0devm=5Fplatform=5Fget=5Fand=5Fioremap=5Fresou?=
 =?iso-8859-1?B?cmNlKCk=?=
Message-ID: <20230303082147.GG2303077@google.com>
References: <202302081731593374472@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202302081731593374472@zte.com.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Feb 2023, ye.xingchen@zte.com.cn wrote:

> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>
> ---
>  drivers/mfd/atmel-flexcom.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
