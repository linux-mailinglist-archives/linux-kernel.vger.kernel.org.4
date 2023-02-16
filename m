Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0922F699387
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjBPLrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBPLrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:47:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BAC1F922;
        Thu, 16 Feb 2023 03:47:20 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bu23so1558896wrb.8;
        Thu, 16 Feb 2023 03:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K/GymRTC8E30kXdASfjuHKtUeZnJnGl8Jnbq0ua5e4w=;
        b=pElrnzmI7gL4teX90A06t9foesLfwzg2W3jO4Ac+TptnGnaYWUeJT7aqzUVL9elwlz
         TBY2fVERHnMX2SDLV9WYl/W8cYbIRVq/WQyeBEuU7tbOcS1ZeTPVa11r1CNi2U3d63ih
         gGILu/yvs9q0kMx9c52+ZMs8kOs3eXknbum5pMWhJKDKTwt65Dj9d6yoK/COuFgJ0b7K
         qVyUM2dcTBOUJNBsQOCALgYXd2BLkaK+vgyQMOcZnh9IHTsRBKOe5q0wGVcU2vFU7rOi
         TodwibpS3sLPqy1n/ARtQ8Dbmk9T2vDUWE6tIeIGEwPXrpNM1Ed/oD/gvMTwzus2cxEO
         Fh0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/GymRTC8E30kXdASfjuHKtUeZnJnGl8Jnbq0ua5e4w=;
        b=elm4ewgrxXn3iW9GiR85iuDZ70uhjeGTG0ORfIAsxDx9tKgvGuATBAL0E9xzNphmsr
         MV84NAyWUOFBBaJi3RLUkmN3xalf/T+7g8oMbTRDm4caK12kB0SY0lI40fnFh8zTyhkc
         9zmDgFiEeJd6QcFEjix4S+b86Z5GDhaMv8w9OuYUzBpu85sfFeCtc09D1nPg/Ixrhwzr
         U86mQ03jK5POxn9qUU+SHb72St/RHgBrFGwFAKBrFrar5nbIcu+/r5eqjGIS9NAHNRaw
         P6yJUG78G+lGXONdWnTY5Om6zdABhzE5yJ819p0vGau6pRnSNPdonNFg5jCBHUcaKRWy
         +40w==
X-Gm-Message-State: AO0yUKX+gWAIOCAo/Jf14wjSPS+I1HZWEYQ9Hj7W4lLv+92Iep1EYtKF
        lG2Jvb96nneCWmR2l7yakWM=
X-Google-Smtp-Source: AK7set+4r8zWos74GXrVBfODT1MIee24TRa67kh+h9GiMPo+o4DQjgxdbo2YrQ/bsYkfXlTIWQFLkw==
X-Received: by 2002:a5d:6882:0:b0:2c3:fb3e:ae85 with SMTP id h2-20020a5d6882000000b002c3fb3eae85mr5416717wru.44.1676548038630;
        Thu, 16 Feb 2023 03:47:18 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o15-20020a5d62cf000000b002c406b357cfsm1320858wrv.86.2023.02.16.03.47.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 03:47:18 -0800 (PST)
Message-ID: <533e5cd4-713a-f683-1545-913b84d280c2@gmail.com>
Date:   Thu, 16 Feb 2023 12:47:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 02/12] arm64: dts: mediatek: mt8183-kukui: Update the
 node name of SCP rpmsg subnode
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230215041257.14548-1-tinghan.shen@mediatek.com>
 <20230215041257.14548-3-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230215041257.14548-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/2023 05:12, Tinghan Shen wrote:
> Align the node name with the definition in SCP bindings.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index fbe14b13051a..a259eb043de5 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -810,7 +810,7 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&scp_pins>;
>   
> -	cros_ec {
> +	cros-ec-rpmsg {
>   		compatible = "google,cros-ec-rpmsg";

There are more users of "google,cros-ec-rpmsg" which would nedd to be updated.

Regards,
Matthias

>   		mediatek,rpmsg-name = "cros-ec-rpmsg";
>   	};
