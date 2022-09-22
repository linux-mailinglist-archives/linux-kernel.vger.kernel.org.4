Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217725E5BA1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbiIVGtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiIVGtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:49:11 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06EBB729A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:49:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id a3so13053946lfk.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kivIBO0juD/4ymQdgeIQKWbZZAbTDNdx8uwuKAi1JwQ=;
        b=kMRtMXiEbrRFe3n2fOiOzKCO/dOQKqmUGDb/4vkD61IY5CPk0zUwAbkildFaGnxYac
         6Bb2B2CDW1RNXQVeEF/O2wmxfX9laLgXa4CveanPLqRDfru0nDxSCJTynsO+W4B9hKG/
         aS/BkKGxB+qii8DACTyyvRVhli6DysxYWBguALi94yE/PqL3zrOjIvZhTH8ceDhK1H66
         59W84lUkWmg8aJA3x8jk/vR5wRmBRXjOIFTx/lx13t1ZM0wWrKCmGHNFv6IkwWKcNHi3
         uCmupZtN6jkygjegr9iJKrdgyPjGLZGEA7+Inm0gsyHxGwQ9y+uGoqwLo2rG3nmZTsMw
         QMJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kivIBO0juD/4ymQdgeIQKWbZZAbTDNdx8uwuKAi1JwQ=;
        b=xlx+onBZ+KAyv1MtIyMEMosLDpTZGHDdM5B8JAKChhNiWI3aGJ1uv5flnb371uwe83
         QTZthnxDmHUkKb7y+JEWYEoYu5N9zOtXU5V1UfDg1d2z4rUlqZ4bhZkmQZ8BEQBWd+Vn
         Fm+rbunZsEW6BGCjeqzQRxxH6IDkN5dA47S0oDE+qv7TOS2RqrhstMZzIalCM4SQoUjH
         8+8QabPgg3xARchVFt7vtruUDsZuk/ETjIB0uAo2whx9Um7ixQTjhixf0KK1N03n6n0E
         xi1dNd+EyXOORWCzl/BqQazvIINHZ7WQRUnQkp8lxx+um8Zd4LK8umkDyWbbcThcBsoR
         lXng==
X-Gm-Message-State: ACrzQf07VDenJJx3Wp1v49gyLFyfjqisv0J3famHSlz4uC1Jcp9p2m7Y
        j2eOed6PkJIqRAMtVbhfMG1lPQ==
X-Google-Smtp-Source: AMsMyM7s6qfEd5T3ZhNN1ZdqiLbx+dvO8AHetJr7BtwPbvytPmPn9zEVC1j5F/16ObgOnVzQV5PJhg==
X-Received: by 2002:a05:6512:3a8e:b0:49a:e5ed:d6aa with SMTP id q14-20020a0565123a8e00b0049ae5edd6aamr699253lfu.271.1663829347013;
        Wed, 21 Sep 2022 23:49:07 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id b27-20020ac247fb000000b00492f5ad0ae7sm795809lfp.43.2022.09.21.23.49.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:49:06 -0700 (PDT)
Message-ID: <1c33bf6d-b458-b2bb-3116-ed20b9cadc0e@linaro.org>
Date:   Thu, 22 Sep 2022 08:49:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] dt-bindings: arm: aspeed: adjust qcom,dc-scm-v1-bmc
 compatible after rename
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Jae Hyun Yoo <quic_jaehyoo@quicinc.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
References: <20220811062953.5976-1-krzysztof.kozlowski@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220811062953.5976-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/08/2022 08:29, Krzysztof Kozlowski wrote:
> The Nuvia DC-SCM BMC board compatible was renamed in commit
> 7f058112873e ("ARM: dts: aspeed: nuvia: rename vendor nuvia to qcom"),
> so adjust the bindings as well.
> 
> Fixes: f77024c80147 ("dt-bindings: arm: aspeed: document board compatibles")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Jae Hyun Yoo <quic_jaehyoo@quicinc.com>
> Acked-by: Rob Herring <robh@kernel.org>
> 
> ---
> 
> Changes since v2:
> 1. Fix typo in commit msg.
> 2. Add Acks.
> 
> Changes since v1:
> 1. Use proper qcom compatible.

Andrew, Joel,

Do you have any more comments on this patch? Do you plan to pick it up?
5 weeks passed..

Best regards,
Krzysztof

