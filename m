Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C587254DB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbjFGGyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbjFGGyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:54:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FEF1BC2;
        Tue,  6 Jun 2023 23:54:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f736e0c9b1so38263215e9.3;
        Tue, 06 Jun 2023 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686120875; x=1688712875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UI9Z3j+r3a0Ltufs6TrTDwqvLTunzcx+0NZ8vIKvHWg=;
        b=CRReD5bCpanlduyt4/F+AGjKmFIRxliDjyfEuvzACcRLo+Hsuk6PnlGwID7Wm3/YaZ
         WT5BD3DzJxXZRNEedYt5X0jE2Udfz9z61LK7JVL/xRx1IzwPO1dIgiMuhUk2LZ489Ovz
         26ThTAFqkvbSTIIUtfxBEgTBCOJyFzKw8T+fettpBSVXerEmsIYOOrhLnVdNLmCyHjC3
         B9nDeLpo1JS/j3LkUSYkUcklDprMO3vyIhU5kxtLyXEKjYrG8SOagNTemb48VDOjOVpR
         YApgcCaLNp8/aHU/lFw1iuqAKntn7SyXk4tJ8WEWTE4U/Dfk8wPBfUvPwZL9ky5dnhYM
         uSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686120875; x=1688712875;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UI9Z3j+r3a0Ltufs6TrTDwqvLTunzcx+0NZ8vIKvHWg=;
        b=UTaHAFxg+d34zRMHOpvyW4D1X9NvZGrsLM5DKNkgEqZy46WSy+LJS0o3KPVtEH+9+s
         Ak4N+rz8guN8Nfh5xlDHIbAxMGqcQ+fv9FkAiaQTif3q9TVacUgeqMa4wY+o4Q7phQko
         utg/IyPE7wFLZrTVjj+wNKBBUVkoh4eGyQnOycdqzM8wn0bLuuDr+Kx49JaaSg4TqkuD
         pEwybD6tra05eWRfPn1OaBDSIBhOXHsxdLt1QmidpmNtUA1LCeWc6ohcMXEfz5dnKXXW
         d3dBPfdY6ZknjdrfR9+I3a9BndXyO2SOW7njNqV9P88ouDO/K8uinxOwOWyS1/ATwsId
         ZsIQ==
X-Gm-Message-State: AC+VfDzknUotQGSa4XjBcI6seGWY+VlHSwXrD2tz3jjLHlXc/VcPqljc
        2tzQtNmDpaQgG8SfYovCtyf4mhImNhp45w==
X-Google-Smtp-Source: ACHHUZ6w1ibYJsDpRq3SReWTvaZuSYU3syNjGO5Cx6RZ0KZNHhZ5jYhYnttjdfluCskxahiLDJ+hJg==
X-Received: by 2002:a05:600c:c1:b0:3f6:a65:6ff3 with SMTP id u1-20020a05600c00c100b003f60a656ff3mr3494314wmm.32.1686120875356;
        Tue, 06 Jun 2023 23:54:35 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0030647d1f34bsm14633830wrp.1.2023.06.06.23.54.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 23:54:34 -0700 (PDT)
Message-ID: <9ec115dd-e419-ec4e-45f1-0865d703fd6a@gmail.com>
Date:   Wed, 7 Jun 2023 08:54:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: dts: mediatek: mt8192: Fix CPUs capacity-dmips-mhz
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Seiya Wang <seiya.wang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230602183515.3778780-1-nfraprado@collabora.com>
 <01c88a42-274c-f8cf-73a6-29741579d9db@collabora.com>
 <4b2fdd36-0871-ecc7-5d64-e088d7f51987@gmail.com>
 <0e9667dc-8f91-49a0-903e-6725204e11ad@notapiano>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <0e9667dc-8f91-49a0-903e-6725204e11ad@notapiano>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/06/2023 15:00, Nícolas F. R. A. Prado wrote:
> On Tue, Jun 06, 2023 at 08:38:42AM +0200, Matthias Brugger wrote:
>>
>>
>> On 05/06/2023 10:21, AngeloGioacchino Del Regno wrote:
>>> Il 02/06/23 20:35, Nícolas F. R. A. Prado ha scritto:
>>>> The capacity-dmips-mhz parameter was miscalculated: this SoC runs
>>>> the first (Cortex-A55) cluster at a maximum of 2000MHz and the
>>>> second (Cortex-A76) cluster at a maximum of 2200MHz.
>>>>
>>>> In order to calculate the right capacity-dmips-mhz, the following
>>>> test was performed:
>>>> 1. CPUFREQ governor was set to 'performance' on both clusters
>>>> 2. Ran dhrystone with 500000000 iterations for 10 times on each cluster
>>>> 3. Calculated the mean result for each cluster
>>>> 4. Calculated DMIPS/MHz: dmips_mhz = dmips_per_second / cpu_mhz
>>>> 5. Scaled results to 1024:
>>>>      result_c0 = dmips_mhz_c0 / dmips_mhz_c1 * 1024
>>>>
>>>> The mean results for this SoC are:
>>>> Cluster 0 (LITTLE): 12016411 Dhry/s
>>>> Cluster 1 (BIG): 31702034 Dhry/s
>>>>
>>>> The calculated scaled results are:
>>>> Cluster 0: 426.953226899238 (rounded to 427)
>>>> Cluster 1: 1024
>>>>
>>>> Fixes: 48489980e27e ("arm64: dts: Add Mediatek SoC MT8192 and
>>>> evaluation board dts and Makefile")
>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>
>>>
>>
>> Applied, thanks
> 
> Hi Matthias,
> 
> this patch doesn't show in your v6.4-next/dts64 branch, while the other patch
> you just applied does, so I just wanted to double check it was really applied.
> 

I forgot to push it, should be fixed now.

Regards,
Matthias
