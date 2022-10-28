Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F38610FA6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 13:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJ1L1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 07:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJ1L1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 07:27:14 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAF81D0D79
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:27:13 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z30so3159364qkz.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 04:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n27P9fQzAea5JJ3rcyXtQsWTxD0urj62so3demloRqQ=;
        b=s3VsWG//KkD/UGRA5ywODMgnFjgOsElESRo8QPf8XegqHktP0/qfkb8meHjwzOWjSf
         Quq2ROyt8VFaPIeB+1xj6oI72gAuBcNZ5+rJZ4VAtCFpV15SoOVyzXo7H4OfzXTc+xMj
         MRGbsvy61qw9FzMmxbYYiP9+piZt39XblXjYoV6DXnwlStS10/O1ZHYZ7oBvzBauQHoy
         utP8L2g93zI+vErg9j684msLNCKn0Jbt5L6R00DAP3X9WmMDAAuRfsgq8m44I+ErlLQk
         2oDrig9l72iCUk2/aKTshcG3eY2qemwJM2I2HVTZeq7a42Xf7iUABHninoGSUpit8xyN
         jYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n27P9fQzAea5JJ3rcyXtQsWTxD0urj62so3demloRqQ=;
        b=MoJ/o+cQ7Iy/2ez2V3ybL5bFueZccqqlMsdNXGqzzTx993ZkYb5U5aD2Jk84CLlTxg
         PfgerfpkwTl5c+uLC9YQnTJPdu6lfZyQJWfmYYReZf2KqKvueyMsV+3tfwVnug94mjEO
         /7l3/uumZdMpAbPwGOzYHM8DuH7xbyL0Z9unWkETBvFrj9ISFqT49ZEV7x8CnBDoGktT
         zi/TSC/fKgBcIB6LlK/6jbj2bmPEvAxr2bG+y5D+z+MvoHQSTmub5DBUx3J0YKFrJMNC
         +I6WEkm8yb5aMgfBIDYMrhF2y/wwttweEaSqYVFAwqiPsDeXnzymSdc8We55mbxsaqkl
         iKHg==
X-Gm-Message-State: ACrzQf0cRap2HAY8nYR/KIii8wIV/u9fl1uPVc5zt5sYHslN/fskpyx7
        uB5pB+cH7UmLrH9ondf/rlYxPQ==
X-Google-Smtp-Source: AMsMyM4oWiDhP7JzCJKC5Vj52NzocxJ+zmvdbOC+BFV0wwy5MqyYFVo6KZ9q5UpuKFDMXqnwowNswQ==
X-Received: by 2002:a37:bb82:0:b0:6fa:e8d:534 with SMTP id l124-20020a37bb82000000b006fa0e8d0534mr297964qkf.738.1666956432590;
        Fri, 28 Oct 2022 04:27:12 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w24-20020ac86b18000000b0039764587192sm2223661qts.57.2022.10.28.04.27.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 04:27:11 -0700 (PDT)
Message-ID: <5676bcd2-14fc-4e1d-643e-89e575d190c3@linaro.org>
Date:   Fri, 28 Oct 2022 07:27:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 04/11] arm64: tegra: Enable XUSB host and device on Jetson
 AGX Orin
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, Wayne Chang <waynec@nvidia.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, treding@nvidia.com,
        thierry.reding@gmail.com, heikki.krogerus@linux.intel.com,
        ajayg@nvidia.com, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, balbi@kernel.org, mathias.nyman@intel.com,
        jckuo@nvidia.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, singhanc@nvidia.com,
        linux-i2c@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-tegra@vger.kernel.org
References: <20221024074128.1113554-1-waynec@nvidia.com>
 <20221024074128.1113554-5-waynec@nvidia.com>
 <2059dfe5-b084-42a4-7f35-9da9561fc12b@linaro.org>
 <b803bcf9-fc47-5239-ffe9-707925f324de@nvidia.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b803bcf9-fc47-5239-ffe9-707925f324de@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/2022 05:33, Jon Hunter wrote:
>>> +			ucsi_ccg: ucsi_ccg@8 {
>>
>> No underscores in node names.
>>
>>> +				compatible = "cypress,cypd4226";
>>> +				cypress,firmware-build = "gn";
>>> +				interrupt-parent = <&gpio>;
>>> +				interrupts = <TEGRA234_MAIN_GPIO(Y, 4) IRQ_TYPE_LEVEL_LOW>;
>>> +				reg = <0x08>;
>>> +				status = "okay";
>>
>> The pattern of redefining full path in Tegra is confusing - I have no
>> clue which of these status=okay are correct which are redundant.
>>
>> Do you?
> 
> I understand you may not like this approach, however, this comment is 
> not really relevant to just this patch, but a general comment. But yes 
> we will ensure that this is correct.
> 

Just to clarify - this status looks redundant, but I have no way to tell
for sure...

Best regards,
Krzysztof

