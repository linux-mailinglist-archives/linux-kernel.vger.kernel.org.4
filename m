Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DED6924C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 18:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbjBJRrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 12:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjBJRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 12:47:13 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662161CAE3;
        Fri, 10 Feb 2023 09:47:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676051205; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=UQ3aLwYRNiudVAC8MzpRBVjQwZMc9SlQabizeZewOVzjZ3WnmCWnquR6zOh+u+LRXdw7QdTVQNxfOos7pO368pgVF3GHRZYM5Sn615H1Gkqh2yJiP4sDpQfeBfHofnASvOeoa93bH1Zpjr2L7viNQx91Tpdnny5RnTGQxKo/78w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676051205; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=iJbOjnXEW4dyp/XUoILzsS4muhY8sjkr0h1zI2/NyAE=; 
        b=C8bX1R6KC/+eMgf8rdL41qdiRRA4jFo7ppraM2S6ZpddmNWvTZn6oI3BY2P0Al7tgl20iD5FpvagEmfNAnIZ6ozBMH/fxIG7ziLHulPEjS/Rkyw/bDvh5u3/DM9rd1cHXaAKltlOmwcuvpSBf3oGpaxk+FlYAcKa5wNViIvl/Ls=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676051205;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=iJbOjnXEW4dyp/XUoILzsS4muhY8sjkr0h1zI2/NyAE=;
        b=JtmY47SxtBqshYc9GF1qQcVRCvOr4Yc29InmE8vE+IPa2L+0kdGNPAssT91Ort73
        S2/7xQbabuih3JP9Ya2rLl3D4RA7AQf2G5a/0Q+KwHcfxPZQ7k0ro0VBLM92yqA0FVG
        bfuYVDwWZm6YUFL1hSnAxnCFnRYjwBaF5+YUbwIw=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676051202563779.3472396397366; Fri, 10 Feb 2023 09:46:42 -0800 (PST)
Message-ID: <3ca26ba2-80f5-32a2-0357-d91c87efd1c0@arinc9.com>
Date:   Fri, 10 Feb 2023 20:46:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 2/4] mips: dts: ralink: mt7621: add phandle to system
 controller node for watchdog
Content-Language: en-US
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20230210173841.705783-1-sergio.paracuellos@gmail.com>
 <20230210173841.705783-3-sergio.paracuellos@gmail.com>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230210173841.705783-3-sergio.paracuellos@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Could you also change the node name to watchdog@100? make dtbs_check 
points it out:

wdt@100: $nodename:0: 'wdt@100' does not match '^watchdog(@.*|-[0-9a-f])?$'

Thanks.
Arınç

On 10.02.2023 20:38, Sergio Paracuellos wrote:
> To allow to access system controller registers from watchdog driver code
> add a phandle in the watchdog 'wdt' node. This avoid using arch dependent
> operations in driver code.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>   arch/mips/boot/dts/ralink/mt7621.dtsi | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/boot/dts/ralink/mt7621.dtsi b/arch/mips/boot/dts/ralink/mt7621.dtsi
> index 5ca40fd21..764916eaf 100644
> --- a/arch/mips/boot/dts/ralink/mt7621.dtsi
> +++ b/arch/mips/boot/dts/ralink/mt7621.dtsi
> @@ -73,6 +73,7 @@ sysc: syscon@0 {
>   		wdt: wdt@100 {
>   			compatible = "mediatek,mt7621-wdt";
>   			reg = <0x100 0x100>;
> +			mediatek,sysctl = <&sysc>;
>   		};
>   
>   		gpio: gpio@600 {
