Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF54651FBD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLTLdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbiLTLcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:32:55 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ACF18E34;
        Tue, 20 Dec 2022 03:32:52 -0800 (PST)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BKBWZic121289;
        Tue, 20 Dec 2022 05:32:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1671535955;
        bh=Hv0mbIKFyBb598pquBKlVFVb7r1h3Fu4j9stmCLwOV4=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PHTk9AE9xGEYTv0kO727iLPBYS8JmgogTJk9aK8sEeT+pZdlaCczXhVh/VwzkfDrB
         j3EqR42a3diUrKsP4bgTL53ArX78A83/GbZnCR21dH557XIjs2n9ihuJyGpFgHUa0+
         2ZBwEUyKyq0XvZrj6+NDtza/VCR00Eu5mhC08ahY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BKBWZdD129770
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 20 Dec 2022 05:32:35 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 20
 Dec 2022 05:32:35 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 20 Dec 2022 05:32:35 -0600
Received: from [10.250.232.115] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BKBWVRq010449;
        Tue, 20 Dec 2022 05:32:32 -0600
Message-ID: <d882df13-33e6-db53-e59e-53419db4255d@ti.com>
Date:   Tue, 20 Dec 2022 17:02:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/3] Improve K3-am625-sk support (USB, MMC)
Content-Language: en-US
To:     Sjoerd Simons <sjoerd@collabora.com>, Nishanth Menon <nm@ti.com>
CC:     <martyn.welch@collabora.com>, Nitin Yadav <n-yadav@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tero Kristo <kristo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221216143624.23708-1-sjoerd@collabora.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20221216143624.23708-1-sjoerd@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/12/22 8:06 pm, Sjoerd Simons wrote:
> 
> This series picks up a few patches from the TI BSP tree that
> unfortunately didn't make it upstream thusfar.
> 
> The first patch improve SD card compatibility (allowing U1 class cards
> to be used), the remaining ones add USB support.
> 
> The type-c connector isn't entirely modelled with these changes as
> it goes through a TPS6598 PD controller. Unfortunately the dtb bindings
> for that currently require an irq line, which is not connected on E1 and
> E2 version boards. The patchese to support this setup unfortunately didn't land
> yet[0].. As such the last patch ignored the PD controller and simply
> configures usb0 as periphal only rather then mode switch capable, which
> at least gives some basic usability of that USB port.
> 
> 0: https://lore.kernel.org/lkml/f714ee55-ef47-317d-81b9-57020dda064b@ti.com/T/
> 
> 
Really appreciate porting and posting these patches to mainline!
Wondering what tree are these patches based on?
I cannot apply cleanly on linux-next.


> Aswath Govindraju (2):
>   arm64: dts: ti: k3-am62-main: Add support for USB
>   arm64: dts: ti: k3-am625-sk: Add support for USB
> 
> Nitin Yadav (1):
>   arm64: dts: ti: k3-am62-main: Update OTAP and ITAP delay select
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 90 ++++++++++++++++++------
>  arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 22 ++++++
>  2 files changed, 90 insertions(+), 22 deletions(-)
> 

Regards
Vignesh
