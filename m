Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDAB617488
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbiKCCxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiKCCwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:52:39 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380971741E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:51:48 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id g62so406201pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wJ8YK3ZkeFa/ubpkLPx4KfooCHAZYFqvy9bY3m0W8OI=;
        b=YJdeZnb7aLAY9WgsUwt1i1CaggwJDIWSctPHkvqDN7BSWyyMvg+dNdvtlDGB5hAr6e
         VsXV7cRxeJhLHj6XHH+OkW4h3TS/Ji3B1JozPRTVnBYMMlZ4C2QAiOz+OtvvR6NoRp1D
         cgXYlXC71rAoX6arAuu2M29RgbsUKN7h6jhVVEvGaRLYCur+dQwVZVoKKDzDJuvseklu
         wodr6vTTDFiJvrrtBcKVZV64vgEm9Hnhba0qkjwRJXAQDCrIlCexyITtXfsKpexOOHHS
         QGxGVYoVfXZXzVJsgKn73wfl/pku8EruCMQTCyuvMHO1zti9dNATB/AQ1NmQm+NulMQd
         sVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ8YK3ZkeFa/ubpkLPx4KfooCHAZYFqvy9bY3m0W8OI=;
        b=bh1Pui2JOlTmUBWQ6z0KU4nUfoUjacGWjAGO+MRj0y4CQ8Yf7jUwvngZZzVMdcG6Lz
         QxsnagLyB2y2+wh6rUehssHwd7W9qoppYN9yvYikKZJVFgvqJHlY/Ni77zsSqicrJph3
         2U4JW59CgPfJhh56jR2Cd6+E2izE4kMzxo89ddej3FW3la+6zyGz+JZFZ5NUYlYbJF/Q
         lecbNvqGmE2TvgsmeSP+q8JG8kPEtsy+l10+HWm8VzYcPGeW6cq1DtOk7BgFLWm1smL+
         jMrvf0mJAocLxU2zKiPfpt/qzyOQ6Kuo47wE/uilU1g3B+GZ44xkWGNW42XxcbHUcrWZ
         HwwQ==
X-Gm-Message-State: ACrzQf0BdidgnI8LiQOB5+qOjnV1vPmgEAvbSvrj5ydMIqanb/XYQMYy
        eyvUReWrmkvz2HBPqDy8wIAM9Q==
X-Google-Smtp-Source: AMsMyM74YTplVPlwGAc9pABYMGH/T+XcnLy/bQyPOd4IQYtYE+bx8hWqC1ki/b6MZqutZRqy3MZR3g==
X-Received: by 2002:a05:6a00:190a:b0:56c:123e:3e61 with SMTP id y10-20020a056a00190a00b0056c123e3e61mr28079536pfi.47.1667443907690;
        Wed, 02 Nov 2022 19:51:47 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id g16-20020aa79dd0000000b0056cd54ac8a0sm9099583pfq.197.2022.11.02.19.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 19:51:46 -0700 (PDT)
Date:   Thu, 3 Nov 2022 08:21:42 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Vipul Kumar Samar <vipulkumar.samar@st.com>,
        Vipin Kumar <vipin.kumar@st.com>,
        Deepak Sikri <deepak.sikri@st.com>,
        Bhavna Yadav <bhavna.yadav@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH v2 3/6] arm: configs: spear6xx: Enable PL110 display
 controller
Message-ID: <20221103025142.a6ap22uks2gan2bj@vireshk-i7>
References: <20221102171012.49150-1-kory.maincent@bootlin.com>
 <20221102171012.49150-4-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102171012.49150-4-kory.maincent@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-11-22, 18:10, Köry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
> 
> Enable the PL110 DRM driver, used by the spear600.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> 
> Notes:
>     Changes since v1:
>     - Do not drop CONFIG_I2C
> 
>  arch/arm/configs/spear6xx_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
> index 1cf0621d2154..3e2c2abae5ba 100644
> --- a/arch/arm/configs/spear6xx_defconfig
> +++ b/arch/arm/configs/spear6xx_defconfig
> @@ -40,6 +40,8 @@ CONFIG_GPIO_PL061=y
>  # CONFIG_HWMON is not set
>  CONFIG_WATCHDOG=y
>  CONFIG_ARM_SP805_WATCHDOG=y
> +CONFIG_DRM=y
> +CONFIG_DRM_PL111=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_OHCI_HCD=y

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
