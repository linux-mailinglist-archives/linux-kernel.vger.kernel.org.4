Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A856F6D1EA0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjCaLAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjCaLAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:00:02 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992E71EA2F;
        Fri, 31 Mar 2023 03:58:01 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n19so12650587wms.0;
        Fri, 31 Mar 2023 03:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680260275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ruVZ+nqpPxejELcPa+QVovP9EcRxs5XzTtjPXBzPybw=;
        b=STGlQbl5pdqAFFPeA9oH+J5ICEFK3qkxQEvxknmC4v2OlpiSrx877BUe9QlCmArIRa
         PoVbu3en0sjd/b4Iokb1AiZ2ClE2HLGtYEN2xQ0DkUxDUj7G71wCC5b4zg2OJHG5ka4i
         qAeJszAOv1lbO7hwrOLAZvzj/KJOb0f9AOJO2Wmieh5Yh9VEZGAUJKlRs3fqIN+KVEgf
         UaZFhEvHrXoZ8dbanR0Z2ODNhcRELXvdARzimA772eEt75Se2cZ4F8/2NTKqzMuwj7Gk
         MU9RrX0CCqcV4b9bcBrDbxMjljcjBRfZHcNuSWbI+UQCmeOUO70voDs6hLJCgUM/SV62
         6HzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680260275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruVZ+nqpPxejELcPa+QVovP9EcRxs5XzTtjPXBzPybw=;
        b=W9gZ2tlpWrwozkmFmq/uPYoSRCH44GadX/g0DKs5GEfaiMFES8VBSVizABaGQ3aVtP
         6ao0JJnip4VBJvuJGG4W6go0diF+guT5QOhPLaIaY+iR/U9HOCeJTOxLYRs9YVWCIY+f
         PIUDS96H7PBgOn65+HE+hX8/iLWGt9nxxW5YTWdd7AkKJBuG6wOZdzas5IcuPAeaawW2
         v8PwX+n76P6m9kxQTg3k+a91UhgTsOEr+3gSYvMFMZqQPnWXTDjEmduXdV8oxFuiHbGG
         g8Yh6SAdLwrn197UFOgfhtsnHHxsWxVt4nHOrMhfdkgRj2Kmm4G9OZl6kHsLOZY8tGFz
         A6zw==
X-Gm-Message-State: AO0yUKXFf8b6JVBDpBKxRwGxVQOWbQkekPL5PzE6fKV3wb9FX6QCCV4I
        96v0Wr7nXPJlmWyx2zl8ASI=
X-Google-Smtp-Source: AK7set/NThtTJbIt9LOK6pAdTg6KLO5h2EdvVtCl5moj2821TwWnFFcOLxxqECrDAvoDTccyuFfKOw==
X-Received: by 2002:a05:600c:22d5:b0:3ee:3d2d:841a with SMTP id 21-20020a05600c22d500b003ee3d2d841amr21155578wmg.24.1680260275314;
        Fri, 31 Mar 2023 03:57:55 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id y22-20020a7bcd96000000b003ee42696acesm2300375wmj.16.2023.03.31.03.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 03:57:54 -0700 (PDT)
Message-ID: <b90a3440-53f8-9384-155a-f7ac2b7f2e9c@gmail.com>
Date:   Fri, 31 Mar 2023 12:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v9 02/11] arm64: dts: mediatek: Update the node name of
 SCP rpmsg subnode
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
References: <20230328022733.29910-1-tinghan.shen@mediatek.com>
 <20230328022733.29910-3-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230328022733.29910-3-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/03/2023 04:27, Tinghan Shen wrote:
> Align the node name with the definition in SCP bindings.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi   | 2 +-
>   arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
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
>   		mediatek,rpmsg-name = "cros-ec-rpmsg";
>   	};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> index 9f12257ab4e7..8f14b633c1e1 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
> @@ -1260,7 +1260,7 @@
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&scp_pins>;
>   
> -	cros-ec {
> +	cros-ec-rpmsg {
>   		compatible = "google,cros-ec-rpmsg";
>   		mediatek,rpmsg-name = "cros-ec-rpmsg";
>   	};
