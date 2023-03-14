Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94E36BA05C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjCNUDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjCNUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:03:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67DA222E9;
        Tue, 14 Mar 2023 13:03:12 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eg48so7606738edb.13;
        Tue, 14 Mar 2023 13:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678824189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V84C+zNYhTlp2thKSex9zBHkOQB0B2Kt996/f1MwII0=;
        b=pd2f42sABaBIjI1MNHhZXr6SfwcrVdAV3DKrfovymQ9je4mY71Nr9bPNeIWhMNPda4
         Qeeh1t20fBxJqOxLei6KBdiRA0aGPv3pqBMW1kz0qlZ+1ceSdY5h3x7awC7KMsqYtt6Y
         tH64mw5kqiO0OMloPkZ23HBMN7O/lmvSPy8EihuVcwCn2sgQkz+IqJW6s09He6njMcqH
         5c2m7uFn9tICf4U3KZLmdL25Y59FLjOKIR5CJgnirSInsOVfc/rLmOJWQn66ysC+NES5
         B/T7Tvbpiu7GXbDkv78MA97Ae1kQuj6riDeHwLQRk4EcFNl80RKXDYx1i11XyJccSOxU
         2TBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678824189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V84C+zNYhTlp2thKSex9zBHkOQB0B2Kt996/f1MwII0=;
        b=d6OBr9lEf5Qcw2d8QtCImEWFXdch4lLNlZDekH0Iu3tYSJXNlCFt0ZuBLhmidzRIxz
         +KJj5i3+fDVnKsvmUnymgDMao30o0I6ONFw/5PfJk0BOmWLJvLVLkL37GPkuuJmGzJo4
         YhkImbe7I5VreVgPi6Jf56RRAcq28rK75c3QYLJZRvouVo17oAg+36bEBT5VUj9o7mZ7
         RYVsBOhEst3X9W8N/wF+MLqs5sKGnz+ct26tDnLn2xfSc11HeKrTpL+nFZBOJbF8nbZb
         RJMRZXQ51STLrJ9v/KMnv1IkVQrHPTOQpOhUalVfMywDMqgykW2fof2QKXg1Y9QtquHx
         2Cfg==
X-Gm-Message-State: AO0yUKX6YTohhlb73KFaEXbnv+WyDuXDmLvonvze7AFy3t72znS8qAbG
        48w9uYfgjNzqaBSPZqkOKKM=
X-Google-Smtp-Source: AK7set/tGK3i4/wh7V/kGHlS+gxB46+6uCjikXR7Cf/3tLigyXQLtTyfHOLyi19AB/HefjV28ihqYA==
X-Received: by 2002:a17:906:edcc:b0:928:a2:904e with SMTP id sb12-20020a170906edcc00b0092800a2904emr3708551ejb.54.1678824188955;
        Tue, 14 Mar 2023 13:03:08 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id jw22-20020a17090776b600b00926a3155fd0sm1548733ejc.98.2023.03.14.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:03:08 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: Use of_property_present() for testing DT property presence
Date:   Tue, 14 Mar 2023 21:03:07 +0100
Message-ID: <8191654.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20230310144720.1544600-1-robh@kernel.org>
References: <20230310144720.1544600-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 10. marec 2023 ob 15:47:20 CET je Rob Herring napisal(a):
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c  | 2 +-

for sun4i:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  drivers/phy/broadcom/phy-bcm-ns-usb2.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c
> b/drivers/phy/allwinner/phy-sun4i-usb.c index fbcd7014ab43..fc9f6fb447a0
> 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -758,7 +758,7 @@ static int sun4i_usb_phy_probe(struct platform_device
> *pdev) return PTR_ERR(data->vbus_det_gpio);
>  	}
> 
> -	if (of_find_property(np, "usb0_vbus_power-supply", NULL)) {
> +	if (of_property_present(np, "usb0_vbus_power-supply")) {
>  		data->vbus_power_supply = 
devm_power_supply_get_by_phandle(dev,
>  						     
"usb0_vbus_power-supply");
>  		if (IS_ERR(data->vbus_power_supply)) {
> diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> b/drivers/phy/broadcom/phy-bcm-ns-usb2.c index 6a36e187d100..269564bdf687
> 100644
> --- a/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> +++ b/drivers/phy/broadcom/phy-bcm-ns-usb2.c
> @@ -107,7 +107,7 @@ static int bcm_ns_usb2_probe(struct platform_device
> *pdev) return -ENOMEM;
>  	usb2->dev = dev;
> 
> -	if (of_find_property(dev->of_node, "brcm,syscon-clkset", NULL)) {
> +	if (of_property_present(dev->of_node, "brcm,syscon-clkset")) {
>  		usb2->base = devm_platform_ioremap_resource(pdev, 0);
>  		if (IS_ERR(usb2->base)) {
>  			dev_err(dev, "Failed to map control reg\n");




