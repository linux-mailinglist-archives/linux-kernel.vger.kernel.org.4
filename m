Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11559722540
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 14:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjFEMJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 08:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjFEMJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:09:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D33F92;
        Mon,  5 Jun 2023 05:09:09 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3559ncW7006719;
        Mon, 5 Jun 2023 14:08:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=6wZOLEa3GpVYAhxU6J6dt+YaBwVxP3xhhj2G/143fFg=;
 b=Fogd2R/WBJ4wh35TzPUkP03ulMrCzWoqkt+rnvCmoTVL/6gMqmifu04UxXgNMTcAHHig
 HEm5ReXaYqrlfd6ZInaShg22w6JysJOuF6mnfetSkvXsdM9ivBoHVewJiY401QpWiTX1
 fgJ8comiS5lyiRSvHgfLre/v36q1FyzKCRsPwdZl71e3jCuBAs+5fms4nm1ls3r5zVug
 mvfiYyMdqR+tgb/BYdNa8aI7AFCojuwW2fZGe+AwgOMygk2vUyPvF4yK/huh7b18Uql9
 nzcCn7Pc7X4/imH4tXSbONwK4JGunf+kR7AegxaCye9VbXe9mPkVbcDXd2IVoey2G02f 6A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r1ddqru9w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Jun 2023 14:08:53 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1B25610002A;
        Mon,  5 Jun 2023 14:08:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1478222788C;
        Mon,  5 Jun 2023 14:08:51 +0200 (CEST)
Received: from [10.201.20.56] (10.201.20.56) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 5 Jun
 2023 14:08:50 +0200
Message-ID: <63e2c1bc-4a80-4857-899a-dd87d92c6f7e@foss.st.com>
Date:   Mon, 5 Jun 2023 14:08:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] serial: st-asc: fix typo in property name
Content-Language: en-US
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604083558.16661-1-rgallaispou@gmail.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230604083558.16661-1-rgallaispou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.56]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-03_08,2023-06-02_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphael

On 6/4/23 10:35, Raphael Gallais-Pou wrote:
> Changes the property name read in the driver according to the YAML.
> According to device-tree documentation, property names should not
> include underscores.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  drivers/tty/serial/st-asc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index 5215e6910f68..6ef99a037a9b 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -754,7 +754,7 @@ static struct asc_port *asc_of_get_asc_port(struct platform_device *pdev)
>  
>  	asc_ports[id].hw_flow_control = of_property_read_bool(np,
>  							"uart-has-rtscts");
> -	asc_ports[id].force_m1 =  of_property_read_bool(np, "st,force_m1");
> +	asc_ports[id].force_m1 =  of_property_read_bool(np, "st,force-m1");
>  	asc_ports[id].port.line = id;
>  	asc_ports[id].rts = NULL;
>  

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice
