Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6623A729D21
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241325AbjFIOlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240870AbjFIOlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:41:16 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE46CE43
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:41:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f7a8089709so19089215e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686321674; x=1688913674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CR0c0Jmte6FeApUkgHJzlSR9/4YGGRJ45CFKhUONxZs=;
        b=ljyF103rTiR0ysRbp8iTZkhShz0Q4wQtsi4SiCh2Z9pCwZ+ITBYkoJFpAwLZ0L/DBf
         dVde8h40DygaZTGXlquTqrFKGhS/fPQXkH3rfBZCFLnXegcLj7R4fwqdhKeSRXc9NGAK
         pOSsUYKkoduu+yFfBsLJXfv2Al7tu01/P+iLRTw5r0H2F4h46VX6M0UKyfU7h4Mkb1Qk
         X0fwqcjc2oruhg7mhpvmyucGXNcHgdB+BZhrMkFLM4f2A6UXmPJvRWIdXy75kRfn+1gF
         TCOFRB20afPYt8QayEUeMFAfMVHHh8ca6M3sl1xH7PD5z9+F/QKbK+8wKI2NYF9ADAxa
         bxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321674; x=1688913674;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CR0c0Jmte6FeApUkgHJzlSR9/4YGGRJ45CFKhUONxZs=;
        b=UB8OdnPi/ifZp678sJWwAK7Qp2wL9Z3ssY3PGL3HMqUpaHitL2r8UTaWMNyVF2Es3h
         FzxqKPeVoBysVB/hcKIXQQh1UBDY0ie8e7mdEjdzCHm5JJJej7mzh4zBLxSKeIzvWE9d
         O9l4dRvla7Et7cZsbTQWz/VjR3rjis9OhEtZ5bhHtKrslX3WvSaqqQvL5RMTmmRx1WcK
         zYyIymGSGUhLdvyea4NLmcNojZPj1qegRHvvSbIpoR8tNQjVjzCjoMIF/RnpOg0DHQbu
         G/mcKSZAmiwKXDL81WUWP95ZoCrIHjUmnt3gQotj9CH/Bj2gQ9ZglPzi9Emfie6gE9Is
         MK5g==
X-Gm-Message-State: AC+VfDyGFwxgyCII6ussq/rO8JoU1KkkGaan4LqW7Q/G1BhpaSIEDthn
        B2v/JMFuuLxdSZkd/5vss7o/+k8zfgo=
X-Google-Smtp-Source: ACHHUZ79Lfg6kM1VebrkIaLd3ziJZPC6iHeyxpXvPXdX4Z7/4UxGlL7mbxQG4cIZxJ4v2F+J48mv2Q==
X-Received: by 2002:a5d:6104:0:b0:30a:e7cb:793 with SMTP id v4-20020a5d6104000000b0030ae7cb0793mr1363370wrt.15.1686321674019;
        Fri, 09 Jun 2023 07:41:14 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q25-20020a7bce99000000b003f17848673fsm2883516wmj.27.2023.06.09.07.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:41:13 -0700 (PDT)
Message-ID: <1c52e05f-33bf-b182-dd4d-18aa43564e59@gmail.com>
Date:   Fri, 9 Jun 2023 16:41:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v8 2/2] soc: mediatek: remove DDP_DOMPONENT_DITHER from
 enum
Content-Language: en-US, ca-ES, es-ES
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Nathan Lu <nathan.lu@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230306080659.15261-1-jason-jh.lin@mediatek.com>
 <20230306080659.15261-3-jason-jh.lin@mediatek.com>
 <CAGXv+5EPktjMABhtWf9dL-25dAe=Mf4=BSMmE+=4m2WisDXXFQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5EPktjMABhtWf9dL-25dAe=Mf4=BSMmE+=4m2WisDXXFQ@mail.gmail.com>
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



On 31/05/2023 09:43, Chen-Yu Tsai wrote:
> Hi Matthias,
> 
> On Mon, Mar 6, 2023 at 4:07 PM Jason-JH.Lin <jason-jh.lin@mediatek.com> wrote:
>>
>> After mmsys and drm change DITHER enum to DDP_COMPONENT_DITHER0,
>> mmsys header can remove the useless DDP_COMPONENT_DITHER enum.
>>
>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
>> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> 
> CK didn't pick up this patch. Since the other patch already got picked up
> in v6.4-rc1, could you merge this for v6.5?
> 

Yes, I gave an acked-by as I thought that CK will take both of them. Anyway 
applied now.

Matthias

> 
> Thanks
> ChenYu
> 
> 
>> ---
>>   include/linux/soc/mediatek/mtk-mmsys.h | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
>> index dc2963a0a0f7..8eb5846985b4 100644
>> --- a/include/linux/soc/mediatek/mtk-mmsys.h
>> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
>> @@ -27,8 +27,7 @@ enum mtk_ddp_comp_id {
>>          DDP_COMPONENT_CCORR,
>>          DDP_COMPONENT_COLOR0,
>>          DDP_COMPONENT_COLOR1,
>> -       DDP_COMPONENT_DITHER,
>> -       DDP_COMPONENT_DITHER0 = DDP_COMPONENT_DITHER,
>> +       DDP_COMPONENT_DITHER0,
>>          DDP_COMPONENT_DITHER1,
>>          DDP_COMPONENT_DP_INTF0,
>>          DDP_COMPONENT_DP_INTF1,
>> --
>> 2.18.0
>>
