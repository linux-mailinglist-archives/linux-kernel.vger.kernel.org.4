Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31B367D0E1
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 17:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjAZQGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 11:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjAZQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 11:06:28 -0500
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BABDCA25E;
        Thu, 26 Jan 2023 08:06:23 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id C8F8A1BF20C;
        Thu, 26 Jan 2023 16:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674749182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dz7ZrhSG/7//SAM3WUV6TQUEA7Ma7h1abeB1kwArUyQ=;
        b=gx+VbNXAZowy/iiPGxv0wV8cdML21nDmwEwpBKavls2oV0QWiYsPjxfa+qiRUkctZve3a4
        22Ai4cv1er/KzZVUb6wjyGX/JNJXE+AVroeZftDVbEByHwTzKbHhSlYHdS8el45IsqRa+X
        8FY5Anyk+jTPfN9fA4LQd89kiRoM51fLxpZGjq7mdiczBq1hvHBQtGlHqdHdM1oXE6YWZe
        3TlC7WFOu9jlHEbV7oe+TjInxKQ4XShAP8nker7vMEwqs5ILKAJjLi2gB1Emvnli7oYA6i
        4PdmSW90ke8vMGH1rt8f42yfOJOxPg6zkpwljNoYSG3FV+bTFsy1RNsmSqc9fQ==
Date:   Thu, 26 Jan 2023 17:06:20 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/24] rtc: pm8xxx: add copyright notice
Message-ID: <Y9Kk/AYBUfnoPCcP@mail.local>
References: <20230126142057.25715-1-johan+linaro@kernel.org>
 <20230126142057.25715-18-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126142057.25715-18-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 15:20:50+0100, Johan Hovold wrote:
> Add a copyright notice for Linaro and add myself as a (primary) author
> of this driver.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/rtc/rtc-pm8xxx.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
> index 09816b9f6282..25bdd804b4d2 100644
> --- a/drivers/rtc/rtc-pm8xxx.c
> +++ b/drivers/rtc/rtc-pm8xxx.c
> @@ -1,5 +1,9 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/* Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> +/*
> + * pm8xxx RTC driver
> + *
> + * Copyright (c) 2010-2011, Code Aurora Forum. All rights reserved.
> + * Copyright (c) 2023, Linaro Limited

Is this really useful? The authoritative source is going to be git
anyway.

>   */
>  #include <linux/of.h>
>  #include <linux/module.h>
> @@ -551,3 +555,4 @@ MODULE_ALIAS("platform:rtc-pm8xxx");
>  MODULE_DESCRIPTION("PMIC8xxx RTC driver");
>  MODULE_LICENSE("GPL v2");
>  MODULE_AUTHOR("Anirudh Ghayal <aghayal@codeaurora.org>");
> +MODULE_AUTHOR("Johan Hovold <johan@kernel.org>");
> -- 
> 2.39.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
