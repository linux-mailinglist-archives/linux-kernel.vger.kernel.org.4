Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4791750C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjGLPXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbjGLPXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:23:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188FE1FC2;
        Wed, 12 Jul 2023 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=BzoSYMa4OL3iPzE0SWPGTeCz8COqc+a7aWf/p8NDp6w=; b=tlxt1Oj6MSqoLM3JkFjr/4Qyaw
        6MPjlBg/GDAzL8hATBH1yzBkxSr8nGTyzkAzOs5jNtkqRqH2TdRHE6IQUluFRO5llqr5t5Oqe4Zru
        el+6hM+o6SenXAgktCEN0mZmclpWGCccdvbaJphVTSi2yQL2rt/gbEYzYzR5svhzTFzo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qJbgX-0019aH-TA; Wed, 12 Jul 2023 17:23:21 +0200
Date:   Wed, 12 Jul 2023 17:23:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?iso-8859-1?Q?Ren=E9?= Kjellerup <rk.katana.steel@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Aleksey Nasibulin <alealexpro100@ya.ru>, stable@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: BCM5301X: Extend RAM to full 256MB for Linksys
 EA6500 V2
Message-ID: <fc94da45-aba8-4e69-a1a0-c1d58a90c68c@lunn.ch>
References: <20230712014017.28123-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712014017.28123-1-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> --- a/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
> +++ b/arch/arm/boot/dts/broadcom/bcm4708-linksys-ea6500-v2.dts
> @@ -19,7 +19,8 @@ chosen {
>  
>  	memory@0 {
>  		device_type = "memory";
> -		reg = <0x00000000 0x08000000>;
> +		reg = <0x00000000 0x08000000>,
> +		      <0x88000000 0x08000000>;

So there is a hole in the middle? Does this require any special
CONFIG_ option to support sparse memory?

	Andrew
