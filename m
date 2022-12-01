Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0994F63F5BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiLAQwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:52:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLAQwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:52:43 -0500
Received: from gateway31.websitewelcome.com (gateway31.websitewelcome.com [192.185.144.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A1975FB4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:52:41 -0800 (PST)
Received: from atl1wswcm02.websitewelcome.com (unknown [50.6.129.163])
        by atl3wswob02.websitewelcome.com (Postfix) with ESMTP id 8628D222A3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:52:40 +0000 (UTC)
Received: from md-in-79.webhostbox.net ([43.225.55.182])
        by cmsmtp with ESMTP
        id 0mndpuVbq4ZGb0mnfpXlel; Thu, 01 Dec 2022 16:52:40 +0000
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=linumiz.com
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=oQj/HJTvdxrVt+zk2ySQjAT2Bd8kLr9eRU+0wbh0SyY=; b=KfZAL9PccHg35tGQV5H19QvMOp
        0mHs2MiMY6EmiEBcaAgtIV79bHtAAitMPipkUwaf77mIG3gaJyWDkrbQIeOof7orF9rEegDuNGYP7
        eBaA86RKRTssD0Vjv56GuKiVub8j+0M1JR+ON0BQ1eJ/pyKIM6AGeTnaxgOnOkw4Z00MheCZyBcJF
        jLSo62221IPO0aSh2eWh+aiWPPaWGEdYpY8x/UoPFpCORKovh8BY0QshN2xbc52ZdLFQfT1F1DYnH
        c0/TomvO3So5AzQ3LWfWxFvLl3lWTWVO1D9QNfIdzWFm4rPBMcZ1BfqDeWMJvoWtouHHWYZCDgngZ
        tnusNc0Q==;
Received: from [106.197.183.239] (port=44685 helo=[192.168.221.42])
        by md-in-79.webhostbox.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <saravanan@linumiz.com>)
        id 1p0mnc-003un4-Oq;
        Thu, 01 Dec 2022 16:52:36 +0000
Message-ID: <ddcda7c9-6aa8-2660-d6fb-8dc117f330c4@linumiz.com>
Date:   Thu, 1 Dec 2022 17:52:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/4] dt-bindings: hwmon/pmbus: Add mps,mpq7932
 power-management IC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Content-Language: en-US
From:   Saravanan Sekar <saravanan@linumiz.com>
In-Reply-To: <bdab2e58-ea12-0ccf-a25a-ed89e50a5332@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - md-in-79.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - linumiz.com
X-BWhitelist: no
X-Source-IP: 106.197.183.239
X-Source-L: No
X-Exim-ID: 1p0mnc-003un4-Oq
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.221.42]) [106.197.183.239]:44685
X-Source-Auth: saravanan@linumiz.com
X-Email-Count: 14
X-Source-Cap: bGludW1jbWM7aG9zdGdhdG9yO21kLWluLTc5LndlYmhvc3Rib3gubmV0
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP4751ZaMPlv/LlK4mHcTRyk/fFVTSadVDnoHE4MKSO4i6FrEvkmWc6BkfKS+a69qxLuVz8IjWaecKgkk62W6ESzwZqxf8ITy9Yzxj6T4Ow2fzVcPaXr
 5QcGmi4uLxvnTaSrL9+s8dRtGxPR0VqY5DhOf1uSVfUVcUvumxVkIF9VYr8Dh8piMvJKCJOfbTXFakdfOerfjR9V8m2DiSG/RY8=
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/22 17:43, Krzysztof Kozlowski wrote:
> On 01/12/2022 17:38, Saravanan Sekar wrote:
>>>>> Plus additional comment for the driver (and related to bindings) was
>>>>> that this is not hwmon but a regulator driver. Why putting regulator
>>>>> driver in hwmon?
>>>>>
>>>>
>>>> Turns out this is primarily a hardware monitoring driver, like the drivers
>>>> for all other PMBus chips. Regulator support is actually optional; the driver
>>>> works perfectly well with CONFIG_REGULATOR=n (except that it needs some
>>>> #ifdefs to address that situation).
>>>
>>> OK, this would explain location  of the driver. However the bindings are
>>> saying:
>>> "Monolithic Power System MPQ7932 PMIC"
>>> and PMIC is not mainly a hwmon device, even if it has such capabilities.
>>> It might be missing description and proper title... or might be misplaced.
>>>
>>
>> Indeed it is PMIC chip. I think this is not the first and not sure title
>> has to be changed for hwmon subsystem.
>>
>> bindings/hwmon/pmbus/ti,lm25066.yaml
>> title: National Semiconductor/Texas Instruments LM250x6/LM506x
>> power-management ICs
> 
> Then I propose to put it in regulator directory.
>

Just for clarification, should bindings put in regulator directory?

Thanks,
Saravanan

