Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16ED965DAF7
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjADRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239829AbjADRHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:07:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E91FDEF0;
        Wed,  4 Jan 2023 09:07:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0AB4861563;
        Wed,  4 Jan 2023 17:07:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CC7C433EF;
        Wed,  4 Jan 2023 17:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672852058;
        bh=H1u7KeGjX9MtbhSj4AsLCYDFLyehWz853sxrtfB7UWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FWbcVGSL+3K9pwtISBY8dsB39H6lt7v2+9oVXR7J0hHyLuMn4E21Pay2vqGiS3tXU
         QFpnP3n3pUg71y3YLYN7xRRC+QRKf8fPkwc9wtPrevms7tG0XyVisjNzVcQd6u9DEh
         q68PrdmG1hNE45557bbFXQAuZYFfXGCgB+aOu74OnnZqV0VhCNZk3d6i+/FZgqgcEX
         VbKczyO1L0bW+ru30EyeOOnLwTE4A5MEcYemel/Kjzbulhq2QMr/jywH6gRkDjgL2Q
         0oPC3YFEY+mRPcsksgqNape/Y3TdCxepiKU8Y9tIQtOPD3aqFyV5tI/cQS1G5hrnGD
         h7J/XJIkWN12g==
Date:   Wed, 4 Jan 2023 17:07:31 +0000
From:   Lee Jones <lee@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] mfd: twl4030-power: Drop empty platform remove function
Message-ID: <Y7WyUyAMErksRqJr@google.com>
References: <20221212214352.3776110-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221212214352.3776110-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Dec 2022, Uwe Kleine-König wrote:

> A remove callback just returning 0 is equivalent to no remove callback
> at all. So drop the useless function.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/mfd/twl4030-power.c | 6 ------
>  1 file changed, 6 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
