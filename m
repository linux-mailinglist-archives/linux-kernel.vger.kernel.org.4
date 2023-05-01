Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D68D6F34D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 19:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjEAREa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 13:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjEAREM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 13:04:12 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756B41723;
        Mon,  1 May 2023 09:57:46 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 77EB080F77;
        Mon,  1 May 2023 18:57:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1682960237;
        bh=b3qkibK7joujGHhVtrdK8VQC4GW/YOZzJdxGgN5lC1s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WHubrOxIRYZGhwaWLgw65oxEk9rEPGVynFE51nHGQBYQw0tWOd/xeNvr6WZHbFWzH
         JaIf8/9I0osfDKWP5QVG9AQx/NP6zyBDhZyTDy4EyQdbb76eP5b8eOSWpcS8q/gswO
         7stGo/pyVjpnpkt6i5dYnPW2JosGow7ijnvc/7ISjJR3kdmBHqdWbcCGV0ca88vKVV
         JxXEwzj88TYvtZ1UtxcoQtuN7H/+P4Inw7VLkqNvNCoajsoIxjAxTmUTAyJz7qCx9J
         O+xnk9PeFGdKJsNwqO0RkGhZIpqZN5VSABPubgzgmc41zQ/fNT2DfbUd67XUYijaLb
         4CrsUR5/FPNbw==
Message-ID: <ebd5de56-38c3-bbe4-0d98-45934aea61a7@denx.de>
Date:   Mon, 1 May 2023 18:57:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V2 ] bindings: arm64: Add an entry in imx8mm boards for
 Emtop SOM-IMX8MM
Content-Language: en-US
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Cc:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@denx.de" <festevam@denx.de>,
        "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>,
        "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
        "max.krummenacher@toradex.com" <max.krummenacher@toradex.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "matthias.schiffer@tq-group.com" <matthias.schiffer@tq-group.com>,
        "denys.drozdov@toradex.com" <denys.drozdov@toradex.com>,
        "leoyang.li@nxp.com" <leoyang.li@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BM1PR01MB4899F56FF3D6A2C0F3C3C3449A6E9@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <BM1PR01MB4899F56FF3D6A2C0F3C3C3449A6E9@BM1PR01MB4899.INDPRD01.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/1/23 18:37, Himanshu Bhavani wrote:
>>From 8b789f3a997c1fbe253e9b5c5f5c370b262f7efd Mon Sep 17 00:00:00 2001
> From: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> Date: Mon, 1 May 2023 21:59:47 +0530
> Subject: [PATCH] Add an entry in imx8mm boards for Emtop SOM-IMX8MM

Can you try and use 'git send-email' to send your patch ?

git send-email --annotate --to=devicetree@vger.kernel.org -1 HEAD

> Change in v2:
> 	- Update vendor name
> 	- Add board name

This should be ...

> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>


... here, but also add '---' line above it, like so:

---
V2: - Do stuff
     - Other stuff
V3: - More stuff ...

> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 442ce8f4d675..06eb2c790f90 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -884,6 +884,7 @@ properties:
>                 - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
>                 - boundary,imx8mm-nitrogen8mm  # i.MX8MM Nitrogen Board
>                 - dmo,imx8mm-data-modul-edm-sbc # i.MX8MM eDM SBC
> +              - emtop,imx8mm-emtop          # i.MX8MM Emtop SoM

Please also update 
Documentation/devicetree/bindings/vendor-prefixes.yaml with emtop vendor 
prefix, do so in separate patch.
