Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DD3692FAB
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBKJLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 04:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKJLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:11:02 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A81E15CBF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 01:11:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1676106635; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=XLpxwGDssbk28zpX4VqVA+NB4NYPD2zFICu8oQ3hCEpm6IHTT16uz5grkp8YpYdS7bm8njXNe3vMnF7aQD3IkstjF+fVaLZuDYm0uOdbatorbAsFmbwxBGVoGLqIeXJQrc1OwwTTFezyEHAkh6s0s5T4uFxyDF/0zzeJk8q/x2Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1676106635; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=P4v9Y6wWmEZjwnGp73bMYV/GVcHUdzW6CDlIM+NzznU=; 
        b=X35hodZ6oJmxo4mJqpSKPNsRly6ad8Jy6nIqVIjgJuS9PKi0DlALcVZ/7XTHwViTReBZzq6Dos17U0SFFPn1dAkWpxej5zLS7s9pErUoYuiL3Fb3+M4EKz7OMtSU9wwaSx387PJbWVfo8HZU2ZxSACTyHpD8FBTpmVIMABpaVbE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1676106635;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=P4v9Y6wWmEZjwnGp73bMYV/GVcHUdzW6CDlIM+NzznU=;
        b=UIUoylujyo7F/jmVOTsKaVdKzFzxGajtOGwExXVKxaYk5913l0RdyxfpsGCUE/Pa
        oqHUx2IpZltVT3frJb73P3xALipjVQIlplQP1/yG5Dq6nb0+YXD6Ttgx3hGtY7e2Juy
        0GCSPN82OQdGTzopBR4Z0+Lj0KWe43Qd3Cx7Ldb0=
Received: from [10.10.10.3] (37.120.152.236 [37.120.152.236]) by mx.zohomail.com
        with SMTPS id 1676106633895687.047830496387; Sat, 11 Feb 2023 01:10:33 -0800 (PST)
Message-ID: <190b3135-82f3-4dfa-55ee-e048c5510e3c@arinc9.com>
Date:   Sat, 11 Feb 2023 12:10:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 1/5] dt-bindings: watchdog: mt7621-wdt: add phandle to
 access system controller registers
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        tsbogend@alpha.franken.de, p.zabel@pengutronix.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org
References: <20230211073357.755893-1-sergio.paracuellos@gmail.com>
 <20230211073357.755893-2-sergio.paracuellos@gmail.com>
Content-Language: en-US
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230211073357.755893-2-sergio.paracuellos@gmail.com>
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

Is this mediatek,sysctl property required after your changes on the 
watchdog code?

Arınç

On 11.02.2023 10:33, Sergio Paracuellos wrote:
> MT7621 SoC provides a system controller node for accessing to some registers.
> Add a phandle in this node to avoid using MIPS related arch operations and
> includes in watchdog driver code.
> 
> Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> ---
>   .../devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml  | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> index b2b17fdf4..a668d0c2f 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mt7621-wdt.yaml
> @@ -19,6 +19,12 @@ properties:
>     reg:
>       maxItems: 1
>   
> +  mediatek,sysctl:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      phandle to system controller 'sysc' syscon node which
> +      controls system registers
> +
>   required:
>     - compatible
>     - reg
> @@ -30,4 +36,5 @@ examples:
>       watchdog@100 {
>         compatible = "mediatek,mt7621-wdt";
>         reg = <0x100 0x100>;
> +      mediatek,sysctl = <&sysc>;
>       };
