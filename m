Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856FF67404E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjASRtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjASRtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:49:25 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C308F7E4;
        Thu, 19 Jan 2023 09:49:15 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v13so3800917eda.11;
        Thu, 19 Jan 2023 09:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HzbxECxJMQfMp/BMDtp/vx0yN9hZtlBlPpuqP9cm6XE=;
        b=DBf7kxBij7qqGeC7y7+/eqPUNl/8sOo6pjwRD5rPQGl0lx7NTp7BuXJfur2TrngUPV
         ULYhqcN9kHR5CXjNHQhWdKbwud/976vBMvMeJAP5FMwrgIVv+p8E2GmSmpu0KR3uuip2
         veExlKiY2VEZtxAQWVGpiOuAZKtVjqGZ4r/rlY6JQVS4D68da+htH0j4rwKbEcY/eMTy
         YPG1U327j7N6pnxhrtJ2fF+jYpFJWE4q2/ijC158tRJd0AIXqKXEJu6AylTqq9vl2i+m
         8ffY5NgAvCR0JE4zsEayxYlyib5K1zL2xstODNZP6fh9hcdL5axzDvBbMJ7uk/pvIgDv
         63WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HzbxECxJMQfMp/BMDtp/vx0yN9hZtlBlPpuqP9cm6XE=;
        b=Haae86DmmCX2N6A0IYAuXR0558+O7eBqnqIPPbRPMz60ULOmedvvDamCg5glvHIDgy
         9y4epY6bqBXArQmR3yBN2BsxVp4Xl8j8nWcjyOYyMgvUqaIWoABHmrANx6gCUyxenVDx
         UF0UNaFK4FEABbhu0qesnyqIILLGy2DVmDTklZlHFH7Svfuqth/G0l67MSkyJaO6NQhc
         BLLAebl8HrniJBx3tASUQxggRSdcvpd8bU8DcC1XiwTllVx2l6DU0D8pkdFM8Zbq+Fvh
         EXJHGVhNjSrxDLcndvdWZ+ZILW01WhpB/S5cBvQiV0ydh2Q5MjpLJmQhrVs+kYCR5EPl
         hDTw==
X-Gm-Message-State: AFqh2kpvC2s5enIaVP0ImDNByTrB1ON9Yt+8maiY06sHbcQnHaqigaVR
        0tcL8vYGI4y6SgyQyfBL+xA=
X-Google-Smtp-Source: AMrXdXsZQQe0vv6Eyi0PePX3epUTaqg5CG+wRcZzRJjobIDth2dMK20TRtch3CyxAPpklgKJPDsJvg==
X-Received: by 2002:a05:6402:10c4:b0:48e:94ec:b7ac with SMTP id p4-20020a05640210c400b0048e94ecb7acmr10498888edu.7.1674150554336;
        Thu, 19 Jan 2023 09:49:14 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id eq19-20020a056402299300b0049e65e4ff20sm1440818edb.14.2023.01.19.09.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:49:13 -0800 (PST)
Message-ID: <8d05d100-ef97-049a-561f-1a65db7a4112@gmail.com>
Date:   Thu, 19 Jan 2023 18:49:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] arm64: dts: mediatek: mt8192: Mark scp_adsp clock as
 broken
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>
References: <20221229101202.1655924-1-wenst@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221229101202.1655924-1-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/12/2022 11:12, Chen-Yu Tsai wrote:
> The scp_adsp clock controller is under the SCP_ADSP power domain. This
> power domain is currently not supported nor defined.
> 
> Mark the clock controller as broken for now, to avoid the system from
> trying to access it, and causing the CPU or bus to stall.
> 
> Fixes: 5d2b897bc6f5 ("arm64: dts: mediatek: Add mt8192 clock controllers")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied thanks!

> ---
> Changes since v1:
> - Changed "broken" to "fail"
> - Rebased onto v6.2-rc1 plus v6.2-tmp/* from mediatek repo
> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> index dd618c563e8a..ef4fcefa2bfc 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> @@ -644,6 +644,8 @@ scp_adsp: clock-controller@10720000 {
>   			compatible = "mediatek,mt8192-scp_adsp";
>   			reg = <0 0x10720000 0 0x1000>;
>   			#clock-cells = <1>;
> +			/* power domain dependency not upstreamed */
> +			status = "fail";
>   		};
>   
>   		uart0: serial@11002000 {
