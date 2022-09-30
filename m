Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 082445F04CC
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiI3Gam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiI3Gag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:30:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296111005EF;
        Thu, 29 Sep 2022 23:30:34 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TMWHdG004121;
        Fri, 30 Sep 2022 08:30:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Vbk+7vl2UPlDx4z5gYqs91y5clSkhvrc8BmQ9thvp+w=;
 b=mAa2YA6lkLxP2HL7StBZJzdTUtKIYOhPNku2x8S5cuEesqxBxUH9JS1Gk0kVv3l9MHL6
 PoslWCe78uhF0y9OZf2fcMx+l6dzQ+vjSFH/V6fxktElViPmHHGOtv3fAkWBHUOaLrJx
 qn6hrMq/r9sOC5ssCQ8quqS7m7TQDN9Tw7CLDDnEaYLTESeEj9lEZGiLn5QcbSOrxomM
 5qpNQtEgJsEYveTFlWA6CWb0AhDXuWmDGU5M2EpTxHXXo3DDY5vYlWIJ4cQm7TX0ByR3
 886FQjS2Lhb644SyoMF/uZw/Li67uSXXg6yf4Wu6lYtxITJ+8mpIUNqSkPVATxvpa6p1 OQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jss82ur2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Sep 2022 08:30:06 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F080E10002A;
        Fri, 30 Sep 2022 08:30:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E8185212FB7;
        Fri, 30 Sep 2022 08:30:04 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.50) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 30 Sep
 2022 08:30:04 +0200
Message-ID: <b3184722-3cbe-5720-8963-3a8517ed1226@foss.st.com>
Date:   Fri, 30 Sep 2022 08:30:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RM: dts: stihxxx-b2120: fix polarity of reset line of
 tsin0 port
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alain Volmat <avolmat@me.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <YzXuU/60TI3tc6ii@google.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <YzXuU/60TI3tc6ii@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-30_03,2022-09-29_03,2022-06-22_01
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry

On 9/29/22 21:13, Dmitry Torokhov wrote:
> According to c8sectpfe driver code we first drive reset line low and
> then high to reset the port, therefore the reset line is supposed to
> be annotated as "active low". This will be important when we convert
> the driver to gpiod API.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/arm/boot/dts/stihxxx-b2120.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> index 2aa94605d3d4..d52a7aaa1074 100644
> --- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
> +++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
> @@ -178,7 +178,7 @@ tsin0: port {
>  				tsin-num = <0>;
>  				serial-not-parallel;
>  				i2c-bus = <&ssc2>;
> -				reset-gpios = <&pio15 4 GPIO_ACTIVE_HIGH>;
> +				reset-gpios = <&pio15 4 GPIO_ACTIVE_LOW>;
>  				dvb-card = <STV0367_TDA18212_NIMA_1>;
>  			};
>  		};
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
