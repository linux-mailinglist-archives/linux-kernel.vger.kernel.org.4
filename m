Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163935EC89F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 17:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiI0PxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232140AbiI0Pww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 11:52:52 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076771B95FC;
        Tue, 27 Sep 2022 08:52:20 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id z20so2580534plb.10;
        Tue, 27 Sep 2022 08:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=p0YcyRlyNYPjC2yUE5rEWl59Rr2Y1jMOfDRIiIcxunI=;
        b=dkXzWr3tMEIvoAgqt/Db887cORt7DqQtdkeWbrjlb2qlMwLXEQIaWpbGozZKdyLaVd
         R1DVx2Z+gxzrYamD8qxUGpiW/IRMrNfIFlXoRpGauQvLS/kH/R9DUuTlOd7zPHb6r0eU
         NjVb3OtdHd1JgAHb1XLwkrUCOTJnJS7Gt0dj7cl/qa8hapLXHk9JYq6TH3uEzU4OmKvM
         QWLpQVpba/hi7UWAhhHXbpDyoN7dOuIg2X0TdNiHkLlykXZNPwtGPG3mNgotflsdc+j+
         TSUffuh88J0HJmoGS8JF9rlUMozrn9weVuQQYbinMqtddwgSa86uULTUVKHSRXKRpyt3
         ZNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=p0YcyRlyNYPjC2yUE5rEWl59Rr2Y1jMOfDRIiIcxunI=;
        b=Rg+sVcmJHbA3UYHF1qbfLjDP/vQeLHlPCDMTu5f6OS8vPlVUtHL754akHTcRkZY/lm
         Y6YEF4YpzPJvjfZLc6bdPWr9+Fi5sBCDG3EAC2Dh0bKrSoHHB+Ll06v6+iMdXuVNp9an
         bOGfIH9WaFHCf/OB2D0wPWblW+5mejTab26DQY/sfbqWY65evZ1jOrC7SAuM0X6BrcbW
         bMjqBIi9oeG+xPev/DknQLmC7/vU72UvwQd8A3FTBX8qAMbt8lfDkXm22pLcuYRUzYsL
         GKDukWE8FfW1LqwBqA3pfr5cGi2uk0E1aHGhHZeeMfOwqIzbjAYBnW6ynBymz4vIIXKZ
         lbXw==
X-Gm-Message-State: ACrzQf2qS+3hdtuHXjYlGJ1n11wdefC3WCwoYRaaVWMObuERtRG8r6G1
        kgE37R7WFEtC2wt5rsm7yns=
X-Google-Smtp-Source: AMsMyM4lQReHf55/5V7GZv01jZKvTie0sNuH+pDIoCDbLJjFZzEASOE06VVWXvBuUWH42yBTlZyW8A==
X-Received: by 2002:a17:903:240b:b0:178:a475:6644 with SMTP id e11-20020a170903240b00b00178a4756644mr28086716plo.96.1664293940295;
        Tue, 27 Sep 2022 08:52:20 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:9739:ab49:3830:2cbb])
        by smtp.gmail.com with ESMTPSA id d190-20020a6336c7000000b0041cd2417c66sm1770777pga.18.2022.09.27.08.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 08:52:19 -0700 (PDT)
Date:   Tue, 27 Sep 2022 08:52:15 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        nm@ti.com, kristo@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, lee@kernel.org,
        tony@atomide.com, vigneshr@ti.com, bjorn.andersson@linaro.org,
        shawnguo@kernel.org, geert+renesas@glider.be,
        dmitry.baryshkov@linaro.org, marcel.ziswiler@toradex.com,
        vkoul@kernel.org, biju.das.jz@bp.renesas.com, arnd@arndb.de,
        jeff@labundy.com, afd@ti.com, khilman@baylibre.com,
        narmstrong@baylibre.com, msp@baylibre.com, j-keerthy@ti.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v5 5/6] Input: Add tps65219 interrupt driven powerbutton
Message-ID: <YzMcL/wktFyKO06K@google.com>
References: <20220927083520.15766-1-jneanne@baylibre.com>
 <20220927083520.15766-6-jneanne@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927083520.15766-6-jneanne@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Tue, Sep 27, 2022 at 10:35:19AM +0200, Jerome Neanne wrote:
> +static int tps65219_pb_probe(struct platform_device *pdev)
> +{
> +	struct tps65219 *tps = dev_get_drvdata(pdev->dev.parent);
> +	struct device *dev = &pdev->dev;
> +	struct tps65219_pwrbutton *pwr;
> +	struct input_dev *idev;
> +	int error;
> +	int push_irq;
> +	int release_irq;
> +
> +	pwr = devm_kzalloc(dev, sizeof(*pwr), GFP_KERNEL);
> +	if (!pwr)
> +		return -ENOMEM;
> +
> +	idev = devm_input_allocate_device(dev);
> +	if (!idev)
> +		return -ENOMEM;
> +
> +	idev->name = pdev->name;
> +	snprintf(pwr->phys, sizeof(pwr->phys), "%s/input0",
> +		 pdev->name);
> +	idev->phys = pwr->phys;
> +	idev->dev.parent = dev;

As I mentioned in my previous email, this assignment is not needed given
that devm_input_allocate_device() is used. Otherwise:

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge through MFD tree.

Thanks.

-- 
Dmitry
