Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4857B5BF7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiIUH0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbiIUH0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:26:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C1A7C1A2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:26:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id s6so7735954lfo.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 00:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MnSWHO+RfIeNaFDFqzwfoinv6Rc5CwKZJPD6zpABsuA=;
        b=oGeYxT8aHwJywwRm9eJhQOM9sgCnqevsJOBHoKUDP0+7PklEDRAvCLaJe/vz6zR1d6
         y4f2oxBEvIhXfqhHO7uQ9YnXtNXBCIboI0eQFWaq4TyaYVFZvfqjWGwQ7VyK8ocoRNA8
         7peHkg3H5So8Obcb5qU/Dez9PuyDebutxrlc5xQ33SPuP/4Stg5Zk7C5otypLXlN7NGZ
         qyMS7nTrzlJ63Tbl7Gx79PvRkjxfOJNoND1Rl77PZH6bouqlScCNb2ga3k7w6V3oMUaN
         axbLtlfUzULYO1Fge3E/pkyBDcJ3il+gBPdtHwOEGS3rowWsAFEzxqpFNaZNWZ8t5bkd
         Z2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MnSWHO+RfIeNaFDFqzwfoinv6Rc5CwKZJPD6zpABsuA=;
        b=c3MYmTv5WXgxdHfgwzppUVxbq5xEfFd+H9Sn6W+ksm7tuaj4xE9vFu2k+RIepoFBTV
         yawVvoUtWzFa8QfcDFT1cbq1pfJOehZeC7QR84+3TycR2Yd7RcbW93BFg+fU392Svwwd
         HYOiCl36taUyYFMVnHWiZYcmUPumB2t6oMxl276Cjq0s12ayqKz0Alsej13RGB6jYUxD
         dsdJocBbWYEyJvGq+7WxYErThN2R9GbKtaHethOTs/87+Tl/As+6c6vpdE65vu0YKLLX
         TvozaBqpQmi6Yq4O5Rjz1z66IgGJo3BDjFnnPUXtIc23G5H9r/e2DkVijgWRBcJmsuI/
         gglw==
X-Gm-Message-State: ACrzQf2kW2nmV7ETny4OFuH7BJusmwlGxqBTahi9ajuh4aKVBoenRGLa
        Ow+Yq4goGkUro9XlcMpZ+pHTdA==
X-Google-Smtp-Source: AMsMyM7FEIha/kn5S4kD/G/mfgRfoNfCWlTclJDQXi2ZBv8md5pqDwyGpYTNn55ERJ4Gzh4WeZqDjA==
X-Received: by 2002:a05:6512:3ba1:b0:498:f547:866b with SMTP id g33-20020a0565123ba100b00498f547866bmr9174722lfv.653.1663745169086;
        Wed, 21 Sep 2022 00:26:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d9-20020a196b09000000b004999c243331sm315377lfa.141.2022.09.21.00.26.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 00:26:08 -0700 (PDT)
Message-ID: <89d925ea-f550-6903-1c24-b320ae5a82c0@linaro.org>
Date:   Wed, 21 Sep 2022 09:26:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 0/8] Support for NVDEC on Tegra234
Content-Language: en-US
To:     Mikko Perttunen <cyndis@kapsi.fi>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920081203.3237744-1-cyndis@kapsi.fi>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220920081203.3237744-1-cyndis@kapsi.fi>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/2022 10:11, Mikko Perttunen wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> v3:
> * Updated patch 3 based on comments
> 
> v2:
> * Updated patches 1,3 based on comments
> * Added Acked-by to patch 2
> 
> Original message:
> 
> Hi all,
> 
> this series adds support for the HW video decoder, NVDEC,
> on Tegra234 (Orin). The main change is a switch from Falcon
> to RISC-V for the internal microcontroller, which brings along
> a change in how the engine is booted. Otherwise it is backwards
> compatible with earlier versions.

I asked you to describe the dependencies and patch merging strategy.
It's still not here, so I assume there are no and I am taking patches
relevant to me.

Best regards,
Krzysztof
