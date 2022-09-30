Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D405F0E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbiI3POS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiI3POL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:14:11 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C82612FF03
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:14:03 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n192so3498360iod.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JfR2GfqXfwHVRcahJmnUzB1Y/QLxN5cyd7oQednba7g=;
        b=P9WWNQtWlB5f/IfBNtwL4w5+xcZ6cZI0BVKiGfdweWgPvQHQEQESV3CnmEnXNXiU+U
         vp+xXcUEit+8B9sj9Hh6xdpeXWF+P6xAL/QS/2JUGxfs6ia29xDNYZN4USoUdbcCO+B3
         2egNXSKAYMBg8zUmbPfKgrHXmfZ2/feemYNI3gL7/71mJEbGW3bABE4qDEBKJe15hThf
         HVTPHWHhvFTL1eubX12elfdIi8vvHFzKCFs9WVn3Pi7pLNPzNL9294YBAquRnqs2KKaO
         rbw92cJxck6GdkD/dmmDOaLcK+VZcLXWLOXJkaiGGcX4OCwgWbbSrC/fLR/t5al86cv8
         Syyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JfR2GfqXfwHVRcahJmnUzB1Y/QLxN5cyd7oQednba7g=;
        b=uX1S4T8ebD5CVX3fzXfShOrlS3vSPpvXLbP1DLpZp6anZQrtin4Gqu1MIaW8XaxlOr
         Mt0/RSg22+Bf4gmfo9tjSTHowx4GXhhFuNbZ2kf9DNGNX3YZG+yZTGwm5WMjMRYDNPw9
         +0NOpx2BQnIaRRHWlplbgpMoSlhsWSN/BI70LGhFKt2pC43Ye+P5fXxFpdcTTjI4z4vw
         Pr1Shvx3VZUZ48cTQyN7rDS7KMvM/G7ilHrBZRYP4ZWttDxThOHrJZ420WU38gJuomPC
         A+Gufb9qW+E+oSu+G9vW9my4BztsF1g6MZW6bD0J+CANz7bMWe8YJn6b6Oh0F+Nb9bHK
         kCgQ==
X-Gm-Message-State: ACrzQf1lw1+aSyX1pWEjcCYZ/l91K4pkbklEYitOjZoORQBNqCjbSA2Z
        2T2CFofGHIYimFuVrxBPRZID8A==
X-Google-Smtp-Source: AMsMyM56qoijmhJXnYPF8kxaWuSK3ez2mfK6ZmVjsiLUqUdOlYO1SRhJq4es+Rf++wuS3uh8BhpzXw==
X-Received: by 2002:a6b:b80a:0:b0:6a4:949:4681 with SMTP id i10-20020a6bb80a000000b006a409494681mr4032792iof.96.1664550843041;
        Fri, 30 Sep 2022 08:14:03 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t2-20020a056e02060200b002eae6cf8898sm1052303ils.30.2022.09.30.08.14.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 08:14:02 -0700 (PDT)
Message-ID: <bd9479f4-ff87-6e5d-296e-e31e669fb148@kernel.dk>
Date:   Fri, 30 Sep 2022 09:13:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v15 00/13] support zoned block devices with non-power-of-2
 zone sizes
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de,
        Keith Busch <kbusch@kernel.org>
Cc:     jaegeuk@kernel.org, agk@redhat.com, gost.dev@samsung.com,
        snitzer@kernel.org, damien.lemoal@opensource.wdc.com,
        bvanassche@acm.org, linux-kernel@vger.kernel.org, hare@suse.de,
        matias.bjorling@wdc.com, Johannes.Thumshirn@wdc.com,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        pankydev8@gmail.com, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <CGME20220923173619eucas1p13e645adbe1c8eb62fb48b52c0248ed65@eucas1p1.samsung.com>
 <20220923173618.6899-1-p.raghav@samsung.com>
 <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <5e9d678f-ffea-e015-53d8-7e80f3deda1e@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/29/22 12:31 AM, Pankaj Raghav wrote:
>> Hi Jens,
>>   Please consider this patch series for the 6.1 release.
>>
> 
> Hi Jens, Christoph, and Keith,
>  All the patches have a Reviewed-by tag at this point. Can we queue this up
> for 6.1?

It's getting pretty late for 6.1 and I'd really like to have both Christoph
and Martin sign off on these changes.

-- 
Jens Axboe


