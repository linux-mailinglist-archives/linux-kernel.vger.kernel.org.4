Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1DE56DCBC2
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjDJTmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjDJTmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:42:07 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3961717
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:42:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j11so9047153wrd.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681155725; x=1683747725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QB7W0GXP1VzxhOdRLXF0y5oyjgK/ieF8BJXDgGfMNiM=;
        b=tTuFtx8K05eMBqFEgo0xW7LwK/ASZJngLvc5VxCb5s3J2/VLac93xFdzLF3NCZAtIm
         Fw/SV0wYMtKQ7KrbeCeNfsdCiwm7pn6h3FAmwAMTUWeEi58Z8fVlDyfP8c8nn40K4u7V
         sZX+ayxtHIDOaxtt4XALJhzVhjt2t+R5Aa5gyFqKCCRZ5gzREFWN85JeSCZgF6h6vQxT
         IqJwZm6fRlNsa7QuA/u0udKcFvyzEHs0rwPxV8flPlqiE5KdGDqeTUT09VyKgnUBSH0J
         xqUaECdiR2GqDIw4XX7omq3W2Z1iC9nvviDwk3mEepeCe9QbzsU3Jl67ThLgVOUYURsp
         b0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681155725; x=1683747725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QB7W0GXP1VzxhOdRLXF0y5oyjgK/ieF8BJXDgGfMNiM=;
        b=XBZrfC2C1PsgmRvLojjV1AfD8468c3v+TwTO0wM02BHM8X2EaHxyPlmyKXAZpVx/eG
         jUp0EBkGmgUc74NTaE824fs8HWaT7M5zNTrZZBK+RAnxMw7+nkGsTOaPWLPmMHDVnN1h
         PNCyvVA6vjM61WodpY4y465lk9nkLlqozqX7BsnLL0HbPY6d+0nP31iU5xJl6ff+z5CT
         +PZUq99aCz+rrvUI05xBUTNAUuCHNHIh4rViLVV2JtpfQvGEg1yzue61Xsp/x4quaM3a
         jftlJINg8oU49u3HuK7tnlpaETMnoh7bH3AQtZm5sTRAZUencCs7IptluGXHzdV79QmD
         Jo5A==
X-Gm-Message-State: AAQBX9cPbtOenFDiJeiqXBJht0L4clMsmBUoKTjMbPoj7okC/n4+GvIN
        c6vOxoaTNMjtY2DA3Zzs85j0+Q==
X-Google-Smtp-Source: AKy350YNT60EVSJ71IQxngPY6jRW+U6UDojuObfwFtal1MwDTVGPJfu8Yn/c4VjxZXCI1e/nab2mGQ==
X-Received: by 2002:adf:e34c:0:b0:2e5:a86c:fe74 with SMTP id n12-20020adfe34c000000b002e5a86cfe74mr4990124wrj.51.1681155724951;
        Mon, 10 Apr 2023 12:42:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:2611:592:3b9e:d2ae? ([2a05:6e02:1041:c10:2611:592:3b9e:d2ae])
        by smtp.googlemail.com with ESMTPSA id e17-20020adffc51000000b002ef2e148d59sm11844898wrs.16.2023.04.10.12.42.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 12:42:04 -0700 (PDT)
Message-ID: <b2e5ef14-9a12-15d5-8016-d0994c1177c3@linaro.org>
Date:   Mon, 10 Apr 2023 21:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] thermal: mediatek: change clk_prepare_enable to
 devm_clk_get_enabled in mtk_thermal_probe
Content-Language: en-US
To:     =?UTF-8?B?6ZmI5bq3?= <void0red@hust.edu.cn>
Cc:     amitk@kernel.org, angelogioacchino.delregno@collabora.com,
        bchihi@baylibre.com, daniel@makrotopia.org, dzm91@hust.edu.cn,
        error27@gmail.com, henry.yen@mediatek.com,
        hust-os-kernel-patches@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org,
        matthias.bgg@gmail.com, rafael@kernel.org, rdunlap@infradead.org,
        rui.zhang@intel.com, void0red@gmail.com
References: <6e3c59c3-8ad0-9c53-62a4-7be6f55a7c02@linaro.org>
 <20230403164610.3608082-1-void0red@hust.edu.cn>
 <20230403164610.3608082-2-void0red@hust.edu.cn>
 <7b1f01ae.3988f.18769458aaf.Coremail.void0red@hust.edu.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <7b1f01ae.3988f.18769458aaf.Coremail.void0red@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 05:46, 陈康 wrote:

[ ... ]

>>   static int mtk_thermal_remove(struct platform_device *pdev)
>> -- 
>> 2.34.1
> 
> ping?

Did you check the 'mtk_thermal_remove' function ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

