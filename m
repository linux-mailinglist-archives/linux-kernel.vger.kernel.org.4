Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B01702B50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240178AbjEOLUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbjEOLUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:20:50 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BB3F9C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 04:20:48 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34F9llco004402;
        Mon, 15 May 2023 13:20:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dfJ4rizXxwF4addGBsh3lweiswGQlhh2D6rEKH2UdC4=;
 b=pFpAPPvElQbTHmtyduc83EhjACPOF0drACRuYsUM6mmhBSBzf7NzEHzR9kwxD8JGIz/T
 atoOVIBwL3xscNxjnRVjZ4X+43Gv59kUAS/f8hLawg0dEsksDy/h0tZYat003atIVWhJ
 H+jwZ3YHvljqgm7FsNCao83TsgZlFEoKkk7NOPVowykLrgAqY3mQPNmhS6bgYjL8PwlP
 hnanvsSwvQuTG9B4WbcQz7PcETdqyiDR9sHUC+V3J3robpI7XyL+8XU0PjYEh5GJcc1B
 0geUhVVfjBAFflqMBQSLP4bF6jcsWTti/+OdaeyCyHo+5KnedIVugnKIcnPVYusNbmMo EA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qhyyh29hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 May 2023 13:20:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 865E210002A;
        Mon, 15 May 2023 13:20:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5CDA8228A25;
        Mon, 15 May 2023 13:20:33 +0200 (CEST)
Received: from [10.48.0.85] (10.48.0.85) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 15 May
 2023 13:20:33 +0200
Message-ID: <7ca8a275-350b-bbb1-b5ce-e8fc61ea3085@foss.st.com>
Date:   Mon, 15 May 2023 13:20:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] MAINTAINERS: Update Alain Volmat's email address for
 drm/sti
To:     Alain Volmat <avolmat@me.com>, <arnd@arnd.de>
CC:     <dri-devel@lists.freedesktop.org>, <patrice.chotard@foss.st.com>,
        <linux-kernel@vger.kernel.org>
References: <20230416202747.62479-1-avolmat@me.com>
Content-Language: en-US
From:   Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20230416202747.62479-1-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.85]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_09,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/23 22:27, Alain Volmat wrote:
> Update my email address for maintainer of the STi DRM driver.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e64787aace8..3cec7ad72389 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6952,7 +6952,7 @@ F:	Documentation/devicetree/bindings/display/rockchip/
>   F:	drivers/gpu/drm/rockchip/
>   
>   DRM DRIVERS FOR STI
> -M:	Alain Volmat <alain.volmat@foss.st.com>
> +M:	Alain Volmat <avolmat@me.com>
>   L:	dri-devel@lists.freedesktop.org
>   S:	Maintained
>   T:	git git://anongit.freedesktop.org/drm/drm-misc

Hi Alain,
Reviewed-by: Philippe Cornu <philippe.cornu@foss.st.com>
Many thanks
Philippe :-)
