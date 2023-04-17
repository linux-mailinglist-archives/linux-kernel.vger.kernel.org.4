Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B56E44F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjDQKQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjDQKQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:16:07 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20034222
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:15:14 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33HA36Cb083426;
        Mon, 17 Apr 2023 05:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681725786;
        bh=D8qr+Cv5rukZLTTodTnztsls7E4THvIR3CS/LIdzADM=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hNWBwi/xEGSlOsOkNKfi4s6Msd5bj270uhgmCKiE1KGLHP22CBmqPKxnHH+lsXeu/
         YeL3BLmn7Fe9YwNt8Acwg7Uv8Uo5ak+Xlcr8BXaTpYVCKrcL4Spv/cjzvFfdF0oJ2l
         e2N2xbM485FOHw7NTX/OQIf268XMI6MT07GxWRx0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33HA36mD065793
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Apr 2023 05:03:06 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 17
 Apr 2023 05:03:05 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 17 Apr 2023 05:03:05 -0500
Received: from [172.24.145.216] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33HA32Hp014978;
        Mon, 17 Apr 2023 05:03:02 -0500
Message-ID: <c224aead-9d75-bdfd-3282-6256fe64ef80@ti.com>
Date:   Mon, 17 Apr 2023 15:33:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] arm64: defconfig: Enable TI ADC driver
To:     Bhavya Kapoor <b-kapoor@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <broonie@kernel.org>, <rafal@milecki.pl>
References: <20230411110034.351950-1-b-kapoor@ti.com>
 <20230411110034.351950-3-b-kapoor@ti.com>
Content-Language: en-US
From:   Manorit Chawdhry <m-chawdhry@ti.com>
In-Reply-To: <20230411110034.351950-3-b-kapoor@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/04/23 16:30, Bhavya Kapoor wrote:
> Enable ADC driver to be built as a module which will
> add support for ADC in TI K3 specific SoCs.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6bbfcc9fdbf4..e320c9ec19aa 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1260,6 +1260,7 @@ CONFIG_QCOM_SPMI_ADC5=m
>   CONFIG_ROCKCHIP_SARADC=m
>   CONFIG_RZG2L_ADC=m
>   CONFIG_TI_ADS1015=m
> +CONFIG_TI_AM335X_ADC=m

Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>

For both the patches

Regards,

Manorit

>   CONFIG_IIO_CROS_EC_SENSORS_CORE=m
>   CONFIG_IIO_CROS_EC_SENSORS=m
>   CONFIG_IIO_ST_LSM6DSX=m
> --
> 2.34.1
>
>
>  From mboxrd@z Thu Jan  1 00:00:00 1970
> Return-Path: <linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org>
> X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
> 	aws-us-west-2-korg-lkml-1.web.codeaurora.org
> Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
> 	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
> 	(No client certificate requested)
> 	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33181C76196
> 	for <linux-arm-kernel@archiver.kernel.org>; Tue, 11 Apr 2023 11:01:56 +0000 (UTC)
> DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
> 	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
> 	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
> 	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
> 	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
> 	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
> 	List-Owner; bh=QznJ3/4o4FghKbmj86o9M+2wHHqO0lbFj/etKZyvaUM=; b=3ODwkCWupUHNN3
> 	RLKUyJaubJxX0qfcpKRGSpaeT/ba/MrIlZVUSENU9Lat/zuSr4DvhfQHOzNr0dJR+rsaYIPjw+yP/
> 	eehAARZazwnEf95yEws57RVy/R9+Vhsb/OqXZwCTakFmcjZQKfwDGlLyE4GPhtok0GBs3pxM1/0CN
> 	WLOEUKAyp7JFqRwuNJbhTNNxTDB7KhNQTgt68nPNieWzbdurzdZfScylA/zXoje6Z3TKY6hFvDE2k
> 	HqkgqUXqCBsNQDNvqn5ZfWiWRnZOKlvLBxCiuWLDf9//jteM1zRAJCzXUvJCTS/N/iwScM0cULF5D
> 	MhspKbG4zj9QNFOn8hzw==;
> Received: from localhost ([::1] helo=bombadil.infradead.org)
> 	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
> 	id 1pmBkG-00HOik-1A;
> 	Tue, 11 Apr 2023 11:01:04 +0000
> Received: from fllv0015.ext.ti.com ([198.47.19.141])
> 	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
> 	id 1pmBkB-00HOhK-12
> 	for linux-arm-kernel@lists.infradead.org;
> 	Tue, 11 Apr 2023 11:01:00 +0000
> Received: from lelv0265.itg.ti.com ([10.180.67.224])
> 	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33BB0c4J065813;
> 	Tue, 11 Apr 2023 06:00:38 -0500
> DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
> 	s=ti-com-17Q1; t=1681210838;
> 	bh=YkF7DFw9YYwRNKPOI1mkBNz0CQ1C+xFAZmDS70RoKC8=;
> 	h=From:To:CC:Subject:Date:In-Reply-To:References;
> 	b=mwrGHJ40WImysTNCy8esuSCx2YNaa/4YuPL0fHUJPWgulJxk2BZriOIOg1VcfmNiq
> 	 NBZu61JM9QOftyRsLN1o0mX4EglhEoAN+ZawqAuL/ng+jK/W8oA4+QZP/C6t9VT/RM
> 	 lk24Em250zJf9Oly41YnTUooc3fmyhJ1JNaP1Bj8=
> Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
> 	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33BB0cSR029171
> 	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
> 	Tue, 11 Apr 2023 06:00:38 -0500
> Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
>   (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
>   cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 11
>   Apr 2023 06:00:38 -0500
> Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
>   (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
>   cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
>   Frontend Transport; Tue, 11 Apr 2023 06:00:38 -0500
> Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
> 	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33BB0bHC031561;
> 	Tue, 11 Apr 2023 06:00:37 -0500
> From: Bhavya Kapoor <b-kapoor@ti.com>
> To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
> CC: <b-kapoor@ti.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
>          <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
>          <krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
>          <nfraprado@collabora.com>, <broonie@kernel.org>, <rafal@milecki.pl>
> Subject: [PATCH 2/2] arm64: defconfig: Enable TI ADC driver
> Date: Tue, 11 Apr 2023 16:30:34 +0530
> Message-ID: <20230411110034.351950-3-b-kapoor@ti.com>
> X-Mailer: git-send-email 2.34.1
> In-Reply-To: <20230411110034.351950-1-b-kapoor@ti.com>
> References: <20230411110034.351950-1-b-kapoor@ti.com>
> MIME-Version: 1.0
> X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
> X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3
> X-CRM114-CacheID: sfid-20230411_040059_397471_9E91A82A
> X-CRM114-Status: UNSURE (   8.70  )
> X-CRM114-Notice: Please train this message.
> X-BeenThere: linux-arm-kernel@lists.infradead.org
> X-Mailman-Version: 2.1.34
> Precedence: list
> List-Id: <linux-arm-kernel.lists.infradead.org>
> List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
>   <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
> List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
> List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
> List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
> List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
>   <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
> Content-Type: text/plain; charset="us-ascii"
> Content-Transfer-Encoding: 7bit
> Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
> Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=archiver.kernel.org@lists.infradead.org
>
> Enable ADC driver to be built as a module which will
> add support for ADC in TI K3 specific SoCs.
>
> Signed-off-by: Bhavya Kapoor <b-kapoor@ti.com>
> ---
>   arch/arm64/configs/defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 6bbfcc9fdbf4..e320c9ec19aa 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -1260,6 +1260,7 @@ CONFIG_QCOM_SPMI_ADC5=m
>   CONFIG_ROCKCHIP_SARADC=m
>   CONFIG_RZG2L_ADC=m
>   CONFIG_TI_ADS1015=m
> +CONFIG_TI_AM335X_ADC=m
>   CONFIG_IIO_CROS_EC_SENSORS_CORE=m
>   CONFIG_IIO_CROS_EC_SENSORS=m
>   CONFIG_IIO_ST_LSM6DSX=m
> --
> 2.34.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
