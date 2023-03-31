Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B5F6D2339
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjCaO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbjCaOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:55:49 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05B20D84;
        Fri, 31 Mar 2023 07:55:33 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h17so22695995wrt.8;
        Fri, 31 Mar 2023 07:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680274530;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v1oqbGwtutANfbZAgt8lNsLuoBjX9Am//6Vl/oFEfA=;
        b=K46Ne0U68WOC0jQyu1f6ef7pr7GDPh7f4Pjgd6JONmZ5vhy5RMvhlW4VUj7raalPXN
         aEAk419VYn+zMv1le8W80jEHTMAuP6mrf+zTSZazTT2K9obzDGaxQ54JqA4M3jRsWzm/
         dzQYQmw7NFmeKkZcjrgHRL1q1/DLzK2Ia3Iiay9q3+FhUszWuTwM65xERLQfBXgCe/Ot
         5yHZkVsNtjhU+MYbUZNaBz9IKuQO6lM1tlRrF7954KM39osWlOJHgnX0fDRKaOPXByTn
         BlYJiRupf+OVpQDWadhViNPq7nGEQqunlLJhVmTKX4eUDkUnW3y6BS7FTCh9aneafmAG
         g6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680274530;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1v1oqbGwtutANfbZAgt8lNsLuoBjX9Am//6Vl/oFEfA=;
        b=M588g1kmwVMQvhavaqehClCcjm+JzRRZTm7EFutPkOvclu23ckt95wMWCCeoWvzc1x
         C6BrPjPML8J3a5sG2I4Qq5boxhMXz/1wxS+wAWd/py8dyaNTS27GatOjwwSiBVE5p2B0
         XGyIc0B4dccmvNtpOpXMVtib77s76HQG+z/Q5m3sIh3wsQ0nognZJiag/odXUH7JcV1N
         BXhRQvIs2oEtod3Xk1D9zGirAPkdhZ3p07o6egeWeLtXquDVkYzV0qEGp6GdoU0Ci6HS
         xqYLZgM72kK5VcIQLPvNLTphxleAhg4u0teucJNrue6XZWn0wfrOio+rBnWBOR0b0Mme
         mnOw==
X-Gm-Message-State: AAQBX9fBMEvCExCrU4jfnwPINE1u1ejDEUGMjHW4gEsiPD3iLv+Huv/w
        qML41gnihadMXYS3i8fJmPqIeAXa54NghQXi
X-Google-Smtp-Source: AKy350YSKtIqzT8X8vCZa/0jBsvl+GqGNYLY0iKeyTokK7bymrPZFg5K6qU89SULQhw0gw/NXjZGpw==
X-Received: by 2002:a5d:4dcb:0:b0:2ca:8da1:db96 with SMTP id f11-20020a5d4dcb000000b002ca8da1db96mr19386253wru.50.1680274530116;
        Fri, 31 Mar 2023 07:55:30 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id g6-20020adfe406000000b002d743eeab39sm2398567wrm.58.2023.03.31.07.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 07:55:29 -0700 (PDT)
Message-ID: <c8861fda-63c6-7951-29a7-9d29a73e8f3e@gmail.com>
Date:   Fri, 31 Mar 2023 16:55:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>,
        Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-1-45cbc68e188b@baylibre.com>
 <CAAOTY_8G03TpY88hMmUgbq5E6P2Y8h5a4DB5T72qfNG6CA+NQA@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 01/21] dt-bindings: display: mediatek: aal: add binding
 for MT8365 SoC
In-Reply-To: <CAAOTY_8G03TpY88hMmUgbq5E6P2Y8h5a4DB5T72qfNG6CA+NQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang Hu,

On 13/03/2023 16:02, Chun-Kuang Hu wrote:
> Hi, Alexandre:
> 
> Alexandre Mergnat <amergnat@baylibre.com> 於 2023年3月9日 週四 下午10:23寫道：
>>
>> Display Adaptive Ambient Light for MT8365 is compatible with another SoC.
>> Then, add MT8365 binding along with MT8183 SoC.
> 
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> 

I'm a bit puzzled that you give your reviewed by while I would have expected 
that you will take the display binding patches. Will you take these or do you 
want someone else to take them?

Regards,
Matthias

>>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> ---
>>   Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
>> index d4d585485e7b..d47bc72f09c0 100644
>> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
>> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
>> @@ -33,6 +33,7 @@ properties:
>>                 - mediatek,mt8186-disp-aal
>>                 - mediatek,mt8192-disp-aal
>>                 - mediatek,mt8195-disp-aal
>> +              - mediatek,mt8365-disp-aal
>>             - const: mediatek,mt8183-disp-aal
>>
>>     reg:
>>
>> --
>> b4 0.10.1
