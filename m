Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B60371FBBD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbjFBIVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 04:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbjFBIVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 04:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD9CEB;
        Fri,  2 Jun 2023 01:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD32E642DB;
        Fri,  2 Jun 2023 08:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B817C433D2;
        Fri,  2 Jun 2023 08:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685694097;
        bh=QbOneeT8lhByLYodDEKczI5ni1C0nepP3+sbgHrYq4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AAwtZHnBN9GrXjXsmigetfsp0evgoEW/HLqlrxb/nOI01R2q4IDkpo+5k4mwsSAET
         IEwccguKNeNQ/x+/eCF29r7wEpMDQclAjvZiQxFhOs4WmerD15Ybd4/z16PPMqwkP4
         4P0xSleF378Y3ym65eFDjEcIkCuWixQ21q8N5n1lAZINbsG5AyidenKGh39jgqGaiT
         13Jf5BsFw8fo+QRmnRpjvqrUs+t9lXX7kcEoTx/hxJ8wzTTuT9Ec5kfN2HP3mGmgwD
         pRpKd1uo8bFRrOKpGswULRUSxJQJnHUpCQaR+p2O6GFztpZ6I++SOVUKhkie8/bz8S
         xDCx6nBijvAFw==
Date:   Fri, 2 Jun 2023 09:21:33 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Julien Panis <jpanis@baylibre.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mfd: tps6594: Fix an error code in probe()
Message-ID: <20230602082133.GP449117@google.com>
References: <49f7cd8f-f7eb-40f1-91e8-291620c684df@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <49f7cd8f-f7eb-40f1-91e8-291620c684df@kili.mountain>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023, Dan Carpenter wrote:

> These error paths accidentally return success when they should return
> -EINVAL.
> 
> Fixes: 325bec7157b3 ("mfd: tps6594: Add driver for TI TPS6594 PMIC")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/mfd/tps6594-i2c.c | 2 +-
>  drivers/mfd/tps6594-spi.c | 2 +-
>  2 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
