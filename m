Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A0B5B2F84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 09:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbiIIHLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 03:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbiIIHLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:11:10 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D684AA221A
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 00:11:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx38so744944ljb.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 00:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=y0DoW8vregXVH+TM9mSXdMASvPMT9wSQ3N08H3J6evs=;
        b=w290wK8hnQpSbBmI3NNQEyLEA0IUA1o7Yh2KDXNLksO9NzSUKeKrwKdCpZcrSqzj+u
         iM0CFYgP/r4t74k4pGZEg05CgZcSA1y5VZWab4+viW0PdL6vzWGGi8raEZun5V4UrjK1
         wYjdB5iYfKMNW/kj/4am9xtzGvglsW57d4gXgUeEleLJgUcY9xGarD/KCq1TEBCNmFQZ
         jj/MRGOPYfZDTND/SumPuDpt/Sv4AJLgpxC9NkbcX+vyjdZaKdzAlnVkPK9ymxWBBhMG
         6C1I2qGyG9dSrMd5y6LSPnz1PpwE4Z+dxZ+0ZAvaGA8aHT/0q/AB5iQ+e1BoLYnC/h5h
         qT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=y0DoW8vregXVH+TM9mSXdMASvPMT9wSQ3N08H3J6evs=;
        b=sv4eq6eRW8KJ7o6QCd05LYH5plTBgcS/X3Uele41exckNqDETzCL2J4wPc+qD7WToa
         J7cove+rs095XIkRCtsrTOyotjlkUnECANpT4N85GYeUxNqc53HQfDrINQpwBHaLpv6B
         fNhu5Fe09CaoRRDmmVU7xtY/Tvx+yt3X4WOoxJn7+tEJi6bmyHJFmjM30Y4Deu771HaH
         /vr+CdXfMQdN+O0NWxS6TbEPGXmN8KjU7yvc7wkRN6LOhapCHgpwxLkvMXn3Rc9ZIYLl
         c8g/kUqmVL593cIRmaRvEKg0k07/6iocuDWkgO1Y4jvJcvDHcEbpLtxxkjxKXgQwGsRJ
         ivpA==
X-Gm-Message-State: ACgBeo2JcM9cEa0SU57mAVnepb4HBEjLxPnZqdYVak+9jEuVOktaZDE0
        SgFWzSuqTfGODS7Pqoy5z+eLw5nDuRbTuQ==
X-Google-Smtp-Source: AA6agR5cskGKF9Nq7MxQL8NV1peMGWdlaRakuhFzDBcuIUAY5U+RObocA3dShuBgZsktmyl+JKAROw==
X-Received: by 2002:a2e:aa13:0:b0:264:eb98:b7fd with SMTP id bf19-20020a2eaa13000000b00264eb98b7fdmr3379497ljb.26.1662707468235;
        Fri, 09 Sep 2022 00:11:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q30-20020ac2511e000000b004979ec19387sm142439lfb.305.2022.09.09.00.11.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 00:11:07 -0700 (PDT)
Message-ID: <87307ae4-a320-5880-1333-6ea700b61ca7@linaro.org>
Date:   Fri, 9 Sep 2022 09:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 1/3] dt-bindings: mediatek: mt8188: Add binding for MM
 & INFRA IOMMU
Content-Language: en-US
To:     "Chengci.Xu" <chengci.xu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220831125502.7818-1-chengci.xu@mediatek.com>
 <20220831125502.7818-2-chengci.xu@mediatek.com>
 <2e575ed1-b82c-c7bd-3ddf-ccb6022b2461@linaro.org>
 <c09f262422dd6cd0bf2147870a109bd2ede36d4f.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c09f262422dd6cd0bf2147870a109bd2ede36d4f.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 05:20, Chengci.Xu wrote:
>>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
>>
>> Why do you license it under BSD-3 clause?
>>
> 
> A mediatek internal wiki suggest me use "BSD-3-Clause" without detial
> reason. May be it is not suitable for this file.
> 
> If you don't approve of this, I can change this license to "GPL-2.0-
> only OR BSD-2-Clause", which is perferred by DT bindings file according
> to "submitting-patches.rst". 
> 
> Do you think "BSD-2-Clause" is OK? Or could you kindly share me another
> proper license?

Please switch to "GPL-2.0-only OR BSD-2-Clause", which is preferred for
bindings.


Best regards,
Krzysztof
