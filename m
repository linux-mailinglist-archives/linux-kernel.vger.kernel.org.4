Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E626E727B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 06:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbjDSE7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 00:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjDSE7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 00:59:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FBC49F2;
        Tue, 18 Apr 2023 21:59:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f178da21afso8623725e9.1;
        Tue, 18 Apr 2023 21:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681880369; x=1684472369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4h9mgi4PzKesSJC7XIsTMZkcYL8dBVXESTqkBCdQKM=;
        b=m82flReCGw1X6m+CoV2VKD+wwl0j8lhmJJMb1tzlpP7xDwbIRKqHgdxpEyWmt/mY4c
         XTijt6KK4i7rlCf0Bnj157U2I6rx/K8al9Ebeg7iTvyf4oiJEfF60ppFAsaF5FjDVEeA
         zB1HnTygglUtV62FVkt9TLP/s+qGZZ6saHHf9USTP8BR5TUYQHvSugtytraVJzt0LFcB
         cGFIDy9zaPi/LVaLiTLtbxuqs/itW/h8gqKWGs95B1OkGL6j+zzs7EGYRt1iHO2ErVZ2
         V4Q97TWS3RGDSmi08ihhwflvQ09RLq8kjZ37HMbANMMr16yhhlrrhYdDEX1neMaNBNeo
         kLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681880369; x=1684472369;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4h9mgi4PzKesSJC7XIsTMZkcYL8dBVXESTqkBCdQKM=;
        b=MQB0pD5tAMxkR4U/NAjOVaFCuXYxVEBHHj6zGhTkduTFkXm5ZF0GIWpQMs95tOnc6g
         haI/M8mkD4FubgVjiYGYzIh4aX2mTngkSSVd5MvxUm5L/8S37yRbWJaThBI/NnWP/V4h
         dIxmfKIbO4g0sQdJXInjHHejqzXJ5UQo/SfJes8UAAXtl5DtcUMUAHo662qhn6m7xFJW
         K8OLyj8/a35ZDQZUQ30I70XylrmMbr0klLuHIBTvn/JpKjPO8075pJypKLTRp4L5a0Cd
         bStIdVNxDKeRKM8iX4jxxU4IIuChl2owT7+TBJtWmmr/M4+3je0GMbOrdmKYY/MQKm1f
         4tcw==
X-Gm-Message-State: AAQBX9evQPVJkh+ZusyQwk/AIvLF2fz2JxGrmBEiAdBmgvDl6av2DEaA
        x91C1yE+Tm0pArJU4EYeRq0=
X-Google-Smtp-Source: AKy350bukf4oJKo+btPlV5rCqL74IzCRSna9IqwXsdE6vXBZNGYK2s177m//3AXWr3mxuIcjhn5NNw==
X-Received: by 2002:adf:cd05:0:b0:2f0:df59:1ea7 with SMTP id w5-20020adfcd05000000b002f0df591ea7mr3621918wrm.31.1681880369662;
        Tue, 18 Apr 2023 21:59:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i15-20020a5d630f000000b002f27dd92643sm14487616wru.99.2023.04.18.21.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 21:59:29 -0700 (PDT)
Date:   Wed, 19 Apr 2023 07:59:25 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Helge Deller <deller@gmx.de>, Cai Huoqing <cai.huoqing@linux.dev>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video: fbdev: mmp: Fix deferred clk handling in
 mmphw_probe()
Message-ID: <a7c75eb0-857c-4755-aa23-0a4a96a6d2ca@kili.mountain>
References: <685f452cacc74f4983aaff2bc28a02a95e8aa8b7.1681414375.git.christophe.jaillet@wanadoo.fr>
 <67353089-4966-424c-99c2-8524818f0e37@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67353089-4966-424c-99c2-8524818f0e37@kili.mountain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 04:09:03PM +0300, Dan Carpenter wrote:
> On Thu, Apr 13, 2023 at 09:33:17PM +0200, Christophe JAILLET wrote:
> > When dev_err_probe() is called, 'ret' holds the value of the previous
> > successful devm_request_irq() call.
> > 'ret' should be assigned with a meaningful value before being used in
> > dev_err_probe().
> > 
> > While at it, use and return "PTR_ERR(ctrl->clk)" instead of a hard-coded
> > "-ENOENT" so that -EPROBE_DEFER is handled and propagated correctly.
> > 
> > Fixes: 81b63420564d ("video: fbdev: mmp: Make use of the helper function dev_err_probe()")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> 
> Presumably you already wrote a Coccinelle script for this but I've added
> it to Smatch as well.

Here is this warning:
drivers/video/fbdev/mmp/hw/mmp_ctrl.c:518 mmphw_probe() warn: passing zero to 'dev_err_probe'

Other warnings.  All five are interesting.
drivers/power/supply/rt9467-charger.c:1026 rt9467_request_interrupt() warn: passing zero to 'dev_err_probe'
drivers/pci/controller/dwc/pcie-bt1.c:601 bt1_pcie_add_port() warn: passing zero to 'dev_err_probe'
drivers/spi/spi-sprd-adi.c:570 sprd_adi_probe() warn: passing zero to 'dev_err_probe'
drivers/soc/qcom/icc-bwmon.c:776 bwmon_probe() warn: passing zero to 'dev_err_probe'
drivers/soc/qcom/icc-bwmon.c:781 bwmon_probe() warn: passing zero to 'dev_err_probe'

regards,
dan carpenter

