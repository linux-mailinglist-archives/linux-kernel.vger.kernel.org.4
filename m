Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83A6CFFCF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 11:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjC3JaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 05:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjC3JaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 05:30:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAB872A2;
        Thu, 30 Mar 2023 02:30:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id bg13-20020a05600c3c8d00b003ef90adc168so3554603wmb.5;
        Thu, 30 Mar 2023 02:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680168616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxXKhS9wYHWQInB5jxFKjqRzqsBiAg9IWI/b1YLumcc=;
        b=o5UR1YKGDskY7lYN1CPA3sqcrsWktdXRTHgC3jsX9yd/RemyoJJhGoPqOV0V9Ske29
         /AV/2HYWYof4pYufYh7jV6blR4rPN7LHgG6yBv4pR9OPuxTcBBUaUjOemY0vz49bDPMd
         JrzpyAQf2fVoCpFXHgHourHjognNlZ9rUz0si3TYfQoE4Jos2GGfX4ItBCOEvX5A3mLZ
         HOVtpHENE2u11yedAN+JJOge3bv3Yf8/dfIe89NgeMLmel+jZiJkZHM8XT67kJJ+39XK
         WaWs+aIkitN3nD2kypexmNThLm8NAWur5ehf4w28iY8cf9XsHM3/aUbmOFI0ouS3ND3F
         vsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680168616;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WxXKhS9wYHWQInB5jxFKjqRzqsBiAg9IWI/b1YLumcc=;
        b=qu1sHU5cNQhovdlW0kFJzjB4cvUAny8Jx2wwJYFS4ZZq4z2TfIQc6e7tHb4J6Ry1E8
         n8uPivtE5VMOw6gM3FjggJTi0NpkGbnw06ML6q5i868yNjCSx14AcbepfFbN3/WGbwb5
         sgcuYUn/nAmlg9+HzHSM7d/Ec8ngBKYD+W7Hph/YSNCZPnVnCnWu1dQBKFex4ZxIwhZH
         2zT3UDvK0WpLcipLZeXf61J55CI6nC7/+o4CZLSEk8gn66RFe80gwsYNKIVMBvwgGDJ8
         AZNvVIICzgQ+rx0ZSyQ8DExTlVOVxiPEobIvXH5QB5bKDsY0JqPoByb0A1ay2H834d1M
         cWJg==
X-Gm-Message-State: AAQBX9eVEgbLGyAvQyWcHeW27R9dnwKcEJ8FcKJgK2v+eHs8Ey7xKDV7
        sqsprZAPAJd4qj41qGBAlSoCvd+QU2m4YF6I
X-Google-Smtp-Source: AKy350ZBgLhNRR9TxRDx2aLTQWJRkGyCwyq3TOUYsvCakwonAbrsN83wbcfgg94RBbGOiSfUp+sXnA==
X-Received: by 2002:a7b:cd93:0:b0:3ed:346d:4534 with SMTP id y19-20020a7bcd93000000b003ed346d4534mr4173874wmj.0.1680168616343;
        Thu, 30 Mar 2023 02:30:16 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id f18-20020a1c6a12000000b003ed2276cd0dsm5161439wmc.38.2023.03.30.02.30.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 02:30:15 -0700 (PDT)
Message-ID: <d6314775-0918-eb9a-d501-2f22db6a951c@gmail.com>
Date:   Thu, 30 Mar 2023 11:30:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: soc: mediatek: mtk-svs: fix passing zero to 'PTR_ERR'
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230216132543.814-1-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230216132543.814-1-roger.lu@mediatek.com>
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



On 16/02/2023 14:25, Roger Lu wrote:
> nvmem_cell_get() cannot return NULL so checking for NULL is wrong here.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Fixes: 6c7174fd90a4690 ("soc: mediatek: mtk-svs: use svs get efuse common function")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/r/202302160720.N64SWT4l-lkp@intel.com/

Applied, thanks.

> ---
>   drivers/soc/mediatek/mtk-svs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index a7eb019b5157..8127fb6d587b 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1726,7 +1726,7 @@ static int svs_get_efuse_data(struct svs_platform *svsp,
>   	struct nvmem_cell *cell;
>   
>   	cell = nvmem_cell_get(svsp->dev, nvmem_cell_name);
> -	if (IS_ERR_OR_NULL(cell)) {
> +	if (IS_ERR(cell)) {
>   		dev_err(svsp->dev, "no \"%s\"? %ld\n",
>   			nvmem_cell_name, PTR_ERR(cell));
>   		return PTR_ERR(cell);
