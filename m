Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2680E733F0C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbjFQHPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbjFQHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:15:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AE1213B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:15:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f907f31247so529885e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jun 2023 00:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686986104; x=1689578104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qkJta/itqN/plYtDpPSK5B2b/lfTXQ8wtnzVNHq6pLE=;
        b=ycmJGcahVDhbo4zOAmSq3lKerxRW6RC3JCMzXhwfVt5UvBk/TgeuQrTapqugeYLPvN
         qy0ktDd9U08LGZRRgjXYmhb0ILQAwM0B6A95fewx/Wu4+UyZt0LHuMCQl5WU75ujZT5C
         rm2ojIKbqyY7CbIHO6hKRDcknLcpqncqujV7u4oKlx7iDKUY1fPolscXd3QiTudbPkmG
         sFWJj2vaHfaMykLDDUY3YkUVbtu59vkMCos6sGf69zVRjNvwso5WYKUDQOwNEfK25HCE
         1gTotbnZv9vvgda7fR62QgrhXFFPo66oqyiIjXt3t3PJ3UrmUe2vvInawh6CHBXDEZY+
         QWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686986104; x=1689578104;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qkJta/itqN/plYtDpPSK5B2b/lfTXQ8wtnzVNHq6pLE=;
        b=MKB+b2xjs0rBbCB+PTt5AOJDVBu3k4Mzu3oUrvGsjU1x2zT61iuNOIxc7Ro4AOIYcu
         e9K3laOc8+AbEU3IZVtNtWGfF+j18l2ZaqbcDzQc4W5IU3v2m/OJ9fMu5zXl8etvd/s/
         IymzgQhWl6HiaD/Ya9Oba89XNWkoKrH9RDpIyhBeMZDQQt00TAAuMM3utYrw933GVZPB
         ulbOmDiLlqeMVZmzwp05kRiNu3z7/Y+ukNoeDLtahxJOVTnr/uHGMGcrUbMLMSypXQkM
         eCXNZciOlJcRnEl9OCui5eMXACPSRZzbcil0Y1FBrARM/2iBTyVcL4j6s+hX7LZv0hd5
         NbfQ==
X-Gm-Message-State: AC+VfDzOyCTNe1lkiGPMGrhb+8+gdKOxj4EPLPn0io+Lbj9WolUgFGLG
        fRfQA9LgFGAh+xVyEXl+aOVqEA==
X-Google-Smtp-Source: ACHHUZ5OiiQzsETNaWBoHR3RwTTo+lhlSaUAJZCEBguY17vTlskHr3Q8Om8diCiSMwvip/2wP+bn/A==
X-Received: by 2002:a05:600c:2043:b0:3f7:3280:810b with SMTP id p3-20020a05600c204300b003f73280810bmr2941325wmg.19.1686986104226;
        Sat, 17 Jun 2023 00:15:04 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c? ([2a05:6e02:1041:c10:4aa0:8c56:eebe:c05c])
        by smtp.googlemail.com with ESMTPSA id p19-20020a05600c469300b003f7f475c3bcsm11212368wmo.1.2023.06.17.00.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jun 2023 00:15:03 -0700 (PDT)
Message-ID: <dd3cc9db-bb60-8dfd-19b7-afeeedb65177@linaro.org>
Date:   Sat, 17 Jun 2023 09:15:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] thermal: loongson-2: add thermal management
 support
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20230426062018.19755-1-zhuyinbo@loongson.cn>
 <af4d1e00-76d6-b71a-2ed1-562e6405306b@linaro.org>
 <bc081559-e6f5-7ac8-7ae1-3cfbbee51697@loongson.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <bc081559-e6f5-7ac8-7ae1-3cfbbee51697@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2023 05:25, zhuyinbo wrote:
> 
> Hi Daniel,
> 
> 在 2023/6/12 下午10:22, Daniel Lezcano 写道:
> 
> ...
> 
>>>
>>> +#define LOONGSON2_SOC_MAX_SENSOR_NUM            4
>>> +
>>> +#define LOONGSON2_TSENSOR_CTRL_HI            0x0
>>> +#define LOONGSON2_TSENSOR_CTRL_LO            0x8
>>> +#define LOONGSON2_TSENSOR_STATUS            0x10
>>> +#define LOONGSON2_TSENSOR_OUT                0x14
>>
>> Please use BIT() macros
> 
> 
> I learn about that BIT() is generally used to describe the functional
> bit or control bit or status bits of a register, but these register was
> some different register offset and not some control bit or status bit
> So using BIT() here seems a bit inappropriate, Do you think so?

Yes, you are right


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

