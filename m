Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2A8624308
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiKJNP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiKJNP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:15:57 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8957B31DCC;
        Thu, 10 Nov 2022 05:15:56 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id v1so2180858wrt.11;
        Thu, 10 Nov 2022 05:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJihVigxc3YBQCdD/qaXAkslKdIoK8zbFHIY6LxE+sk=;
        b=EYgiAWcjV27JiZUmxRn5Tr2Ji8RqFCHAaiTBcThLsYWgWQxcfP+hAU4CMPTlb0iEmE
         xQUX+NrxXcwNXhQIAexVwZ1J0DmstP1eLy+x65HkZ1rsSiv2ZowF++0Q29UJffbyPfCx
         MgIGDRzt0mBWhWPGW3NJuEkculyGnj0CRLcgZj/AEqcRYBK5I7EjgP9++qd6kO9hHon+
         iTtuAPt1uONNQztNkn6ixMF8aaONJYtc2JiD8QrSgYVonz7w0gZM3P8/vfL93YZvgs/A
         IZe5xEAHJk8RsDegi8Dz3YjXNMLU4Oz24RK6HhOCu5OIg87zRKKgnTW/sjovl0AsdGp2
         7nUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJihVigxc3YBQCdD/qaXAkslKdIoK8zbFHIY6LxE+sk=;
        b=zDASaen/HP3Bnvohg32H6ev8ArdoqzfX0FrA1FmT/oX10YxH/+CHzFBQW3NipmjG8a
         tr3d6/RMYsdqShSFUzZsTQKK03YV5bX0BppVZ0b8tOJPEQmbaPJZq2oFaxxSlZrC4/vq
         wSbUokBJYqKW9WOxc9Gfo1+5OaHN/tdLnm47oMZSrUGvfpzm9mhPEKPfpQeZYWaGOIQ+
         0HdZjgWAVfzcGKGDVCNRibWOKiS3+IRjTFTHvgcgRjGoU1PWmPBysuW9Eq59kcG4m74j
         Idxh2o/PFo+6TxskDP78tV3rAffnjXojDNz1Rxsyf78ONynDQ3xdxeR3su0mZoE6hRu4
         fiuA==
X-Gm-Message-State: ACrzQf2XBS9Uf8lMLchHeaP/3rEnXmcjHVCrJXECpuxwLbppzNjTNR92
        xBBWsTWQeMlpq3WtX0CPOe4=
X-Google-Smtp-Source: AMsMyM5g4mhTFAFCs2FPncVjkJu2yntcuKmfiDvf/4whVmdZ2/hBYfOyLbb4MJ1Nb6H9pW2fAAPuzw==
X-Received: by 2002:a5d:650c:0:b0:236:49d9:8e83 with SMTP id x12-20020a5d650c000000b0023649d98e83mr41300085wru.714.1668086155058;
        Thu, 10 Nov 2022 05:15:55 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c358b00b003cf47fdead5sm5688374wmq.30.2022.11.10.05.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 05:15:53 -0800 (PST)
Message-ID: <a77e722d-6354-c670-281d-f10217c73927@gmail.com>
Date:   Thu, 10 Nov 2022 14:15:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v3 0/3] mediatek: pwrap: Add mt8365 pwrap support
Content-Language: en-US
To:     fchiby@baylibre.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221031093401.22916-1-fchiby@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20221031093401.22916-1-fchiby@baylibre.com>
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



On 31/10/2022 10:33, fchiby@baylibre.com wrote:
> From: Fadwa CHIBY <fchiby@baylibre.com>
> 
> Hello,
> 
> MT8365 requires an extra 2 clocks to be enabled to behave correctly.
> This series contains patches adding the support of mt8365 pwrap.
> 
> changes in v3:
> - Modify "sys" and "tmr" descriptions to be more generic.
> Changes in v2 :
> - Rebase on top of linux-next/master
> - Link to v1 "https://lore.kernel.org/linux-arm-kernel/20220530135522.762560-1-fparent@baylibre.com/"
> 
> Regards,
> Fadwa CHIBY
> 
> Fabien Parent (3):
>    dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
>    soc: mediatek: pwrap: add support for sys & tmr clocks
>    soc: mediatek: pwrap: add mt8365 SoC support
> 
>   .../bindings/soc/mediatek/pwrap.txt           |   3 +
>   drivers/soc/mediatek/mtk-pmic-wrap.c          | 114 +++++++++++++++++-
>   2 files changed, 113 insertions(+), 4 deletions(-)
> 

Whole series applied, thanks!
