Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE6C60CB73
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbiJYMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJYMBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:01:39 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B4F7E310
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:01:36 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id h10so8355592qvq.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 05:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=irIklGIGYXj1ZpFYPGwzEyqYr11Kn+bOOpv9KU220eg=;
        b=CE1udPBBHzcYvfFbmMXYXr+o9fUb4/nV33iGczLc86DfSioFDQZRE5EcrrF13eWZsB
         WkiyRKk3hckZKmhkBe12jDvJgITqWLlrnk0fUJk8EujMTwxFVFSIl8KvLJ2XfnutIrtK
         Y1mXqgruPwX3yQHF22C2wIK5r5hZpg2gLuM7LQFjZG4ptcLsfuRd259ZtJNyeOczdn8W
         qr+NItXglIYjazPVk3F1MBNOEIqFmiYljVeDedR/DcAg4dipEuU/OniJ55elsXZzit6O
         lLqecKMSswauSicYZUWDxE569FkdhPoGs0JyItBjjC4txkYfRuKBNGrXr6umGz5G0PBi
         IrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irIklGIGYXj1ZpFYPGwzEyqYr11Kn+bOOpv9KU220eg=;
        b=0UwYv5bjVBLLwyLI375S2ilJgfTKfiotFB7oTDfls2xogipbF1IsYBQqRaBoBGOYGa
         qbTTq7t1lIu7ueHCPdNHVBzr+xEBx8K0aX2yML4I1N7DY8/EDFHCo6WIn2YMunyWZqlI
         K9Btg0OujMLkJahOHmELVZ4nbfmwxUEpJ/TnO51JHtW8Y9x8vrLeXahPTeiNNGbHqRmJ
         E0tggyU9pxdi9noxnFzG/nvYL6BWVwMZxZ9gc1AkK71VR7SCX4vsgPXcDoR8sIyksqfz
         hJ7MQOBEBLDJ9WZK0HlgTRxFBYuQHB4Nggr0oLDLWY88KNvo52rirhDoOvUznQr43zqQ
         6s3g==
X-Gm-Message-State: ACrzQf39f7qpafNVzdG4uoJ8Oz1om8lkb8EaSfnmsuBRGP4RbNvmLmSf
        ql0J1FBYKnQFE976nnZ6BPYKWQ==
X-Google-Smtp-Source: AMsMyM7ESZdgrvM4rWa6BYvH3NiQ7BTqC8+muJutk2WPeftZ+/+YHRs8dap/XPUFW4052axfxT+Ocg==
X-Received: by 2002:a0c:abc7:0:b0:4b4:8d4e:d2f8 with SMTP id k7-20020a0cabc7000000b004b48d4ed2f8mr31684205qvb.43.1666699286025;
        Tue, 25 Oct 2022 05:01:26 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id g10-20020ac8480a000000b0039cc9d24843sm1494377qtq.66.2022.10.25.05.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 05:01:25 -0700 (PDT)
Message-ID: <7574f8a0-2509-ab87-4f89-25e8589cbd77@linaro.org>
Date:   Tue, 25 Oct 2022 08:01:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
References: <20221024210153.28852-1-vadym.kochan@plvision.eu>
 <20221024210153.28852-2-vadym.kochan@plvision.eu>
 <ae7c86fd-5bc9-4cdb-857c-e686225f5966@linaro.org>
 <VI1P190MB03170C4FC92ED25F78EF57FC95319@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1P190MB03170C4FC92ED25F78EF57FC95319@VI1P190MB0317.EURP190.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 20:29, Vadym Kochan wrote:

> [...]
> 
>>> +      nand-ecc-step-size:
>>> +        description: |
>>> +          Marvell's NAND flash controller does use fixed strength
>>> +          (1-bit for Hamming, 16-bit for BCH), so the actual step size
>>> +          will shrink or grow in order to fit the required strength.
>>> +          Step sizes are not completely random for all and follow certain
>>> +          patterns described in AN-379, "Marvell SoC NFC ECC".
>>> +
>>> +      label:
>>> +        $ref: /schemas/types.yaml#/definitions/string
>>> +
>>> +      partitions:
>>> +        type: object
>>> +        $ref: /schemas/mtd/partitions/partition.yaml
>>
>> This is a friendly reminder during the review process.
>>
>> It seems my previous comments were not fully addressed. Maybe my
>> feedback got lost between the quotes, maybe you just forgot to apply it.
>> Please go back to the previous discussion and either implement all
>> requested changes or keep discussing them.
>>
>> Thank you.
>>
> 
> I see that I have to drop "label" and "partitions" properties.

Hm.... why?

I commented about missing unevaluatedProperties.


Best regards,
Krzysztof

