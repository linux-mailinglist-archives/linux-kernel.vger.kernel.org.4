Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B1B5BB90D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 17:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiIQPSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 11:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiIQPSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 11:18:46 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5332F667;
        Sat, 17 Sep 2022 08:18:44 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id r18so55492358eja.11;
        Sat, 17 Sep 2022 08:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SXmSD7rQesiFD0RXizg8ZPh0M25mEIP++dLEWBB4dHk=;
        b=n2NBW86burrRr2b0WpKrhi1JUZSvVeLMkC23Lcm9Qv37+oOYky5CqJ/3ccdVKW6sQo
         axRkEBTEAmukfVMIemg2AkkaiO4NzN+HvoVyqqUFAz5iv3g56iFMb3YkysbILeefloOJ
         8xXH+xBGQxuhC3m+irmx/y2PzmwD74AwYtRZlWz9hgRG6OlYkT1knq3+e/uOz9DJrMLo
         fB4lc45a7UTBk7LtE3fdRTvFNQHfCM80/a9Sf89ckLmwtHakonNUYweT4xt30cmwKNyN
         ZQAbuhmxJw9JgsUmesy6dbRumPuf22wS2sS3YQbCQux+gukeQiLGqjc5anTLNl7QjdhW
         ZVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SXmSD7rQesiFD0RXizg8ZPh0M25mEIP++dLEWBB4dHk=;
        b=pkerZM4vXjE9di1Jzr+Ze/NWQxFJWhxNYQjt0FoHqm9Y1sQvrJa6cEQCGORq3EOOVP
         QfSw7+Q/Y01NxkCmrOnyK2G9rXe62NrALLItldJNtX4kZN1NEbKc4bk04j9bY2lw+3vz
         X0PCenzLkywXycfcKxFttGSabAr8Rmc09Ao9XHbIUi4Axsx/MvfWUhn+1zvJrCI/zU3y
         LnWTGL9lPXIU8O4dydyqtLl6K6rH0erKsYF9CHPq1LauhBYT1Tz2LYTdQZXwqB0Ycnnj
         87bjKu1z/21eDpK0QrYYUW+GFqLC6P07hywx/xuB7oipCl7+Y+ZT2Uuq5ZzLgpRIwwuB
         BAsw==
X-Gm-Message-State: ACrzQf3zro8hdY0kU0RaHLjwVFrJJLHXtEs4zV5BJVeB/2dRgFnAL7tl
        pMmcxIo37AOGwPHSnYw/wVLz+/gJQQg=
X-Google-Smtp-Source: AMsMyM4a3iu9JCgycuHuL0IcblQFnT1VvNcPYiEwQVqgZZuK7aIkT2bKq8MW00RxrhCpGKQFNbYSSQ==
X-Received: by 2002:a17:907:7b95:b0:731:113a:d7a2 with SMTP id ne21-20020a1709077b9500b00731113ad7a2mr6812718ejc.377.1663427922507;
        Sat, 17 Sep 2022 08:18:42 -0700 (PDT)
Received: from ?IPV6:2a02:908:1256:79a0:89be:3f80:f009:10f? ([2a02:908:1256:79a0:89be:3f80:f009:10f])
        by smtp.gmail.com with ESMTPSA id d12-20020aa7d5cc000000b0044e937ddcabsm15886004eds.77.2022.09.17.08.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Sep 2022 08:18:41 -0700 (PDT)
Message-ID: <c958d871-9a89-3490-f5e3-3a2441926074@gmail.com>
Date:   Sat, 17 Sep 2022 17:18:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [Linaro-mm-sig] Re: [PATCH v4 0/6] dma-buf: Check status of
 enable-signaling bit on debug
Content-Language: en-US
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Cc:     "Yadav, Arvind" <arvyadav@amd.com>,
        Arvind Yadav <Arvind.Yadav@amd.com>, andrey.grodzovsky@amd.com,
        shashank.sharma@amd.com, amaranath.somalapuram@amd.com,
        Arunpravin.PaneerSelvam@amd.com, sumit.semwal@linaro.org,
        gustavo@padovan.org, airlied@linux.ie, daniel@ffwll.ch,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20220914164321.2156-1-Arvind.Yadav@amd.com>
 <d2d81ffd-2269-bdc6-0daa-8f3a99306e46@amd.com>
 <33a16b15-3d3c-7485-d021-ee2a727e5391@amd.com>
 <691c421f-1297-cd08-ea70-6750099275b1@amd.com> <YyVmYXGCfTuYUsNb@intel.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <YyVmYXGCfTuYUsNb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.09.22 um 08:17 schrieb Ville Syrjälä:
> On Thu, Sep 15, 2022 at 06:05:30PM +0200, Christian König wrote:
>> Am 15.09.22 um 15:02 schrieb Yadav, Arvind:
>>> On 9/15/2022 5:37 PM, Christian König wrote:
>>>> Is that sufficient to allow running a desktop on amdgpu with the
>>>> extra check enabled? If yes that would be quite a milestone.
>>>>
>>> Yes, It is running on amdgpu with extra config enabled.
>> In this case I will start pushing the patches to drm-misc-next. I'm just
>> going to leave out the last one until the IGT tests are working as well.
> ffs Christian. intel CI blew up yet again:
> https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_12146/shard-glk7/igt@kms_plane_lowres@tiling-y@pipe-c-hdmi-a-2.html
>
> The last time (some ttm thing) was just a week or two ago,
> so it's really getting tiresome watching you push entirely
> untested stuff all the time. Would be really helpful if you
> finally started to do/require premerge testing.

Well first of all sorry for causing trouble, but as I wrote above I 
intentionally left out the last one to *not* break the IGT tests.

The patches pushed so far where just updating a bunch of corner cases 
and fixing the selftests.

Do you have any more insight why that should affect the IGT tests?

Regards,
Christian.
