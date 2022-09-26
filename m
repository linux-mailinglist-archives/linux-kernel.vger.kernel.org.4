Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88855E9B45
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234181AbiIZHzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiIZHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FD9D3E75B;
        Mon, 26 Sep 2022 00:49:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED6BA61227;
        Mon, 26 Sep 2022 07:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23259C433C1;
        Mon, 26 Sep 2022 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664178501;
        bh=/htJEdi2feByWdsEsHxT+AkmDwBkzzciAM9gCrQcalA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FMqCHkcxoFIYNza3vOKTEy1C9UEARwh3Id2YEl8DjSTbSoqizdhvr0bIW8ZH7yuUF
         nwXOYFSUCoo4oGZQFIc3639SezWm+q1n0MCrce45zpOCjwsWYIGUTy7cx2Yp5ouq50
         7XqXN6CDgimEVi5CbrA9l9roNbbN/h23raCbVVH+aO0fhCdnBY9trYnAeUUO2/hOga
         3e+ceHrB7t3qEVSo1r6D4ojIRCXoKi0ECRjYRncxH2rov/tuBJVnBZVmvKcphBls61
         59VNUEvYSRL89QFkfT63kzX9G0UWlNKgyhRxbRlKaNoFmmbVnipnlbUdTM1FAJCZ7A
         MXN88i/YP98Bg==
Date:   Mon, 26 Sep 2022 08:48:16 +0100
From:   Lee Jones <lee@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 1/1] mfd: twl4030: Add missed linux/device.h header
Message-ID: <YzFZQLVeK9pXrKmF@google.com>
References: <20220923175401.8723-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220923175401.8723-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Sep 2022, Andy Shevchenko wrote:

> With compile testing on non-OMAP platforms compiler might be not happy:
> 
> In function ‘twl4030_sih_setup’:
>   error: implicit declaration of function ‘dev_err’ [-Werror=implicit-function-declaration]
>   error: implicit declaration of function ‘dev_info’ [-Werror=implicit-function-declaration]
> In function ‘twl4030_init_irq’:
>   error: invalid use of undefined type ‘struct device’
> 
> Add missed header.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/twl4030-irq.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
