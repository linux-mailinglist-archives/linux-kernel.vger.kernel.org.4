Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC895F14B1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 23:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiI3VYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 17:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiI3VYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 17:24:49 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F10220369
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:24:47 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a80so5298871pfa.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 14:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gQa4eGbEVBeAKBGzZEdWdAqwKEPR/qyaUUpn0AQUmcY=;
        b=3EURTjXeklkLflGUj4iVrCFJLZ7OcWMFSStfiFCwgJII/1WImuD2se4G66ta21P6Da
         vFoTglIBbGNORBQWbWTCDuqtqxaO+HPnkTQTzYC1dhwW92sS/v7QWSB1rIA5TUm6h0E5
         jsb7sBRYK8arp+hv/lW94rlgekF6bYM1d7eL9MJrDFF4Jk6jfeNFYeFJdnUSlPMr0Aro
         8ecBCzitkMgDwf6dYdV/gZREORLjH+l1NiJuWBUuGWTpxnLT8s2Lknz+mn3Ff8tLqPUd
         rAi/qyTW2/CzAM7vCQAK1RkNXW4p2AVdxEwZ3EcAgVJEn+e9yv2o+6CMYbSmoBlDdJ7+
         631g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gQa4eGbEVBeAKBGzZEdWdAqwKEPR/qyaUUpn0AQUmcY=;
        b=Kkcdm6d2HjLiszk4ZT//zS/FhlhdTiM+RdWLi9ThMVL5FtNI/YWSMDWiIJnhl3oHFd
         IMtgNVV1pOK1Bbfn2jfsoFnWbNcq8xvOsiTLT2YAyNDX4qZ5MnBmMfkrDz196nyzhhex
         nk1u0SFfgeMh1Eq3R1MTkExWoeXLEkvWub+vormXPcqtqJnPS2ekS9WQOEgYEhS47jr7
         8GxcAQ2B6vthnD1hoC3Cn9AIFpa8qHo8vOcFgZjSXKW+u5CMxQwJAO3XjzCFVgUqTOxI
         gHwrBci3E+ETSr/ibvlzmgEpxeFE4rDmlHvUAv1AEDhnTyySNBvI2FFhPkdgQi1OcV1t
         Exyg==
X-Gm-Message-State: ACrzQf2zbsSVXx4PuglOQhT1TVpoTgbvaRDREtfifLyW5je7s23jjPId
        PZ6DWG92dmw531UV+juUe8ftBeopLoQYLQ==
X-Google-Smtp-Source: AMsMyM6bH8LWTyKM8E6TZPLLzzJcAnhCSq843METl4dQR8aOBKDpfMXeY2d7Z+NB8UVtrtjnFjkUSQ==
X-Received: by 2002:a63:d603:0:b0:43c:6762:20d9 with SMTP id q3-20020a63d603000000b0043c676220d9mr9108628pgg.68.1664573086605;
        Fri, 30 Sep 2022 14:24:46 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id q15-20020a17090ad38f00b00209a12b3879sm2028502pju.37.2022.09.30.14.24.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 14:24:46 -0700 (PDT)
Message-ID: <90b6d45e-61a5-3eb3-7525-8467f1a67587@kernel.dk>
Date:   Fri, 30 Sep 2022 15:24:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>,
        Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Cc:     jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
        snitzer@kernel.org, damien.lemoal@opensource.wdc.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
 <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
 <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <0e5088a5-5408-c5bd-bf97-00803cb5faed@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/22 1:38 PM, Bart Van Assche wrote:
> On 9/30/22 08:13, Jens Axboe wrote:
>> On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>>>> Hi Jens,
>>>> ?? Please consider this patch series for the 6.1 release.
>>>>
>>>
>>> Hi Jens, Christoph, and Keith,
>>> ? All the patches have a Reviewed-by tag at this point. Can we queue this up
>>> for 6.1?
>>
>> It's getting pretty late for 6.1 and I'd really like to have both Christoph
>> and Martin sign off on these changes.
> 
> Hi Jens,
> 
> Agreed that it's getting late for 6.1.
> 
> Since this has not been mentioned in the cover letter, I want to add
> that in the near future we will need these patches for Android
> devices. JEDEC is working on supporting zoned storage for UFS devices,
> the storage devices used in all modern Android phones. Although it
> would be possible to make the offset between zone starts a power of
> two by inserting gap zones between data zones, UFS vendors asked not
> to do this and hence need support for zone sizes that are not a power
> of two. An advantage of not having to deal with gap zones is better
> filesystem performance since filesystem extents cannot span gap zones.
> Having to split filesystem extents because of gap zones reduces
> filesystem performance.

Noted. I'll find some time to review this as well separately, once we're
on the other side of the merge window.

-- 
Jens Axboe
