Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B67486C95D1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 16:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjCZOuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 10:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCZOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 10:50:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FEB61A2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:49:28 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id w9so25896415edc.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679842161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iT9B1aKF9yJ12QmOx1QgiryrgEw9qF6otzhh3qqptZk=;
        b=IXiwMi8o3JmSm95Jwv3M1jLx/L5NOcP7f9NB6Q5sLnJpgzEmAXhhzs3pG/X8OBcuZy
         TLAUsHroaaKoE67do67fCKspAhtbVkiQuxwUwoRATkoJE/U/pXxCh9fmBId2/jTxAs2g
         ywJLdKxTZm41YnM2iFqBmELADwCfioIUM6G2R+PBluY4gEaVyIVPjEMPzLyZPh0Qe6al
         Z+U3uojayhZiI8jWwxI13etksWA9PpuGf04U2tixb+ATJQdzzGECldSgqqO9F1ontwme
         gLL2Q0B3BYJorBodILde5RbSBYBH+kKV69SfMmhhLY93CgiVt9hCJ+2YqoMs/LAx6yQW
         g6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679842161;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iT9B1aKF9yJ12QmOx1QgiryrgEw9qF6otzhh3qqptZk=;
        b=ggUspAIUfBZ2+0xllQx6DsxnORVXNYmRLj/Fm6w9gEdfLAIRN6QYtgKcQcHp40OqW4
         +YYUEzOLX1jtQEcX2cI/GNH6S5OEk6Az+hjtkXhg01j34TurPM/8R89PQaOsf/ymvBJ1
         WNBgSYCTNJVn2BQu/XnvD4mY/gkidHXhExMT7wGmLAP+3JwkgaapeOV1tpsdeZaSxNa1
         dxvgHJ9x6Fz1X02twJvm3GBSr/GAHGK/4GFSM+o46N08tJdzzf9ukrFQA5OU6v0OGL4f
         W/mOgOlvtErr5zkqP8Ek7K3R8V6mxxRCOIcESqgMyg4LX9W+k4UCL32uJtIsRRTAYH6m
         Qd3Q==
X-Gm-Message-State: AAQBX9e7gYCSsHilZncuwaVE19V6aW0Gqc6D/y5qKAeLalXqg2Wg+7ih
        soj/uV/JHJWhuGv3rrQx8MohNg==
X-Google-Smtp-Source: AKy350ad6D065/wohSaDAKojWzAl2ktvz1jF7/iGTZwc4RKVWp1rzHxYPItKCoVoZGzRKeCEnp+AFA==
X-Received: by 2002:a05:6402:708:b0:502:4182:963e with SMTP id w8-20020a056402070800b005024182963emr1720975edx.26.1679842161115;
        Sun, 26 Mar 2023 07:49:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:eca3:3b8f:823b:2669? ([2a02:810d:15c0:828:eca3:3b8f:823b:2669])
        by smtp.gmail.com with ESMTPSA id lk8-20020a170906cb0800b009311c9d33d7sm12917378ejb.184.2023.03.26.07.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 07:49:20 -0700 (PDT)
Message-ID: <7dc532c8-de85-8db2-ad48-5d6d717f6d52@linaro.org>
Date:   Sun, 26 Mar 2023 16:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: ak4458: Convert to dtschema
Content-Language: en-US
To:     Saalim Quadri <danascape@gmail.com>
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        daniel.baluta@nxp.com, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, shengjiu.wang@nxp.com
References: <4762f4a1-5e99-4e5a-72c0-9c4c61cdc856@linaro.org>
 <20230326125819.18986-1-danascape@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230326125819.18986-1-danascape@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/2023 14:58, Saalim Quadri wrote:
>> allOf:
>> - if:
>>      properties:
>>        compatible:
>>          enum:
>>            - ak4458.....
>>  then:
>>    properties:
>>      dsd-path: false
> 
> Do we also require to add a descriptioon to explain the pins which will be selected based off on the value?

Description where? What pins?

> Or have you disabled it based on, that it is disabled for ak4458 codecs?

What is disabled? The driver indicates the property is valid only for
ak4497.



Best regards,
Krzysztof

