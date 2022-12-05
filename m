Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5380642570
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 10:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiLEJIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 04:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbiLEJH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 04:07:59 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEB91834A
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 01:06:35 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id l8so12735295ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 01:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5ZTncPZSmmM8YtV3eOV41TWmby1NfBlelF9byY72Kg=;
        b=FmQg61AYiojSXcPEVg2/VcRA64ZyruSZKCoC8eQjQAszR39C32EmyyE2UMnY2+JKrr
         /+YJm4qduR5MqPaRFPOInuqZRtsCX+o//SjummVVvTG5PSnA7mWhjRfnGcZ5sX+RO0Rw
         9brAMt46fQjdDgokS3QsGPh51/SIcvwFe1qLji8P7vleSGlgxmqQgvjJxgVTqGxo/iaM
         SkdrA3fA6MqHKUVYjLJg2T+Bckj8JUhspL9poqyf4q8lABjkj7sJJB9xethmES8kzIs2
         Dy3ZpSa9wxj2P2Oymp1Pq9oELhS5JQz8bIJ85VoNEhpkQGaLnymh6NnqZrP02boVg/9p
         puXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5ZTncPZSmmM8YtV3eOV41TWmby1NfBlelF9byY72Kg=;
        b=ONuF6wEjyyBn8wVwZeVR7+3wypZ2jMeEGxrO0HNKV83iXSgiK/wrtezVLJ9UdhM5MK
         Dwu7hU9os1wDJGrpDGnO4b88bfUKZNdqzPfMVE3IE+2lCjbbeRYbzH65jwlfBYr5PcVp
         x8xwZYA0360/iZj+kNCZvMIR2TfoFU8JFoqXoG9ocWGPqixzCpkMEHNnUKLWLZS4amqB
         YUDPhQpNg9eau2fc2Bl7+3rCbiuQ/JertHXfxRDbYywrlrDX8J7fhFnFw65QgjgpGY7z
         58pqPaTyZRGO92H+9GzFkW5qIk8co/hZLXVO/0aEjmPMvOhBOYWAllgIDqmZvN8CcR3V
         ewgQ==
X-Gm-Message-State: ANoB5ploW6dGEh6QQYzFt8Rj+h0xzWMjsUNMXFLKsDhNB65PO0M3pSs6
        Umv+SAu9z6zDXW4v12LXkd1jIg==
X-Google-Smtp-Source: AA0mqf5S6gXj5coEIP8nqbgaKkxlyuQq8uWDpyo0HJ5TZT9TjGF08Asdm4bnWFPa0NFzDd9kn9gA9A==
X-Received: by 2002:a2e:a9a0:0:b0:278:f1a5:a365 with SMTP id x32-20020a2ea9a0000000b00278f1a5a365mr24403347ljq.29.1670231193792;
        Mon, 05 Dec 2022 01:06:33 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id bu4-20020a056512168400b004b51ab265f8sm2041942lfb.193.2022.12.05.01.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 01:06:33 -0800 (PST)
Message-ID: <d320f49f-b304-4ef7-1d50-5c909c6fd108@linaro.org>
Date:   Mon, 5 Dec 2022 10:06:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 7/9] dt-bindings: spi: mtk-snfi: Add read latch latency
 property
Content-Language: en-US
To:     Xiangsheng Hou <xiangsheng.hou@mediatek.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, benliang.zhao@mediatek.com,
        bin.zhang@mediatek.com
References: <20221205065756.26875-1-xiangsheng.hou@mediatek.com>
 <20221205065756.26875-8-xiangsheng.hou@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221205065756.26875-8-xiangsheng.hou@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2022 07:57, Xiangsheng Hou wrote:
> Add mediatek,rx-latch-latency property which adjust read delay in the
> unit of clock cycle.
> 
> Signed-off-by: Xiangsheng Hou <xiangsheng.hou@mediatek.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

