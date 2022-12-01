Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB5863F5D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLARA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiLARAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:00:17 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0E0A555B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:00:15 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a19so2623768ljk.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXnwTyp0YzPLRKKZLOzA/snGGDPMoFoECUlFdWFKQ/8=;
        b=cN63MJ1yua6tFgv8fqubukDCnpaSammsB9wrt0ahsC14hkp5sjMoKEoc0PSshbAH43
         RunesN1GCo5ibSd3GI34qkdeSvBcR7Dq1jjME8BplO+6GNV/2xPJHPSfS+l0peUYk5bx
         vVfSHCdtlBDg7Cg8zFBxidJG/yFv4+dtAkHCOmh4MrS3+2sGbGYuIyzfHFtwIwTgGXlN
         PjTLoTo9OeV9XM93wvUrohURu39ddWUmQB6c3Pqle1TUFTltlz6K70Fuc8k3mC4L0Rlq
         rtdhxQTQALFVJEd4Q0nMfMHffYSaECzJdtKnkGkRDN/LEk1Z44jqAxbOQ9QaWMZ8Iizl
         M9kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WXnwTyp0YzPLRKKZLOzA/snGGDPMoFoECUlFdWFKQ/8=;
        b=Fqm4DGa/suF+hy5L7WA4AZKLu9BzHecSDjT0tiT+W3T/VCo4Cev17klcq7PA6zHzaf
         QPBvSUC2m2RBoTw6qgPIc+uNY82vPHRTOYYnYI6Lv9UKkhDqa1WuqIXRMTU0PudAS69W
         Xy0lsgTspywp/VaJ9H1Q53ulXo4X5PVeGZhLHUaIQ+ai/i+uY4/VHUAeTC0Pt50TEKFn
         AoMdp96jCS+VZqE74Sf8Cphl2+R+Hcii9sFH9gRt8jXR56Oug0a5HPw0bwWvMK2laCG8
         Y1/OZSBz2yHVvv2dUivAYLNMYSmUewk0oCzSXT2r9yOUbCaksyGNXveW23NNA48//SrO
         dobg==
X-Gm-Message-State: ANoB5pnr2sQYwXFIIHmLyZP0fA5E8Af7MQKwt1obNlj8+ezI4qlEYihQ
        z3q/ETxf8bWoA8XRyJ49zUeHJw==
X-Google-Smtp-Source: AA0mqf5V8lf0rMqvlg71kHW8BCttSGXbDCzdME1L5cknr3D55eoHjtElDUF0dTr4LZREa3ygTFHGXg==
X-Received: by 2002:a2e:380b:0:b0:279:8590:8a28 with SMTP id f11-20020a2e380b000000b0027985908a28mr12497729lja.48.1669914013570;
        Thu, 01 Dec 2022 09:00:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c7-20020a056512324700b004b50d4521f0sm711819lfr.15.2022.12.01.09.00.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 09:00:13 -0800 (PST)
Message-ID: <02a90915-2786-9454-1f10-fbf1ab18f8c1@linaro.org>
Date:   Thu, 1 Dec 2022 18:00:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon/pmbus: Add mps,mpq7932
 power-management IC
Content-Language: en-US
To:     Saravanan Sekar <saravanan@linumiz.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marten.lindahl@axis.com,
        jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20221201044643.1150870-1-saravanan@linumiz.com>
 <20221201044643.1150870-3-saravanan@linumiz.com>
 <bc86121f-3cc2-1e55-4c6a-02cb1644a8bd@linaro.org>
 <e7b20055-4f44-aa91-e18d-9fb0f835fbf1@linumiz.com>
 <29de4d2b-3e32-809e-6ccd-5e7a4fe548fc@linaro.org>
 <e0d97b79-2133-8869-eaea-eb286fdb3a11@roeck-us.net>
 <785e942a-0691-f87e-b6e9-058749a79ec1@linaro.org>
 <8228db8d-2a32-1d23-74f3-05b9fe529a82@linumiz.com>
 <bdab2e58-ea12-0ccf-a25a-ed89e50a5332@linaro.org>
 <ddcda7c9-6aa8-2660-d6fb-8dc117f330c4@linumiz.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ddcda7c9-6aa8-2660-d6fb-8dc117f330c4@linumiz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 17:52, Saravanan Sekar wrote:

>>>
>>> Indeed it is PMIC chip. I think this is not the first and not sure title
>>> has to be changed for hwmon subsystem.
>>>
>>> bindings/hwmon/pmbus/ti,lm25066.yaml
>>> title: National Semiconductor/Texas Instruments LM250x6/LM506x
>>> power-management ICs
>>
>> Then I propose to put it in regulator directory.
>>
> 
> Just for clarification, should bindings put in regulator directory?

Yes, only the bindings. Assuming of course that the PMIC is the main
role of this device and it's not a MFD (then usually we put them into mfd).

Best regards,
Krzysztof

