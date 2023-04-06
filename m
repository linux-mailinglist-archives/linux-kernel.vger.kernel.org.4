Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9946D9D08
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239878AbjDFQGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239860AbjDFQG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:06:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86493F4
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 09:06:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j11so348330wrd.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 09:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680797165; x=1683389165;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tGBcjAE6j139nGrIeCa4gFdeD5NsoReg/shcLBHBhms=;
        b=ilJZDzEidBWQIUC/WEyHBGDCmt0cL+CP5MSZDpG5JB4DEmx+iCCm2eolefvzKHqePs
         pPr5KEMziD1SfnzjcT7+V2LbK6NO4kGSMU9+vrMBiNxCUo+0yCJLJXN1GOd8xnTsrDFP
         5ttKj7hXEN+WARyIDBN+aJMbKgLwykkxseBQlNWWYddQ7j24/HTKyL2rfD5d9YgpSvH8
         NCOWr7ne1XNH4RceyRoq74JZKlfolKiIu4uOwzNmkdyjCaRkkE3yNkOn5sgi+Brd7EQ9
         BxsNdGp4804+wu6FlQ7CxoZI5ausQcPB0JIBbA10IeZTz+Q1A1ccbUueZTedCg1t2U74
         YoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680797165; x=1683389165;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGBcjAE6j139nGrIeCa4gFdeD5NsoReg/shcLBHBhms=;
        b=ifxI1ayKa+kth2hw7neTMHAb4SIpZzrRVwmSmxdnPJ/zO8HM/JYHHWWAM3rszgwHn7
         KT10M5DfC1xWjhgFOkdPIyNu23uVB8zAzgeqTlUIWxNSqQ1ZVAOHBN3OxJYwjPOt+uhi
         L2ojlyZkIudU/k2VLXQcp6/Kq0O3v8mNql4vCB8XDf0YndgFFYpj4Sq7EQrQRtaYyqRf
         R5RxgAAKtyPeU3TIpzx8kYJ6SwjsgCVQ4U6O5rzce/jCWhgYJvMDpyeoweCcWorbe5no
         lxpcUjoVmVl+WGu+UQ82DiTl0BpeF2SIav9PeoLRpMZo6A3REA+09aS//tLTZKlCsLPo
         xqyg==
X-Gm-Message-State: AAQBX9cjmzrGm+ALIEDYGRRApFO4yq0dIXlQLJU6YdB5msZhjfLjR2Ks
        RfmIeFyFkaUp37LaESGRBAyhww==
X-Google-Smtp-Source: AKy350Z6NL84QoajoMkHAcqHoiPnqfDtjwjHP1ozYJ3eK1bhBdJxqz9vdxU74lO60iF0AtXdxGpuBg==
X-Received: by 2002:a5d:6584:0:b0:2ee:ee98:efbe with SMTP id q4-20020a5d6584000000b002eeee98efbemr1836418wru.58.1680797165454;
        Thu, 06 Apr 2023 09:06:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:8569:a62a:11bd:c344? ([2a01:e0a:982:cbb0:8569:a62a:11bd:c344])
        by smtp.gmail.com with ESMTPSA id b10-20020a5d634a000000b002e116cbe24esm2112794wrw.32.2023.04.06.09.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 09:06:05 -0700 (PDT)
Message-ID: <9835aeba-6e4c-0594-427b-9990fc07407a@linaro.org>
Date:   Thu, 6 Apr 2023 18:06:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] of: fdt: Allow the kernel to mark nomap regions
 received from fdt
Content-Language: en-US
To:     Rob Herring <robh+dt@kernel.org>, Lucas Tanure <tanure@linux.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, jbrunet@baylibre.com,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        martin.blumenstingl@googlemail.com, narmstrong@baylibre.com,
        stefan@agner.ch
References: <20230406151429.524591-1-tanure@linux.com>
 <20230406151429.524591-3-tanure@linux.com>
 <CAL_JsqL_MLHO-zk0HAmuAmiJQ_TmD4EN5YC0JmRs7PXjStjr3A@mail.gmail.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <CAL_JsqL_MLHO-zk0HAmuAmiJQ_TmD4EN5YC0JmRs7PXjStjr3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 17:48, Rob Herring wrote:
> On Thu, Apr 6, 2023 at 10:14 AM Lucas Tanure <tanure@linux.com> wrote:
>>
>> Reserved regions can be described in FDT and device trees, but FDT doesn't
>> provide the related flags, like nomap.
> 
> It took me a minute to understand what you meant by FDT vs. device
> trees. Use the exact things you are talking about: /memreserve/ and
> /reserved-memory node.
> 
>> So allow the kernel to mark regions where the base and size received from
>> the device tree are the same as the base and region on FDT.
>> Here we trust that the device tree has a more updated description of the
>> region than the one received from FDT.
>>
>> Signed-off-by: Lucas Tanure <tanure@linux.com>
>> ---
>>   drivers/of/fdt.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
>> index d1a68b6d03b3..754a7ea4f45c 100644
>> --- a/drivers/of/fdt.c
>> +++ b/drivers/of/fdt.c
>> @@ -482,11 +482,13 @@ static int __init early_init_dt_reserve_memory(phys_addr_t base,
>>          if (nomap) {
>>                  /*
>>                   * If the memory is already reserved (by another region), we
>> -                * should not allow it to be marked nomap, but don't worry
>> -                * if the region isn't memory as it won't be mapped.
>> +                * should not allow it to be marked nomap, unless is the exact same region
>> +                * (same base and size), which the kernel knows better and should be allowed to mark
>> +                *  it as nomap.
>> +                * But don't worry if the region isn't memory as it won't be mapped.
>>                   */
>> -               if (memblock_overlaps_region(&memblock.memory, base, size) &&
>> -                   memblock_is_region_reserved(base, size))
>> +               if (memblock_overlaps_region(&memblock.memory, base, size) == MEMBLOCK_OVERLAPS &&
>> +                   memblock_is_region_reserved(base, size) == MEMBLOCK_OVERLAPS)
> 
> Won't this fail to work as IIRC memblock will merge regions when they
> are adjacent and have the same atrributes.
> 
> Perhaps instead, the DT code should ignore any /memreserve/ entries
> that are also in /reserved-memory.
> 
> I would suggest just reverse the order they are processed, but I
> suspect that might cause some regression. This code is all fragile
> especially with platforms putting in 100 regions.
> 
> Finally, perhaps fix u-boot. The reason the reserved location goes in
> both places was to support an OS not supporting /reserved-memory. I
> think that support has been in place for a lot longer than anyone
> would care about.

Fixing U-Boot won't fix already tagged and in-the-field mainline u-boot
releases that adds /memreserve/ entries, so yes u-boot should be definitely
fixed but Linux should ignore the /memreserve/ entries when they matches
an /reserved-memory node like when the U-Boot /memreserve/ code was added.

Neil

> 
> Rob
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

