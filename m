Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50A56FF34C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 15:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238033AbjEKNo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 09:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238170AbjEKNoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 09:44:10 -0400
Received: from sender4-op-o10.zoho.com (sender4-op-o10.zoho.com [136.143.188.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D652186;
        Thu, 11 May 2023 06:43:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683812625; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ahzbYv3GbsCy7qFGNW+TS6G1K255Zc8tPaWnlVtL34PzrIjWLJE3OcYUMNikkmzikiQxlaE8iQm1kcfJMFN6O7Z3atGtOsvcfvXBIe5AzcgpvwT1ufp3LS4+9sOGTbpluno1/8y0v1Kg4SLXtGTYn5LHr3fwJMWrWs0BjdfgCWo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683812625; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Kk1qAWGqn4/kFRbf5MQYGMlgX+H8kYV39hdmYP2/k+M=; 
        b=Keb9SULhVo2MJuQmSeY/mgDU31kNet+uzF3P37nYECsw37mqgogyKxRMD6Leoq8JAXhO53Y8P4qt5uRRdsI783IVEzpKgVwyu5UsTNX2MbHz5E8CvEXpsa4Pgpz+ZEmOdSKm/1crHfZwLHBmv79pWsDggsVQrDSP8e+D+qcHCpg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683812625;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Kk1qAWGqn4/kFRbf5MQYGMlgX+H8kYV39hdmYP2/k+M=;
        b=DGnJBJ4qU3CD7oYYjhpQrQ5OaZJCAWgCdNNNscX7qvtmkIYZZo1MhdT3glOuQ19p
        kzhMeXM/5brWbtD2hbwvQEwP1PLIAre522RVXXOfGQrE9rTqIT19RV9t2JY4NcI+Js2
        hLokbkq9lPKUPb9C/8tMKFdducaae4EOwCvmHb/Y=
Received: from [10.1.111.147] (185.242.250.116-ip.operadors.cat [185.242.250.116]) by mx.zohomail.com
        with SMTPS id 168381262314599.20625267029584; Thu, 11 May 2023 06:43:43 -0700 (PDT)
Message-ID: <7be59dc4-1663-9acc-ae5d-f0ad7e3b1053@arinc9.com>
Date:   Thu, 11 May 2023 15:43:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mips: dts: ralink: Add support for TP-Link HC220 G5 v1
 board.
Content-Language: en-US
To:     Liviu Dudau <liviu@dudau.co.uk>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230509200125.309026-1-liviu@dudau.co.uk>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230509200125.309026-1-liviu@dudau.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9.05.2023 22:01, Liviu Dudau wrote:
> This WiFi AP is based on a MT7621 SoC with 128MiB RAM, 128MiB NAND,
> a MT7603 2.4GHz WiFi and a MT7663 5GHz WiFi chips integrated on the board,
> connected to the main SoC over PCIe.
> 
> The GMAC1 on the SoC is connected to PHY0 on the GSW and can be used to
> improve routing bandwidth.
> 
> The device uses NMBM over NAND, which is not currently supported in the
> mainline, so NAND node is skipped in this revision.
> 
> Signed-off-by: Liviu Dudau <liviu@dudau.co.uk>
> ---
>   arch/mips/boot/dts/ralink/Makefile            |   3 +-
>   .../dts/ralink/mt7621-tplink-hc220_g5.dts     | 126 ++++++++++++++++++
>   2 files changed, 128 insertions(+), 1 deletion(-)
>   create mode 100644 arch/mips/boot/dts/ralink/mt7621-tplink-hc220_g5.dts
> 
> diff --git a/arch/mips/boot/dts/ralink/Makefile b/arch/mips/boot/dts/ralink/Makefile
> index 11732b8c8163a..c57a2b40876b4 100644
> --- a/arch/mips/boot/dts/ralink/Makefile
> +++ b/arch/mips/boot/dts/ralink/Makefile
> @@ -8,6 +8,7 @@ dtb-$(CONFIG_DTB_VOCORE2)	+= vocore2.dtb
>   
>   dtb-$(CONFIG_SOC_MT7621) += \
>   	mt7621-gnubee-gb-pc1.dtb \
> -	mt7621-gnubee-gb-pc2.dtb
> +	mt7621-gnubee-gb-pc2.dtb \
> +	mt7621-tplink-hc220_g5.dtb

No underscores please. And add v1 on the filename.

Arınç
