Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872895FA0B6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJJO4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiJJO4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:56:30 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B72EC2611A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:56:07 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id a17so1773890qtw.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UwsU1fn/1SfZtcqL1Zfll3O9hBAK2GV/zHS0qbctt9A=;
        b=vFfv1QykuX1R6T4Pv3s7wuWLMBDo5sYCAxir3KGVHEjCi0mdzbZew2vk7h7L4rix3k
         Rf9SYZNWSKxwJzDt0MinCCWk2PmF6aLaMXl9clOTRhhkSAK0KWc7C0aO7U54037TBtBp
         4WFqQ2HLFcob6z8Ev57+FwoAg7h4Bm28VhWB77XX8IRaKjbKaqyq77FLWnJ0q2FteKKn
         psQcN8rXlsCo7oPYfisgs70YCbhs13QHkG2xCSvUGtoeOKERdZN72m1KwwMTeyBq5B82
         tCIPlwoZiF7YhC9lP40IqRPJAuxZrd15FL1yLQZqZtt6u0BAhCS62zqGejhDSUBQCqv9
         rcIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UwsU1fn/1SfZtcqL1Zfll3O9hBAK2GV/zHS0qbctt9A=;
        b=uID451t18PRqcHlIqCIrm0aQ/AJ33DiEcVOqgpnxQaZpy1m6p1oCwdMuEuxxiwLz2p
         /glhW1z5ZTYsElmiSGhczy417pxMZb6Qs/slazSeneX10BN7O/yZp/Hwz2iV0P+RdrDN
         lCmLuxN5Q+NfScPWMGUc2jFBtlAHlHyM1SemTj3NAQIFa8StgBdCo3fBBxu52oBpHvp7
         0w6k7WmmEvn+Y/3syqTjD8rBp3Mw/D9tesd/G5HTi3F6rJscv28k0JRp8JEoT7UoAn3I
         m94gyrG8WjaiX10Uz5XYq43HAaHNZHlA6dJlOn97kmULkRT66U3oUbHA/xkQwi1EmqCI
         RipQ==
X-Gm-Message-State: ACrzQf2dOrtDP9sdPFFFz3KoBMic/AbueFxWavATPQmx0U9CzATaPohZ
        uOR9sETtRCfppPdO1VIXxS3/Tg==
X-Google-Smtp-Source: AMsMyM4wUdL69r1gqbyekIM8UU8nT+Iwy6V3/bmUUZzogalJHEIVc9ztR+cgKUf3W7pIPUCmGyr9vg==
X-Received: by 2002:a05:622a:13c6:b0:39b:e62:cfc3 with SMTP id p6-20020a05622a13c600b0039b0e62cfc3mr2150730qtk.687.1665413740678;
        Mon, 10 Oct 2022 07:55:40 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id fp3-20020a05622a508300b0039b26d92989sm1083673qtb.86.2022.10.10.07.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 07:55:39 -0700 (PDT)
Message-ID: <1c10a474-7014-b56e-d2e1-3e422ae82401@linaro.org>
Date:   Mon, 10 Oct 2022 10:55:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v3 1/3] dt-bindings: iommu: mediatek: add binding
 documentation for MT8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org
References: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
 <20221001-iommu-support-v3-1-c7b3059b0d16@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221001-iommu-support-v3-1-c7b3059b0d16@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2022 08:54, Alexandre Mergnat wrote:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add IOMMU binding documentation for the MT8365 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(for DT bindings and memory-controllers)

Best regards,
Krzysztof

