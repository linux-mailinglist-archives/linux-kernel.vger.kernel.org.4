Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5CA7237C3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 08:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjFFGei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 02:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjFFGeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 02:34:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FA512D;
        Mon,  5 Jun 2023 23:34:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f7378a74faso19934655e9.0;
        Mon, 05 Jun 2023 23:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686033274; x=1688625274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YScY1UjX9AdjPO3LUvmrwRHMUCozTWDeiHmroKKD6oA=;
        b=TKI41HF12vkyd2mjuw9ikl45D888WzPYyq/c+Fu8MvyOfs6IC+Fj85qDJ4CXD9AdFp
         9p1WLXkKuHdvfr3zf8YrOu+zwpT15fRVcQDNbNUOcSkmKaXgPZAsonRu845Xv9yPcx/J
         BndOvEVLGUlZeuwSTb7g79d4edxN7/EzNHTk7dcx1CWXmlFF+E45hSaLCk2NsPbkdr4n
         uTXcD87dcuC3/hWtRcDHaD46ybNDOSF9tvKc91wQ0JN7efEmJcAt9nKlAll+vfCI4GjM
         koT+XuSy2MW5L1W7tMzcCDOmWHXQBf/gLs/MjJfKXs98swSGZL0h0iSgY1XX647xuL/0
         LJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686033274; x=1688625274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YScY1UjX9AdjPO3LUvmrwRHMUCozTWDeiHmroKKD6oA=;
        b=MvVURuH1ZQBVtCLu7VlsRAbDhuWpicyMR9IP9b+uFc8oJV9fJNhRH7RW0Rdqi4TYtC
         tAMP79OT7r5DlvpL9JBzIaa9R1Ra0HSbp2ryrL+1199vcUU8ef22NfUNk4Cw0v9Ehbn4
         BDvefL5gmvyC7LFkTJB1I9wAFc5+eb/nIXQ2lbS3OaIaDVaxzib8r3FclIzX324YnoaY
         EzcvR8aCih+FI6BPhlh68mcv/bjHEfb3IGRGBReKhoxLqT8Y7IFYiOvcJgC7hJc3OKA/
         En37J3xcZRQCOD+ansUu3VeL3sdJQvUKB0mw75DU+MG3UiDWoYfzABhkVl5Zowooj4ng
         VZ7Q==
X-Gm-Message-State: AC+VfDxrqUJLbCVFBkJwmTVv0VwaVUWeHXm1vDK9NMgK7uESpdGQA4xW
        Ur/CSIJViOoQV2BAZ/dWEmSP9d+nfSXW7A==
X-Google-Smtp-Source: ACHHUZ7D1BuPEsMDTVS1CtwL4aZn9kxPQUlTrWyIhdsrDD6PTh4+b1PaLCt8/CkOaGJolEbHEi66vQ==
X-Received: by 2002:a7b:ce09:0:b0:3f6:906:1194 with SMTP id m9-20020a7bce09000000b003f609061194mr1130720wmc.18.1686033273522;
        Mon, 05 Jun 2023 23:34:33 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b12-20020a05600010cc00b003077a19cf75sm11509618wrx.60.2023.06.05.23.34.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 23:34:32 -0700 (PDT)
Message-ID: <1dc6354d-80f0-1f22-0af8-0ad84b2f15f5@gmail.com>
Date:   Tue, 6 Jun 2023 08:34:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Add missing dma-ranges to
 soc node
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     kernel@collabora.com, Yong Wu <yong.wu@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230601203221.3675915-1-nfraprado@collabora.com>
 <511269ce-2493-1d21-d8fe-a9d78828e018@collabora.com>
Content-Language: en-US, ca-ES, es-ES
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <511269ce-2493-1d21-d8fe-a9d78828e018@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/06/2023 11:45, AngeloGioacchino Del Regno wrote:
> Il 01/06/23 22:32, Nícolas F. R. A. Prado ha scritto:
>> In the series "Adjust the dma-ranges for MTK IOMMU", the mtk-iommu
>> driver was adapted to separate the iova range based on the larb used,
>> and a dma-ranges property was added to the soc node in the devicetree of
>> the affected SoCs allowing the whole 16GB iova range to be used. Except
>> that for mt8192, there was no patch adding dma-ranges.
>>
>> Add the missing dma-ranges property to the soc node like was done for
>> mt8195 and mt8186. This fixes the usage of the vcodec, which would
>> otherwise trigger iommu faults.
>>
>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>
>> ---
>> Matthias,
>>
>> this is a very simple but important fix for the vcodec functionality.
>> Since the vcodec node for mt8192 was just merged, can we please get this
>> in in this merge window as well?
> 
> +1
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Applied, thanks!

>>
>> Thanks,
>> Nícolas
>>
>>   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi 
>> b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> index 7ff183c35494..a3612de8e9d1 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
>> @@ -401,6 +401,7 @@ soc {
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>>           compatible = "simple-bus";
>> +        dma-ranges = <0x0 0x0 0x0 0x0 0x4 0x0>;
>>           ranges;
>>           gic: interrupt-controller@c000000 {
> 
