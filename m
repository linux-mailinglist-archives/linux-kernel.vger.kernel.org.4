Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC50E65235B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 16:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiLTPCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 10:02:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiLTPCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 10:02:13 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B14C1A;
        Tue, 20 Dec 2022 07:02:12 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so11350829wma.1;
        Tue, 20 Dec 2022 07:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pzMfGFc+T+OIDYYl9okQ5zfw6NreFa0yZMhUyrOURHs=;
        b=X2x/zvCz9r5+AAAYObauwRktUdYKTf4lUnGeUJrACEkwzXnzI6YdTHIg7dA+ZvO4Ay
         Ntvid8RN1oe7ceqskyB+IFwi0VpUow8r8odxL6gx13QaHzrMFj/ItDaCLZCgJOlJxGk8
         cZfrnwUzvInv9U8Kq6H1QcssTYUf1XxOCPqKQ6lR7e0D8n+IZoze9k3GaLMC1uRxXQFF
         EGbaZ974Nqqx03lCN41YPKacfVkZgYWBaHAZhq6fVRzSp/QM4b+eG25iR4wZeuzFLqig
         E5zxHz+Hx92yvp43E+wrD/VBVgRADusDLUjQyii6D5CxyAyFQxHTtXoAmxuvblzHQg3i
         MxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pzMfGFc+T+OIDYYl9okQ5zfw6NreFa0yZMhUyrOURHs=;
        b=UodZmcBDC6KBjDFGGr2NYCGYDuDV4P5lruwe226x1jxo7avbJq8aUZjc3WAWm24+Ek
         QW1zOX0T8/t0T76yr4l+K3pY5O/+GQUTeD9iIMbFKYXykW74h3EREQ9bc4TfpOMAuTYE
         bQtzOqHN0/78qmcAtSjDYv4MvK3Yt4AWWdfi+woxX26AenArZMEGKAqwYrUmkaNgOaOr
         FLtxYVXggpwzqGQ1zbsIl8id9H8diPfLqCw5LO+aqHU9IGd/cqDZnvds2t3ra6PbtqgL
         yiVCh5eTdn0E0QtsU5CMT2ecPpfw6QjxQdty7Z1GoS/9wFnqJRTLvVb9cxshE8gkWDQ9
         /+TA==
X-Gm-Message-State: ANoB5pn36MrWzN/+tDGy5449GMWEi+PYP8V5TxYVgswyv/T22eQT7V9L
        Icnst+Hcm+bJoXD8zmmNl/o=
X-Google-Smtp-Source: AA0mqf4mnN7mbrBWMZrA3GgHFXd3WHHkBz0CyQ1EINScx97Fm6ED8gdAtihCqezouN1INwn+f5S4iw==
X-Received: by 2002:a05:600c:3544:b0:3d1:e04f:9bfa with SMTP id i4-20020a05600c354400b003d1e04f9bfamr35819264wmq.28.1671548529865;
        Tue, 20 Dec 2022 07:02:09 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b003cf71b1f66csm17664025wms.0.2022.12.20.07.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Dec 2022 07:02:09 -0800 (PST)
Message-ID: <2f003afc-1375-56fa-f9e2-82ad3bb7cee2@gmail.com>
Date:   Tue, 20 Dec 2022 16:02:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH resend] arm64: dts: mediatek: mt8192: Mark scp_adsp clock
 as broken
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221130031741.3176853-1-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221130031741.3176853-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/11/2022 04:17, Chen-Yu Tsai wrote:
> The scp_adsp clock controller is under the SCP_ADSP power domain. This
> power domain is currently not supported nor defined.
> 
> Mark the clock controller as broken for now, to avoid the system from
> trying to access it, and causing the CPU or bus to stall.
> 
> Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index 6b20376191a7..ef91941848ae 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -575,6 +575,8 @@ scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8192-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
>   			#clock-cells = <1>;
> +			/* power domain dependency not upstreamed */
> +			status = "broken";
>   		};
>   
>   		uart0: serial@11002000 {

Looking into the DT spec, "broken" is no valid value. I suppose we want to have 
"fail" here.

Regards,
Matthias
