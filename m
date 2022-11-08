Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA03762112B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 13:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234189AbiKHMny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 07:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbiKHMnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 07:43:52 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A36451C2A;
        Tue,  8 Nov 2022 04:43:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id y16so20736055wrt.12;
        Tue, 08 Nov 2022 04:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YbJO9KqDk7Xkc6dEU4ClRlhFIchA8zzKrx3Cy0s+pcA=;
        b=Lgmam9mhkOtQYFah9fRTHWscwGdNqA4Go8EUt/QdUEG8CGOlyy49cFhX8nWbcgZjQs
         cKDjUyu21tgP3r/SJGVZgt6sFkaSP8oZzPFg07KEzZnGqFPYMe9fit+Nw4pjwFwrQh7R
         ZD8lQAYBVambcUkn3RyTXFODHmOX/SPzHjNRfwoprv99fRzde+8pa0c74fbRdEU5A7tK
         11t+5C1NRjMsodDMYb3AFjmasQEIeyBjiE6LoqUO8X7rfSVaOpYP/ZqksGNmbWCYukXr
         66VYHa4tMlsWRe+h7VhUqvYBYF1HVPQvGLJMXH4ZOgzD3dTZ/yUMurCu6ebvHILuNuKJ
         n3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YbJO9KqDk7Xkc6dEU4ClRlhFIchA8zzKrx3Cy0s+pcA=;
        b=FClbNGKWvK88DPdQ0eCd72PKKcnk6m9TB8Soq6wqrwUA/i6kGXTtf2dry5F7es2/is
         DLfq0I4FD/bMAYG4ebqvnyEm15wwnQrYpx1Uv6eMBuLnMXdMG3o03oXHM+63cRuAodh3
         rbh+RPi+O7Rfwn/1n1QGoDxEojX6DrXYEEGNhndG/yeW++vr60wSMhVaRJNhpbS0zj72
         SgrrrN6prCfOevCfgB11lYQb2LElHXYj/7TXLZlnfayQqYWOiYp/7Y2+j5tFktCgFJ8p
         7XJ70ieNwUv/fNZ4bAnWSVw3zr89Y9xnxZT3tGhmXYLjD1KeKCOy4gzU+J5atJcBbw31
         dA9w==
X-Gm-Message-State: ACrzQf2yjZMa2ll1YOGQ9hsWtmGOhuMBSfcmhLqm+yEvfBNh0/2riy+v
        jcLyDNm9YkgWClD/a7rxTXc=
X-Google-Smtp-Source: AMsMyM4zMnkwa7yKd8CP1iszyfp2MdswvMN9cDFrCEW+w06/cvxr3ripNS3QQ6jOK0O0iFdHvammVA==
X-Received: by 2002:adf:f701:0:b0:236:e2b2:3b69 with SMTP id r1-20020adff701000000b00236e2b23b69mr25781904wrp.532.1667911427921;
        Tue, 08 Nov 2022 04:43:47 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n41-20020a05600c502900b003c6c4639ac6sm11474295wmr.34.2022.11.08.04.43.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 04:43:46 -0800 (PST)
Message-ID: <f20356cf-4347-6bb7-20d4-ec5a154fa9e4@gmail.com>
Date:   Tue, 8 Nov 2022 13:43:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 07/10] arm64: dts: mediatek: kukui: Remove i2s-share
 properties
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220908161154.648557-1-nfraprado@collabora.com>
 <20220908161154.648557-8-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220908161154.648557-8-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/09/2022 18:11, Nícolas F. R. A. Prado wrote:
> The i2sN-share properties were never documented in the dt-binding and
> thus shouldn't be used. Now that the ASoC machine drivers are setting
> the I2S clock sharing internally, these properties are no longer needed,
> so remove them.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Applied, thanks!

> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index b4b86bb1f1a7..42191b3025a9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -221,11 +221,6 @@ tboard_thermistor2: thermal-sensor2 {
>   	};
>   };
>   
> -&afe {
> -	i2s3-share = "I2S2";
> -	i2s0-share = "I2S5";
> -};
> -
>   &auxadc {
>   	status = "okay";
>   };
