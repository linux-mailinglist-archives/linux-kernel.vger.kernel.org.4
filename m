Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724126CC89F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 18:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjC1Q4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 12:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjC1Q4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 12:56:05 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8624B750
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:56:03 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id o12so1643089ilh.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1680022563; x=1682614563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LQykbIASwaSOYckFPBEJVXD9EFhn71W8gTG9pE8tJ28=;
        b=QWR06jmFMbM35tLVtFQq3O9myToaGC9er1DxfnCBHTEDHmxan8RTCzSppq9DWOPTZT
         HLuhb+yzXciKn+JYUvugYFEeOkuB+PWz65UHJQPVZ7MpMwXCZdxsXsCAMQTl5bEBYmua
         Ctg48hqn1V/ZTGzdIf6s3Svpb5HEk3k8j+6B8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680022563; x=1682614563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LQykbIASwaSOYckFPBEJVXD9EFhn71W8gTG9pE8tJ28=;
        b=6mLNcP4nGhqY8ZMIOmSVb9XQ8X9kcLX+tVu7eidcW2lzWa65rQRRwzsYg4F0nLjauP
         EGwrOY01+mdXA11rInFPpJ+dH3Gtj14oYQo6axCL3ZnP+4/fS2DKrBvRWIDdenq2+Ogn
         S3hTkYOMUSwj5TWN5Kj9InWn4uBc/MdF4QdieNq32xcJblTG5pQULpWOfhbkOp0iII2x
         Z7F4cxZVEXFUA0XMLc3KYHAYtacrQJWQ70F6DmT/dO9sO34575BcnNQBsrJXWjOHIjXQ
         ZMb8u7BM7zuNuQnyI0Rw8U8OMJz36ZYfRWfH+aqVZmqA6GFx8OSBYYHY3+bQS5D1SV+o
         5M0Q==
X-Gm-Message-State: AAQBX9fJzGj6gJZmpX3q+qtxNb138JzaI382v/LN1yxT1OjhkACMQK9c
        yJOxkTiR95y7itdjfhQzO8cCGA==
X-Google-Smtp-Source: AKy350ZSTXugk9eX2S1qXpaj1sPbjpqobxS+5rq+wwp5hkk3J6VeQsdK6GdG8PGaBod38GyGAtIpkA==
X-Received: by 2002:a05:6e02:1bc1:b0:326:1d0a:cce6 with SMTP id x1-20020a056e021bc100b003261d0acce6mr1820673ilv.0.1680022563167;
        Tue, 28 Mar 2023 09:56:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id j3-20020a92c203000000b0032627e754bbsm4704ilo.21.2023.03.28.09.56.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 09:56:02 -0700 (PDT)
Message-ID: <e2d86dd7-16c0-3d08-a906-3c81c0905187@linuxfoundation.org>
Date:   Tue, 28 Mar 2023 10:56:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests: cgroup: Add 'malloc' failures checks in
 test_memcontrol
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>,
        Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, shakeelb@google.com,
        muchun.song@linux.dev, tj@kernel.org, lizefan.x@bytedance.com,
        shuah@kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230226131634.34366-1-ivan.orlov0322@gmail.com>
 <Y/zzVWJ5PHs5My6x@P9FQF9L96D>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y/zzVWJ5PHs5My6x@P9FQF9L96D>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/23 11:15, Roman Gushchin wrote:
> On Sun, Feb 26, 2023 at 04:16:33PM +0300, Ivan Orlov wrote:
>> There are several 'malloc' calls in test_memcontrol, which can be
>> unsuccessful. This patch will add 'malloc' failures checking to
>> give more details about test's fail reasons and avoid possible
>> undefined behavior during the future null dereference (like the
>> one in alloc_anon_50M_check_swap function).
>>
>> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> 
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
> 
> Thanks!

Thank you all. Applied to linux-kselftest next for Linux 6.4-rc1

thanks,
-- Shuah
