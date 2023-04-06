Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F806D90CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234984AbjDFHun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbjDFHul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:50:41 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2759076A8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:50:40 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-93db98f7b33so83120966b.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680767438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=acsxKS8JAme3fiaY0A/7VQXARsXOyYhuyHtw99/eJzY=;
        b=D+LRcXAPgAjQF1qELH9IoHjo2uLJb20Wlrd57lGAmRpIlD2R2Se2wMyXR42G7HkzRc
         kQryQxhjcW+8oCmhOGDwNH+AfqyuzWruS/ETU6cOXOB30qSeFWZ/gwFJ4MzbSiOIMKDM
         o+W+ZQzFZ9ttDVSd7q3KxWZ9kCyDy5KxHg+FX6d3P1dUbuPXPTsa0ij5p4qhY7mkgkv6
         AChXS1krfUsDa2HxNhgYUo0TMnwbMgw9rA7tnAEVt6KQkDJ0U/yskXzO8CS8M8c/jpE5
         xhiLmR0NTxzRLcRPLUm0FHcHzKlUzUQdkherUy+82rDZVS8Bnbpfgw11v7NcE/QY3sf9
         6pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680767438;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=acsxKS8JAme3fiaY0A/7VQXARsXOyYhuyHtw99/eJzY=;
        b=ohbMSrf9WIbheXF8/AK1JIMNNnqllu7s1Pq87t+lX6/uUopCUfTU4X3bhJH5IJrZpb
         c/GKn6rI+Z/6p/aVoKNkheirdI+SZ3ubl2T1PqOA4oitheXPXsOx+jHMfbRzYQW4v6bI
         CAIMAKy6j95h90u1fegKpnTmvY6Z7Ry4yShIClEyzjganS426xBqwfPXW/s1z3Imyezg
         FV+GeXYL4vMUsXBtgyhtjHK44DR3LhDV+8I/fBXX/NRb5eY2UpAryrIfr9l5tL9HAYvU
         9rzldnbrm3I9TLEi8XMO92y3iZQyARlzpwDRf3HldMWpVFQD6Yi3e64RjHzKLg9W1oKL
         aSkg==
X-Gm-Message-State: AAQBX9eyT1SzEHUR4xjzDh6uPLSIo7zivn2DQAoNQ/dhZnWJ3WzTALvQ
        SRzl9KD5ChRD7Wsu/zt05auCJg==
X-Google-Smtp-Source: AKy350Z74im14UBTpQDaKfczphvzBZhLrAWZc+1VzpVIGSWgdepzgVVxlleeas6+L/T8lRwePIcQQg==
X-Received: by 2002:a05:6402:1001:b0:502:4862:d453 with SMTP id c1-20020a056402100100b005024862d453mr3727333edu.3.1680767438661;
        Thu, 06 Apr 2023 00:50:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id gg4-20020a170906e28400b0092a3b199db8sm442654ejb.186.2023.04.06.00.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 00:50:38 -0700 (PDT)
Message-ID: <d25081e4-69bc-74db-bdf1-5f1f2d2c794d@linaro.org>
Date:   Thu, 6 Apr 2023 09:50:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 10/10] memory: mtk-smi: mt8365: Add SMI Support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
 <20230207-iommu-support-v2-10-60d5fa00e4e5@baylibre.com>
 <9847bc48-c96c-3599-e876-bcf9ebf1522e@linaro.org>
 <CAFGrd9pBdaHLGUZHkaz2_XKafyX=dxu9UckQxrphg52EG=A1SQ@mail.gmail.com>
 <8fc3dd22-79df-32cb-c219-896eda8fa986@linaro.org>
 <fd24877a-5fae-5434-dc56-61ab35ccd820@baylibre.com>
 <e38658be-1a2a-bccb-3f30-18f1b031f71d@linaro.org>
 <25bcaa84-fb29-4343-d046-26e210fc81f4@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <25bcaa84-fb29-4343-d046-26e210fc81f4@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2023 16:34, Alexandre Mergnat wrote:
> 
> On 05/04/2023 15:54, Krzysztof Kozlowski wrote:
>> On 05/04/2023 15:06, Alexandre Mergnat wrote:
>>> On 05/04/2023 13:45, Krzysztof Kozlowski wrote:
>>>> On 05/04/2023 11:53, Alexandre Mergnat wrote:
>>>>> Ok, I will move the driver patch before the DTS patches in the next version.
>>>>>
>>>> Or do not send it together at all, which might solve your dependency
>>>> problem. According to your cover letter I cannot take the memory
>>>> controller bits, so I am waiting for dependencies to hit the mainline.
>>>> Alternatively I will need pull request with stable tag.
>>>>
>>> Ok, I prefer send the driver patch in another serie. That will solve the
>>> dependency with the DTS a least.
>> What dependency? Why do you have dependencies between drivers and DTS?
>> That's a no-go.
> I probably do something wrong but, that start with this comment [1]:
> 
>> I guess we should add a independent "mediatek,mt8365-smi-common".
> 
> Then I have added the mt8365 compatible support in the driver instead of using the mt8186 which already supported and used in the v1.
> I change the binding and DTS to use "mediatek,mt8365-smi-common" only (no more "mediatek,mt8186-smi-common").
> Maybe "dependency isn't the good word to use in that case.

I do not see patch changing existing compatible. Which one is it?

I don't know what is your meaning of dependency then. For all of us,
dependency means one patch must be applied after another patch. So is
this the case here? If yes, then why?

> Except for the patch order in the serie (or send the driver in another one), everything is fine or there are others wrong things ?

If this is the question to me, then I am not the maintainer of your
platform. I am taking only memory controller bits, which look fine and I
would have already apply them if not the dependency trouble. Soon the
window for applying will close, BTW. We are almost at RC6.


Best regards,
Krzysztof

