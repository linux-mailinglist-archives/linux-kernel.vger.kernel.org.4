Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E27E722498
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbjFELaH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:30:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbjFEL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:29:59 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F6FE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:29:56 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-977d02931d1so210794866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1685964595; x=1688556595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fcfFQz2kkXuEX9LLu8BP6v39M9e6iUA76icIqncfjU=;
        b=1q2MpNr3SINlbJ6UMSRGe5JaGXR1k+iCGB1kCLll/nRwqKhAkBRNUYyeL9l5O7XmT+
         ky5BvQ/kvHP1ufsLpIx5VLY2G8+Kc9IhjW2VeJGbHzsfTdo6v4HKaJnsgDoqeBEPdW+U
         G1gBiYRHxc/b2kTtZhnAUdpEwYM9StBqBS/G9DufoMNQ+Zx6LAvRTS+iJJduFnB6BKYf
         u+wptaBZmjfX+LWZXdAMjdb9iZnve9A3A/devxUCcFiINIKEuhqzkQGZyzy2tZx/jOcc
         ZpG0Fq3URxld/Jkzgh9ITRtD4d3P6CodojKqv92+XB8nm13YHj6hNGCYSiBuDh5QwmvL
         QJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685964595; x=1688556595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0fcfFQz2kkXuEX9LLu8BP6v39M9e6iUA76icIqncfjU=;
        b=M/YsamJ0ZGoNL6xP3SR/AYmELEM5WISlZnIWi4DQMbupUQI9Srto89SZ6qnmB7Cfns
         6dmZO30vtFIlohKRBII8d8T60GwnBmK3WS9eXv492eRrMF4ZAdt8GPnYBBNW+8Fzt/g/
         K5J5mxe6hq+YysDQDGM2pLh8qaAK8PuNxr8l3pd8HKZgzUijHdmfsNWEQ7xBMGXLf2T8
         ax/arx15yGW7ZYCbGnDJkREDKejBcRfKpr2oA1NIFV3t2HQ5YtFVu4SUxvdbFVmaJXwU
         rIMk+2u9aPGORUKS5Aop5U8Isc3iQ4uORgNLIwVrXBdGKjwfGnVeEgUYbaiYfZqxPuzl
         veTA==
X-Gm-Message-State: AC+VfDzvzvw7S407lM1uWotbcKscL+LzwynpqSBor2VCb2OpUKZym4pH
        vU9dCmj1ufUDsv7khUjbt/QQOzZvi4tH/y7Fin8Bk6HoqWIXE9Kfyjk=
X-Google-Smtp-Source: ACHHUZ5OWAgCYQFlwn8iVDHuplHPzjR5/FBmL6p+FZvdJjMFVypMfdUX5tGpCISNKtPcNP3U3ifgdBWnLBAEbD0D4gA=
X-Received: by 2002:a17:906:dacd:b0:974:1ced:6a56 with SMTP id
 xi13-20020a170906dacd00b009741ced6a56mr4743653ejb.32.1685964594964; Mon, 05
 Jun 2023 04:29:54 -0700 (PDT)
MIME-Version: 1.0
References: <f7773fdd002f89578b9e5262692a563fe7be4123.1684244928.git.michal.simek@amd.com>
In-Reply-To: <f7773fdd002f89578b9e5262692a563fe7be4123.1684244928.git.michal.simek@amd.com>
From:   Michal Simek <monstr@monstr.eu>
Date:   Mon, 5 Jun 2023 13:29:42 +0200
Message-ID: <CAHTX3dJ7j0CNJ07T2vubKMYO2s1oVEZgqh2jXMd_+ExgTbOA-g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Switch to @amd.com emails
To:     Michal Simek <michal.simek@amd.com>
Cc:     radhey.shyam.pandey@amd.com, shubhrajyoti.datta@amd.com,
        linux-kernel@vger.kernel.org, git@xilinx.com,
        srinivas.neeli@amd.com, derek.kiernan@amd.com,
        dragan.cvetic@amd.com, harsha.harsha@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C3=BAt 16. 5. 2023 v 15:49 odes=C3=ADlatel Michal Simek <michal.simek@amd.=
com> napsal:
>
> @xilinx.com is still working but better to switch to new amd.com after
> AMD/Xilinx acquisition.
>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
>
>  MAINTAINERS | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 60f6effb168c..4b2ef60a4d01 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23115,7 +23115,7 @@ F:      Documentation/devicetree/bindings/iio/adc=
/xlnx,zynqmp-ams.yaml
>  F:     drivers/iio/adc/xilinx-ams.c
>
>  XILINX AXI ETHERNET DRIVER
> -M:     Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> +M:     Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
>  S:     Maintained
>  F:     drivers/net/ethernet/xilinx/xilinx_axienet*
>
> @@ -23128,8 +23128,8 @@ F:      Documentation/devicetree/bindings/net/can=
/xilinx,can.yaml
>  F:     drivers/net/can/xilinx_can.c
>
>  XILINX GPIO DRIVER
> -M:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> -R:     Srinivas Neeli <srinivas.neeli@xilinx.com>
> +M:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +R:     Srinivas Neeli <srinivas.neeli@amd.com>
>  R:     Michal Simek <michal.simek@amd.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/gpio/xlnx,gpio-xilinx.yaml
> @@ -23138,8 +23138,8 @@ F:      drivers/gpio/gpio-xilinx.c
>  F:     drivers/gpio/gpio-zynq.c
>
>  XILINX SD-FEC IP CORES
> -M:     Derek Kiernan <derek.kiernan@xilinx.com>
> -M:     Dragan Cvetic <dragan.cvetic@xilinx.com>
> +M:     Derek Kiernan <derek.kiernan@amd.com>
> +M:     Dragan Cvetic <dragan.cvetic@amd.com>
>  S:     Maintained
>  F:     Documentation/devicetree/bindings/misc/xlnx,sd-fec.txt
>  F:     Documentation/misc-devices/xilinx_sdfec.rst
> @@ -23212,7 +23212,7 @@ F:      Documentation/devicetree/bindings/phy/xln=
x,zynqmp-psgtr.yaml
>  F:     drivers/phy/xilinx/phy-zynqmp.c
>
>  XILINX ZYNQMP SHA3 DRIVER
> -M:     Harsha <harsha.harsha@xilinx.com>
> +M:     Harsha <harsha.harsha@amd.com>
>  S:     Maintained
>  F:     drivers/crypto/xilinx/zynqmp-sha.c
>
> --
> 2.36.1
>

Applied.
M

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
