Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D96861748B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 03:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiKCCxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 22:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiKCCw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 22:52:58 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0375C16585
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 19:52:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id g129so498786pgc.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 19:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fCqO3QlyxQvDT0x+o7BF5bX3iSDJLGmHcDQfDe9vAnw=;
        b=xuKhe1nL73XZdr3LYDCwjHCiOAxOJ+DifYx3Fc/Z34iXO6f1EcWpN5Syfur6xz7bTy
         KenjQxPJzLKaJZmED6xPz/6JoLyWP1UxoqgCIjFq1/zFoD0S4JL4q195ajbA1rVvO5TD
         IxV9lurV/mM8QWhQHJYpDWw+PNohoQRkWN4wm1M8a1sseic6RY2PgBbb9jbt7NL2mnXT
         A7I9TxwH3IHPnkTihn2rxl5ffCl1CMRFyeTN2qCIfiVigiBvoiWtPLqoWgqr0/znGchR
         TF3aUxrqCep0UiHbZ75YwrsneAMDoAHUNjIn5laOHtdSqM5E+E1o1rMwak8WVqkM8eBP
         7YqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fCqO3QlyxQvDT0x+o7BF5bX3iSDJLGmHcDQfDe9vAnw=;
        b=zXI22H/bVHcw2MqqmkqjfXsD0rA57JjTXnDYswAydIbDEV9Py8SIs48POktwFpBzz7
         f1ELFTVG8zms+tpO83EgkOjmtyOkqc9kwmNHrgVqt4PZyYy7Zt+aBUoJxtyEM8DMeuiD
         Ptc/kf7hZ6pbahyMBmuNQ2Z9sxnsAIHkbMAgzVnr6g2EjXM80uW9d5wqF3DnxJ0ffnnc
         FKfzgr0tqZuCmgKoy5QvDMuMeJ2PsjL+M2s3a8kcZbyA8Vi8MWz+J5ewTcp/BMHWKHXW
         zTfOawgohpKBZokqIneMb0NF30JWeKLyisPasIKXTIB/j2gh8MAwL63txkMaC2q0sDyE
         jzDA==
X-Gm-Message-State: ACrzQf1FX0qEpTChYNl/z3xCpLSGttpkobdFjv2ua9e08QF3Qe049quW
        jUUypqIRRucfNpqV8jrLXTy3YQ==
X-Google-Smtp-Source: AMsMyM51ykASDmLBohSM0PmjQEeWbT0MhPuGZKBxelw3Pb5ydPIpEKTN0cwcRWrPUWcXWKYDaJ9hIQ==
X-Received: by 2002:a63:f07:0:b0:440:5c6e:5833 with SMTP id e7-20020a630f07000000b004405c6e5833mr24721616pgl.375.1667443920519;
        Wed, 02 Nov 2022 19:52:00 -0700 (PDT)
Received: from localhost ([122.172.84.80])
        by smtp.gmail.com with ESMTPSA id w18-20020a170902e89200b0017f92246e4dsm9043145plg.181.2022.11.02.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 19:51:59 -0700 (PDT)
Date:   Thu, 3 Nov 2022 08:21:57 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc:     Bhavna Yadav <bhavna.yadav@st.com>,
        Rajeev Kumar <rajeev-dlh.kumar@st.com>,
        Deepak Sikri <deepak.sikri@st.com>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Vipin Kumar <vipin.kumar@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Viresh Kumar <vireshk@kernel.org>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Vijay Kumar Mishra <vijay.kumar@st.com>
Subject: Re: [PATCH v2 1/6] arm: configs: spear6xx: Refresh defconfig
Message-ID: <20221103025157.4ml5ns4me4365lsj@vireshk-i7>
References: <20221102171012.49150-1-kory.maincent@bootlin.com>
 <20221102171012.49150-2-kory.maincent@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102171012.49150-2-kory.maincent@bootlin.com>
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
> Refresh the defconfig to follow the changes made over the year.
> I ensure important options have not gone away.
> I drop the gpio sysfs config as it is useless to keep it alone without
> CONFIG_EXPERT.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  arch/arm/configs/spear6xx_defconfig | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/configs/spear6xx_defconfig b/arch/arm/configs/spear6xx_defconfig
> index 3d631b1f3cfa..1cf0621d2154 100644
> --- a/arch/arm/configs/spear6xx_defconfig
> +++ b/arch/arm/configs/spear6xx_defconfig
> @@ -11,7 +11,6 @@ CONFIG_PARTITION_ADVANCED=y
>  CONFIG_BINFMT_MISC=y
>  CONFIG_NET=y
>  CONFIG_MTD=y
> -CONFIG_MTD_OF_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_RAW_NAND=y
>  CONFIG_MTD_NAND_FSMC=y
> @@ -28,19 +27,15 @@ CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_SMSC is not set
>  CONFIG_STMMAC_ETH=y
>  # CONFIG_WLAN is not set
> -CONFIG_INPUT_FF_MEMLESS=y
> -# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
>  # CONFIG_INPUT_KEYBOARD is not set
>  # CONFIG_INPUT_MOUSE is not set
>  # CONFIG_LEGACY_PTYS is not set
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> -CONFIG_RAW_DRIVER=y
>  CONFIG_I2C=y
>  CONFIG_I2C_DESIGNWARE_PLATFORM=y
>  CONFIG_SPI=y
>  CONFIG_SPI_PL022=y
> -CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_PL061=y
>  # CONFIG_HWMON is not set
>  CONFIG_WATCHDOG=y

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
