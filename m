Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8DB712642
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243038AbjEZMGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 08:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236664AbjEZMGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 08:06:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CA2E66;
        Fri, 26 May 2023 05:05:41 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QAhvxC025540;
        Fri, 26 May 2023 14:05:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YAD+QRu+FHSj9Eq1EY9SbCn4rmGwV2pr6NVxlQDczT4=;
 b=wYtieyBeRLzTpSRPI2RhKrx6qYAPDZgi3DIrkVXlJyo+PapREfB8HoriEnHC5su1uWNX
 DDWQPWXM4vi1rEkWIcnff37ctkqyK1B6JMKQ1vVER9tOMJW2Mp8xIoWaRX6wJg3aDTHa
 ASfitvxXOz4zpbJ++Hx9w5/rt1MXMlKN/JB+rUOm2obqn84xgN5M0CL95jLSPcC6OCY8
 +MQ4piAWWWxkUOJdV3MQyjxpVEOCJNZwLhqnN7hRIkh3NG1eXd8TacVDZ2REdShRImvP
 S4CC0/Fo2oJ4/nbmK8SlzriSVSXPVFc7HXTCSFTGhhG5UXTSWqFsgotV2sfSK4mdhfbG hg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qt4aw0r16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 14:05:24 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5E2FB10002A;
        Fri, 26 May 2023 14:05:23 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 550F122AFEF;
        Fri, 26 May 2023 14:05:23 +0200 (CEST)
Received: from [10.48.0.148] (10.48.0.148) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 26 May
 2023 14:05:22 +0200
Message-ID: <9faab8c9-a38b-3f06-c2fb-6c7803b22eb1@foss.st.com>
Date:   Fri, 26 May 2023 14:05:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] dt-bindings: backlight: document new property
 default-brightness-level
Content-Language: en-US
To:     Alexandru Ardelean <alex@shruggie.ro>,
        <dri-devel@lists.freedesktop.org>, <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fbdev@vger.kernel.org>
CC:     <lee@kernel.org>, <daniel.thompson@linaro.org>,
        <jingoohan1@gmail.com>, <pavel@ucw.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <deller@gmx.de>, Yannick Fertre <yannick.fertre@foss.st.com>
References: <20230519200520.10657-1-alex@shruggie.ro>
 <20230519200520.10657-2-alex@shruggie.ro>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <20230519200520.10657-2-alex@shruggie.ro>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.148]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/23 22:05, Alexandru Ardelean wrote:
> From: Yannick Fertre <yannick.fertre@foss.st.com>
> 
> Add documentation for new default-brightness-level property.
> 
> Reviewed-by: Philippe CORNU <philippe.cornu@foss.st.com>

Hi Alexandru,
same comments as for the 1/2 patch.
Many thanks
Philippe :-)

> Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
> 
> Link to original patch:
>    https://github.com/STMicroelectronics/linux/commit/c4067d7bd883c6fa14ffd49892c4ce663cdafe98
> 
>   .../bindings/leds/backlight/gpio-backlight.yaml          | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> index 584030b6b0b9..b96c08cff0f0 100644
> --- a/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> +++ b/Documentation/devicetree/bindings/leds/backlight/gpio-backlight.yaml
> @@ -23,6 +23,15 @@ properties:
>       description: enable the backlight at boot.
>       type: boolean
>   
> +  default-brightness-level:
> +    description:
> +      The default brightness level (index into the array defined by the
> +      "brightness-levels" property).
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +dependencies:
> +  default-brightness-level: [ "brightness-levels" ]
> +
>   required:
>     - compatible
>     - gpios
