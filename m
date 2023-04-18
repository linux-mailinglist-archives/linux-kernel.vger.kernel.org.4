Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F126E608C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 14:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDRMB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 08:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjDRL7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:59:49 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E3D83D4;
        Tue, 18 Apr 2023 04:56:41 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o9-20020a05600c510900b003f17012276fso3970803wms.4;
        Tue, 18 Apr 2023 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681819000; x=1684411000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T9oSeZGJaO3G9BEkK1S2Mgd4sINffRf+WgKyKKehfmI=;
        b=EXHJXEGXy79uUSSwalxffycq7KWxOyLGcigWWbEvbe4A/tHuCrJx3bi9fyVr30xbvt
         2ohr0yYvurqh89V5/02Q1Lxqa1lcYhqwJT9gY2OkB9rEfs9TqLQHFDOXD5xueuIZKLIi
         0enhdobg6t6Pn+69lbxkw5PDTNIKBWJC2ntey0mtiKfSW2kKhayCaxskZc6WC/vPvrhO
         bC1syUexCP1omtV1npNjjcM6CzulU+hIVBIJEb6WXUrn9tqFidigErpnMAl0gPt0EZ8e
         vjD7hAefkxeTGZK7t8fEssZ0/C8eTQFa8cG8kZc3cSanJT3q9kEr34rQ5C6FT2zXaJ4j
         khRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681819000; x=1684411000;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T9oSeZGJaO3G9BEkK1S2Mgd4sINffRf+WgKyKKehfmI=;
        b=BqlCc2Jnr8JrwVfLfs3xUtFGDcGJZP90sViwaHXghBABSAPG3w9yxgJjeN6Zws1jJs
         9tDTAuxWeRH4x9cJU8EtaNL26EIVGqYqpX1AVq0oLUWYJGFtfmylAy7L9ZlQhTS6gYLU
         ctIAB2YOFGjSoU9sRml9i/3doC3ccP+B1SUgNrFh9J7TtszrIR0u8ApTztCbzm5urDsP
         NeRFHXSa0n7Lbq3TFMXpZ/qV83g7Yf4zpDERVg6Mg28fh6I+M8MqLR4jQ05ObfmtiTsr
         r3Osc7tOk/9OO7ihIHF0Fvgz1KB94L3jZ2ewAoHL/patqzXE5/Qola8ZkHclaaWE/144
         ZYwQ==
X-Gm-Message-State: AAQBX9duWhOPzwOfzGC3Q76dqUMQQwu7gC9Bez3bMeIZDgs5JtkMd1ik
        s5KGjCVk8uDfJKXVsOUtVCk=
X-Google-Smtp-Source: AKy350bbx0bJ/4L8a44U/aCtvaM2RV9kN1tMXWOPsHUuu0HTywAsjz+gzSejmnkzvEnhtHbDS3+jEw==
X-Received: by 2002:a05:600c:b47:b0:3f1:6cdf:93ac with SMTP id k7-20020a05600c0b4700b003f16cdf93acmr7012569wmr.17.1681819000111;
        Tue, 18 Apr 2023 04:56:40 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v3-20020a1cf703000000b003f04646838esm14855802wmh.39.2023.04.18.04.56.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 04:56:39 -0700 (PDT)
Message-ID: <1e55328e-aaa2-78e3-ddc8-c2717f6283f5@gmail.com>
Date:   Tue, 18 Apr 2023 13:56:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 01/27] dt-bindings: pwm: Add compatible for MediaTek
 MT6795
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        chunkuang.hu@kernel.org, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-2-angelogioacchino.delregno@collabora.com>
 <20230414054345.ip3ug53ivr3elbpy@pengutronix.de>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230414054345.ip3ug53ivr3elbpy@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/2023 07:43, Uwe Kleine-König wrote:
> Hello,
> 
> On Wed, Apr 12, 2023 at 01:27:13PM +0200, AngeloGioacchino Del Regno wrote:
>> Add a compatible string for MediaTek Helio X10 MT6795's display PWM
>> block: this is the same as MT8173.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> I assume this patch will go in together with the other patches in this
> series via an ARM tree? (I.e. not via pwm.)
> 

That's totally fine, I'll take this patch through my tree once everything is ready.

Regards,
Matthias
