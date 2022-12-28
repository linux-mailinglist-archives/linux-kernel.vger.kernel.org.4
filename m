Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE9658530
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 18:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiL1RQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 12:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiL1RQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 12:16:28 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978C312A88;
        Wed, 28 Dec 2022 09:16:27 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-144bd860fdbso19227637fac.0;
        Wed, 28 Dec 2022 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SPha2JC7a5iWhjDoT4npjZ1YLSAi405g3BMufo6wT/g=;
        b=UbT1axoKTsV9y4Vh/fM15Otwo/1bmqUw6oOxnmBX9m29PNANBbRtcMla9mQWFkBEuR
         bOevDFSgFQyyE33xJ5HFcnheKlvquZxG1j7NSsc3AURg9SHa+pv9cNI0bMdVF4LxqSrb
         3Ctrhh3uqHpv+DtTs+kH6BoHH7AYgopIxOBFca6jOvFP5OypuVkwYGXGuw9+bC2jalnD
         QJTKDEtVWK82cxnA3oXriJNuQqioj70VoU5b/vbXwH2Vcg69kZydvGIUZA4iwwf2xk5c
         +YrpybWZrDTCn/O1/qy+LPWotLK8U1CVDKqAC53EcRGBIpy8U3BaavqLeTqB5IHT0+ww
         gW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPha2JC7a5iWhjDoT4npjZ1YLSAi405g3BMufo6wT/g=;
        b=tMCBUy4ZANLubtoRg1Ziudnwlj5Gy3f7NtLE4cfoa69O3fwNsYVJDsefFztYCL00WF
         5iYSDZo3iDCCPfB/xhk1rD6oDCCGMem3Xdb0fOy82bh6Z2oQU+ehK+0pERQ1U1Vaomp9
         YcAtivZrC995+9GQrmg9icGF8tzwpJtS+pkFKxRWoX2EvtziU9RWltVK3uo0yWLcEIc0
         wEg0Gj+xEkQFPdsnCMSMmS5/gxEliSmxGcI8lbR8M1PK/BzB2zaUJqY/1a4yeqp1ulPD
         7NcGvvx9azFZ/4vHUIFNUnrUHYVvGiubCsvO7VRfBF+O2EmgLQWFAl5byleryKqo1vBS
         Pcqw==
X-Gm-Message-State: AFqh2kq7UBmR+ZQX5+B6nyD8s1krvItlDCOXRK7KYEdgYSQ03hgP3pIQ
        ivXr80q6YmrlikteeYO1LtA=
X-Google-Smtp-Source: AMrXdXsYX4EqajaqLFS10AU61WljgCZOA1UeSh/cwjMj5l5aHoT7rCfWm4TxzifkG6rBbi7x//0jwg==
X-Received: by 2002:a05:6870:883:b0:14f:e487:11b9 with SMTP id fx3-20020a056870088300b0014fe48711b9mr5358432oab.56.1672247786858;
        Wed, 28 Dec 2022 09:16:26 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g15-20020a9d6a0f000000b006770e855c61sm8015918otn.31.2022.12.28.09.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 09:16:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 09:16:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     nick.hawkins@hpe.com
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com, corbet@lwn.net,
        linux@armlinux.org.uk, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/6] MAINTAINERS: add gxp fan controller and documents
Message-ID: <20221228171625.GA2575735@roeck-us.net>
References: <20221130200846.4226-1-nick.hawkins@hpe.com>
 <20221130200846.4226-7-nick.hawkins@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130200846.4226-7-nick.hawkins@hpe.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 02:08:46PM -0600, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Add the gxp-fan-ctrl.c and gxp-fan-ctrl.rst in hwmon
> driver/documentation.
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

For my reference:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

... assuming the assumption is that I would apply the patch through
the hwmon subsystem. If not please let me know.

Guenter

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1daadaa4d48b..00b52be102d6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2216,13 +2216,16 @@ ARM/HPE GXP ARCHITECTURE
>  M:	Jean-Marie Verdun <verdun@hpe.com>
>  M:	Nick Hawkins <nick.hawkins@hpe.com>
>  S:	Maintained
> +F:	Documentation/hwmon/gxp-fan-ctrl.rst
>  F:	Documentation/devicetree/bindings/arm/hpe,gxp.yaml
> +F:	Documentation/devicetree/bindings/hwmon/hpe,gxp-fan-ctrl.yaml
>  F:	Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
>  F:	Documentation/devicetree/bindings/timer/hpe,gxp-timer.yaml
>  F:	arch/arm/boot/dts/hpe-bmc*
>  F:	arch/arm/boot/dts/hpe-gxp*
>  F:	arch/arm/mach-hpe/
>  F:	drivers/clocksource/timer-gxp.c
> +F:	drivers/hwmon/gxp-fan-ctrl.c
>  F:	drivers/spi/spi-gxp.c
>  F:	drivers/watchdog/gxp-wdt.c
>  
