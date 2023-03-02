Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC25E6A80FF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 12:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCBL0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 06:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjCBL03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 06:26:29 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AC230B33;
        Thu,  2 Mar 2023 03:26:28 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id bw19so16141677wrb.13;
        Thu, 02 Mar 2023 03:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677756387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ubt9kS070SRzays7Lyyyhk92YHHgZCfGzQC7bvZRYWs=;
        b=M7HyxsaUb8pCJPb17juc/uvkXUftUuBGUQwLlDrMMbY26zD8crXuN3+8IkHbq+CzGT
         QpLTvaotYucqTLcapHtEbVpBhPaHFMDTfpQUCYcjKnj9XlJEfDih4bJh/UVm70yLio/Z
         Ew5m0KmWNymD7y3JCAeb+k1njUx8M3RskXi+w26ZfzPkQI3p999shSIXs+QBCa1OrINk
         py38sbXW5I8WB5SrTOHk1DJkTtdmIJFiZcZKiZ8KvjDLRiqBkMjcTH+4IYr+Me36k1D0
         ZIYNHH8s/2wVAKgBNsJ031M/0s4ZEMQncHnbWUWc713joUjQ89zW9ZcTYCrE5cLc/Gb7
         Kghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677756387;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ubt9kS070SRzays7Lyyyhk92YHHgZCfGzQC7bvZRYWs=;
        b=Vo9l94QFBQD2zZNcBsRmME17r4LbP8gNkNGs5Dayo82i3qXoHFjoYti/09n8yYbcJ7
         uT8Z424XsF1C1w/4VRAzmzmz3dR2F82i+KS03+33mRyZoagtjhGeF8JSk6TIUAsWMRdh
         nEC1HXwm/hmwOe8351gv1soqKoWrSGre4BPQA4B4COzjVH/24/Mk6lXL67z5PPzeOLDv
         v7OGXzLAeWIUooe7+oQA5HdQCpusm+G6/EhEmYlLhhJN8ZSkM6Pk02OqMDUWAavS1MKD
         dBoFlawwkPnIMDW0sK2iPw5gO9z5DT7+xrvf/vUyp7I62RQvowVDJgbKbfRsLMLNWlou
         A0jA==
X-Gm-Message-State: AO0yUKUVDa5kE5FearToRRyqfzpxNP7tutQHCe7JRMUufObqns2jN4bY
        pYvKcA5wa0Y8cxteMuB0F46JKVkUhEJIVg==
X-Google-Smtp-Source: AK7set98pNPLGEg7TnBb4ZHI/1aEVLqnr3HiKc4PTIVLKBrwMGrQRt4geF25PL/4FYK5yQ9Q03E3Hg==
X-Received: by 2002:adf:dd85:0:b0:2c5:5d21:7d4c with SMTP id x5-20020adfdd85000000b002c55d217d4cmr7184234wrl.43.1677756386980;
        Thu, 02 Mar 2023 03:26:26 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b002c794495f6fsm14634729wrx.117.2023.03.02.03.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 03:26:26 -0800 (PST)
Message-ID: <1f65671b-7c68-b007-60c8-6c4841febce0@gmail.com>
Date:   Thu, 2 Mar 2023 12:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/4] arm64: dts: mt8195: Update vdosys compatible
Content-Language: en-US
To:     matthias.bgg@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com
References: <20230209160357.19307-1-matthias.bgg@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230209160357.19307-1-matthias.bgg@kernel.org>
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

Patch 1 and 2 applied.

Matthias

On 09/02/2023 17:03, matthias.bgg@kernel.org wrote:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> In an effort to fix the vdosys implementation, the compatible has
> changes. Fix the device tree to adhere the binding definition.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> 
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 00891bfa564e9..8f1264d5290bf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -2369,7 +2369,7 @@ vencsys_core1: clock-controller@1b000000 {
>   		};
>   
>   		vdosys0: syscon@1c01a000 {
> -			compatible = "mediatek,mt8195-mmsys", "syscon";
> +			compatible = "mediatek,mt8195-vdosys0", "mediatek,mt8195-mmsys", "syscon";
>   			reg = <0 0x1c01a000 0 0x1000>;
>   			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
>   			#clock-cells = <1>;
> @@ -2555,7 +2555,7 @@ larb1: larb@1c019000 {
>   		};
>   
>   		vdosys1: syscon@1c100000 {
> -			compatible = "mediatek,mt8195-mmsys", "syscon";
> +			compatible = "mediatek,mt8195-vdosys1", "syscon";
>   			reg = <0 0x1c100000 0 0x1000>;
>   			#clock-cells = <1>;
>   		};
