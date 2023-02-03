Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDBA68978F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjBCLOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbjBCLOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:14:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06CF8FB6A;
        Fri,  3 Feb 2023 03:14:35 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f7so4828823edw.5;
        Fri, 03 Feb 2023 03:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UzRhNOEqZ6otVdDMPPDeehfgx4iYyErBm5BV2nKoj+I=;
        b=gbjn2BhPSkF/JyklWXUgKAyCSvSXiUeuU9Vx7UlVX78DXCsVv/IGvvg1GH6eKcZ3j+
         g6mQXo9cmJWHwufBPMtRMNpChz5h2d43tmiffUKfJQecs363oIOSPc866P+pHPHvGOCn
         /ocabbLUhXKo5cVmLDEMa0D2g6QV2eDO+PgenAIAIGLuiVEmZ0BHbRuTeHyWiTIHMglS
         nfoqFIB1RbYXPu8P2N8ipXp8rFQBXI58SZPd2WrvGLEW6DulaEzO+Tj8Oj/5WOw+4u0z
         SxU80B3SieGVg48F+l3JnLUTKN4PlC71+VfhWrBbgcnm8KCf9dyKKiCJ0k4QmCpbwCY8
         +dKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzRhNOEqZ6otVdDMPPDeehfgx4iYyErBm5BV2nKoj+I=;
        b=s0Iiw9TO6HvuyBL9B1LTSCrqDaxBSchJvmrwrzQAB5Iax11Hykal2w5DJAXstWB/TI
         9YEAP5rnCeFrqGdvPh5Byc8duuknWzS4EHFY01N0vkSw5XGu0gYbGAOchrWMu1LJVtbU
         6xgFkwsIb2TfNa/XVcce5JSWd5Ke/fal88zvZoscuTqVm9xB1KWYwmY4zJp8g2k5t/NG
         9E507B8GAhCppkbPhCJLzuJ/SFyo7cBgcYYBQFhcRg4eN6kQYJwTQXLjPr1yL3jfHBMz
         DxgPzn6Wa31YjS4YWgpLNYLNGcxDcX+3dnmAdN7+GEWzkTu7WKQG8IhQgCX7zxbJ5bwK
         Qrhw==
X-Gm-Message-State: AO0yUKW+I3TxySqltWXV1i1ojso2ZwQnLeMoabkn/oLhYtNKsvOBj/BY
        6iUSLGtrZgL9UqQAvdKvajo=
X-Google-Smtp-Source: AK7set846aawl7qp/socuCnmS3sx9OowfDg7l4wvHAmZ4js1qkVmfadMsu4MnsX3SrAKFPmoy06xng==
X-Received: by 2002:a50:f692:0:b0:49d:221b:4b3f with SMTP id d18-20020a50f692000000b0049d221b4b3fmr8530287edn.21.1675422873130;
        Fri, 03 Feb 2023 03:14:33 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id es26-20020a056402381a00b00488117821ffsm973829edb.31.2023.02.03.03.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 03:14:32 -0800 (PST)
Message-ID: <6c7b2874-8812-c706-3e82-b701bb69408e@gmail.com>
Date:   Fri, 3 Feb 2023 12:14:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 5/8] soc: mediatek: pm-domains: Fix caps field
 documentation
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230105170735.1637416-1-msp@baylibre.com>
 <20230105170735.1637416-6-msp@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230105170735.1637416-6-msp@baylibre.com>
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



On 05/01/2023 18:07, Markus Schneider-Pargmann wrote:
> This field is not for ACTIVE_WAKEUP exclusively. There are a lot of
> other flags defined as well.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")

No bug here, nothing that needs to be fixed in the stable kernels. We can drop 
the Fixes tag here.

> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.h b/drivers/soc/mediatek/mtk-pm-domains.h
> index da827e91d462..34642a279213 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.h
> +++ b/drivers/soc/mediatek/mtk-pm-domains.h
> @@ -95,7 +95,7 @@ struct scpsys_bus_prot_data {
>    * @ctl_offs: The offset for main power control register.
>    * @sram_pdn_bits: The mask for sram power control bits.
>    * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> - * @caps: The flag for active wake-up action.
> + * @caps: MTK_SCPD_* capability flags.
>    * @bp_infracfg: bus protection for infracfg subsystem
>    * @bp_smi: bus protection for smi subsystem
>    */
