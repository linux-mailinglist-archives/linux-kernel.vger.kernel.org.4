Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA526034AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 23:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiJRVNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 17:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiJRVNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 17:13:02 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150CC4C3E;
        Tue, 18 Oct 2022 14:13:01 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id be13so9194028lfb.4;
        Tue, 18 Oct 2022 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PcTgztvz01i1AUaYLJIqCVOYn5kiAMuKCqT5W3AEJoc=;
        b=T01XTyoUWE3zKGhM5BukE0c6AKGTmT47D55TxG5MXFdgzGTAtGpp7GY+eXzqQqEyEO
         +Ieo+MvqJkO3XpnyD0PaWiJ08qcvHucWUIJsVKaDGvBOcrjbDYJAPykOYu5/nxjJe27r
         3CMWB4NRxPpCsxZIuQKLtO5BjzGGx6VfDUQf1N5LfbQMkHj3KjYkjQSDD77BUCWBFcSy
         5vJbb/ot+lATv8RUkKowyiCoR0oOg5y+0mPADA/6vtm5PCrIaufzaQd7jEGLjg/iLZgE
         4klR561pSitwWtDhCph02lXEz7+8ZBy4KbRtef0NvtbYmyz63MnHO465MlX6vTCZI0aX
         fnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PcTgztvz01i1AUaYLJIqCVOYn5kiAMuKCqT5W3AEJoc=;
        b=1OnNI876l9IS3O/LVqJm2LxinWMKXcJ/L0+Hi75x7iO+fW+XttoR1M91zzZSgbbItE
         BiR+///xip9XoN3v480LvwPCR7BahM1+TxvEkJsSpogg9CwIQ9STrV+EwQyNcHogQFFw
         SJaVvOk9FocHsRD95bD56fHPH5DeSM1bW2uUbJlIPYiT/0R81v8LNgr+JDTbF9WBosqE
         le+KWQP7oYtGwIG9imdK8joqacou6DJYc4aVqETO23QuHsK+uLPnq25qYNrekiaFPiXx
         7y69FUF68pX21lTIIzjqxjAUBS2RjOvWBVPiK6XyOCEtj7lFhCg7+YToje52HJIys9as
         ilFw==
X-Gm-Message-State: ACrzQf1p3F3Cb0UtGBnIGTE5taVLYuV6WtxyJ0es/ReB3Jmizm4Vr/Ue
        53ryFmvbAVZDZ5xea+Z7R6I=
X-Google-Smtp-Source: AMsMyM5ntKDQNkrDBnb7blafjSZLYV3kqVmVdDiuWmlMEgdeMqPYBer81Mcg2MdQmkhbSRNzWJd5yw==
X-Received: by 2002:a05:6512:a8c:b0:4a2:10f1:6e06 with SMTP id m12-20020a0565120a8c00b004a210f16e06mr1546297lfu.415.1666127581163;
        Tue, 18 Oct 2022 14:13:01 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.119.114])
        by smtp.googlemail.com with ESMTPSA id bf12-20020a056512258c00b004a478c2f4desm1068357lfb.163.2022.10.18.14.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 14:13:00 -0700 (PDT)
Message-ID: <712c9e51-f589-b566-6194-259393180e43@gmail.com>
Date:   Wed, 19 Oct 2022 00:12:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 05/16] iommu: Move bus setup to IOMMU device
 registration
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        Thierry Reding <treding@nvidia.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, baolu.lu@linux.intel.com,
        kevin.tian@intel.com, suravee.suthikulpanit@amd.com,
        vasant.hegde@amd.com, mjrosato@linux.ibm.com,
        schnelle@linux.ibm.com, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <cover.1660572783.git.robin.murphy@arm.com>
 <d342b6f27efb5ef3e93aacaa3012d25386d74866.1660572783.git.robin.murphy@arm.com>
 <89d873fc-9f0a-156e-dcf2-48a2b9f93dcc@nvidia.com>
 <583c4689-844d-2ae2-79fb-4750b21c4304@arm.com>
 <41293685-54aa-6fa3-ca41-189fdbb7e8b0@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <41293685-54aa-6fa3-ca41-189fdbb7e8b0@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

18.10.2022 09:13, Jon Hunter пишет:
> 
> On 06/10/2022 16:27, Robin Murphy wrote:
>> On 2022-10-06 15:01, Jon Hunter wrote:
>>> Hi Robin,
>>>
>>> On 15/08/2022 17:20, Robin Murphy wrote:
>>>> Move the bus setup to iommu_device_register(). This should allow
>>>> bus_iommu_probe() to be correctly replayed for multiple IOMMU
>>>> instances,
>>>> and leaves bus_set_iommu() as a glorified no-op to be cleaned up next.
>>>>
>>>> At this point we can also handle cleanup better than just rolling back
>>>> the most-recently-touched bus upon failure - which may release devices
>>>> owned by other already-registered instances, and still leave devices on
>>>> other buses with dangling pointers to the failed instance. Now it's
>>>> easy
>>>> to clean up the exact footprint of a given instance, no more, no less.
>>>
>>>
>>> Since this change, I have noticed that the DRM driver on Tegra20 is
>>> failing to probe and I am seeing ...
>>>
>>>   tegra-gr2d 54140000.gr2d: failed to attach to domain: -19
>>>   drm drm: failed to initialize 54140000.gr2d: -19
>>>
>>> Bisect points to this change and reverting it fixes it. Let me know
>>> if you have any thoughts.
>>
>> Oh, apparently what's happened is that I've inadvertently enabled the
>> tegra-gart driver, since it seems that *wasn't* calling
>> bus_set_iommu() before. Looking at the history, it appears to have
>> been that way since c7e3ca515e78 ("iommu/tegra: gart: Do not register
>> with bus"), so essentially that driver has been broken and useless for
>> close to 8 years now :(
>>
>> Given that, I'd be inclined to "fix" it as below, or just give up and
>> delete the whole thing.
>>
>> Thanks,
>> Robin.
>>
>> ----->8-----
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index 5c5cb5bee8b6..7b3f7fd6e527 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -230,6 +230,7 @@ config TEGRA_IOMMU_GART
>>       bool "Tegra GART IOMMU Support"
>>       depends on ARCH_TEGRA_2x_SOC
>>       depends on TEGRA_MC
>> +    depends on BROKEN
>>       select IOMMU_API
>>       help
>>         Enables support for remapping discontiguous physical memory
> 
> 
> Thanks Robin. This works for me.
> 
> Thierry, Dmitry, we need a fix for v6.1 and so OK with the above?

To me it is more a problem of the DRM driver that it doesn't support
GART. GART will require a special handling from the DRM driver anyways [1].

[1]
https://github.com/grate-driver/linux/blob/master/drivers/gpu/drm/grate/drm.c#L460

The GART driver itself isn't broken, it's working perfectly fine. It's
the DRM driver that should start caring about the GART presence, IMO.
