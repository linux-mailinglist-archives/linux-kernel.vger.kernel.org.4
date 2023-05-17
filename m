Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9720B706D14
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEQPmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjEQPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:42:02 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F95F618E;
        Wed, 17 May 2023 08:41:57 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id A079A846BF;
        Wed, 17 May 2023 17:41:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1684338115;
        bh=yu+HBQ+xsF7Vdw92aEE9A/go0SCqzU/xKdNUXvOwEPA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Jod5jwz3UbECy2pApjdZKKmx9LfmUwR0C3LKq+MPolY/ieAuWh/CUTuNU4BwSrC4A
         PAm9tS+DtaOTkWicX9m0rC+utJPR/3TFzWH7M04hccR8vxYfenU3enqR5H08XpcjMD
         I/zDYk0cdSkV4YXHaCHqCTWU2VqXBQXsl/SlLRkLPnt1+1CKj1dVYOKyiEYvbPQExh
         F3eD0RgqAn5oOEWMuiPqpHgR/83/cQ8vG+IA8p1uP9SFxnhb28kL1deQG6TI2yO85P
         fP5jyAfh0oOZ2/cnFf1Yn2ikYTM5hWciIv7MPZg4+kJhVKm8xq+1n+JBoUTA6PgegX
         LvshId/EEoehw==
Message-ID: <f64de05b-8854-4345-80c2-f424968defdc@denx.de>
Date:   Wed, 17 May 2023 17:41:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] ARM: dts: stm32: fix several DT warnings on
 stm32mp15
Content-Language: en-US
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@dh-electronics.com
References: <20230517143542.284029-1-raphael.gallais-pou@foss.st.com>
 <20230517143542.284029-4-raphael.gallais-pou@foss.st.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230517143542.284029-4-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 16:35, Raphael Gallais-Pou wrote:

Hi,

> diff --git a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> index 0f1110e42c93..a6e2e20f12fa 100644
> --- a/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> +++ b/arch/arm/boot/dts/stm32mp15xx-dkx.dtsi
> @@ -457,8 +457,7 @@ &ltdc {
>   	status = "okay";
>   
>   	port {
> -		ltdc_ep0_out: endpoint@0 {
> -			reg = <0>;
> +		ltdc_ep0_out: endpoint {
>   			remote-endpoint = <&sii9022_in>;
>   		};
>   	};

This LTDC port/endpoint stuff always scares me, because I always feel I 
get it wrong.

I believe the LTDC does have one "port" , correct.

But I think (?) that the LTDC has two endpoints, endpoint@0 for DPI 
(parallel output out of the SoC) and endpoint@1 for DSI (internal 
connection into the DSI serializer) ?

Only one of the endpoints can be connected at a time, but there are 
actually two endpoints in the LTDC port {} node, aren't there ?

So the original description should be OK I think , maybe 
#address/#size-cells are missing instead ?
