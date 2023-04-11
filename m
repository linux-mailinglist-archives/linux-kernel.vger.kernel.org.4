Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E8D6DDDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjDKO3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjDKO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:29:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADA4859F2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:28:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16262FEC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:29:26 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7184C3F6C4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 07:28:41 -0700 (PDT)
Date:   Tue, 11 Apr 2023 15:28:33 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] bus: vexpress-config: Add explicit of_platform.h include
Message-ID: <ZDVukW3cPlr_7sre@e110455-lin.cambridge.arm.com>
References: <20230410232727.1562115-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230410232727.1562115-1-robh@kernel.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 06:27:26PM -0500, Rob Herring wrote:
> vexpress-config uses of_platform_* functions which are declared in
> of_platform.h. of_platform.h gets implicitly included by of_device.h,
> but that is going to be removed soon. Nothing else depends on
> of_device.h so it can be dropped.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

I'm expecting Sudeep will pick this one up through his tree, if not please
let me know.

Best regards,
Liviu

> ---
>  drivers/bus/vexpress-config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
> index a58ac0c8e282..472a570bd53a 100644
> --- a/drivers/bus/vexpress-config.c
> +++ b/drivers/bus/vexpress-config.c
> @@ -10,7 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> -#include <linux/of_device.h>
> +#include <linux/of_platform.h>
>  #include <linux/sched/signal.h>
>  #include <linux/slab.h>
>  #include <linux/vexpress.h>
> -- 
> 2.39.2
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
