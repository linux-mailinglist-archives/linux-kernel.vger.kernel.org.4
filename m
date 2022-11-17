Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A533D62E05E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:53:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbiKQPxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiKQPxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:53:34 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B71093;
        Thu, 17 Nov 2022 07:53:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id k8so4616664wrh.1;
        Thu, 17 Nov 2022 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lgeyqq4V2xeaVGb3HNx7wFZLtkDW7im+x1haPklssOU=;
        b=COleCBgGfskJyMtBdjyzQ5TJAu6BVoUip0XI2qaMKzeWYtVroAKQ7km0EsnQBtSdJe
         rXeZtFpTu/oQFowU9hS4+AndKvwRgXo0qxQg4wPHtIDeYqqSef9QFiD/TptIXzFA6pqJ
         vv64a5vwXLnQFE0oHMQIAWF3AdszFQ4+muH7lSj4np6Yzg8LmDQ1Q81+tYsN0/dLJcl2
         rqYr52FAiIV2j0cMqXXuZY5GOumjiVvX/xAWE058y/vXy3BScU8moxvB1j51Nwj7Phup
         LgcHAwGleOm+NlYwuM1Q9AlsivIjX6Tamr45Bpa/sIX2bXXy9S14d1emCeXPGXQ4eSsj
         KBXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgeyqq4V2xeaVGb3HNx7wFZLtkDW7im+x1haPklssOU=;
        b=fiwCBO4mNplCcXEW1TMwg0JXZmiey11x+ywnnaKzf/W8tTCDHLOdhJ269NucP4x6iK
         Ji9JbXlusAOJfuMjxP4Z4VXRdSyvY01qC6yqiUghdB8eCunrfoSVDhQcoSLPmuffEhY5
         OdvAyNoPZ58HtiWGMA6ndHPgm5q2mR9vfDHPsMNU6Vamd3OhZMW2/fnrcFEE60b0mlgf
         9Xygt1Ae8nVxfSdmMqOrIS5di7bcfxlfj3ZonVFn5oV3+taPsofHuM/wBifQaOHvqfu/
         Ou8bg6cPviUfc34BnfYuJQxaO8pWXC3o6gVFp/ND43P2JaHhZg6rmoJitIJe+0XeH4Uk
         jdxA==
X-Gm-Message-State: ANoB5plNrmqBCEL69kQFx4xa55g7FgJHYGmo2JGI48euLvHStGdTnO63
        fdvQ834uXB4zuqvOMSXYXJWkAmIOY+0=
X-Google-Smtp-Source: AA0mqf6CSXvB7fJEGy8sU3KquiMYDpizvrXZNaALs1X9u0ExYmw9K8LKvME/eHVIFW4lj8rV1Xqoiw==
X-Received: by 2002:adf:f601:0:b0:236:55a7:348f with SMTP id t1-20020adff601000000b0023655a7348fmr1913435wrp.331.1668700408256;
        Thu, 17 Nov 2022 07:53:28 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0acf00b003c21ba7d7d6sm1571445wmr.44.2022.11.17.07.53.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 07:53:26 -0800 (PST)
Message-ID: <fd2a6390-9395-6fd2-04bc-8d9d55c2efdd@gmail.com>
Date:   Thu, 17 Nov 2022 16:53:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt7986: Add SoC compatible
Content-Language: en-US
To:     matthias.bgg@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, frank-w@public-files.de
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
References: <20221114121653.14739-1-matthias.bgg@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221114121653.14739-1-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/2022 13:16, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <mbrugger@suse.com>
> 
> Missing SoC compatible in the board file causes dt bindings check.
> 
> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> 

Applied!

> ---
> Changes since v1:
> - Move SoC compatible to first line of the block
> - Add SoC compatible to mt7986b
> 
> 
>   arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts | 2 +-
>   arch/arm64/boot/dts/mediatek/mt7986a.dtsi    | 1 +
>   arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts | 2 +-
>   arch/arm64/boot/dts/mediatek/mt7986b.dtsi    | 3 +++
>   4 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> index afe37b702eef9..0e3b603159477 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-rfb.dts
> @@ -9,7 +9,7 @@
>   
>   / {
>   	model = "MediaTek MT7986a RFB";
> -	compatible = "mediatek,mt7986a-rfb";
> +	compatible = "mediatek,mt7986a-rfb", "mediatek,mt7986a";
>   
>   	aliases {
>   		serial0 = &uart0;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> index 72e0d9722e07a..3c52ec3f99a31 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986a.dtsi
> @@ -10,6 +10,7 @@
>   #include <dt-bindings/reset/mt7986-resets.h>
>   
>   / {
> +	compatible = "mediatek,mt7986a";
>   	interrupt-parent = <&gic>;
>   	#address-cells = <2>;
>   	#size-cells = <2>;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> index 3443013b5971e..d03e66a84c5d4 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b-rfb.dts
> @@ -9,7 +9,7 @@
>   
>   / {
>   	model = "MediaTek MT7986b RFB";
> -	compatible = "mediatek,mt7986b-rfb";
> +	compatible = "mediatek,mt7986b-rfb", "mediatek,mt7986b";
>   
>   	aliases {
>   		serial0 = &uart0;
> diff --git a/arch/arm64/boot/dts/mediatek/mt7986b.dtsi b/arch/arm64/boot/dts/mediatek/mt7986b.dtsi
> index 23923b9f8944b..db5189664c29b 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7986b.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7986b.dtsi
> @@ -5,6 +5,9 @@
>    */
>   
>   #include "mt7986a.dtsi"
> +/ {
> +	compatible = "mediatek,mt7986b";
> +};
>   
>   &pio {
>   	compatible = "mediatek,mt7986b-pinctrl";
